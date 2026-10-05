// Reconstructed CUDA C++ from the original C64 down8 entry. NOT the historical source.
// Native scalar names and control edges deliberately retained for auditable first reconstruction.
#pragma once
#include "window_block_c64_downsample_abi_fp8.cuh"

namespace dlssnr::reconstructed::window_block_c64_downsample_fp8
{
__global__ __maxnreg__(168) void window_block_c64_downsample_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(16) unsigned char s_SharedStorage[4096];
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
		r_bPtxPredicate143, r_bPtxPredicate144;
	bool r_bPtxPredicate145, r_bPtxPredicate146, r_bPtxPredicate147, r_bPtxPredicate148, r_bPtxPredicate149,
		r_bPtxPredicate150, r_bPtxPredicate151, r_bPtxPredicate152, r_bPtxPredicate153, r_bPtxPredicate154,
		r_bPtxPredicate155, r_bPtxPredicate156;
	bool r_bPtxPredicate157, r_bPtxPredicate158, r_bPtxPredicate159, r_bPtxPredicate160, r_bPtxPredicate161,
		r_bPtxPredicate162, r_bPtxPredicate163, r_bPtxPredicate164, r_bPtxPredicate165, r_bPtxPredicate166,
		r_bPtxPredicate167, r_bPtxPredicate168;
	bool r_bPtxPredicate169, r_bPtxPredicate170, r_bPtxPredicate171, r_bPtxPredicate172, r_bPtxPredicate173,
		r_bPtxPredicate174, r_bPtxPredicate175, r_bPtxPredicate176, r_bPtxPredicate177, r_bPtxPredicate178,
		r_bPtxPredicate179, r_bPtxPredicate180;
	bool r_bPtxPredicate181, r_bPtxPredicate182, r_bPtxPredicate183, r_bPtxPredicate184, r_bPtxPredicate185,
		r_bPtxPredicate186, r_bPtxPredicate187, r_bPtxPredicate188, r_bPtxPredicate189, r_bPtxPredicate190,
		r_bPtxPredicate191, r_bPtxPredicate192;
	bool r_bPtxPredicate193, r_bPtxPredicate194, r_bPtxPredicate195, r_bPtxPredicate196, r_bPtxPredicate197,
		r_bPtxPredicate198, r_bPtxPredicate199, r_bPtxPredicate200, r_bPtxPredicate201, r_bPtxPredicate202,
		r_bPtxPredicate203, r_bPtxPredicate204;
	bool r_bPtxPredicate205, r_bPtxPredicate206, r_bPtxPredicate207, r_bPtxPredicate208, r_bPtxPredicate209,
		r_bPtxPredicate210, r_bPtxPredicate211, r_bPtxPredicate212, r_bPtxPredicate213, r_bPtxPredicate214,
		r_bPtxPredicate215, r_bPtxPredicate216;
	bool r_bPtxPredicate217, r_bPtxPredicate218, r_bPtxPredicate219, r_bPtxPredicate220, r_bPtxPredicate221,
		r_bPtxPredicate222, r_bPtxPredicate223, r_bPtxPredicate224, r_bPtxPredicate225, r_bPtxPredicate226,
		r_bPtxPredicate227, r_bPtxPredicate228;
	bool r_bPtxPredicate229, r_bPtxPredicate230, r_bPtxPredicate231, r_bPtxPredicate232, r_bPtxPredicate233,
		r_bPtxPredicate234, r_bPtxPredicate235, r_bPtxPredicate236, r_bPtxPredicate237, r_bPtxPredicate238,
		r_bPtxPredicate239, r_bPtxPredicate240;
	bool r_bPtxPredicate241, r_bPtxPredicate242, r_bPtxPredicate243, r_bPtxPredicate244, r_bPtxPredicate245,
		r_bPtxPredicate246, r_bPtxPredicate247, r_bPtxPredicate248, r_bPtxPredicate249, r_bPtxPredicate250,
		r_bPtxPredicate251, r_bPtxPredicate252;
	bool r_bPtxPredicate253, r_bPtxPredicate254, r_bPtxPredicate255, r_bPtxPredicate256, r_bPtxPredicate257,
		r_bPtxPredicate258, r_bPtxPredicate259, r_bPtxPredicate260, r_bPtxPredicate261, r_bPtxPredicate262,
		r_bPtxPredicate263, r_bPtxPredicate264;
	bool r_bPtxPredicate265, r_bPtxPredicate266, r_bPtxPredicate267, r_bPtxPredicate268, r_bPtxPredicate269,
		r_bPtxPredicate270, r_bPtxPredicate271, r_bPtxPredicate272, r_bPtxPredicate273, r_bPtxPredicate274,
		r_bPtxPredicate275, r_bPtxPredicate276;
	bool r_bPtxPredicate277, r_bPtxPredicate278, r_bPtxPredicate279, r_bPtxPredicate280, r_bPtxPredicate281,
		r_bPtxPredicate282, r_bPtxPredicate283, r_bPtxPredicate284, r_bPtxPredicate285, r_bPtxPredicate286,
		r_bPtxPredicate287, r_bPtxPredicate288;
	bool r_bPtxPredicate289, r_bPtxPredicate290, r_bPtxPredicate291, r_bPtxPredicate292, r_bPtxPredicate293,
		r_bPtxPredicate294, r_bPtxPredicate295, r_bPtxPredicate296, r_bPtxPredicate297, r_bPtxPredicate298,
		r_bPtxPredicate299;
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_PtxU16Register3, r_PtxU16Register4, r_PtxU16Register5,
		r_PtxU16Register6, r_PtxU16Register7, r_PtxU16Register8, r_PtxU16Register9,
		r_ConvertedE4PairAtPtx90Rs10, r_PtxU16Register11, r_ConvertedE4PairAtPtx143Rs12;
	uint16_t r_PtxU16Register13, r_ConvertedE4PairAtPtx199Rs14, r_PtxU16Register15,
		r_ConvertedE4PairAtPtx252Rs16, r_PtxU16Register17, r_PtxU16Register18, r_PtxU16Register19,
		r_PtxU16Register20, r_PtxU16Register21, r_PtxU16Register22, r_PtxU16Register23, r_PtxU16Register24;
	uint16_t r_PtxU16Register25, r_PtxU16Register26, r_PtxU16Register27, r_PtxU16Register28,
		r_PtxU16Register29, r_PtxU16Register30, r_PtxU16Register31, r_PtxU16Register32, r_PtxU16Register33,
		r_PtxU16Register34, r_PtxU16Register35, r_PtxU16Register36;
	uint16_t r_PtxU16Register37, r_PtxU16Register38, r_PtxU16Register39, r_PtxU16Register40,
		r_PtxU16Register41, r_PtxU16Register42, r_PtxU16Register43, r_PtxU16Register44, r_PtxU16Register45,
		r_PtxU16Register46, r_PtxU16Register47, r_PtxU16Register48;
	uint16_t r_ConvertedE4PairAtPtx994Rs49, r_ConvertedE4PairAtPtx997Rs50, r_ConvertedE4PairAtPtx1001Rs51,
		r_ConvertedE4PairAtPtx1004Rs52, r_ConvertedE4PairAtPtx1008Rs53, r_ConvertedE4PairAtPtx1011Rs54,
		r_ConvertedE4PairAtPtx1015Rs55, r_ConvertedE4PairAtPtx1018Rs56, r_ConvertedE4PairAtPtx1022Rs57,
		r_ConvertedE4PairAtPtx1025Rs58, r_ConvertedE4PairAtPtx1029Rs59, r_ConvertedE4PairAtPtx1032Rs60;
	uint16_t r_ConvertedE4PairAtPtx1036Rs61, r_ConvertedE4PairAtPtx1039Rs62, r_ConvertedE4PairAtPtx1043Rs63,
		r_ConvertedE4PairAtPtx1046Rs64, r_ConvertedE4PairAtPtx1124Rs65, r_ConvertedE4PairAtPtx1127Rs66,
		r_ConvertedE4PairAtPtx1131Rs67, r_ConvertedE4PairAtPtx1134Rs68, r_ConvertedE4PairAtPtx1138Rs69,
		r_ConvertedE4PairAtPtx1141Rs70, r_ConvertedE4PairAtPtx1145Rs71, r_ConvertedE4PairAtPtx1148Rs72;
	uint16_t r_ConvertedE4PairAtPtx1152Rs73, r_ConvertedE4PairAtPtx1155Rs74, r_ConvertedE4PairAtPtx1159Rs75,
		r_ConvertedE4PairAtPtx1162Rs76, r_ConvertedE4PairAtPtx1166Rs77, r_ConvertedE4PairAtPtx1169Rs78,
		r_ConvertedE4PairAtPtx1173Rs79, r_ConvertedE4PairAtPtx1176Rs80, r_ConvertedE4PairAtPtx1724Rs81,
		r_ConvertedE4PairAtPtx1727Rs82, r_ConvertedE4PairAtPtx1731Rs83, r_ConvertedE4PairAtPtx1734Rs84;
	uint16_t r_ConvertedE4PairAtPtx1738Rs85, r_ConvertedE4PairAtPtx1741Rs86, r_ConvertedE4PairAtPtx1745Rs87,
		r_ConvertedE4PairAtPtx1748Rs88, r_ConvertedE4PairAtPtx1752Rs89, r_ConvertedE4PairAtPtx1755Rs90,
		r_ConvertedE4PairAtPtx1759Rs91, r_ConvertedE4PairAtPtx1762Rs92, r_ConvertedE4PairAtPtx1766Rs93,
		r_ConvertedE4PairAtPtx1769Rs94, r_ConvertedE4PairAtPtx1773Rs95, r_ConvertedE4PairAtPtx1776Rs96;
	uint16_t r_ConvertedE4PairAtPtx2434Rs97, r_ConvertedE4PairAtPtx2437Rs98, r_ConvertedE4PairAtPtx2441Rs99,
		r_ConvertedE4PairAtPtx2444Rs100, r_ConvertedE4PairAtPtx2448Rs101, r_ConvertedE4PairAtPtx2451Rs102,
		r_ConvertedE4PairAtPtx2455Rs103, r_ConvertedE4PairAtPtx2458Rs104, r_ConvertedE4PairAtPtx2462Rs105,
		r_ConvertedE4PairAtPtx2465Rs106, r_ConvertedE4PairAtPtx2469Rs107, r_ConvertedE4PairAtPtx2472Rs108;
	uint16_t r_ConvertedE4PairAtPtx2476Rs109, r_ConvertedE4PairAtPtx2479Rs110,
		r_ConvertedE4PairAtPtx2483Rs111, r_ConvertedE4PairAtPtx2486Rs112, r_ConvertedE4PairAtPtx3144Rs113,
		r_ConvertedE4PairAtPtx3147Rs114, r_ConvertedE4PairAtPtx3151Rs115, r_ConvertedE4PairAtPtx3154Rs116,
		r_ConvertedE4PairAtPtx3158Rs117, r_ConvertedE4PairAtPtx3161Rs118, r_ConvertedE4PairAtPtx3165Rs119,
		r_ConvertedE4PairAtPtx3168Rs120;
	uint16_t r_ConvertedE4PairAtPtx3172Rs121, r_ConvertedE4PairAtPtx3175Rs122,
		r_ConvertedE4PairAtPtx3179Rs123, r_ConvertedE4PairAtPtx3182Rs124, r_ConvertedE4PairAtPtx3186Rs125,
		r_ConvertedE4PairAtPtx3189Rs126, r_ConvertedE4PairAtPtx3193Rs127, r_ConvertedE4PairAtPtx3196Rs128,
		r_ConvertedE4PairAtPtx3854Rs129, r_ConvertedE4PairAtPtx3857Rs130, r_ConvertedE4PairAtPtx3861Rs131,
		r_ConvertedE4PairAtPtx3864Rs132;
	uint16_t r_ConvertedE4PairAtPtx3868Rs133, r_ConvertedE4PairAtPtx3871Rs134,
		r_ConvertedE4PairAtPtx3875Rs135, r_ConvertedE4PairAtPtx3878Rs136, r_ConvertedE4PairAtPtx3882Rs137,
		r_ConvertedE4PairAtPtx3885Rs138, r_ConvertedE4PairAtPtx3889Rs139, r_ConvertedE4PairAtPtx3892Rs140,
		r_ConvertedE4PairAtPtx3896Rs141, r_ConvertedE4PairAtPtx3899Rs142, r_ConvertedE4PairAtPtx3903Rs143,
		r_ConvertedE4PairAtPtx3906Rs144;
	uint16_t r_ConvertedE4PairAtPtx4005Rs145, r_ConvertedE4PairAtPtx4008Rs146,
		r_ConvertedE4PairAtPtx4012Rs147, r_ConvertedE4PairAtPtx4015Rs148, r_ConvertedE4PairAtPtx4019Rs149,
		r_ConvertedE4PairAtPtx4022Rs150, r_ConvertedE4PairAtPtx4026Rs151, r_ConvertedE4PairAtPtx4029Rs152,
		r_ConvertedE4PairAtPtx4033Rs153, r_ConvertedE4PairAtPtx4036Rs154, r_ConvertedE4PairAtPtx4040Rs155,
		r_ConvertedE4PairAtPtx4043Rs156;
	uint16_t r_ConvertedE4PairAtPtx4047Rs157, r_ConvertedE4PairAtPtx4050Rs158,
		r_ConvertedE4PairAtPtx4054Rs159, r_ConvertedE4PairAtPtx4057Rs160, r_ConvertedE4PairAtPtx4176Rs161,
		r_ConvertedE4PairAtPtx4179Rs162, r_ConvertedE4PairAtPtx4183Rs163, r_ConvertedE4PairAtPtx4186Rs164,
		r_ConvertedE4PairAtPtx4190Rs165, r_ConvertedE4PairAtPtx4193Rs166, r_ConvertedE4PairAtPtx4197Rs167,
		r_ConvertedE4PairAtPtx4200Rs168;
	uint16_t r_ConvertedE4PairAtPtx4204Rs169, r_ConvertedE4PairAtPtx4207Rs170,
		r_ConvertedE4PairAtPtx4211Rs171, r_ConvertedE4PairAtPtx4214Rs172, r_ConvertedE4PairAtPtx4218Rs173,
		r_ConvertedE4PairAtPtx4221Rs174, r_ConvertedE4PairAtPtx4225Rs175, r_ConvertedE4PairAtPtx4228Rs176,
		r_ConvertedE4PairAtPtx4232Rs177, r_ConvertedE4PairAtPtx4235Rs178, r_ConvertedE4PairAtPtx4239Rs179,
		r_ConvertedE4PairAtPtx4242Rs180;
	uint16_t r_ConvertedE4PairAtPtx4246Rs181, r_ConvertedE4PairAtPtx4249Rs182,
		r_ConvertedE4PairAtPtx4253Rs183, r_ConvertedE4PairAtPtx4256Rs184, r_ConvertedE4PairAtPtx4260Rs185,
		r_ConvertedE4PairAtPtx4263Rs186, r_ConvertedE4PairAtPtx4267Rs187, r_ConvertedE4PairAtPtx4270Rs188,
		r_ConvertedE4PairAtPtx4274Rs189, r_ConvertedE4PairAtPtx4277Rs190, r_ConvertedE4PairAtPtx4281Rs191,
		r_ConvertedE4PairAtPtx4284Rs192;
	uint16_t r_ConvertedE4PairAtPtx6528Rs193, r_ConvertedE4PairAtPtx6531Rs194,
		r_ConvertedE4PairAtPtx6535Rs195, r_ConvertedE4PairAtPtx6538Rs196, r_ConvertedE4PairAtPtx6542Rs197,
		r_ConvertedE4PairAtPtx6545Rs198, r_ConvertedE4PairAtPtx6549Rs199, r_ConvertedE4PairAtPtx6552Rs200,
		r_ConvertedE4PairAtPtx6556Rs201, r_ConvertedE4PairAtPtx6559Rs202, r_ConvertedE4PairAtPtx6563Rs203,
		r_ConvertedE4PairAtPtx6566Rs204;
	uint16_t r_ConvertedE4PairAtPtx6570Rs205, r_ConvertedE4PairAtPtx6573Rs206,
		r_ConvertedE4PairAtPtx6577Rs207, r_ConvertedE4PairAtPtx6580Rs208, r_ConvertedE4PairAtPtx6584Rs209,
		r_ConvertedE4PairAtPtx6587Rs210, r_ConvertedE4PairAtPtx6590Rs211, r_ConvertedE4PairAtPtx6593Rs212,
		r_ConvertedE4PairAtPtx6596Rs213, r_ConvertedE4PairAtPtx6599Rs214, r_ConvertedE4PairAtPtx6602Rs215,
		r_ConvertedE4PairAtPtx6605Rs216;
	uint16_t r_ConvertedE4PairAtPtx6608Rs217, r_ConvertedE4PairAtPtx6611Rs218,
		r_ConvertedE4PairAtPtx6614Rs219, r_ConvertedE4PairAtPtx6617Rs220, r_ConvertedE4PairAtPtx6620Rs221,
		r_ConvertedE4PairAtPtx6623Rs222, r_ConvertedE4PairAtPtx6626Rs223, r_ConvertedE4PairAtPtx6629Rs224,
		r_ConvertedE4PairAtPtx7728Rs225, r_ConvertedE4PairAtPtx7731Rs226, r_ConvertedE4PairAtPtx7735Rs227,
		r_ConvertedE4PairAtPtx7738Rs228;
	uint16_t r_ConvertedE4PairAtPtx7742Rs229, r_ConvertedE4PairAtPtx7745Rs230,
		r_ConvertedE4PairAtPtx7749Rs231, r_ConvertedE4PairAtPtx7752Rs232, r_ConvertedE4PairAtPtx7756Rs233,
		r_ConvertedE4PairAtPtx7759Rs234, r_ConvertedE4PairAtPtx7763Rs235, r_ConvertedE4PairAtPtx7766Rs236,
		r_ConvertedE4PairAtPtx7770Rs237, r_ConvertedE4PairAtPtx7773Rs238, r_ConvertedE4PairAtPtx7777Rs239,
		r_ConvertedE4PairAtPtx7780Rs240;
	uint16_t r_ConvertedE4PairAtPtx7784Rs241, r_ConvertedE4PairAtPtx7787Rs242,
		r_ConvertedE4PairAtPtx7791Rs243, r_ConvertedE4PairAtPtx7794Rs244, r_ConvertedE4PairAtPtx7798Rs245,
		r_ConvertedE4PairAtPtx7801Rs246, r_ConvertedE4PairAtPtx7805Rs247, r_ConvertedE4PairAtPtx7808Rs248,
		r_ConvertedE4PairAtPtx7812Rs249, r_ConvertedE4PairAtPtx7815Rs250, r_ConvertedE4PairAtPtx7819Rs251,
		r_ConvertedE4PairAtPtx7822Rs252;
	uint16_t r_ConvertedE4PairAtPtx7826Rs253, r_ConvertedE4PairAtPtx7829Rs254,
		r_ConvertedE4PairAtPtx7833Rs255, r_ConvertedE4PairAtPtx7836Rs256, r_ConvertedE4PairAtPtx7936Rs257,
		r_ConvertedE4PairAtPtx7939Rs258, r_ConvertedE4PairAtPtx7943Rs259, r_ConvertedE4PairAtPtx7946Rs260,
		r_ConvertedE4PairAtPtx7950Rs261, r_ConvertedE4PairAtPtx7953Rs262, r_ConvertedE4PairAtPtx7957Rs263,
		r_ConvertedE4PairAtPtx7960Rs264;
	uint16_t r_ConvertedE4PairAtPtx7964Rs265, r_ConvertedE4PairAtPtx7967Rs266,
		r_ConvertedE4PairAtPtx7971Rs267, r_ConvertedE4PairAtPtx7974Rs268, r_ConvertedE4PairAtPtx7978Rs269,
		r_ConvertedE4PairAtPtx7981Rs270, r_ConvertedE4PairAtPtx7985Rs271, r_ConvertedE4PairAtPtx7988Rs272,
		r_ConvertedE4PairAtPtx7992Rs273, r_ConvertedE4PairAtPtx7995Rs274, r_ConvertedE4PairAtPtx7999Rs275,
		r_ConvertedE4PairAtPtx8002Rs276;
	uint16_t r_ConvertedE4PairAtPtx8006Rs277, r_ConvertedE4PairAtPtx8009Rs278,
		r_ConvertedE4PairAtPtx8013Rs279, r_ConvertedE4PairAtPtx8016Rs280, r_ConvertedE4PairAtPtx8020Rs281,
		r_ConvertedE4PairAtPtx8023Rs282, r_ConvertedE4PairAtPtx8027Rs283, r_ConvertedE4PairAtPtx8030Rs284,
		r_ConvertedE4PairAtPtx8034Rs285, r_ConvertedE4PairAtPtx8037Rs286, r_ConvertedE4PairAtPtx8041Rs287,
		r_ConvertedE4PairAtPtx8044Rs288;
	uint16_t r_PtxU16Register289, r_ConvertedE4PairAtPtx9443Rs290, r_ConvertedE4PairAtPtx9446Rs291,
		r_ConvertedE4PairAtPtx9450Rs292, r_ConvertedE4PairAtPtx9453Rs293, r_ConvertedE4PairAtPtx9457Rs294,
		r_ConvertedE4PairAtPtx9460Rs295, r_ConvertedE4PairAtPtx9464Rs296, r_ConvertedE4PairAtPtx9467Rs297,
		r_ConvertedE4PairAtPtx9471Rs298, r_ConvertedE4PairAtPtx9474Rs299, r_ConvertedE4PairAtPtx9478Rs300;
	uint16_t r_ConvertedE4PairAtPtx9481Rs301, r_ConvertedE4PairAtPtx9485Rs302,
		r_ConvertedE4PairAtPtx9488Rs303, r_ConvertedE4PairAtPtx9492Rs304, r_ConvertedE4PairAtPtx9495Rs305,
		r_ConvertedE4PairAtPtx9499Rs306, r_ConvertedE4PairAtPtx9502Rs307, r_ConvertedE4PairAtPtx9506Rs308,
		r_ConvertedE4PairAtPtx9509Rs309, r_ConvertedE4PairAtPtx9513Rs310, r_ConvertedE4PairAtPtx9516Rs311,
		r_ConvertedE4PairAtPtx9520Rs312;
	uint16_t r_ConvertedE4PairAtPtx9523Rs313, r_ConvertedE4PairAtPtx9527Rs314,
		r_ConvertedE4PairAtPtx9530Rs315, r_ConvertedE4PairAtPtx9534Rs316, r_ConvertedE4PairAtPtx9537Rs317,
		r_ConvertedE4PairAtPtx9541Rs318, r_ConvertedE4PairAtPtx9544Rs319, r_ConvertedE4PairAtPtx9548Rs320,
		r_ConvertedE4PairAtPtx9551Rs321, r_PtxU16Register322, r_PtxU16Register323, r_PtxU16Register324;
	uint16_t r_PtxU16Register325, r_PtxU16Register326, r_PtxU16Register327, r_PtxU16Register328,
		r_PtxU16Register329, r_PtxU16Register330, r_PtxU16Register331, r_PtxU16Register332,
		r_PtxU16Register333, r_PtxU16Register334, r_PtxU16Register335, r_PtxU16Register336;
	uint16_t r_PtxU16Register337, r_ConvertedE4PairAtPtx10058Rs338, r_ConvertedE4PairAtPtx10061Rs339,
		r_ConvertedE4PairAtPtx10065Rs340, r_ConvertedE4PairAtPtx10068Rs341, r_ConvertedE4PairAtPtx10072Rs342,
		r_ConvertedE4PairAtPtx10075Rs343, r_ConvertedE4PairAtPtx10079Rs344, r_ConvertedE4PairAtPtx10082Rs345,
		r_ConvertedE4PairAtPtx10086Rs346, r_ConvertedE4PairAtPtx10089Rs347, r_ConvertedE4PairAtPtx10093Rs348;
	uint16_t r_ConvertedE4PairAtPtx10096Rs349, r_ConvertedE4PairAtPtx10100Rs350,
		r_ConvertedE4PairAtPtx10103Rs351, r_ConvertedE4PairAtPtx10107Rs352, r_ConvertedE4PairAtPtx10110Rs353,
		r_ConvertedE4PairAtPtx10318Rs354, r_ConvertedE4PairAtPtx10321Rs355, r_ConvertedE4PairAtPtx10324Rs356,
		r_ConvertedE4PairAtPtx10327Rs357, r_ConvertedE4PairAtPtx10330Rs358, r_ConvertedE4PairAtPtx10333Rs359,
		r_ConvertedE4PairAtPtx10336Rs360;
	uint16_t r_ConvertedE4PairAtPtx10339Rs361, r_ConvertedE4PairAtPtx10342Rs362,
		r_ConvertedE4PairAtPtx10345Rs363, r_ConvertedE4PairAtPtx10348Rs364, r_ConvertedE4PairAtPtx10351Rs365,
		r_ConvertedE4PairAtPtx10354Rs366, r_ConvertedE4PairAtPtx10357Rs367, r_ConvertedE4PairAtPtx10360Rs368,
		r_ConvertedE4PairAtPtx10363Rs369, r_PtxU16Register370, r_PtxU16Register371, r_PtxU16Register372;
	uint16_t r_PtxU16Register373, r_PtxU16Register374, r_PtxU16Register375, r_PtxU16Register376,
		r_PtxU16Register377, r_PtxU16Register378, r_PtxU16Register379, r_PtxU16Register380,
		r_PtxU16Register381, r_PtxU16Register382, r_PtxU16Register383, r_PtxU16Register384;
	uint16_t r_PtxU16Register385, r_PtxU16Register386, r_PtxU16Register387, r_PtxU16Register388,
		r_PtxU16Register389, r_PtxU16Register390, r_PtxU16Register391, r_PtxU16Register392,
		r_PtxU16Register393, r_PtxU16Register394, r_PtxU16Register395, r_PtxU16Register396;
	uint16_t r_PtxU16Register397, r_PtxU16Register398, r_PtxU16Register399, r_PtxU16Register400,
		r_PtxU16Register401, r_PtxU16Register402, r_PtxU16Register403, r_PtxU16Register404,
		r_PtxU16Register405, r_PtxU16Register406, r_PtxU16Register407, r_ConvertedE4PairAtPtx11778Rs408;
	uint16_t r_ConvertedE4PairAtPtx11781Rs409, r_ConvertedE4PairAtPtx11785Rs410,
		r_ConvertedE4PairAtPtx11788Rs411, r_ConvertedE4PairAtPtx11792Rs412, r_ConvertedE4PairAtPtx11795Rs413,
		r_ConvertedE4PairAtPtx11799Rs414, r_ConvertedE4PairAtPtx11802Rs415, r_ConvertedE4PairAtPtx11806Rs416,
		r_ConvertedE4PairAtPtx11809Rs417, r_ConvertedE4PairAtPtx11813Rs418, r_ConvertedE4PairAtPtx11816Rs419,
		r_ConvertedE4PairAtPtx11820Rs420;
	uint16_t r_ConvertedE4PairAtPtx11823Rs421, r_ConvertedE4PairAtPtx11827Rs422,
		r_ConvertedE4PairAtPtx11830Rs423, r_ConvertedE4PairAtPtx11834Rs424, r_ConvertedE4PairAtPtx11837Rs425,
		r_ConvertedE4PairAtPtx11841Rs426, r_ConvertedE4PairAtPtx11844Rs427, r_ConvertedE4PairAtPtx11848Rs428,
		r_ConvertedE4PairAtPtx11851Rs429, r_ConvertedE4PairAtPtx11855Rs430, r_ConvertedE4PairAtPtx11858Rs431,
		r_ConvertedE4PairAtPtx11862Rs432;
	uint16_t r_ConvertedE4PairAtPtx11865Rs433, r_ConvertedE4PairAtPtx11869Rs434,
		r_ConvertedE4PairAtPtx11872Rs435, r_ConvertedE4PairAtPtx11876Rs436, r_ConvertedE4PairAtPtx11879Rs437,
		r_ConvertedE4PairAtPtx11883Rs438, r_ConvertedE4PairAtPtx11886Rs439, r_PtxU16Register440,
		r_PtxU16Register441, r_PtxU16Register442, r_PtxU16Register443, r_PtxU16Register444;
	uint16_t r_PtxU16Register445, r_PtxU16Register446, r_PtxU16Register447, r_PtxU16Register448,
		r_PtxU16Register449, r_PtxU16Register450, r_PtxU16Register451, r_PtxU16Register452,
		r_PtxU16Register453, r_PtxU16Register454, r_PtxU16Register455, r_ConvertedE4PairAtPtx12389Rs456;
	uint16_t r_ConvertedE4PairAtPtx12392Rs457, r_ConvertedE4PairAtPtx12396Rs458,
		r_ConvertedE4PairAtPtx12399Rs459, r_ConvertedE4PairAtPtx12403Rs460, r_ConvertedE4PairAtPtx12406Rs461,
		r_ConvertedE4PairAtPtx12410Rs462, r_ConvertedE4PairAtPtx12413Rs463, r_ConvertedE4PairAtPtx12417Rs464,
		r_ConvertedE4PairAtPtx12420Rs465, r_ConvertedE4PairAtPtx12424Rs466, r_ConvertedE4PairAtPtx12427Rs467,
		r_ConvertedE4PairAtPtx12431Rs468;
	uint16_t r_ConvertedE4PairAtPtx12434Rs469, r_ConvertedE4PairAtPtx12438Rs470,
		r_ConvertedE4PairAtPtx12441Rs471, r_ConvertedE4PairAtPtx12647Rs472, r_ConvertedE4PairAtPtx12650Rs473,
		r_ConvertedE4PairAtPtx12653Rs474, r_ConvertedE4PairAtPtx12656Rs475, r_ConvertedE4PairAtPtx12659Rs476,
		r_ConvertedE4PairAtPtx12662Rs477, r_ConvertedE4PairAtPtx12665Rs478, r_ConvertedE4PairAtPtx12668Rs479,
		r_ConvertedE4PairAtPtx12671Rs480;
	uint16_t r_ConvertedE4PairAtPtx12674Rs481, r_ConvertedE4PairAtPtx12677Rs482,
		r_ConvertedE4PairAtPtx12680Rs483, r_ConvertedE4PairAtPtx12683Rs484, r_ConvertedE4PairAtPtx12686Rs485,
		r_ConvertedE4PairAtPtx12689Rs486, r_ConvertedE4PairAtPtx12692Rs487, r_PtxU16Register488,
		r_PtxU16Register489, r_PtxU16Register490, r_PtxU16Register491, r_PtxU16Register492;
	uint16_t r_PtxU16Register493, r_PtxU16Register494, r_ConvertedE4PairAtPtx13106Rs495,
		r_ConvertedE4PairAtPtx13109Rs496, r_ConvertedE4PairAtPtx13113Rs497, r_ConvertedE4PairAtPtx13116Rs498,
		r_ConvertedE4PairAtPtx13120Rs499, r_ConvertedE4PairAtPtx13123Rs500, r_ConvertedE4PairAtPtx13127Rs501,
		r_ConvertedE4PairAtPtx13130Rs502;
	uint32_t r_PtxRegister1, r_PtxRegister2, r_PtxRegister3, r_HeightDiv4Bits, r_WidthDiv4Bits,
		r_PtxRegister6, r_PtxRegister7, r_PtxRegister8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11,
		r_PtxRegister12;
	uint32_t r_PtxRegister13, r_ThreadYAtPtx4287, r_PtxRegister15, r_PackedHalf2AtPtx8240R16,
		r_PackedHalf2AtPtx8247R17, r_PackedHalf2AtPtx8254R18, r_PackedHalf2AtPtx8261R19, r_PtxRegister20,
		r_PtxRegister21, r_PtxRegister22, r_PtxRegister23, r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41,
		r_PtxRegister42, r_PtxRegister43, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46, r_ThreadX,
		r_BlockSizeX;
	uint32_t r_BlockSizeY, r_ThreadZ, r_BlockSizeZ, r_PtxRegister52, r_PtxRegister53, r_PtxRegister54,
		r_PtxRegister55, r_PtxRegister56, r_PtxRegister57, r_PtxRegister58, r_PtxRegister59, r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_PtxRegister71,
		r_PtxRegister72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_PtxRegister75, r_PtxRegister76, r_PtxRegister77,
		r_PtxRegister78, r_PtxRegister79, r_HeightBits, r_WidthBits, r_OriginXBits, r_OriginYBits,
		r_DownHeightBits;
	uint32_t r_DownWidthBits, r_CtaXAtPtx20, r_CtaYAtPtx21, r_PtxRegister88, r_PtxRegister89, r_PtxRegister90,
		r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94, r_PtxRegister95, r_PtxRegister96;
	uint32_t r_HeightSignBits, r_HeightDiv4Bias, r_HeightBiasedForDiv4, r_WidthSignBits, r_WidthDiv4Bias,
		r_WidthBiasedForDiv4, r_ThreadYAtPtx42, r_PtxRegister104, r_PtxRegister105, r_PackedHalf2AtPtx88R106,
		r_LaneIndexAtPtx74, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PackedHalf2AtPtx141R112,
		r_LaneIndexAtPtx126, r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117,
		r_PackedHalf2AtPtx197R118, r_LaneIndexAtPtx183, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PackedHalf2AtPtx250R124,
		r_LaneIndexAtPtx235, r_PtxRegister126, r_PtxRegister127, r_LaneIndexAtPtx360, r_LaneIndexAtPtx371,
		r_LaneIndexAtPtx382, r_LaneIndexAtPtx394, r_LaneIndexAtPtx406;
	uint32_t r_LaneIndexAtPtx418, r_LaneIndexAtPtx430, r_LaneIndexAtPtx442, r_LaneIndexAtPtx454,
		r_LaneIndexAtPtx466, r_LaneIndexAtPtx478, r_LaneIndexAtPtx490, r_LaneIndexAtPtx502,
		r_LaneIndexAtPtx514, r_LaneIndexAtPtx526, r_LaneIndexAtPtx538, r_LaneIndexAtPtx550;
	uint32_t r_LaneIndexAtPtx561, r_LaneIndexAtPtx572, r_LaneIndexAtPtx584, r_LaneIndexAtPtx596,
		r_LaneIndexAtPtx608, r_LaneIndexAtPtx620, r_LaneIndexAtPtx632, r_LaneIndexAtPtx644,
		r_LaneIndexAtPtx656, r_LaneIndexAtPtx668, r_LaneIndexAtPtx680, r_LaneIndexAtPtx692;
	uint32_t r_LaneIndexAtPtx704, r_LaneIndexAtPtx716, r_LaneIndexAtPtx728, r_LaneIndexAtPtx740,
		r_PtxRegister161, r_LaneIndexAtPtx747, r_PtxRegister163, r_LaneIndexAtPtx754, r_PtxRegister165,
		r_LaneIndexAtPtx761, r_PtxRegister167, r_LaneIndexAtPtx768;
	uint32_t r_PtxRegister169, r_LaneIndexAtPtx775, r_PtxRegister171, r_LaneIndexAtPtx782, r_PtxRegister173,
		r_LaneIndexAtPtx789, r_PtxRegister175, r_LaneIndexAtPtx796, r_PtxRegister177, r_LaneIndexAtPtx803,
		r_PtxRegister179, r_LaneIndexAtPtx810;
	uint32_t r_PtxRegister181, r_LaneIndexAtPtx817, r_PtxRegister183, r_LaneIndexAtPtx824, r_PtxRegister185,
		r_LaneIndexAtPtx831, r_PtxRegister187, r_LaneIndexAtPtx838, r_PtxRegister189, r_LaneIndexAtPtx845,
		r_PtxRegister191, r_LaneIndexAtPtx852;
	uint32_t r_PtxRegister193, r_LaneIndexAtPtx859, r_PtxRegister195, r_LaneIndexAtPtx866, r_PtxRegister197,
		r_LaneIndexAtPtx873, r_PtxRegister199, r_LaneIndexAtPtx880, r_PtxRegister201, r_LaneIndexAtPtx887,
		r_PtxRegister203, r_LaneIndexAtPtx894;
	uint32_t r_PtxRegister205, r_LaneIndexAtPtx901, r_PtxRegister207, r_LaneIndexAtPtx908, r_PtxRegister209,
		r_LaneIndexAtPtx915, r_PtxRegister211, r_LaneIndexAtPtx922, r_PtxRegister213, r_LaneIndexAtPtx929,
		r_PtxRegister215, r_LaneIndexAtPtx936;
	uint32_t r_PtxRegister217, r_LaneIndexAtPtx943, r_PtxRegister219, r_LaneIndexAtPtx950, r_PtxRegister221,
		r_LaneIndexAtPtx957, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225, r_PtxRegister226,
		r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_PtxRegister231, r_PtxRegister232, r_PtxRegister233,
		r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_PtxRegister237, r_PtxRegister238,
		r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PtxRegister243, r_PtxRegister244, r_PtxRegister245,
		r_PtxRegister246, r_PtxRegister247, r_PtxRegister248, r_PtxRegister249, r_PtxRegister250,
		r_PtxRegister251, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256, r_PtxRegister257,
		r_PtxRegister258, r_PtxRegister259, r_PtxRegister260, r_PtxRegister261, r_PtxRegister262,
		r_PtxRegister263, r_PtxRegister264;
	uint32_t r_PtxRegister265, r_PtxRegister266, r_PtxRegister267, r_PtxRegister268, r_PtxRegister269,
		r_PtxRegister270, r_PtxRegister271, r_PtxRegister272, r_PtxRegister273, r_PtxRegister274,
		r_PtxRegister275, r_PtxRegister276;
	uint32_t r_PtxRegister277, r_PtxRegister278, r_PtxRegister279, r_PtxRegister280, r_PtxRegister281,
		r_PtxRegister282, r_PtxRegister283, r_PtxRegister284, r_PtxRegister285, r_PtxRegister286,
		r_PtxRegister287, r_PtxRegister288;
	uint32_t r_PtxRegister289, r_PtxRegister290, r_PtxRegister291, r_PtxRegister292, r_PtxRegister293,
		r_PtxRegister294, r_PtxRegister295, r_PtxRegister296, r_PtxRegister297, r_PtxRegister298,
		r_PtxRegister299, r_PtxRegister300;
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
	uint32_t r_PtxRegister409, r_PtxRegister410, r_PtxRegister411, r_LaneIndexAtPtx977, r_LaneIndexAtPtx985,
		r_PackedHalf2AtPtx260R414, r_PackedHalf2AtPtx263R415, r_PackedHalf2AtPtx266R416,
		r_PackedHalf2AtPtx269R417, r_PackedHalf2AtPtx272R418, r_PackedHalf2AtPtx275R419,
		r_PackedHalf2AtPtx278R420;
	uint32_t r_PackedHalf2AtPtx281R421, r_PackedHalf2AtPtx308R422, r_PackedHalf2AtPtx311R423,
		r_PackedHalf2AtPtx314R424, r_PackedHalf2AtPtx317R425, r_PackedHalf2AtPtx320R426,
		r_PackedHalf2AtPtx323R427, r_PackedHalf2AtPtx326R428, r_PackedHalf2AtPtx329R429,
		r_MmaBE4x4WordAtPtx982R430, r_MmaBE4x4WordAtPtx982R431, r_MmaAE4x4WordAtPtx999R432;
	uint32_t r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434, r_MmaAE4x4WordAtPtx1020R435,
		r_MmaBE4x4WordAtPtx982R436, r_MmaBE4x4WordAtPtx982R437, r_MmaBE4x4WordAtPtx991R438,
		r_MmaBE4x4WordAtPtx991R439, r_MmaBE4x4WordAtPtx991R440, r_MmaBE4x4WordAtPtx991R441,
		r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444;
	uint32_t r_MmaAE4x4WordAtPtx1048R445, r_LaneIndexAtPtx1106, r_LaneIndexAtPtx1115,
		r_PackedHalf2AtPtx284R448, r_PackedHalf2AtPtx287R449, r_PackedHalf2AtPtx290R450,
		r_PackedHalf2AtPtx293R451, r_PackedHalf2AtPtx296R452, r_PackedHalf2AtPtx299R453,
		r_PackedHalf2AtPtx302R454, r_PackedHalf2AtPtx305R455, r_PackedHalf2AtPtx333R456;
	uint32_t r_PackedHalf2AtPtx336R457, r_PackedHalf2AtPtx340R458, r_PackedHalf2AtPtx343R459,
		r_PackedHalf2AtPtx347R460, r_PackedHalf2AtPtx350R461, r_PackedHalf2AtPtx354R462,
		r_PackedHalf2AtPtx357R463, r_MmaBE4x4WordAtPtx1112R464, r_MmaBE4x4WordAtPtx1112R465,
		r_MmaAccumulatorHalf2WordAtPtx1050R466, r_MmaAccumulatorHalf2WordAtPtx1050R467,
		r_MmaAE4x4WordAtPtx1129R468;
	uint32_t r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470, r_MmaAE4x4WordAtPtx1150R471,
		r_MmaBE4x4WordAtPtx1112R472, r_MmaBE4x4WordAtPtx1112R473, r_MmaAccumulatorHalf2WordAtPtx1057R474,
		r_MmaAccumulatorHalf2WordAtPtx1057R475, r_MmaBE4x4WordAtPtx1121R476, r_MmaBE4x4WordAtPtx1121R477,
		r_MmaAccumulatorHalf2WordAtPtx1064R478, r_MmaAccumulatorHalf2WordAtPtx1064R479,
		r_MmaBE4x4WordAtPtx1121R480;
	uint32_t r_MmaBE4x4WordAtPtx1121R481, r_MmaAccumulatorHalf2WordAtPtx1071R482,
		r_MmaAccumulatorHalf2WordAtPtx1071R483, r_MmaAccumulatorHalf2WordAtPtx1078R484,
		r_MmaAccumulatorHalf2WordAtPtx1078R485, r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487,
		r_MmaAE4x4WordAtPtx1171R488, r_MmaAE4x4WordAtPtx1178R489, r_MmaAccumulatorHalf2WordAtPtx1085R490,
		r_MmaAccumulatorHalf2WordAtPtx1085R491, r_MmaAccumulatorHalf2WordAtPtx1092R492;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1092R493, r_MmaAccumulatorHalf2WordAtPtx1099R494,
		r_MmaAccumulatorHalf2WordAtPtx1099R495, r_LaneIndexAtPtx1236, r_Float32BitsAtPtx1238R497,
		r_Float32BitsAtPtx1245R498, r_Float32BitsAtPtx1252R499, r_Float32BitsAtPtx1259R500,
		r_Float32BitsAtPtx1266R501, r_MmaAccumulatorHalf2WordAtPtx1180R502, r_PackedHalf2AtPtx1247R503,
		r_PackedHalf2AtPtx1274R504;
	uint32_t r_PackedHalf2AtPtx1240R505, r_PackedHalf2AtPtx1278R506, r_PackedHalf2AtPtx1268R507,
		r_PackedHalf2AtPtx1282R508, r_PackedHalf2AtPtx1261R509, r_PackedHalf2AtPtx1286R510,
		r_PackedHalf2AtPtx1254R511, r_PackedHalf2AtPtx1290R512, r_LaneIndexAtPtx1298,
		r_MmaAccumulatorHalf2WordAtPtx1180R514, r_PackedHalf2AtPtx1301R515, r_PackedHalf2AtPtx1305R516;
	uint32_t r_PackedHalf2AtPtx1309R517, r_PackedHalf2AtPtx1313R518, r_PackedHalf2AtPtx1317R519,
		r_LaneIndexAtPtx1325, r_MmaAccumulatorHalf2WordAtPtx1187R521, r_PackedHalf2AtPtx1328R522,
		r_PackedHalf2AtPtx1332R523, r_PackedHalf2AtPtx1336R524, r_PackedHalf2AtPtx1340R525,
		r_PackedHalf2AtPtx1344R526, r_LaneIndexAtPtx1352, r_MmaAccumulatorHalf2WordAtPtx1187R528;
	uint32_t r_PackedHalf2AtPtx1355R529, r_PackedHalf2AtPtx1359R530, r_PackedHalf2AtPtx1363R531,
		r_PackedHalf2AtPtx1367R532, r_PackedHalf2AtPtx1371R533, r_LaneIndexAtPtx1379,
		r_MmaAccumulatorHalf2WordAtPtx1194R535, r_PackedHalf2AtPtx1382R536, r_PackedHalf2AtPtx1386R537,
		r_PackedHalf2AtPtx1390R538, r_PackedHalf2AtPtx1394R539, r_PackedHalf2AtPtx1398R540;
	uint32_t r_LaneIndexAtPtx1406, r_MmaAccumulatorHalf2WordAtPtx1194R542, r_PackedHalf2AtPtx1409R543,
		r_PackedHalf2AtPtx1413R544, r_PackedHalf2AtPtx1417R545, r_PackedHalf2AtPtx1421R546,
		r_PackedHalf2AtPtx1425R547, r_LaneIndexAtPtx1433, r_MmaAccumulatorHalf2WordAtPtx1201R549,
		r_PackedHalf2AtPtx1436R550, r_PackedHalf2AtPtx1440R551, r_PackedHalf2AtPtx1444R552;
	uint32_t r_PackedHalf2AtPtx1448R553, r_PackedHalf2AtPtx1452R554, r_LaneIndexAtPtx1460,
		r_MmaAccumulatorHalf2WordAtPtx1201R556, r_PackedHalf2AtPtx1463R557, r_PackedHalf2AtPtx1467R558,
		r_PackedHalf2AtPtx1471R559, r_PackedHalf2AtPtx1475R560, r_PackedHalf2AtPtx1479R561,
		r_LaneIndexAtPtx1487, r_MmaAccumulatorHalf2WordAtPtx1208R563, r_PackedHalf2AtPtx1490R564;
	uint32_t r_PackedHalf2AtPtx1494R565, r_PackedHalf2AtPtx1498R566, r_PackedHalf2AtPtx1502R567,
		r_PackedHalf2AtPtx1506R568, r_LaneIndexAtPtx1514, r_MmaAccumulatorHalf2WordAtPtx1208R570,
		r_PackedHalf2AtPtx1517R571, r_PackedHalf2AtPtx1521R572, r_PackedHalf2AtPtx1525R573,
		r_PackedHalf2AtPtx1529R574, r_PackedHalf2AtPtx1533R575, r_LaneIndexAtPtx1541;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1215R577, r_PackedHalf2AtPtx1544R578, r_PackedHalf2AtPtx1548R579,
		r_PackedHalf2AtPtx1552R580, r_PackedHalf2AtPtx1556R581, r_PackedHalf2AtPtx1560R582,
		r_LaneIndexAtPtx1568, r_MmaAccumulatorHalf2WordAtPtx1215R584, r_PackedHalf2AtPtx1571R585,
		r_PackedHalf2AtPtx1575R586, r_PackedHalf2AtPtx1579R587, r_PackedHalf2AtPtx1583R588;
	uint32_t r_PackedHalf2AtPtx1587R589, r_LaneIndexAtPtx1595, r_MmaAccumulatorHalf2WordAtPtx1222R591,
		r_PackedHalf2AtPtx1598R592, r_PackedHalf2AtPtx1602R593, r_PackedHalf2AtPtx1606R594,
		r_PackedHalf2AtPtx1610R595, r_PackedHalf2AtPtx1614R596, r_LaneIndexAtPtx1622,
		r_MmaAccumulatorHalf2WordAtPtx1222R598, r_PackedHalf2AtPtx1625R599, r_PackedHalf2AtPtx1629R600;
	uint32_t r_PackedHalf2AtPtx1633R601, r_PackedHalf2AtPtx1637R602, r_PackedHalf2AtPtx1641R603,
		r_LaneIndexAtPtx1649, r_MmaAccumulatorHalf2WordAtPtx1229R605, r_PackedHalf2AtPtx1652R606,
		r_PackedHalf2AtPtx1656R607, r_PackedHalf2AtPtx1660R608, r_PackedHalf2AtPtx1664R609,
		r_PackedHalf2AtPtx1668R610, r_LaneIndexAtPtx1676, r_MmaAccumulatorHalf2WordAtPtx1229R612;
	uint32_t r_PackedHalf2AtPtx1679R613, r_PackedHalf2AtPtx1683R614, r_PackedHalf2AtPtx1687R615,
		r_PackedHalf2AtPtx1691R616, r_PackedHalf2AtPtx1695R617, r_LaneIndexAtPtx1706, r_LaneIndexAtPtx1715,
		r_PackedHalf2AtPtx1294R620, r_PackedHalf2AtPtx1348R621, r_PackedHalf2AtPtx1321R622,
		r_PackedHalf2AtPtx1375R623, r_PackedHalf2AtPtx1402R624;
	uint32_t r_PackedHalf2AtPtx1456R625, r_PackedHalf2AtPtx1429R626, r_PackedHalf2AtPtx1483R627,
		r_PackedHalf2AtPtx1510R628, r_PackedHalf2AtPtx1564R629, r_PackedHalf2AtPtx1537R630,
		r_PackedHalf2AtPtx1591R631, r_PackedHalf2AtPtx1618R632, r_PackedHalf2AtPtx1672R633,
		r_PackedHalf2AtPtx1645R634, r_PackedHalf2AtPtx1699R635, r_MmaBE4x4WordAtPtx1712R636;
	uint32_t r_MmaBE4x4WordAtPtx1712R637, r_MmaAE4x4WordAtPtx1729R638, r_MmaAE4x4WordAtPtx1736R639,
		r_MmaAE4x4WordAtPtx1743R640, r_MmaAE4x4WordAtPtx1750R641, r_MmaBE4x4WordAtPtx1712R642,
		r_MmaBE4x4WordAtPtx1712R643, r_MmaBE4x4WordAtPtx1721R644, r_MmaBE4x4WordAtPtx1721R645,
		r_MmaBE4x4WordAtPtx1721R646, r_MmaBE4x4WordAtPtx1721R647, r_MmaAE4x4WordAtPtx1757R648;
	uint32_t r_MmaAE4x4WordAtPtx1764R649, r_MmaAE4x4WordAtPtx1771R650, r_MmaAE4x4WordAtPtx1778R651,
		r_LaneIndexAtPtx1836, r_LaneIndexAtPtx1845, r_MmaBE4x4WordAtPtx1842R654, r_MmaBE4x4WordAtPtx1842R655,
		r_MmaBE4x4WordAtPtx1842R656, r_MmaBE4x4WordAtPtx1842R657, r_MmaBE4x4WordAtPtx1851R658,
		r_MmaBE4x4WordAtPtx1851R659, r_MmaBE4x4WordAtPtx1851R660;
	uint32_t r_MmaBE4x4WordAtPtx1851R661, r_LaneIndexAtPtx1910, r_LaneIndexAtPtx1919,
		r_MmaBE4x4WordAtPtx1916R664, r_MmaBE4x4WordAtPtx1916R665, r_MmaAccumulatorHalf2WordAtPtx1854R666,
		r_MmaAccumulatorHalf2WordAtPtx1854R667, r_MmaBE4x4WordAtPtx1916R668, r_MmaBE4x4WordAtPtx1916R669,
		r_MmaAccumulatorHalf2WordAtPtx1861R670, r_MmaAccumulatorHalf2WordAtPtx1861R671,
		r_MmaBE4x4WordAtPtx1925R672;
	uint32_t r_MmaBE4x4WordAtPtx1925R673, r_MmaAccumulatorHalf2WordAtPtx1868R674,
		r_MmaAccumulatorHalf2WordAtPtx1868R675, r_MmaBE4x4WordAtPtx1925R676, r_MmaBE4x4WordAtPtx1925R677,
		r_MmaAccumulatorHalf2WordAtPtx1875R678, r_MmaAccumulatorHalf2WordAtPtx1875R679,
		r_MmaAccumulatorHalf2WordAtPtx1882R680, r_MmaAccumulatorHalf2WordAtPtx1882R681,
		r_MmaAccumulatorHalf2WordAtPtx1889R682, r_MmaAccumulatorHalf2WordAtPtx1889R683,
		r_MmaAccumulatorHalf2WordAtPtx1896R684;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1896R685, r_MmaAccumulatorHalf2WordAtPtx1903R686,
		r_MmaAccumulatorHalf2WordAtPtx1903R687, r_LaneIndexAtPtx1984, r_MmaAccumulatorHalf2WordAtPtx1928R689,
		r_PackedHalf2AtPtx1987R690, r_PackedHalf2AtPtx1991R691, r_PackedHalf2AtPtx1995R692,
		r_PackedHalf2AtPtx1999R693, r_PackedHalf2AtPtx2003R694, r_LaneIndexAtPtx2011,
		r_MmaAccumulatorHalf2WordAtPtx1928R696;
	uint32_t r_PackedHalf2AtPtx2014R697, r_PackedHalf2AtPtx2018R698, r_PackedHalf2AtPtx2022R699,
		r_PackedHalf2AtPtx2026R700, r_PackedHalf2AtPtx2030R701, r_LaneIndexAtPtx2038,
		r_MmaAccumulatorHalf2WordAtPtx1935R703, r_PackedHalf2AtPtx2041R704, r_PackedHalf2AtPtx2045R705,
		r_PackedHalf2AtPtx2049R706, r_PackedHalf2AtPtx2053R707, r_PackedHalf2AtPtx2057R708;
	uint32_t r_LaneIndexAtPtx2065, r_MmaAccumulatorHalf2WordAtPtx1935R710, r_PackedHalf2AtPtx2068R711,
		r_PackedHalf2AtPtx2072R712, r_PackedHalf2AtPtx2076R713, r_PackedHalf2AtPtx2080R714,
		r_PackedHalf2AtPtx2084R715, r_LaneIndexAtPtx2092, r_MmaAccumulatorHalf2WordAtPtx1942R717,
		r_PackedHalf2AtPtx2095R718, r_PackedHalf2AtPtx2099R719, r_PackedHalf2AtPtx2103R720;
	uint32_t r_PackedHalf2AtPtx2107R721, r_PackedHalf2AtPtx2111R722, r_LaneIndexAtPtx2119,
		r_MmaAccumulatorHalf2WordAtPtx1942R724, r_PackedHalf2AtPtx2122R725, r_PackedHalf2AtPtx2126R726,
		r_PackedHalf2AtPtx2130R727, r_PackedHalf2AtPtx2134R728, r_PackedHalf2AtPtx2138R729,
		r_LaneIndexAtPtx2146, r_MmaAccumulatorHalf2WordAtPtx1949R731, r_PackedHalf2AtPtx2149R732;
	uint32_t r_PackedHalf2AtPtx2153R733, r_PackedHalf2AtPtx2157R734, r_PackedHalf2AtPtx2161R735,
		r_PackedHalf2AtPtx2165R736, r_LaneIndexAtPtx2173, r_MmaAccumulatorHalf2WordAtPtx1949R738,
		r_PackedHalf2AtPtx2176R739, r_PackedHalf2AtPtx2180R740, r_PackedHalf2AtPtx2184R741,
		r_PackedHalf2AtPtx2188R742, r_PackedHalf2AtPtx2192R743, r_LaneIndexAtPtx2200;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1956R745, r_PackedHalf2AtPtx2203R746, r_PackedHalf2AtPtx2207R747,
		r_PackedHalf2AtPtx2211R748, r_PackedHalf2AtPtx2215R749, r_PackedHalf2AtPtx2219R750,
		r_LaneIndexAtPtx2227, r_MmaAccumulatorHalf2WordAtPtx1956R752, r_PackedHalf2AtPtx2230R753,
		r_PackedHalf2AtPtx2234R754, r_PackedHalf2AtPtx2238R755, r_PackedHalf2AtPtx2242R756;
	uint32_t r_PackedHalf2AtPtx2246R757, r_LaneIndexAtPtx2254, r_MmaAccumulatorHalf2WordAtPtx1963R759,
		r_PackedHalf2AtPtx2257R760, r_PackedHalf2AtPtx2261R761, r_PackedHalf2AtPtx2265R762,
		r_PackedHalf2AtPtx2269R763, r_PackedHalf2AtPtx2273R764, r_LaneIndexAtPtx2281,
		r_MmaAccumulatorHalf2WordAtPtx1963R766, r_PackedHalf2AtPtx2284R767, r_PackedHalf2AtPtx2288R768;
	uint32_t r_PackedHalf2AtPtx2292R769, r_PackedHalf2AtPtx2296R770, r_PackedHalf2AtPtx2300R771,
		r_LaneIndexAtPtx2308, r_MmaAccumulatorHalf2WordAtPtx1970R773, r_PackedHalf2AtPtx2311R774,
		r_PackedHalf2AtPtx2315R775, r_PackedHalf2AtPtx2319R776, r_PackedHalf2AtPtx2323R777,
		r_PackedHalf2AtPtx2327R778, r_LaneIndexAtPtx2335, r_MmaAccumulatorHalf2WordAtPtx1970R780;
	uint32_t r_PackedHalf2AtPtx2338R781, r_PackedHalf2AtPtx2342R782, r_PackedHalf2AtPtx2346R783,
		r_PackedHalf2AtPtx2350R784, r_PackedHalf2AtPtx2354R785, r_LaneIndexAtPtx2362,
		r_MmaAccumulatorHalf2WordAtPtx1977R787, r_PackedHalf2AtPtx2365R788, r_PackedHalf2AtPtx2369R789,
		r_PackedHalf2AtPtx2373R790, r_PackedHalf2AtPtx2377R791, r_PackedHalf2AtPtx2381R792;
	uint32_t r_LaneIndexAtPtx2389, r_MmaAccumulatorHalf2WordAtPtx1977R794, r_PackedHalf2AtPtx2392R795,
		r_PackedHalf2AtPtx2396R796, r_PackedHalf2AtPtx2400R797, r_PackedHalf2AtPtx2404R798,
		r_PackedHalf2AtPtx2408R799, r_LaneIndexAtPtx2416, r_LaneIndexAtPtx2425, r_PackedHalf2AtPtx2007R802,
		r_PackedHalf2AtPtx2061R803, r_PackedHalf2AtPtx2034R804;
	uint32_t r_PackedHalf2AtPtx2088R805, r_PackedHalf2AtPtx2115R806, r_PackedHalf2AtPtx2169R807,
		r_PackedHalf2AtPtx2142R808, r_PackedHalf2AtPtx2196R809, r_PackedHalf2AtPtx2223R810,
		r_PackedHalf2AtPtx2277R811, r_PackedHalf2AtPtx2250R812, r_PackedHalf2AtPtx2304R813,
		r_PackedHalf2AtPtx2331R814, r_PackedHalf2AtPtx2385R815, r_PackedHalf2AtPtx2358R816;
	uint32_t r_PackedHalf2AtPtx2412R817, r_MmaBE4x4WordAtPtx2422R818, r_MmaBE4x4WordAtPtx2422R819,
		r_MmaAccumulatorHalf2WordAtPtx1780R820, r_MmaAccumulatorHalf2WordAtPtx1780R821,
		r_MmaAE4x4WordAtPtx2439R822, r_MmaAE4x4WordAtPtx2446R823, r_MmaAE4x4WordAtPtx2453R824,
		r_MmaAE4x4WordAtPtx2460R825, r_MmaBE4x4WordAtPtx2422R826, r_MmaBE4x4WordAtPtx2422R827,
		r_MmaAccumulatorHalf2WordAtPtx1787R828;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1787R829, r_MmaBE4x4WordAtPtx2431R830, r_MmaBE4x4WordAtPtx2431R831,
		r_MmaAccumulatorHalf2WordAtPtx1794R832, r_MmaAccumulatorHalf2WordAtPtx1794R833,
		r_MmaBE4x4WordAtPtx2431R834, r_MmaBE4x4WordAtPtx2431R835, r_MmaAccumulatorHalf2WordAtPtx1801R836,
		r_MmaAccumulatorHalf2WordAtPtx1801R837, r_MmaAccumulatorHalf2WordAtPtx1808R838,
		r_MmaAccumulatorHalf2WordAtPtx1808R839, r_MmaAE4x4WordAtPtx2467R840;
	uint32_t r_MmaAE4x4WordAtPtx2474R841, r_MmaAE4x4WordAtPtx2481R842, r_MmaAE4x4WordAtPtx2488R843,
		r_MmaAccumulatorHalf2WordAtPtx1815R844, r_MmaAccumulatorHalf2WordAtPtx1815R845,
		r_MmaAccumulatorHalf2WordAtPtx1822R846, r_MmaAccumulatorHalf2WordAtPtx1822R847,
		r_MmaAccumulatorHalf2WordAtPtx1829R848, r_MmaAccumulatorHalf2WordAtPtx1829R849, r_LaneIndexAtPtx2546,
		r_LaneIndexAtPtx2555, r_MmaBE4x4WordAtPtx2552R852;
	uint32_t r_MmaBE4x4WordAtPtx2552R853, r_MmaBE4x4WordAtPtx2552R854, r_MmaBE4x4WordAtPtx2552R855,
		r_MmaBE4x4WordAtPtx2561R856, r_MmaBE4x4WordAtPtx2561R857, r_MmaBE4x4WordAtPtx2561R858,
		r_MmaBE4x4WordAtPtx2561R859, r_LaneIndexAtPtx2620, r_LaneIndexAtPtx2629, r_MmaBE4x4WordAtPtx2626R862,
		r_MmaBE4x4WordAtPtx2626R863, r_MmaAccumulatorHalf2WordAtPtx2564R864;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2564R865, r_MmaBE4x4WordAtPtx2626R866, r_MmaBE4x4WordAtPtx2626R867,
		r_MmaAccumulatorHalf2WordAtPtx2571R868, r_MmaAccumulatorHalf2WordAtPtx2571R869,
		r_MmaBE4x4WordAtPtx2635R870, r_MmaBE4x4WordAtPtx2635R871, r_MmaAccumulatorHalf2WordAtPtx2578R872,
		r_MmaAccumulatorHalf2WordAtPtx2578R873, r_MmaBE4x4WordAtPtx2635R874, r_MmaBE4x4WordAtPtx2635R875,
		r_MmaAccumulatorHalf2WordAtPtx2585R876;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2585R877, r_MmaAccumulatorHalf2WordAtPtx2592R878,
		r_MmaAccumulatorHalf2WordAtPtx2592R879, r_MmaAccumulatorHalf2WordAtPtx2599R880,
		r_MmaAccumulatorHalf2WordAtPtx2599R881, r_MmaAccumulatorHalf2WordAtPtx2606R882,
		r_MmaAccumulatorHalf2WordAtPtx2606R883, r_MmaAccumulatorHalf2WordAtPtx2613R884,
		r_MmaAccumulatorHalf2WordAtPtx2613R885, r_LaneIndexAtPtx2694, r_MmaAccumulatorHalf2WordAtPtx2638R887,
		r_PackedHalf2AtPtx2697R888;
	uint32_t r_PackedHalf2AtPtx2701R889, r_PackedHalf2AtPtx2705R890, r_PackedHalf2AtPtx2709R891,
		r_PackedHalf2AtPtx2713R892, r_LaneIndexAtPtx2721, r_MmaAccumulatorHalf2WordAtPtx2638R894,
		r_PackedHalf2AtPtx2724R895, r_PackedHalf2AtPtx2728R896, r_PackedHalf2AtPtx2732R897,
		r_PackedHalf2AtPtx2736R898, r_PackedHalf2AtPtx2740R899, r_LaneIndexAtPtx2748;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2645R901, r_PackedHalf2AtPtx2751R902, r_PackedHalf2AtPtx2755R903,
		r_PackedHalf2AtPtx2759R904, r_PackedHalf2AtPtx2763R905, r_PackedHalf2AtPtx2767R906,
		r_LaneIndexAtPtx2775, r_MmaAccumulatorHalf2WordAtPtx2645R908, r_PackedHalf2AtPtx2778R909,
		r_PackedHalf2AtPtx2782R910, r_PackedHalf2AtPtx2786R911, r_PackedHalf2AtPtx2790R912;
	uint32_t r_PackedHalf2AtPtx2794R913, r_LaneIndexAtPtx2802, r_MmaAccumulatorHalf2WordAtPtx2652R915,
		r_PackedHalf2AtPtx2805R916, r_PackedHalf2AtPtx2809R917, r_PackedHalf2AtPtx2813R918,
		r_PackedHalf2AtPtx2817R919, r_PackedHalf2AtPtx2821R920, r_LaneIndexAtPtx2829,
		r_MmaAccumulatorHalf2WordAtPtx2652R922, r_PackedHalf2AtPtx2832R923, r_PackedHalf2AtPtx2836R924;
	uint32_t r_PackedHalf2AtPtx2840R925, r_PackedHalf2AtPtx2844R926, r_PackedHalf2AtPtx2848R927,
		r_LaneIndexAtPtx2856, r_MmaAccumulatorHalf2WordAtPtx2659R929, r_PackedHalf2AtPtx2859R930,
		r_PackedHalf2AtPtx2863R931, r_PackedHalf2AtPtx2867R932, r_PackedHalf2AtPtx2871R933,
		r_PackedHalf2AtPtx2875R934, r_LaneIndexAtPtx2883, r_MmaAccumulatorHalf2WordAtPtx2659R936;
	uint32_t r_PackedHalf2AtPtx2886R937, r_PackedHalf2AtPtx2890R938, r_PackedHalf2AtPtx2894R939,
		r_PackedHalf2AtPtx2898R940, r_PackedHalf2AtPtx2902R941, r_LaneIndexAtPtx2910,
		r_MmaAccumulatorHalf2WordAtPtx2666R943, r_PackedHalf2AtPtx2913R944, r_PackedHalf2AtPtx2917R945,
		r_PackedHalf2AtPtx2921R946, r_PackedHalf2AtPtx2925R947, r_PackedHalf2AtPtx2929R948;
	uint32_t r_LaneIndexAtPtx2937, r_MmaAccumulatorHalf2WordAtPtx2666R950, r_PackedHalf2AtPtx2940R951,
		r_PackedHalf2AtPtx2944R952, r_PackedHalf2AtPtx2948R953, r_PackedHalf2AtPtx2952R954,
		r_PackedHalf2AtPtx2956R955, r_LaneIndexAtPtx2964, r_MmaAccumulatorHalf2WordAtPtx2673R957,
		r_PackedHalf2AtPtx2967R958, r_PackedHalf2AtPtx2971R959, r_PackedHalf2AtPtx2975R960;
	uint32_t r_PackedHalf2AtPtx2979R961, r_PackedHalf2AtPtx2983R962, r_LaneIndexAtPtx2991,
		r_MmaAccumulatorHalf2WordAtPtx2673R964, r_PackedHalf2AtPtx2994R965, r_PackedHalf2AtPtx2998R966,
		r_PackedHalf2AtPtx3002R967, r_PackedHalf2AtPtx3006R968, r_PackedHalf2AtPtx3010R969,
		r_LaneIndexAtPtx3018, r_MmaAccumulatorHalf2WordAtPtx2680R971, r_PackedHalf2AtPtx3021R972;
	uint32_t r_PackedHalf2AtPtx3025R973, r_PackedHalf2AtPtx3029R974, r_PackedHalf2AtPtx3033R975,
		r_PackedHalf2AtPtx3037R976, r_LaneIndexAtPtx3045, r_MmaAccumulatorHalf2WordAtPtx2680R978,
		r_PackedHalf2AtPtx3048R979, r_PackedHalf2AtPtx3052R980, r_PackedHalf2AtPtx3056R981,
		r_PackedHalf2AtPtx3060R982, r_PackedHalf2AtPtx3064R983, r_LaneIndexAtPtx3072;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2687R985, r_PackedHalf2AtPtx3075R986, r_PackedHalf2AtPtx3079R987,
		r_PackedHalf2AtPtx3083R988, r_PackedHalf2AtPtx3087R989, r_PackedHalf2AtPtx3091R990,
		r_LaneIndexAtPtx3099, r_MmaAccumulatorHalf2WordAtPtx2687R992, r_PackedHalf2AtPtx3102R993,
		r_PackedHalf2AtPtx3106R994, r_PackedHalf2AtPtx3110R995, r_PackedHalf2AtPtx3114R996;
	uint32_t r_PackedHalf2AtPtx3118R997, r_LaneIndexAtPtx3126, r_LaneIndexAtPtx3135,
		r_PackedHalf2AtPtx2717R1000, r_PackedHalf2AtPtx2771R1001, r_PackedHalf2AtPtx2744R1002,
		r_PackedHalf2AtPtx2798R1003, r_PackedHalf2AtPtx2825R1004, r_PackedHalf2AtPtx2879R1005,
		r_PackedHalf2AtPtx2852R1006, r_PackedHalf2AtPtx2906R1007, r_PackedHalf2AtPtx2933R1008;
	uint32_t r_PackedHalf2AtPtx2987R1009, r_PackedHalf2AtPtx2960R1010, r_PackedHalf2AtPtx3014R1011,
		r_PackedHalf2AtPtx3041R1012, r_PackedHalf2AtPtx3095R1013, r_PackedHalf2AtPtx3068R1014,
		r_PackedHalf2AtPtx3122R1015, r_MmaBE4x4WordAtPtx3132R1016, r_MmaBE4x4WordAtPtx3132R1017,
		r_MmaAccumulatorHalf2WordAtPtx2490R1018, r_MmaAccumulatorHalf2WordAtPtx2490R1019,
		r_MmaAE4x4WordAtPtx3149R1020;
	uint32_t r_MmaAE4x4WordAtPtx3156R1021, r_MmaAE4x4WordAtPtx3163R1022, r_MmaAE4x4WordAtPtx3170R1023,
		r_MmaBE4x4WordAtPtx3132R1024, r_MmaBE4x4WordAtPtx3132R1025, r_MmaAccumulatorHalf2WordAtPtx2497R1026,
		r_MmaAccumulatorHalf2WordAtPtx2497R1027, r_MmaBE4x4WordAtPtx3141R1028, r_MmaBE4x4WordAtPtx3141R1029,
		r_MmaAccumulatorHalf2WordAtPtx2504R1030, r_MmaAccumulatorHalf2WordAtPtx2504R1031,
		r_MmaBE4x4WordAtPtx3141R1032;
	uint32_t r_MmaBE4x4WordAtPtx3141R1033, r_MmaAccumulatorHalf2WordAtPtx2511R1034,
		r_MmaAccumulatorHalf2WordAtPtx2511R1035, r_MmaAccumulatorHalf2WordAtPtx2518R1036,
		r_MmaAccumulatorHalf2WordAtPtx2518R1037, r_MmaAE4x4WordAtPtx3177R1038, r_MmaAE4x4WordAtPtx3184R1039,
		r_MmaAE4x4WordAtPtx3191R1040, r_MmaAE4x4WordAtPtx3198R1041, r_MmaAccumulatorHalf2WordAtPtx2525R1042,
		r_MmaAccumulatorHalf2WordAtPtx2525R1043, r_MmaAccumulatorHalf2WordAtPtx2532R1044;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2532R1045, r_MmaAccumulatorHalf2WordAtPtx2539R1046,
		r_MmaAccumulatorHalf2WordAtPtx2539R1047, r_LaneIndexAtPtx3256, r_LaneIndexAtPtx3265,
		r_MmaBE4x4WordAtPtx3262R1050, r_MmaBE4x4WordAtPtx3262R1051, r_MmaBE4x4WordAtPtx3262R1052,
		r_MmaBE4x4WordAtPtx3262R1053, r_MmaBE4x4WordAtPtx3271R1054, r_MmaBE4x4WordAtPtx3271R1055,
		r_MmaBE4x4WordAtPtx3271R1056;
	uint32_t r_MmaBE4x4WordAtPtx3271R1057, r_LaneIndexAtPtx3330, r_LaneIndexAtPtx3339,
		r_MmaBE4x4WordAtPtx3336R1060, r_MmaBE4x4WordAtPtx3336R1061, r_MmaAccumulatorHalf2WordAtPtx3274R1062,
		r_MmaAccumulatorHalf2WordAtPtx3274R1063, r_MmaBE4x4WordAtPtx3336R1064, r_MmaBE4x4WordAtPtx3336R1065,
		r_MmaAccumulatorHalf2WordAtPtx3281R1066, r_MmaAccumulatorHalf2WordAtPtx3281R1067,
		r_MmaBE4x4WordAtPtx3345R1068;
	uint32_t r_MmaBE4x4WordAtPtx3345R1069, r_MmaAccumulatorHalf2WordAtPtx3288R1070,
		r_MmaAccumulatorHalf2WordAtPtx3288R1071, r_MmaBE4x4WordAtPtx3345R1072, r_MmaBE4x4WordAtPtx3345R1073,
		r_MmaAccumulatorHalf2WordAtPtx3295R1074, r_MmaAccumulatorHalf2WordAtPtx3295R1075,
		r_MmaAccumulatorHalf2WordAtPtx3302R1076, r_MmaAccumulatorHalf2WordAtPtx3302R1077,
		r_MmaAccumulatorHalf2WordAtPtx3309R1078, r_MmaAccumulatorHalf2WordAtPtx3309R1079,
		r_MmaAccumulatorHalf2WordAtPtx3316R1080;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3316R1081, r_MmaAccumulatorHalf2WordAtPtx3323R1082,
		r_MmaAccumulatorHalf2WordAtPtx3323R1083, r_LaneIndexAtPtx3404,
		r_MmaAccumulatorHalf2WordAtPtx3348R1085, r_PackedHalf2AtPtx3407R1086, r_PackedHalf2AtPtx3411R1087,
		r_PackedHalf2AtPtx3415R1088, r_PackedHalf2AtPtx3419R1089, r_PackedHalf2AtPtx3423R1090,
		r_LaneIndexAtPtx3431, r_MmaAccumulatorHalf2WordAtPtx3348R1092;
	uint32_t r_PackedHalf2AtPtx3434R1093, r_PackedHalf2AtPtx3438R1094, r_PackedHalf2AtPtx3442R1095,
		r_PackedHalf2AtPtx3446R1096, r_PackedHalf2AtPtx3450R1097, r_LaneIndexAtPtx3458,
		r_MmaAccumulatorHalf2WordAtPtx3355R1099, r_PackedHalf2AtPtx3461R1100, r_PackedHalf2AtPtx3465R1101,
		r_PackedHalf2AtPtx3469R1102, r_PackedHalf2AtPtx3473R1103, r_PackedHalf2AtPtx3477R1104;
	uint32_t r_LaneIndexAtPtx3485, r_MmaAccumulatorHalf2WordAtPtx3355R1106, r_PackedHalf2AtPtx3488R1107,
		r_PackedHalf2AtPtx3492R1108, r_PackedHalf2AtPtx3496R1109, r_PackedHalf2AtPtx3500R1110,
		r_PackedHalf2AtPtx3504R1111, r_LaneIndexAtPtx3512, r_MmaAccumulatorHalf2WordAtPtx3362R1113,
		r_PackedHalf2AtPtx3515R1114, r_PackedHalf2AtPtx3519R1115, r_PackedHalf2AtPtx3523R1116;
	uint32_t r_PackedHalf2AtPtx3527R1117, r_PackedHalf2AtPtx3531R1118, r_LaneIndexAtPtx3539,
		r_MmaAccumulatorHalf2WordAtPtx3362R1120, r_PackedHalf2AtPtx3542R1121, r_PackedHalf2AtPtx3546R1122,
		r_PackedHalf2AtPtx3550R1123, r_PackedHalf2AtPtx3554R1124, r_PackedHalf2AtPtx3558R1125,
		r_LaneIndexAtPtx3566, r_MmaAccumulatorHalf2WordAtPtx3369R1127, r_PackedHalf2AtPtx3569R1128;
	uint32_t r_PackedHalf2AtPtx3573R1129, r_PackedHalf2AtPtx3577R1130, r_PackedHalf2AtPtx3581R1131,
		r_PackedHalf2AtPtx3585R1132, r_LaneIndexAtPtx3593, r_MmaAccumulatorHalf2WordAtPtx3369R1134,
		r_PackedHalf2AtPtx3596R1135, r_PackedHalf2AtPtx3600R1136, r_PackedHalf2AtPtx3604R1137,
		r_PackedHalf2AtPtx3608R1138, r_PackedHalf2AtPtx3612R1139, r_LaneIndexAtPtx3620;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3376R1141, r_PackedHalf2AtPtx3623R1142,
		r_PackedHalf2AtPtx3627R1143, r_PackedHalf2AtPtx3631R1144, r_PackedHalf2AtPtx3635R1145,
		r_PackedHalf2AtPtx3639R1146, r_LaneIndexAtPtx3647, r_MmaAccumulatorHalf2WordAtPtx3376R1148,
		r_PackedHalf2AtPtx3650R1149, r_PackedHalf2AtPtx3654R1150, r_PackedHalf2AtPtx3658R1151,
		r_PackedHalf2AtPtx3662R1152;
	uint32_t r_PackedHalf2AtPtx3666R1153, r_LaneIndexAtPtx3674, r_MmaAccumulatorHalf2WordAtPtx3383R1155,
		r_PackedHalf2AtPtx3677R1156, r_PackedHalf2AtPtx3681R1157, r_PackedHalf2AtPtx3685R1158,
		r_PackedHalf2AtPtx3689R1159, r_PackedHalf2AtPtx3693R1160, r_LaneIndexAtPtx3701,
		r_MmaAccumulatorHalf2WordAtPtx3383R1162, r_PackedHalf2AtPtx3704R1163, r_PackedHalf2AtPtx3708R1164;
	uint32_t r_PackedHalf2AtPtx3712R1165, r_PackedHalf2AtPtx3716R1166, r_PackedHalf2AtPtx3720R1167,
		r_LaneIndexAtPtx3728, r_MmaAccumulatorHalf2WordAtPtx3390R1169, r_PackedHalf2AtPtx3731R1170,
		r_PackedHalf2AtPtx3735R1171, r_PackedHalf2AtPtx3739R1172, r_PackedHalf2AtPtx3743R1173,
		r_PackedHalf2AtPtx3747R1174, r_LaneIndexAtPtx3755, r_MmaAccumulatorHalf2WordAtPtx3390R1176;
	uint32_t r_PackedHalf2AtPtx3758R1177, r_PackedHalf2AtPtx3762R1178, r_PackedHalf2AtPtx3766R1179,
		r_PackedHalf2AtPtx3770R1180, r_PackedHalf2AtPtx3774R1181, r_LaneIndexAtPtx3782,
		r_MmaAccumulatorHalf2WordAtPtx3397R1183, r_PackedHalf2AtPtx3785R1184, r_PackedHalf2AtPtx3789R1185,
		r_PackedHalf2AtPtx3793R1186, r_PackedHalf2AtPtx3797R1187, r_PackedHalf2AtPtx3801R1188;
	uint32_t r_LaneIndexAtPtx3809, r_MmaAccumulatorHalf2WordAtPtx3397R1190, r_PackedHalf2AtPtx3812R1191,
		r_PackedHalf2AtPtx3816R1192, r_PackedHalf2AtPtx3820R1193, r_PackedHalf2AtPtx3824R1194,
		r_PackedHalf2AtPtx3828R1195, r_LaneIndexAtPtx3836, r_LaneIndexAtPtx3845, r_PackedHalf2AtPtx3427R1198,
		r_PackedHalf2AtPtx3481R1199, r_PackedHalf2AtPtx3454R1200;
	uint32_t r_PackedHalf2AtPtx3508R1201, r_PackedHalf2AtPtx3535R1202, r_PackedHalf2AtPtx3589R1203,
		r_PackedHalf2AtPtx3562R1204, r_PackedHalf2AtPtx3616R1205, r_PackedHalf2AtPtx3643R1206,
		r_PackedHalf2AtPtx3697R1207, r_PackedHalf2AtPtx3670R1208, r_PackedHalf2AtPtx3724R1209,
		r_PackedHalf2AtPtx3751R1210, r_PackedHalf2AtPtx3805R1211, r_PackedHalf2AtPtx3778R1212;
	uint32_t r_PackedHalf2AtPtx3832R1213, r_MmaBE4x4WordAtPtx3842R1214, r_MmaBE4x4WordAtPtx3842R1215,
		r_MmaAccumulatorHalf2WordAtPtx3200R1216, r_MmaAccumulatorHalf2WordAtPtx3200R1217,
		r_MmaAE4x4WordAtPtx3859R1218, r_MmaAE4x4WordAtPtx3866R1219, r_MmaAE4x4WordAtPtx3873R1220,
		r_MmaAE4x4WordAtPtx3880R1221, r_MmaBE4x4WordAtPtx3842R1222, r_MmaBE4x4WordAtPtx3842R1223,
		r_MmaAccumulatorHalf2WordAtPtx3207R1224;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3207R1225, r_MmaBE4x4WordAtPtx3851R1226,
		r_MmaBE4x4WordAtPtx3851R1227, r_MmaAccumulatorHalf2WordAtPtx3214R1228,
		r_MmaAccumulatorHalf2WordAtPtx3214R1229, r_MmaBE4x4WordAtPtx3851R1230, r_MmaBE4x4WordAtPtx3851R1231,
		r_MmaAccumulatorHalf2WordAtPtx3221R1232, r_MmaAccumulatorHalf2WordAtPtx3221R1233,
		r_MmaAccumulatorHalf2WordAtPtx3228R1234, r_MmaAccumulatorHalf2WordAtPtx3228R1235,
		r_MmaAE4x4WordAtPtx3887R1236;
	uint32_t r_MmaAE4x4WordAtPtx3894R1237, r_MmaAE4x4WordAtPtx3901R1238, r_MmaAE4x4WordAtPtx3908R1239,
		r_MmaAccumulatorHalf2WordAtPtx3235R1240, r_MmaAccumulatorHalf2WordAtPtx3235R1241,
		r_MmaAccumulatorHalf2WordAtPtx3242R1242, r_MmaAccumulatorHalf2WordAtPtx3242R1243,
		r_MmaAccumulatorHalf2WordAtPtx3249R1244, r_MmaAccumulatorHalf2WordAtPtx3249R1245,
		r_LaneIndexAtPtx3969, r_LaneIndexAtPtx3978, r_LaneIndexAtPtx3987;
	uint32_t r_LaneIndexAtPtx3996, r_MmaAccumulatorHalf2WordAtPtx3910R1250,
		r_MmaAccumulatorHalf2WordAtPtx3917R1251, r_MmaAccumulatorHalf2WordAtPtx3910R1252,
		r_MmaAccumulatorHalf2WordAtPtx3917R1253, r_MmaAccumulatorHalf2WordAtPtx3924R1254,
		r_MmaAccumulatorHalf2WordAtPtx3931R1255, r_MmaAccumulatorHalf2WordAtPtx3924R1256,
		r_MmaAccumulatorHalf2WordAtPtx3931R1257, r_MmaAccumulatorHalf2WordAtPtx3938R1258,
		r_MmaAccumulatorHalf2WordAtPtx3945R1259, r_MmaAccumulatorHalf2WordAtPtx3938R1260;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3945R1261, r_MmaAccumulatorHalf2WordAtPtx3952R1262,
		r_MmaAccumulatorHalf2WordAtPtx3959R1263, r_MmaAccumulatorHalf2WordAtPtx3952R1264,
		r_MmaAccumulatorHalf2WordAtPtx3959R1265, r_MmaBE4x4WordAtPtx3975R1266, r_MmaBE4x4WordAtPtx3975R1267,
		r_MmaAE4x4WordAtPtx4010R1268, r_MmaAE4x4WordAtPtx4017R1269, r_MmaAE4x4WordAtPtx4024R1270,
		r_MmaAE4x4WordAtPtx4031R1271, r_MmaBE4x4WordAtPtx3975R1272;
	uint32_t r_MmaBE4x4WordAtPtx3975R1273, r_MmaBE4x4WordAtPtx3984R1274, r_MmaBE4x4WordAtPtx3984R1275,
		r_MmaBE4x4WordAtPtx3984R1276, r_MmaBE4x4WordAtPtx3984R1277, r_MmaBE4x4WordAtPtx3993R1278,
		r_MmaBE4x4WordAtPtx3993R1279, r_MmaBE4x4WordAtPtx3993R1280, r_MmaBE4x4WordAtPtx3993R1281,
		r_MmaBE4x4WordAtPtx4002R1282, r_MmaBE4x4WordAtPtx4002R1283, r_MmaBE4x4WordAtPtx4002R1284;
	uint32_t r_MmaBE4x4WordAtPtx4002R1285, r_MmaAE4x4WordAtPtx4038R1286, r_MmaAE4x4WordAtPtx4045R1287,
		r_MmaAE4x4WordAtPtx4052R1288, r_MmaAE4x4WordAtPtx4059R1289, r_PtxRegister1290, r_PtxRegister1291,
		r_PtxRegister1292, r_LaneIndexAtPtx4290, r_PtxRegister1294, r_PackedE4WordAtPtx4181R1295,
		r_PackedE4WordAtPtx4188R1296;
	uint32_t r_PackedE4WordAtPtx4195R1297, r_PackedE4WordAtPtx4202R1298, r_LaneIndexAtPtx4300,
		r_PtxRegister1300, r_PackedE4WordAtPtx4209R1301, r_PackedE4WordAtPtx4216R1302,
		r_PackedE4WordAtPtx4223R1303, r_PackedE4WordAtPtx4230R1304, r_LaneIndexAtPtx4309, r_PtxRegister1306,
		r_PackedE4WordAtPtx4237R1307, r_PackedE4WordAtPtx4244R1308;
	uint32_t r_PackedE4WordAtPtx4251R1309, r_PackedE4WordAtPtx4258R1310, r_LaneIndexAtPtx4318,
		r_PtxRegister1312, r_PackedE4WordAtPtx4265R1313, r_PackedE4WordAtPtx4272R1314,
		r_PackedE4WordAtPtx4279R1315, r_PackedE4WordAtPtx4286R1316, r_LaneIndexAtPtx4328, r_PtxRegister1318,
		r_LaneIndexAtPtx4336, r_PtxRegister1320;
	uint32_t r_LaneIndexAtPtx4345, r_PtxRegister1322, r_LaneIndexAtPtx4354, r_PtxRegister1324,
		r_LaneIndexAtPtx4366, r_LaneIndexAtPtx4375, r_LaneIndexAtPtx4384, r_LaneIndexAtPtx4393,
		r_LaneIndexAtPtx4402, r_LaneIndexAtPtx4411, r_MmaAE4x4WordAtPtx4333R1331,
		r_MmaAE4x4WordAtPtx4333R1332;
	uint32_t r_MmaAE4x4WordAtPtx4333R1333, r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4372R1335,
		r_MmaBE4x4WordAtPtx4372R1336, r_MmaBE4x4WordAtPtx4372R1337, r_MmaBE4x4WordAtPtx4372R1338,
		r_MmaBE4x4WordAtPtx4381R1339, r_MmaBE4x4WordAtPtx4381R1340, r_MmaBE4x4WordAtPtx4381R1341,
		r_MmaBE4x4WordAtPtx4381R1342, r_MmaBE4x4WordAtPtx4390R1343, r_MmaBE4x4WordAtPtx4390R1344;
	uint32_t r_MmaBE4x4WordAtPtx4390R1345, r_MmaBE4x4WordAtPtx4390R1346, r_MmaBE4x4WordAtPtx4399R1347,
		r_MmaBE4x4WordAtPtx4399R1348, r_MmaBE4x4WordAtPtx4399R1349, r_MmaBE4x4WordAtPtx4399R1350,
		r_MmaBE4x4WordAtPtx4408R1351, r_MmaBE4x4WordAtPtx4408R1352, r_MmaBE4x4WordAtPtx4408R1353,
		r_MmaBE4x4WordAtPtx4408R1354, r_MmaBE4x4WordAtPtx4417R1355, r_MmaBE4x4WordAtPtx4417R1356;
	uint32_t r_MmaBE4x4WordAtPtx4417R1357, r_MmaBE4x4WordAtPtx4417R1358, r_MmaAE4x4WordAtPtx4342R1359,
		r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361, r_MmaAE4x4WordAtPtx4342R1362,
		r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		r_MmaAE4x4WordAtPtx4351R1366, r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368;
	uint32_t r_MmaAE4x4WordAtPtx4360R1369, r_MmaAE4x4WordAtPtx4360R1370, r_LaneIndexAtPtx4756,
		r_PtxRegister1372, r_LaneIndexAtPtx4765, r_PtxRegister1374, r_LaneIndexAtPtx4774, r_PtxRegister1376,
		r_LaneIndexAtPtx4783, r_PtxRegister1378, r_LaneIndexAtPtx4792, r_LaneIndexAtPtx4801;
	uint32_t r_LaneIndexAtPtx4810, r_LaneIndexAtPtx4819, r_LaneIndexAtPtx4828, r_LaneIndexAtPtx4837,
		r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386, r_MmaAE4x4WordAtPtx4762R1387,
		r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4798R1389, r_MmaBE4x4WordAtPtx4798R1390,
		r_MmaAccumulatorHalf2WordAtPtx4420R1391, r_MmaAccumulatorHalf2WordAtPtx4420R1392;
	uint32_t r_MmaBE4x4WordAtPtx4798R1393, r_MmaBE4x4WordAtPtx4798R1394,
		r_MmaAccumulatorHalf2WordAtPtx4427R1395, r_MmaAccumulatorHalf2WordAtPtx4427R1396,
		r_MmaBE4x4WordAtPtx4807R1397, r_MmaBE4x4WordAtPtx4807R1398, r_MmaAccumulatorHalf2WordAtPtx4434R1399,
		r_MmaAccumulatorHalf2WordAtPtx4434R1400, r_MmaBE4x4WordAtPtx4807R1401, r_MmaBE4x4WordAtPtx4807R1402,
		r_MmaAccumulatorHalf2WordAtPtx4441R1403, r_MmaAccumulatorHalf2WordAtPtx4441R1404;
	uint32_t r_MmaBE4x4WordAtPtx4816R1405, r_MmaBE4x4WordAtPtx4816R1406,
		r_MmaAccumulatorHalf2WordAtPtx4448R1407, r_MmaAccumulatorHalf2WordAtPtx4448R1408,
		r_MmaBE4x4WordAtPtx4816R1409, r_MmaBE4x4WordAtPtx4816R1410, r_MmaAccumulatorHalf2WordAtPtx4455R1411,
		r_MmaAccumulatorHalf2WordAtPtx4455R1412, r_MmaBE4x4WordAtPtx4825R1413, r_MmaBE4x4WordAtPtx4825R1414,
		r_MmaAccumulatorHalf2WordAtPtx4462R1415, r_MmaAccumulatorHalf2WordAtPtx4462R1416;
	uint32_t r_MmaBE4x4WordAtPtx4825R1417, r_MmaBE4x4WordAtPtx4825R1418,
		r_MmaAccumulatorHalf2WordAtPtx4469R1419, r_MmaAccumulatorHalf2WordAtPtx4469R1420,
		r_MmaBE4x4WordAtPtx4834R1421, r_MmaBE4x4WordAtPtx4834R1422, r_MmaAccumulatorHalf2WordAtPtx4476R1423,
		r_MmaAccumulatorHalf2WordAtPtx4476R1424, r_MmaBE4x4WordAtPtx4834R1425, r_MmaBE4x4WordAtPtx4834R1426,
		r_MmaAccumulatorHalf2WordAtPtx4483R1427, r_MmaAccumulatorHalf2WordAtPtx4483R1428;
	uint32_t r_MmaBE4x4WordAtPtx4843R1429, r_MmaBE4x4WordAtPtx4843R1430,
		r_MmaAccumulatorHalf2WordAtPtx4490R1431, r_MmaAccumulatorHalf2WordAtPtx4490R1432,
		r_MmaBE4x4WordAtPtx4843R1433, r_MmaBE4x4WordAtPtx4843R1434, r_MmaAccumulatorHalf2WordAtPtx4497R1435,
		r_MmaAccumulatorHalf2WordAtPtx4497R1436, r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438,
		r_MmaAE4x4WordAtPtx4771R1439, r_MmaAE4x4WordAtPtx4771R1440;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4504R1441, r_MmaAccumulatorHalf2WordAtPtx4504R1442,
		r_MmaAccumulatorHalf2WordAtPtx4511R1443, r_MmaAccumulatorHalf2WordAtPtx4511R1444,
		r_MmaAccumulatorHalf2WordAtPtx4518R1445, r_MmaAccumulatorHalf2WordAtPtx4518R1446,
		r_MmaAccumulatorHalf2WordAtPtx4525R1447, r_MmaAccumulatorHalf2WordAtPtx4525R1448,
		r_MmaAccumulatorHalf2WordAtPtx4532R1449, r_MmaAccumulatorHalf2WordAtPtx4532R1450,
		r_MmaAccumulatorHalf2WordAtPtx4539R1451, r_MmaAccumulatorHalf2WordAtPtx4539R1452;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4546R1453, r_MmaAccumulatorHalf2WordAtPtx4546R1454,
		r_MmaAccumulatorHalf2WordAtPtx4553R1455, r_MmaAccumulatorHalf2WordAtPtx4553R1456,
		r_MmaAccumulatorHalf2WordAtPtx4560R1457, r_MmaAccumulatorHalf2WordAtPtx4560R1458,
		r_MmaAccumulatorHalf2WordAtPtx4567R1459, r_MmaAccumulatorHalf2WordAtPtx4567R1460,
		r_MmaAccumulatorHalf2WordAtPtx4574R1461, r_MmaAccumulatorHalf2WordAtPtx4574R1462,
		r_MmaAccumulatorHalf2WordAtPtx4581R1463, r_MmaAccumulatorHalf2WordAtPtx4581R1464;
	uint32_t r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466, r_MmaAE4x4WordAtPtx4780R1467,
		r_MmaAE4x4WordAtPtx4780R1468, r_MmaAccumulatorHalf2WordAtPtx4588R1469,
		r_MmaAccumulatorHalf2WordAtPtx4588R1470, r_MmaAccumulatorHalf2WordAtPtx4595R1471,
		r_MmaAccumulatorHalf2WordAtPtx4595R1472, r_MmaAccumulatorHalf2WordAtPtx4602R1473,
		r_MmaAccumulatorHalf2WordAtPtx4602R1474, r_MmaAccumulatorHalf2WordAtPtx4609R1475,
		r_MmaAccumulatorHalf2WordAtPtx4609R1476;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4616R1477, r_MmaAccumulatorHalf2WordAtPtx4616R1478,
		r_MmaAccumulatorHalf2WordAtPtx4623R1479, r_MmaAccumulatorHalf2WordAtPtx4623R1480,
		r_MmaAccumulatorHalf2WordAtPtx4630R1481, r_MmaAccumulatorHalf2WordAtPtx4630R1482,
		r_MmaAccumulatorHalf2WordAtPtx4637R1483, r_MmaAccumulatorHalf2WordAtPtx4637R1484,
		r_MmaAccumulatorHalf2WordAtPtx4644R1485, r_MmaAccumulatorHalf2WordAtPtx4644R1486,
		r_MmaAccumulatorHalf2WordAtPtx4651R1487, r_MmaAccumulatorHalf2WordAtPtx4651R1488;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4658R1489, r_MmaAccumulatorHalf2WordAtPtx4658R1490,
		r_MmaAccumulatorHalf2WordAtPtx4665R1491, r_MmaAccumulatorHalf2WordAtPtx4665R1492,
		r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494, r_MmaAE4x4WordAtPtx4789R1495,
		r_MmaAE4x4WordAtPtx4789R1496, r_MmaAccumulatorHalf2WordAtPtx4672R1497,
		r_MmaAccumulatorHalf2WordAtPtx4672R1498, r_MmaAccumulatorHalf2WordAtPtx4679R1499,
		r_MmaAccumulatorHalf2WordAtPtx4679R1500;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4686R1501, r_MmaAccumulatorHalf2WordAtPtx4686R1502,
		r_MmaAccumulatorHalf2WordAtPtx4693R1503, r_MmaAccumulatorHalf2WordAtPtx4693R1504,
		r_MmaAccumulatorHalf2WordAtPtx4700R1505, r_MmaAccumulatorHalf2WordAtPtx4700R1506,
		r_MmaAccumulatorHalf2WordAtPtx4707R1507, r_MmaAccumulatorHalf2WordAtPtx4707R1508,
		r_MmaAccumulatorHalf2WordAtPtx4714R1509, r_MmaAccumulatorHalf2WordAtPtx4714R1510,
		r_MmaAccumulatorHalf2WordAtPtx4721R1511, r_MmaAccumulatorHalf2WordAtPtx4721R1512;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4728R1513, r_MmaAccumulatorHalf2WordAtPtx4728R1514,
		r_MmaAccumulatorHalf2WordAtPtx4735R1515, r_MmaAccumulatorHalf2WordAtPtx4735R1516,
		r_MmaAccumulatorHalf2WordAtPtx4742R1517, r_MmaAccumulatorHalf2WordAtPtx4742R1518,
		r_MmaAccumulatorHalf2WordAtPtx4749R1519, r_MmaAccumulatorHalf2WordAtPtx4749R1520,
		r_LaneIndexAtPtx5186, r_MmaAccumulatorHalf2WordAtPtx4846R1522, r_LaneIndexAtPtx5193,
		r_MmaAccumulatorHalf2WordAtPtx4846R1524;
	uint32_t r_LaneIndexAtPtx5200, r_MmaAccumulatorHalf2WordAtPtx4853R1526, r_LaneIndexAtPtx5207,
		r_MmaAccumulatorHalf2WordAtPtx4853R1528, r_LaneIndexAtPtx5214,
		r_MmaAccumulatorHalf2WordAtPtx4860R1530, r_LaneIndexAtPtx5221,
		r_MmaAccumulatorHalf2WordAtPtx4860R1532, r_LaneIndexAtPtx5228,
		r_MmaAccumulatorHalf2WordAtPtx4867R1534, r_LaneIndexAtPtx5235,
		r_MmaAccumulatorHalf2WordAtPtx4867R1536;
	uint32_t r_LaneIndexAtPtx5242, r_MmaAccumulatorHalf2WordAtPtx4930R1538, r_LaneIndexAtPtx5249,
		r_MmaAccumulatorHalf2WordAtPtx4930R1540, r_LaneIndexAtPtx5256,
		r_MmaAccumulatorHalf2WordAtPtx4937R1542, r_LaneIndexAtPtx5263,
		r_MmaAccumulatorHalf2WordAtPtx4937R1544, r_LaneIndexAtPtx5270,
		r_MmaAccumulatorHalf2WordAtPtx4944R1546, r_LaneIndexAtPtx5277,
		r_MmaAccumulatorHalf2WordAtPtx4944R1548;
	uint32_t r_LaneIndexAtPtx5284, r_MmaAccumulatorHalf2WordAtPtx4951R1550, r_LaneIndexAtPtx5291,
		r_MmaAccumulatorHalf2WordAtPtx4951R1552, r_LaneIndexAtPtx5298,
		r_MmaAccumulatorHalf2WordAtPtx5014R1554, r_LaneIndexAtPtx5305,
		r_MmaAccumulatorHalf2WordAtPtx5014R1556, r_LaneIndexAtPtx5312,
		r_MmaAccumulatorHalf2WordAtPtx5021R1558, r_LaneIndexAtPtx5319,
		r_MmaAccumulatorHalf2WordAtPtx5021R1560;
	uint32_t r_LaneIndexAtPtx5326, r_MmaAccumulatorHalf2WordAtPtx5028R1562, r_LaneIndexAtPtx5333,
		r_MmaAccumulatorHalf2WordAtPtx5028R1564, r_LaneIndexAtPtx5340,
		r_MmaAccumulatorHalf2WordAtPtx5035R1566, r_LaneIndexAtPtx5347,
		r_MmaAccumulatorHalf2WordAtPtx5035R1568, r_LaneIndexAtPtx5354,
		r_MmaAccumulatorHalf2WordAtPtx5098R1570, r_LaneIndexAtPtx5361,
		r_MmaAccumulatorHalf2WordAtPtx5098R1572;
	uint32_t r_LaneIndexAtPtx5368, r_MmaAccumulatorHalf2WordAtPtx5105R1574, r_LaneIndexAtPtx5375,
		r_MmaAccumulatorHalf2WordAtPtx5105R1576, r_LaneIndexAtPtx5382,
		r_MmaAccumulatorHalf2WordAtPtx5112R1578, r_LaneIndexAtPtx5389,
		r_MmaAccumulatorHalf2WordAtPtx5112R1580, r_LaneIndexAtPtx5396,
		r_MmaAccumulatorHalf2WordAtPtx5119R1582, r_LaneIndexAtPtx5403,
		r_MmaAccumulatorHalf2WordAtPtx5119R1584;
	uint32_t r_LaneIndexAtPtx5410, r_PackedHalf2AtPtx5189R1586, r_PackedHalf2AtPtx5217R1587,
		r_LaneIndexAtPtx5417, r_PackedHalf2AtPtx5196R1589, r_PackedHalf2AtPtx5224R1590, r_LaneIndexAtPtx5424,
		r_PackedHalf2AtPtx5203R1592, r_PackedHalf2AtPtx5231R1593, r_LaneIndexAtPtx5431,
		r_PackedHalf2AtPtx5210R1595, r_PackedHalf2AtPtx5238R1596;
	uint32_t r_LaneIndexAtPtx5438, r_PackedHalf2AtPtx5245R1598, r_PackedHalf2AtPtx5273R1599,
		r_LaneIndexAtPtx5445, r_PackedHalf2AtPtx5252R1601, r_PackedHalf2AtPtx5280R1602, r_LaneIndexAtPtx5452,
		r_PackedHalf2AtPtx5259R1604, r_PackedHalf2AtPtx5287R1605, r_LaneIndexAtPtx5459,
		r_PackedHalf2AtPtx5266R1607, r_PackedHalf2AtPtx5294R1608;
	uint32_t r_LaneIndexAtPtx5466, r_PackedHalf2AtPtx5301R1610, r_PackedHalf2AtPtx5329R1611,
		r_LaneIndexAtPtx5473, r_PackedHalf2AtPtx5308R1613, r_PackedHalf2AtPtx5336R1614, r_LaneIndexAtPtx5480,
		r_PackedHalf2AtPtx5315R1616, r_PackedHalf2AtPtx5343R1617, r_LaneIndexAtPtx5487,
		r_PackedHalf2AtPtx5322R1619, r_PackedHalf2AtPtx5350R1620;
	uint32_t r_LaneIndexAtPtx5494, r_PackedHalf2AtPtx5357R1622, r_PackedHalf2AtPtx5385R1623,
		r_LaneIndexAtPtx5501, r_PackedHalf2AtPtx5364R1625, r_PackedHalf2AtPtx5392R1626, r_LaneIndexAtPtx5508,
		r_PackedHalf2AtPtx5371R1628, r_PackedHalf2AtPtx5399R1629, r_LaneIndexAtPtx5515,
		r_PackedHalf2AtPtx5378R1631, r_PackedHalf2AtPtx5406R1632;
	uint32_t r_PackedHalf2AtPtx5427R1633, r_PackedHalf2AtPtx5413R1634, r_PackedHalf2AtPtx5434R1635,
		r_PackedHalf2AtPtx5420R1636, r_PtxRegister1637, r_PackedHalf2AtPtx5522R1638, r_PtxRegister1639,
		r_PtxRegister1640, r_PtxRegister1641, r_PackedHalf2AtPtx5538R1642, r_PackedHalf2AtPtx5542R1643,
		r_PtxRegister1644;
	uint32_t r_PackedHalf2AtPtx5547R1645, r_PtxRegister1646, r_PackedHalf2AtPtx5555R1647,
		r_PackedHalf2AtPtx5526R1648, r_PackedHalf2AtPtx5561R1649, r_PackedHalf2AtPtx5565R1650,
		r_PackedHalf2AtPtx5569R1651, r_PtxRegister1652, r_PackedHalf2AtPtx5577R1653,
		r_PackedHalf2AtPtx5455R1654, r_PackedHalf2AtPtx5441R1655, r_PackedHalf2AtPtx5462R1656;
	uint32_t r_PackedHalf2AtPtx5448R1657, r_PackedHalf2AtPtx5583R1658, r_PackedHalf2AtPtx5591R1659,
		r_PackedHalf2AtPtx5595R1660, r_PackedHalf2AtPtx5599R1661, r_PtxRegister1662,
		r_PackedHalf2AtPtx5607R1663, r_PackedHalf2AtPtx5587R1664, r_PackedHalf2AtPtx5613R1665,
		r_PackedHalf2AtPtx5617R1666, r_PackedHalf2AtPtx5621R1667, r_PtxRegister1668;
	uint32_t r_PackedHalf2AtPtx5629R1669, r_PackedHalf2AtPtx5483R1670, r_PackedHalf2AtPtx5469R1671,
		r_PackedHalf2AtPtx5490R1672, r_PackedHalf2AtPtx5476R1673, r_PackedHalf2AtPtx5635R1674,
		r_PackedHalf2AtPtx5643R1675, r_PackedHalf2AtPtx5647R1676, r_PackedHalf2AtPtx5651R1677,
		r_PtxRegister1678, r_PackedHalf2AtPtx5659R1679, r_PackedHalf2AtPtx5639R1680;
	uint32_t r_PackedHalf2AtPtx5665R1681, r_PackedHalf2AtPtx5669R1682, r_PackedHalf2AtPtx5673R1683,
		r_PtxRegister1684, r_PackedHalf2AtPtx5681R1685, r_PackedHalf2AtPtx5511R1686,
		r_PackedHalf2AtPtx5497R1687, r_PackedHalf2AtPtx5518R1688, r_PackedHalf2AtPtx5504R1689,
		r_PackedHalf2AtPtx5687R1690, r_PackedHalf2AtPtx5695R1691, r_PackedHalf2AtPtx5699R1692;
	uint32_t r_PackedHalf2AtPtx5703R1693, r_PtxRegister1694, r_PackedHalf2AtPtx5711R1695,
		r_PackedHalf2AtPtx5691R1696, r_PackedHalf2AtPtx5717R1697, r_PackedHalf2AtPtx5721R1698,
		r_PackedHalf2AtPtx5725R1699, r_PtxRegister1700, r_PackedHalf2AtPtx5733R1701, r_PtxRegister1702,
		r_LaneIndexAtPtx5746, r_PackedHalf2AtPtx5557R1704;
	uint32_t r_PackedHalf2AtPtx5740R1705, r_LaneIndexAtPtx5753, r_PackedHalf2AtPtx5579R1707,
		r_LaneIndexAtPtx5760, r_LaneIndexAtPtx5763, r_LaneIndexAtPtx5766, r_LaneIndexAtPtx5769,
		r_LaneIndexAtPtx5772, r_LaneIndexAtPtx5775, r_LaneIndexAtPtx5778, r_PackedHalf2AtPtx5609R1715,
		r_LaneIndexAtPtx5785;
	uint32_t r_PackedHalf2AtPtx5631R1717, r_LaneIndexAtPtx5792, r_LaneIndexAtPtx5795, r_LaneIndexAtPtx5798,
		r_LaneIndexAtPtx5801, r_LaneIndexAtPtx5804, r_LaneIndexAtPtx5807, r_LaneIndexAtPtx5810,
		r_PackedHalf2AtPtx5661R1725, r_LaneIndexAtPtx5817, r_PackedHalf2AtPtx5683R1727, r_LaneIndexAtPtx5824;
	uint32_t r_LaneIndexAtPtx5827, r_LaneIndexAtPtx5830, r_LaneIndexAtPtx5833, r_LaneIndexAtPtx5836,
		r_LaneIndexAtPtx5839, r_LaneIndexAtPtx5842, r_PackedHalf2AtPtx5713R1735, r_LaneIndexAtPtx5849,
		r_PackedHalf2AtPtx5735R1737, r_LaneIndexAtPtx5856, r_LaneIndexAtPtx5859, r_LaneIndexAtPtx5862;
	uint32_t r_LaneIndexAtPtx5865, r_LaneIndexAtPtx5868, r_LaneIndexAtPtx5871, r_LaneIndexAtPtx5874,
		r_PackedHalf2AtPtx5749R1745, r_LaneIndexAtPtx5890, r_PackedHalf2AtPtx5756R1747, r_LaneIndexAtPtx5906,
		r_LaneIndexAtPtx5909, r_LaneIndexAtPtx5912, r_LaneIndexAtPtx5915, r_LaneIndexAtPtx5918;
	uint32_t r_LaneIndexAtPtx5921, r_LaneIndexAtPtx5924, r_PackedHalf2AtPtx5781R1755, r_LaneIndexAtPtx5940,
		r_PackedHalf2AtPtx5788R1757, r_LaneIndexAtPtx5956, r_LaneIndexAtPtx5959, r_LaneIndexAtPtx5962,
		r_LaneIndexAtPtx5965, r_LaneIndexAtPtx5968, r_LaneIndexAtPtx5971, r_LaneIndexAtPtx5974;
	uint32_t r_PackedHalf2AtPtx5813R1765, r_LaneIndexAtPtx5990, r_PackedHalf2AtPtx5820R1767,
		r_LaneIndexAtPtx6006, r_LaneIndexAtPtx6009, r_LaneIndexAtPtx6012, r_LaneIndexAtPtx6015,
		r_LaneIndexAtPtx6018, r_LaneIndexAtPtx6021, r_LaneIndexAtPtx6024, r_PackedHalf2AtPtx5845R1775,
		r_LaneIndexAtPtx6040;
	uint32_t r_PackedHalf2AtPtx5852R1777, r_LaneIndexAtPtx6056, r_LaneIndexAtPtx6059, r_LaneIndexAtPtx6062,
		r_LaneIndexAtPtx6065, r_LaneIndexAtPtx6068, r_LaneIndexAtPtx6071, r_LaneIndexAtPtx6074,
		r_PackedHalf2AtPtx5877R1785, r_LaneIndexAtPtx6081, r_PackedHalf2AtPtx5893R1787, r_LaneIndexAtPtx6088;
	uint32_t r_LaneIndexAtPtx6095, r_LaneIndexAtPtx6102, r_LaneIndexAtPtx6109, r_LaneIndexAtPtx6116,
		r_LaneIndexAtPtx6123, r_LaneIndexAtPtx6130, r_PackedHalf2AtPtx5927R1795, r_LaneIndexAtPtx6137,
		r_PackedHalf2AtPtx5943R1797, r_LaneIndexAtPtx6144, r_LaneIndexAtPtx6151, r_LaneIndexAtPtx6158;
	uint32_t r_LaneIndexAtPtx6165, r_LaneIndexAtPtx6172, r_LaneIndexAtPtx6179, r_LaneIndexAtPtx6186,
		r_PackedHalf2AtPtx5977R1805, r_LaneIndexAtPtx6193, r_PackedHalf2AtPtx5993R1807, r_LaneIndexAtPtx6200,
		r_LaneIndexAtPtx6207, r_LaneIndexAtPtx6214, r_LaneIndexAtPtx6221, r_LaneIndexAtPtx6228;
	uint32_t r_LaneIndexAtPtx6235, r_LaneIndexAtPtx6242, r_PackedHalf2AtPtx6027R1815, r_LaneIndexAtPtx6249,
		r_PackedHalf2AtPtx6043R1817, r_LaneIndexAtPtx6256, r_LaneIndexAtPtx6263, r_LaneIndexAtPtx6270,
		r_LaneIndexAtPtx6277, r_LaneIndexAtPtx6284, r_LaneIndexAtPtx6291, r_PtxRegister1824;
	uint32_t r_LaneIndexAtPtx6304, r_PackedHalf2AtPtx6077R1826, r_PackedHalf2AtPtx6298R1827,
		r_LaneIndexAtPtx6311, r_PackedHalf2AtPtx6084R1829, r_LaneIndexAtPtx6318, r_PackedHalf2AtPtx6091R1831,
		r_LaneIndexAtPtx6325, r_PackedHalf2AtPtx6098R1833, r_LaneIndexAtPtx6332, r_PackedHalf2AtPtx6105R1835,
		r_LaneIndexAtPtx6339;
	uint32_t r_PackedHalf2AtPtx6112R1837, r_LaneIndexAtPtx6346, r_PackedHalf2AtPtx6119R1839,
		r_LaneIndexAtPtx6353, r_PackedHalf2AtPtx6126R1841, r_LaneIndexAtPtx6360, r_PackedHalf2AtPtx6133R1843,
		r_LaneIndexAtPtx6367, r_PackedHalf2AtPtx6140R1845, r_LaneIndexAtPtx6374, r_PackedHalf2AtPtx6147R1847,
		r_LaneIndexAtPtx6381;
	uint32_t r_PackedHalf2AtPtx6154R1849, r_LaneIndexAtPtx6388, r_PackedHalf2AtPtx6161R1851,
		r_LaneIndexAtPtx6395, r_PackedHalf2AtPtx6168R1853, r_LaneIndexAtPtx6402, r_PackedHalf2AtPtx6175R1855,
		r_LaneIndexAtPtx6409, r_PackedHalf2AtPtx6182R1857, r_LaneIndexAtPtx6416, r_PackedHalf2AtPtx6189R1859,
		r_LaneIndexAtPtx6423;
	uint32_t r_PackedHalf2AtPtx6196R1861, r_LaneIndexAtPtx6430, r_PackedHalf2AtPtx6203R1863,
		r_LaneIndexAtPtx6437, r_PackedHalf2AtPtx6210R1865, r_LaneIndexAtPtx6444, r_PackedHalf2AtPtx6217R1867,
		r_LaneIndexAtPtx6451, r_PackedHalf2AtPtx6224R1869, r_LaneIndexAtPtx6458, r_PackedHalf2AtPtx6231R1871,
		r_LaneIndexAtPtx6465;
	uint32_t r_PackedHalf2AtPtx6238R1873, r_LaneIndexAtPtx6472, r_PackedHalf2AtPtx6245R1875,
		r_LaneIndexAtPtx6479, r_PackedHalf2AtPtx6252R1877, r_LaneIndexAtPtx6486, r_PackedHalf2AtPtx6259R1879,
		r_LaneIndexAtPtx6493, r_PackedHalf2AtPtx6266R1881, r_LaneIndexAtPtx6500, r_PackedHalf2AtPtx6273R1883,
		r_LaneIndexAtPtx6507;
	uint32_t r_PackedHalf2AtPtx6280R1885, r_LaneIndexAtPtx6514, r_PackedHalf2AtPtx6287R1887,
		r_LaneIndexAtPtx6521, r_PackedHalf2AtPtx6294R1889, r_PackedHalf2AtPtx6307R1890,
		r_PackedHalf2AtPtx6321R1891, r_PackedHalf2AtPtx6314R1892, r_PackedHalf2AtPtx6328R1893,
		r_PackedHalf2AtPtx6335R1894, r_PackedHalf2AtPtx6349R1895, r_PackedHalf2AtPtx6342R1896;
	uint32_t r_PackedHalf2AtPtx6356R1897, r_PackedHalf2AtPtx6363R1898, r_PackedHalf2AtPtx6377R1899,
		r_PackedHalf2AtPtx6370R1900, r_PackedHalf2AtPtx6384R1901, r_PackedHalf2AtPtx6391R1902,
		r_PackedHalf2AtPtx6405R1903, r_PackedHalf2AtPtx6398R1904, r_PackedHalf2AtPtx6412R1905,
		r_PackedHalf2AtPtx6419R1906, r_PackedHalf2AtPtx6433R1907, r_PackedHalf2AtPtx6426R1908;
	uint32_t r_PackedHalf2AtPtx6440R1909, r_PackedHalf2AtPtx6447R1910, r_PackedHalf2AtPtx6461R1911,
		r_PackedHalf2AtPtx6454R1912, r_PackedHalf2AtPtx6468R1913, r_PackedHalf2AtPtx6475R1914,
		r_PackedHalf2AtPtx6489R1915, r_PackedHalf2AtPtx6482R1916, r_PackedHalf2AtPtx6496R1917,
		r_PackedHalf2AtPtx6503R1918, r_PackedHalf2AtPtx6517R1919, r_PackedHalf2AtPtx6510R1920;
	uint32_t r_PackedHalf2AtPtx6524R1921, r_LaneIndexAtPtx6632, r_MmaAccumulatorHalf2WordAtPtx4874R1923,
		r_LaneIndexAtPtx6639, r_MmaAccumulatorHalf2WordAtPtx4874R1925, r_LaneIndexAtPtx6646,
		r_MmaAccumulatorHalf2WordAtPtx4881R1927, r_LaneIndexAtPtx6653,
		r_MmaAccumulatorHalf2WordAtPtx4881R1929, r_LaneIndexAtPtx6660,
		r_MmaAccumulatorHalf2WordAtPtx4888R1931, r_LaneIndexAtPtx6667;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4888R1933, r_LaneIndexAtPtx6674,
		r_MmaAccumulatorHalf2WordAtPtx4895R1935, r_LaneIndexAtPtx6681,
		r_MmaAccumulatorHalf2WordAtPtx4895R1937, r_LaneIndexAtPtx6688,
		r_MmaAccumulatorHalf2WordAtPtx4958R1939, r_LaneIndexAtPtx6695,
		r_MmaAccumulatorHalf2WordAtPtx4958R1941, r_LaneIndexAtPtx6702,
		r_MmaAccumulatorHalf2WordAtPtx4965R1943, r_LaneIndexAtPtx6709;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4965R1945, r_LaneIndexAtPtx6716,
		r_MmaAccumulatorHalf2WordAtPtx4972R1947, r_LaneIndexAtPtx6723,
		r_MmaAccumulatorHalf2WordAtPtx4972R1949, r_LaneIndexAtPtx6730,
		r_MmaAccumulatorHalf2WordAtPtx4979R1951, r_LaneIndexAtPtx6737,
		r_MmaAccumulatorHalf2WordAtPtx4979R1953, r_LaneIndexAtPtx6744,
		r_MmaAccumulatorHalf2WordAtPtx5042R1955, r_LaneIndexAtPtx6751;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5042R1957, r_LaneIndexAtPtx6758,
		r_MmaAccumulatorHalf2WordAtPtx5049R1959, r_LaneIndexAtPtx6765,
		r_MmaAccumulatorHalf2WordAtPtx5049R1961, r_LaneIndexAtPtx6772,
		r_MmaAccumulatorHalf2WordAtPtx5056R1963, r_LaneIndexAtPtx6779,
		r_MmaAccumulatorHalf2WordAtPtx5056R1965, r_LaneIndexAtPtx6786,
		r_MmaAccumulatorHalf2WordAtPtx5063R1967, r_LaneIndexAtPtx6793;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5063R1969, r_LaneIndexAtPtx6800,
		r_MmaAccumulatorHalf2WordAtPtx5126R1971, r_LaneIndexAtPtx6807,
		r_MmaAccumulatorHalf2WordAtPtx5126R1973, r_LaneIndexAtPtx6814,
		r_MmaAccumulatorHalf2WordAtPtx5133R1975, r_LaneIndexAtPtx6821,
		r_MmaAccumulatorHalf2WordAtPtx5133R1977, r_LaneIndexAtPtx6828,
		r_MmaAccumulatorHalf2WordAtPtx5140R1979, r_LaneIndexAtPtx6835;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5140R1981, r_LaneIndexAtPtx6842,
		r_MmaAccumulatorHalf2WordAtPtx5147R1983, r_LaneIndexAtPtx6849,
		r_MmaAccumulatorHalf2WordAtPtx5147R1985, r_LaneIndexAtPtx6856, r_PackedHalf2AtPtx6635R1987,
		r_PackedHalf2AtPtx6663R1988, r_LaneIndexAtPtx6863, r_PackedHalf2AtPtx6642R1990,
		r_PackedHalf2AtPtx6670R1991, r_LaneIndexAtPtx6870;
	uint32_t r_PackedHalf2AtPtx6649R1993, r_PackedHalf2AtPtx6677R1994, r_LaneIndexAtPtx6877,
		r_PackedHalf2AtPtx6656R1996, r_PackedHalf2AtPtx6684R1997, r_LaneIndexAtPtx6884,
		r_PackedHalf2AtPtx6691R1999, r_PackedHalf2AtPtx6719R2000, r_LaneIndexAtPtx6891,
		r_PackedHalf2AtPtx6698R2002, r_PackedHalf2AtPtx6726R2003, r_LaneIndexAtPtx6898;
	uint32_t r_PackedHalf2AtPtx6705R2005, r_PackedHalf2AtPtx6733R2006, r_LaneIndexAtPtx6905,
		r_PackedHalf2AtPtx6712R2008, r_PackedHalf2AtPtx6740R2009, r_LaneIndexAtPtx6912,
		r_PackedHalf2AtPtx6747R2011, r_PackedHalf2AtPtx6775R2012, r_LaneIndexAtPtx6919,
		r_PackedHalf2AtPtx6754R2014, r_PackedHalf2AtPtx6782R2015, r_LaneIndexAtPtx6926;
	uint32_t r_PackedHalf2AtPtx6761R2017, r_PackedHalf2AtPtx6789R2018, r_LaneIndexAtPtx6933,
		r_PackedHalf2AtPtx6768R2020, r_PackedHalf2AtPtx6796R2021, r_LaneIndexAtPtx6940,
		r_PackedHalf2AtPtx6803R2023, r_PackedHalf2AtPtx6831R2024, r_LaneIndexAtPtx6947,
		r_PackedHalf2AtPtx6810R2026, r_PackedHalf2AtPtx6838R2027, r_LaneIndexAtPtx6954;
	uint32_t r_PackedHalf2AtPtx6817R2029, r_PackedHalf2AtPtx6845R2030, r_LaneIndexAtPtx6961,
		r_PackedHalf2AtPtx6824R2032, r_PackedHalf2AtPtx6852R2033, r_PackedHalf2AtPtx6873R2034,
		r_PackedHalf2AtPtx6859R2035, r_PackedHalf2AtPtx6880R2036, r_PackedHalf2AtPtx6866R2037,
		r_PackedHalf2AtPtx6968R2038, r_PackedHalf2AtPtx6976R2039, r_PackedHalf2AtPtx6980R2040;
	uint32_t r_PackedHalf2AtPtx6984R2041, r_PtxRegister2042, r_PackedHalf2AtPtx6992R2043,
		r_PackedHalf2AtPtx6972R2044, r_PackedHalf2AtPtx6998R2045, r_PackedHalf2AtPtx7002R2046,
		r_PackedHalf2AtPtx7006R2047, r_PtxRegister2048, r_PackedHalf2AtPtx7014R2049,
		r_PackedHalf2AtPtx6901R2050, r_PackedHalf2AtPtx6887R2051, r_PackedHalf2AtPtx6908R2052;
	uint32_t r_PackedHalf2AtPtx6894R2053, r_PackedHalf2AtPtx7020R2054, r_PackedHalf2AtPtx7028R2055,
		r_PackedHalf2AtPtx7032R2056, r_PackedHalf2AtPtx7036R2057, r_PtxRegister2058,
		r_PackedHalf2AtPtx7044R2059, r_PackedHalf2AtPtx7024R2060, r_PackedHalf2AtPtx7050R2061,
		r_PackedHalf2AtPtx7054R2062, r_PackedHalf2AtPtx7058R2063, r_PtxRegister2064;
	uint32_t r_PackedHalf2AtPtx7066R2065, r_PackedHalf2AtPtx6929R2066, r_PackedHalf2AtPtx6915R2067,
		r_PackedHalf2AtPtx6936R2068, r_PackedHalf2AtPtx6922R2069, r_PackedHalf2AtPtx7072R2070,
		r_PackedHalf2AtPtx7080R2071, r_PackedHalf2AtPtx7084R2072, r_PackedHalf2AtPtx7088R2073,
		r_PtxRegister2074, r_PackedHalf2AtPtx7096R2075, r_PackedHalf2AtPtx7076R2076;
	uint32_t r_PackedHalf2AtPtx7102R2077, r_PackedHalf2AtPtx7106R2078, r_PackedHalf2AtPtx7110R2079,
		r_PtxRegister2080, r_PackedHalf2AtPtx7118R2081, r_PackedHalf2AtPtx6957R2082,
		r_PackedHalf2AtPtx6943R2083, r_PackedHalf2AtPtx6964R2084, r_PackedHalf2AtPtx6950R2085,
		r_PackedHalf2AtPtx7124R2086, r_PackedHalf2AtPtx7132R2087, r_PackedHalf2AtPtx7136R2088;
	uint32_t r_PackedHalf2AtPtx7140R2089, r_PtxRegister2090, r_PackedHalf2AtPtx7148R2091,
		r_PackedHalf2AtPtx7128R2092, r_PackedHalf2AtPtx7154R2093, r_PackedHalf2AtPtx7158R2094,
		r_PackedHalf2AtPtx7162R2095, r_PtxRegister2096, r_PackedHalf2AtPtx7170R2097, r_LaneIndexAtPtx7176,
		r_PackedHalf2AtPtx6994R2099, r_LaneIndexAtPtx7183;
	uint32_t r_PackedHalf2AtPtx7016R2101, r_LaneIndexAtPtx7190, r_LaneIndexAtPtx7193, r_LaneIndexAtPtx7196,
		r_LaneIndexAtPtx7199, r_LaneIndexAtPtx7202, r_LaneIndexAtPtx7205, r_LaneIndexAtPtx7208,
		r_PackedHalf2AtPtx7046R2109, r_LaneIndexAtPtx7215, r_PackedHalf2AtPtx7068R2111, r_LaneIndexAtPtx7222;
	uint32_t r_LaneIndexAtPtx7225, r_LaneIndexAtPtx7228, r_LaneIndexAtPtx7231, r_LaneIndexAtPtx7234,
		r_LaneIndexAtPtx7237, r_LaneIndexAtPtx7240, r_PackedHalf2AtPtx7098R2119, r_LaneIndexAtPtx7247,
		r_PackedHalf2AtPtx7120R2121, r_LaneIndexAtPtx7254, r_LaneIndexAtPtx7257, r_LaneIndexAtPtx7260;
	uint32_t r_LaneIndexAtPtx7263, r_LaneIndexAtPtx7266, r_LaneIndexAtPtx7269, r_LaneIndexAtPtx7272,
		r_PackedHalf2AtPtx7150R2129, r_LaneIndexAtPtx7279, r_PackedHalf2AtPtx7172R2131, r_LaneIndexAtPtx7286,
		r_LaneIndexAtPtx7289, r_LaneIndexAtPtx7292, r_LaneIndexAtPtx7295, r_LaneIndexAtPtx7298;
	uint32_t r_LaneIndexAtPtx7301, r_LaneIndexAtPtx7304, r_PackedHalf2AtPtx7179R2139, r_LaneIndexAtPtx7320,
		r_PackedHalf2AtPtx7186R2141, r_LaneIndexAtPtx7336, r_LaneIndexAtPtx7339, r_LaneIndexAtPtx7342,
		r_LaneIndexAtPtx7345, r_LaneIndexAtPtx7348, r_LaneIndexAtPtx7351, r_LaneIndexAtPtx7354;
	uint32_t r_PackedHalf2AtPtx7211R2149, r_LaneIndexAtPtx7370, r_PackedHalf2AtPtx7218R2151,
		r_LaneIndexAtPtx7386, r_LaneIndexAtPtx7389, r_LaneIndexAtPtx7392, r_LaneIndexAtPtx7395,
		r_LaneIndexAtPtx7398, r_LaneIndexAtPtx7401, r_LaneIndexAtPtx7404, r_PackedHalf2AtPtx7243R2159,
		r_LaneIndexAtPtx7420;
	uint32_t r_PackedHalf2AtPtx7250R2161, r_LaneIndexAtPtx7436, r_LaneIndexAtPtx7439, r_LaneIndexAtPtx7442,
		r_LaneIndexAtPtx7445, r_LaneIndexAtPtx7448, r_LaneIndexAtPtx7451, r_LaneIndexAtPtx7454,
		r_PackedHalf2AtPtx7275R2169, r_LaneIndexAtPtx7470, r_PackedHalf2AtPtx7282R2171, r_LaneIndexAtPtx7486;
	uint32_t r_LaneIndexAtPtx7489, r_LaneIndexAtPtx7492, r_LaneIndexAtPtx7495, r_LaneIndexAtPtx7498,
		r_LaneIndexAtPtx7501, r_LaneIndexAtPtx7504, r_PackedHalf2AtPtx7307R2179, r_LaneIndexAtPtx7511,
		r_PackedHalf2AtPtx7323R2181, r_LaneIndexAtPtx7518, r_LaneIndexAtPtx7525, r_LaneIndexAtPtx7532;
	uint32_t r_LaneIndexAtPtx7539, r_LaneIndexAtPtx7546, r_LaneIndexAtPtx7553, r_LaneIndexAtPtx7560,
		r_PackedHalf2AtPtx7357R2189, r_LaneIndexAtPtx7567, r_PackedHalf2AtPtx7373R2191, r_LaneIndexAtPtx7574,
		r_LaneIndexAtPtx7581, r_LaneIndexAtPtx7588, r_LaneIndexAtPtx7595, r_LaneIndexAtPtx7602;
	uint32_t r_LaneIndexAtPtx7609, r_LaneIndexAtPtx7616, r_PackedHalf2AtPtx7407R2199, r_LaneIndexAtPtx7623,
		r_PackedHalf2AtPtx7423R2201, r_LaneIndexAtPtx7630, r_LaneIndexAtPtx7637, r_LaneIndexAtPtx7644,
		r_LaneIndexAtPtx7651, r_LaneIndexAtPtx7658, r_LaneIndexAtPtx7665, r_LaneIndexAtPtx7672;
	uint32_t r_PackedHalf2AtPtx7457R2209, r_LaneIndexAtPtx7679, r_PackedHalf2AtPtx7473R2211,
		r_LaneIndexAtPtx7686, r_LaneIndexAtPtx7693, r_LaneIndexAtPtx7700, r_LaneIndexAtPtx7707,
		r_LaneIndexAtPtx7714, r_LaneIndexAtPtx7721, r_PackedHalf2AtPtx7507R2218, r_PackedHalf2AtPtx7521R2219,
		r_PackedHalf2AtPtx7535R2220;
	uint32_t r_PackedHalf2AtPtx7549R2221, r_PackedHalf2AtPtx7514R2222, r_PackedHalf2AtPtx7528R2223,
		r_PackedHalf2AtPtx7542R2224, r_PackedHalf2AtPtx7556R2225, r_PackedHalf2AtPtx7563R2226,
		r_PackedHalf2AtPtx7577R2227, r_PackedHalf2AtPtx7591R2228, r_PackedHalf2AtPtx7605R2229,
		r_PackedHalf2AtPtx7570R2230, r_PackedHalf2AtPtx7584R2231, r_PackedHalf2AtPtx7598R2232;
	uint32_t r_PackedHalf2AtPtx7612R2233, r_PackedHalf2AtPtx7619R2234, r_PackedHalf2AtPtx7633R2235,
		r_PackedHalf2AtPtx7647R2236, r_PackedHalf2AtPtx7661R2237, r_PackedHalf2AtPtx7626R2238,
		r_PackedHalf2AtPtx7640R2239, r_PackedHalf2AtPtx7654R2240, r_PackedHalf2AtPtx7668R2241,
		r_PackedHalf2AtPtx7675R2242, r_PackedHalf2AtPtx7689R2243, r_PackedHalf2AtPtx7703R2244;
	uint32_t r_PackedHalf2AtPtx7717R2245, r_PackedHalf2AtPtx7682R2246, r_PackedHalf2AtPtx7696R2247,
		r_PackedHalf2AtPtx7710R2248, r_PackedHalf2AtPtx7724R2249, r_PtxRegister2250, r_PtxRegister2251,
		r_PtxRegister2252, r_PtxRegister2253, r_PtxRegister2254, r_PtxRegister2255, r_PtxRegister2256;
	uint32_t r_PtxRegister2257, r_PtxRegister2258, r_PtxRegister2259, r_PtxRegister2260, r_PtxRegister2261,
		r_PtxRegister2262, r_PtxRegister2263, r_PtxRegister2264, r_PtxRegister2265, r_PtxRegister2266,
		r_PtxRegister2267, r_PtxRegister2268;
	uint32_t r_PtxRegister2269, r_PtxRegister2270, r_PtxRegister2271, r_PtxRegister2272, r_PtxRegister2273,
		r_PtxRegister2274, r_PtxRegister2275, r_PtxRegister2276, r_PtxRegister2277, r_PtxRegister2278,
		r_PtxRegister2279, r_PtxRegister2280;
	uint32_t r_PtxRegister2281, r_PtxRegister2282, r_PtxRegister2283, r_PtxRegister2284, r_PtxRegister2285,
		r_PtxRegister2286, r_PtxRegister2287, r_PtxRegister2288, r_PtxRegister2289, r_PtxRegister2290,
		r_PtxRegister2291, r_PtxRegister2292;
	uint32_t r_PtxRegister2293, r_PtxRegister2294, r_PtxRegister2295, r_PtxRegister2296, r_PtxRegister2297,
		r_PtxRegister2298, r_PtxRegister2299, r_PtxRegister2300, r_PtxRegister2301, r_PtxRegister2302,
		r_PtxRegister2303, r_PtxRegister2304;
	uint32_t r_PtxRegister2305, r_PtxRegister2306, r_PtxRegister2307, r_PtxRegister2308, r_PtxRegister2309,
		r_PtxRegister2310, r_PtxRegister2311, r_PtxRegister2312, r_PtxRegister2313, r_LaneIndexAtPtx8052,
		r_LaneIndexAtPtx8061, r_LaneIndexAtPtx8070;
	uint32_t r_LaneIndexAtPtx8079, r_LaneIndexAtPtx8088, r_LaneIndexAtPtx8097, r_LaneIndexAtPtx8106,
		r_LaneIndexAtPtx8115, r_MmaBE4x4WordAtPtx7733R2322, r_MmaBE4x4WordAtPtx7740R2323,
		r_MmaAccumulatorHalf2WordAtPtx8058R2324, r_MmaAccumulatorHalf2WordAtPtx8058R2325,
		r_MmaAE4x4WordAtPtx6533R2326, r_MmaAE4x4WordAtPtx6540R2327, r_MmaAE4x4WordAtPtx6547R2328;
	uint32_t r_MmaAE4x4WordAtPtx6554R2329, r_MmaBE4x4WordAtPtx7747R2330, r_MmaBE4x4WordAtPtx7754R2331,
		r_MmaAccumulatorHalf2WordAtPtx8058R2332, r_MmaAccumulatorHalf2WordAtPtx8058R2333,
		r_MmaBE4x4WordAtPtx7761R2334, r_MmaBE4x4WordAtPtx7768R2335, r_MmaAccumulatorHalf2WordAtPtx8067R2336,
		r_MmaAccumulatorHalf2WordAtPtx8067R2337, r_MmaBE4x4WordAtPtx7775R2338, r_MmaBE4x4WordAtPtx7782R2339,
		r_MmaAccumulatorHalf2WordAtPtx8067R2340;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx8067R2341, r_MmaBE4x4WordAtPtx7789R2342,
		r_MmaBE4x4WordAtPtx7796R2343, r_MmaAccumulatorHalf2WordAtPtx8076R2344,
		r_MmaAccumulatorHalf2WordAtPtx8076R2345, r_MmaBE4x4WordAtPtx7803R2346, r_MmaBE4x4WordAtPtx7810R2347,
		r_MmaAccumulatorHalf2WordAtPtx8076R2348, r_MmaAccumulatorHalf2WordAtPtx8076R2349,
		r_MmaBE4x4WordAtPtx7817R2350, r_MmaBE4x4WordAtPtx7824R2351, r_MmaAccumulatorHalf2WordAtPtx8085R2352;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx8085R2353, r_MmaBE4x4WordAtPtx7831R2354,
		r_MmaBE4x4WordAtPtx7838R2355, r_MmaAccumulatorHalf2WordAtPtx8085R2356,
		r_MmaAccumulatorHalf2WordAtPtx8085R2357, r_MmaAccumulatorHalf2WordAtPtx8094R2358,
		r_MmaAccumulatorHalf2WordAtPtx8094R2359, r_MmaAE4x4WordAtPtx6561R2360, r_MmaAE4x4WordAtPtx6568R2361,
		r_MmaAE4x4WordAtPtx6575R2362, r_MmaAE4x4WordAtPtx6582R2363, r_MmaAccumulatorHalf2WordAtPtx8094R2364;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx8094R2365, r_MmaAccumulatorHalf2WordAtPtx8103R2366,
		r_MmaAccumulatorHalf2WordAtPtx8103R2367, r_MmaAccumulatorHalf2WordAtPtx8103R2368,
		r_MmaAccumulatorHalf2WordAtPtx8103R2369, r_MmaAccumulatorHalf2WordAtPtx8112R2370,
		r_MmaAccumulatorHalf2WordAtPtx8112R2371, r_MmaAccumulatorHalf2WordAtPtx8112R2372,
		r_MmaAccumulatorHalf2WordAtPtx8112R2373, r_MmaAccumulatorHalf2WordAtPtx8121R2374,
		r_MmaAccumulatorHalf2WordAtPtx8121R2375, r_MmaAccumulatorHalf2WordAtPtx8121R2376;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx8121R2377, r_LaneIndexAtPtx8236, r_Float32BitsAtPtx8238R2379,
		r_Float32BitsAtPtx8245R2380, r_Float32BitsAtPtx8252R2381, r_Float32BitsAtPtx8259R2382,
		r_MmaAccumulatorHalf2WordAtPtx8124R2383, r_PackedHalf2AtPtx8267R2384, r_PtxRegister2385,
		r_PackedHalf2AtPtx8271R2386, r_LaneIndexAtPtx8281, r_MmaAccumulatorHalf2WordAtPtx8124R2388;
	uint32_t r_PackedHalf2AtPtx8284R2389, r_PtxRegister2390, r_PackedHalf2AtPtx8288R2391,
		r_LaneIndexAtPtx8298, r_MmaAccumulatorHalf2WordAtPtx8131R2393, r_PackedHalf2AtPtx8301R2394,
		r_PtxRegister2395, r_PackedHalf2AtPtx8305R2396, r_LaneIndexAtPtx8315,
		r_MmaAccumulatorHalf2WordAtPtx8131R2398, r_PackedHalf2AtPtx8318R2399, r_PtxRegister2400;
	uint32_t r_PackedHalf2AtPtx8322R2401, r_LaneIndexAtPtx8332, r_MmaAccumulatorHalf2WordAtPtx8138R2403,
		r_PackedHalf2AtPtx8335R2404, r_PtxRegister2405, r_PackedHalf2AtPtx8339R2406, r_LaneIndexAtPtx8349,
		r_MmaAccumulatorHalf2WordAtPtx8138R2408, r_PackedHalf2AtPtx8352R2409, r_PtxRegister2410,
		r_PackedHalf2AtPtx8356R2411, r_LaneIndexAtPtx8366;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx8145R2413, r_PackedHalf2AtPtx8369R2414, r_PtxRegister2415,
		r_PackedHalf2AtPtx8373R2416, r_LaneIndexAtPtx8383, r_MmaAccumulatorHalf2WordAtPtx8145R2418,
		r_PackedHalf2AtPtx8386R2419, r_PtxRegister2420, r_PackedHalf2AtPtx8390R2421, r_LaneIndexAtPtx8400,
		r_MmaAccumulatorHalf2WordAtPtx8152R2423, r_PackedHalf2AtPtx8403R2424;
	uint32_t r_PtxRegister2425, r_PackedHalf2AtPtx8407R2426, r_LaneIndexAtPtx8417,
		r_MmaAccumulatorHalf2WordAtPtx8152R2428, r_PackedHalf2AtPtx8420R2429, r_PtxRegister2430,
		r_PackedHalf2AtPtx8424R2431, r_LaneIndexAtPtx8434, r_MmaAccumulatorHalf2WordAtPtx8159R2433,
		r_PackedHalf2AtPtx8437R2434, r_PtxRegister2435, r_PackedHalf2AtPtx8441R2436;
	uint32_t r_LaneIndexAtPtx8451, r_MmaAccumulatorHalf2WordAtPtx8159R2438, r_PackedHalf2AtPtx8454R2439,
		r_PtxRegister2440, r_PackedHalf2AtPtx8458R2441, r_LaneIndexAtPtx8468,
		r_MmaAccumulatorHalf2WordAtPtx8166R2443, r_PackedHalf2AtPtx8471R2444, r_PtxRegister2445,
		r_PackedHalf2AtPtx8475R2446, r_LaneIndexAtPtx8485, r_MmaAccumulatorHalf2WordAtPtx8166R2448;
	uint32_t r_PackedHalf2AtPtx8488R2449, r_PtxRegister2450, r_PackedHalf2AtPtx8492R2451,
		r_LaneIndexAtPtx8502, r_MmaAccumulatorHalf2WordAtPtx8173R2453, r_PackedHalf2AtPtx8505R2454,
		r_PtxRegister2455, r_PackedHalf2AtPtx8509R2456, r_LaneIndexAtPtx8519,
		r_MmaAccumulatorHalf2WordAtPtx8173R2458, r_PackedHalf2AtPtx8522R2459, r_PtxRegister2460;
	uint32_t r_PackedHalf2AtPtx8526R2461, r_LaneIndexAtPtx8536, r_MmaAccumulatorHalf2WordAtPtx8180R2463,
		r_PackedHalf2AtPtx8539R2464, r_PtxRegister2465, r_PackedHalf2AtPtx8543R2466, r_LaneIndexAtPtx8553,
		r_MmaAccumulatorHalf2WordAtPtx8180R2468, r_PackedHalf2AtPtx8556R2469, r_PtxRegister2470,
		r_PackedHalf2AtPtx8560R2471, r_LaneIndexAtPtx8570;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx8187R2473, r_PackedHalf2AtPtx8573R2474, r_PtxRegister2475,
		r_PackedHalf2AtPtx8577R2476, r_LaneIndexAtPtx8587, r_MmaAccumulatorHalf2WordAtPtx8187R2478,
		r_PackedHalf2AtPtx8590R2479, r_PtxRegister2480, r_PackedHalf2AtPtx8594R2481, r_LaneIndexAtPtx8604,
		r_MmaAccumulatorHalf2WordAtPtx8194R2483, r_PackedHalf2AtPtx8607R2484;
	uint32_t r_PtxRegister2485, r_PackedHalf2AtPtx8611R2486, r_LaneIndexAtPtx8621,
		r_MmaAccumulatorHalf2WordAtPtx8194R2488, r_PackedHalf2AtPtx8624R2489, r_PtxRegister2490,
		r_PackedHalf2AtPtx8628R2491, r_LaneIndexAtPtx8638, r_MmaAccumulatorHalf2WordAtPtx8201R2493,
		r_PackedHalf2AtPtx8641R2494, r_PtxRegister2495, r_PackedHalf2AtPtx8645R2496;
	uint32_t r_LaneIndexAtPtx8655, r_MmaAccumulatorHalf2WordAtPtx8201R2498, r_PackedHalf2AtPtx8658R2499,
		r_PtxRegister2500, r_PackedHalf2AtPtx8662R2501, r_LaneIndexAtPtx8672,
		r_MmaAccumulatorHalf2WordAtPtx8208R2503, r_PackedHalf2AtPtx8675R2504, r_PtxRegister2505,
		r_PackedHalf2AtPtx8679R2506, r_LaneIndexAtPtx8689, r_MmaAccumulatorHalf2WordAtPtx8208R2508;
	uint32_t r_PackedHalf2AtPtx8692R2509, r_PtxRegister2510, r_PackedHalf2AtPtx8696R2511,
		r_LaneIndexAtPtx8706, r_MmaAccumulatorHalf2WordAtPtx8215R2513, r_PackedHalf2AtPtx8709R2514,
		r_PtxRegister2515, r_PackedHalf2AtPtx8713R2516, r_LaneIndexAtPtx8723,
		r_MmaAccumulatorHalf2WordAtPtx8215R2518, r_PackedHalf2AtPtx8726R2519, r_PtxRegister2520;
	uint32_t r_PackedHalf2AtPtx8730R2521, r_LaneIndexAtPtx8740, r_MmaAccumulatorHalf2WordAtPtx8222R2523,
		r_PackedHalf2AtPtx8743R2524, r_PtxRegister2525, r_PackedHalf2AtPtx8747R2526, r_LaneIndexAtPtx8757,
		r_MmaAccumulatorHalf2WordAtPtx8222R2528, r_PackedHalf2AtPtx8760R2529, r_PtxRegister2530,
		r_PackedHalf2AtPtx8764R2531, r_LaneIndexAtPtx8774;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx8229R2533, r_PackedHalf2AtPtx8777R2534, r_PtxRegister2535,
		r_PackedHalf2AtPtx8781R2536, r_LaneIndexAtPtx8791, r_MmaAccumulatorHalf2WordAtPtx8229R2538,
		r_PackedHalf2AtPtx8794R2539, r_PtxRegister2540, r_PackedHalf2AtPtx8798R2541, r_LaneIndexAtPtx8808,
		r_PackedHalf2AtPtx8811R2543, r_PackedHalf2AtPtx8815R2544;
	uint32_t r_PackedHalf2AtPtx8819R2545, r_PackedHalf2AtPtx8823R2546, r_PtxRegister2547,
		r_PackedHalf2AtPtx8827R2548, r_PackedHalf2AtPtx8831R2549, r_PackedHalf2AtPtx8839R2550,
		r_PackedHalf2AtPtx8843R2551, r_PackedHalf2AtPtx8847R2552, r_PackedHalf2AtPtx8851R2553,
		r_PtxRegister2554, r_PackedHalf2AtPtx8855R2555, r_PackedHalf2AtPtx8859R2556;
	uint32_t r_PackedHalf2AtPtx8867R2557, r_PackedHalf2AtPtx8871R2558, r_PackedHalf2AtPtx8875R2559,
		r_PackedHalf2AtPtx8879R2560, r_PtxRegister2561, r_PackedHalf2AtPtx8883R2562,
		r_PackedHalf2AtPtx8887R2563, r_PackedHalf2AtPtx8895R2564, r_PackedHalf2AtPtx8899R2565,
		r_PackedHalf2AtPtx8903R2566, r_PackedHalf2AtPtx8907R2567, r_PtxRegister2568;
	uint32_t r_PackedHalf2AtPtx8911R2569, r_PackedHalf2AtPtx8915R2570, r_PtxRegister2571, r_PtxRegister2572,
		r_PackedHalf2AtPtx8959R2573, r_PtxRegister2574, r_PtxRegister2575, r_PackedHalf2AtPtx8963R2576,
		r_PtxRegister2577, r_PtxRegister2578, r_PackedHalf2AtPtx8971R2579, r_PackedHalf2AtPtx8972R2580;
	uint32_t r_LaneIndexAtPtx8984, r_PtxRegister2582, r_PackedHalf2AtPtx8982R2583, r_LaneIndexAtPtx8991,
		r_PtxRegister2585, r_PackedHalf2AtPtx8987R2586, r_LaneIndexAtPtx9007, r_LaneIndexAtPtx9033,
		r_LaneIndexAtPtx9059, r_LaneIndexAtPtx9085, r_LaneIndexAtPtx9111, r_LaneIndexAtPtx9138;
	uint32_t r_LaneIndexAtPtx9165, r_LaneIndexAtPtx9192, r_LaneIndexAtPtx9219, r_PtxRegister2596,
		r_PtxRegister2597, r_LaneIndexAtPtx9226, r_PtxRegister2599, r_PtxRegister2600, r_LaneIndexAtPtx9233,
		r_PtxRegister2602, r_PtxRegister2603, r_LaneIndexAtPtx9240;
	uint32_t r_PtxRegister2605, r_PtxRegister2606, r_LaneIndexAtPtx9247, r_PtxRegister2608, r_PtxRegister2609,
		r_LaneIndexAtPtx9254, r_PtxRegister2611, r_PtxRegister2612, r_LaneIndexAtPtx9261, r_PtxRegister2614,
		r_PtxRegister2615, r_LaneIndexAtPtx9268;
	uint32_t r_PtxRegister2617, r_PtxRegister2618, r_LaneIndexAtPtx9275, r_PtxRegister2620, r_PtxRegister2621,
		r_LaneIndexAtPtx9282, r_PtxRegister2623, r_PtxRegister2624, r_LaneIndexAtPtx9289, r_PtxRegister2626,
		r_PtxRegister2627, r_LaneIndexAtPtx9296;
	uint32_t r_PtxRegister2629, r_PtxRegister2630, r_LaneIndexAtPtx9303, r_PtxRegister2632, r_PtxRegister2633,
		r_LaneIndexAtPtx9310, r_PtxRegister2635, r_PtxRegister2636, r_LaneIndexAtPtx9317, r_PtxRegister2638,
		r_PtxRegister2639, r_LaneIndexAtPtx9324;
	uint32_t r_PtxRegister2641, r_PtxRegister2642, r_LaneIndexAtPtx9331, r_PtxRegister2644, r_PtxRegister2645,
		r_LaneIndexAtPtx9338, r_PtxRegister2647, r_PtxRegister2648, r_LaneIndexAtPtx9345, r_PtxRegister2650,
		r_PtxRegister2651, r_LaneIndexAtPtx9352;
	uint32_t r_PtxRegister2653, r_PtxRegister2654, r_LaneIndexAtPtx9359, r_PtxRegister2656, r_PtxRegister2657,
		r_LaneIndexAtPtx9366, r_PtxRegister2659, r_PtxRegister2660, r_LaneIndexAtPtx9373, r_PtxRegister2662,
		r_PtxRegister2663, r_LaneIndexAtPtx9380;
	uint32_t r_PtxRegister2665, r_PtxRegister2666, r_LaneIndexAtPtx9387, r_PtxRegister2668, r_PtxRegister2669,
		r_LaneIndexAtPtx9394, r_PtxRegister2671, r_PtxRegister2672, r_LaneIndexAtPtx9401, r_PtxRegister2674,
		r_PtxRegister2675, r_LaneIndexAtPtx9408;
	uint32_t r_PtxRegister2677, r_PtxRegister2678, r_LaneIndexAtPtx9415, r_PtxRegister2680, r_PtxRegister2681,
		r_LaneIndexAtPtx9422, r_PtxRegister2683, r_PtxRegister2684, r_LaneIndexAtPtx9429, r_PtxRegister2686,
		r_PtxRegister2687, r_LaneIndexAtPtx9436;
	uint32_t r_PtxRegister2689, r_PtxRegister2690, r_PackedHalf2AtPtx9222R2691, r_PackedHalf2AtPtx9236R2692,
		r_PackedHalf2AtPtx9229R2693, r_PackedHalf2AtPtx9243R2694, r_PackedHalf2AtPtx9250R2695,
		r_PackedHalf2AtPtx9264R2696, r_PackedHalf2AtPtx9257R2697, r_PackedHalf2AtPtx9271R2698,
		r_PackedHalf2AtPtx9278R2699, r_PackedHalf2AtPtx9292R2700;
	uint32_t r_PackedHalf2AtPtx9285R2701, r_PackedHalf2AtPtx9299R2702, r_PackedHalf2AtPtx9306R2703,
		r_PackedHalf2AtPtx9320R2704, r_PackedHalf2AtPtx9313R2705, r_PackedHalf2AtPtx9327R2706,
		r_PackedHalf2AtPtx9334R2707, r_PackedHalf2AtPtx9348R2708, r_PackedHalf2AtPtx9341R2709,
		r_PackedHalf2AtPtx9355R2710, r_PackedHalf2AtPtx9362R2711, r_PackedHalf2AtPtx9376R2712;
	uint32_t r_PackedHalf2AtPtx9369R2713, r_PackedHalf2AtPtx9383R2714, r_PackedHalf2AtPtx9390R2715,
		r_PackedHalf2AtPtx9404R2716, r_PackedHalf2AtPtx9397R2717, r_PackedHalf2AtPtx9411R2718,
		r_PackedHalf2AtPtx9418R2719, r_PackedHalf2AtPtx9432R2720, r_PackedHalf2AtPtx9425R2721,
		r_PackedHalf2AtPtx9439R2722, r_MmaBE4x4WordAtPtx7941R2723, r_MmaBE4x4WordAtPtx7948R2724;
	uint32_t r_MmaAE4x4WordAtPtx9448R2725, r_MmaAE4x4WordAtPtx9455R2726, r_MmaAE4x4WordAtPtx9462R2727,
		r_MmaAE4x4WordAtPtx9469R2728, r_MmaBE4x4WordAtPtx7955R2729, r_MmaBE4x4WordAtPtx7962R2730,
		r_MmaBE4x4WordAtPtx7997R2731, r_MmaBE4x4WordAtPtx8004R2732, r_MmaAccumulatorHalf2WordAtPtx9555R2733,
		r_MmaAccumulatorHalf2WordAtPtx9555R2734, r_MmaAE4x4WordAtPtx9476R2735, r_MmaAE4x4WordAtPtx9483R2736;
	uint32_t r_MmaAE4x4WordAtPtx9490R2737, r_MmaAE4x4WordAtPtx9497R2738, r_MmaBE4x4WordAtPtx8011R2739,
		r_MmaBE4x4WordAtPtx8018R2740, r_MmaAccumulatorHalf2WordAtPtx9562R2741,
		r_MmaAccumulatorHalf2WordAtPtx9562R2742, r_MmaBE4x4WordAtPtx7969R2743, r_MmaBE4x4WordAtPtx7976R2744,
		r_MmaBE4x4WordAtPtx7983R2745, r_MmaBE4x4WordAtPtx7990R2746, r_MmaBE4x4WordAtPtx8025R2747,
		r_MmaBE4x4WordAtPtx8032R2748;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx9583R2749, r_MmaAccumulatorHalf2WordAtPtx9583R2750,
		r_MmaBE4x4WordAtPtx8039R2751, r_MmaBE4x4WordAtPtx8046R2752, r_MmaAccumulatorHalf2WordAtPtx9590R2753,
		r_MmaAccumulatorHalf2WordAtPtx9590R2754, r_MmaAE4x4WordAtPtx9504R2755, r_MmaAE4x4WordAtPtx9511R2756,
		r_MmaAE4x4WordAtPtx9518R2757, r_MmaAE4x4WordAtPtx9525R2758, r_MmaAccumulatorHalf2WordAtPtx9611R2759,
		r_MmaAccumulatorHalf2WordAtPtx9611R2760;
	uint32_t r_MmaAE4x4WordAtPtx9532R2761, r_MmaAE4x4WordAtPtx9539R2762, r_MmaAE4x4WordAtPtx9546R2763,
		r_MmaAE4x4WordAtPtx9553R2764, r_MmaAccumulatorHalf2WordAtPtx9618R2765,
		r_MmaAccumulatorHalf2WordAtPtx9618R2766, r_PackedHalf2AtPtx965R2767,
		r_MmaAccumulatorHalf2WordAtPtx9639R2768, r_MmaAccumulatorHalf2WordAtPtx9639R2769,
		r_MmaAccumulatorHalf2WordAtPtx9646R2770, r_MmaAccumulatorHalf2WordAtPtx9646R2771,
		r_LaneIndexAtPtx9667;
	uint32_t r_PtxRegister2773, r_PtxRegister2774, r_PtxRegister2775, r_PtxRegister2776, r_PtxRegister2777,
		r_LaneIndexAtPtx9677, r_PtxRegister2779, r_PtxRegister2780, r_PtxRegister2781, r_PtxRegister2782,
		r_PtxRegister2783, r_LaneIndexAtPtx9742;
	uint32_t r_LaneIndexAtPtx9756, r_LaneIndexAtPtx9770, r_LaneIndexAtPtx9784, r_LaneIndexAtPtx9796,
		r_LaneIndexAtPtx9809, r_LaneIndexAtPtx9821, r_LaneIndexAtPtx9834, r_LaneIndexAtPtx9846,
		r_LaneIndexAtPtx9860, r_LaneIndexAtPtx9874, r_LaneIndexAtPtx9886, r_LaneIndexAtPtx9898;
	uint32_t r_LaneIndexAtPtx9910, r_LaneIndexAtPtx9922, r_LaneIndexAtPtx9934, r_LaneIndexAtPtx9946,
		r_PackedHalf2AtPtx9687R2801, r_PtxRegister2802, r_LaneIndexAtPtx9953, r_PackedHalf2AtPtx9694R2804,
		r_PtxRegister2805, r_LaneIndexAtPtx9960, r_PackedHalf2AtPtx9690R2807, r_PtxRegister2808;
	uint32_t r_LaneIndexAtPtx9967, r_PackedHalf2AtPtx9697R2810, r_PtxRegister2811, r_LaneIndexAtPtx9974,
		r_PackedHalf2AtPtx9701R2813, r_PtxRegister2814, r_LaneIndexAtPtx9981, r_PackedHalf2AtPtx9708R2816,
		r_PtxRegister2817, r_LaneIndexAtPtx9988, r_PackedHalf2AtPtx9704R2819, r_PtxRegister2820;
	uint32_t r_LaneIndexAtPtx9995, r_PackedHalf2AtPtx9711R2822, r_PtxRegister2823, r_LaneIndexAtPtx10002,
		r_PackedHalf2AtPtx9715R2825, r_PtxRegister2826, r_LaneIndexAtPtx10009, r_PackedHalf2AtPtx9722R2828,
		r_PtxRegister2829, r_LaneIndexAtPtx10016, r_PackedHalf2AtPtx9718R2831, r_PtxRegister2832;
	uint32_t r_LaneIndexAtPtx10023, r_PackedHalf2AtPtx9725R2834, r_PtxRegister2835, r_LaneIndexAtPtx10030,
		r_PackedHalf2AtPtx9729R2837, r_PtxRegister2838, r_LaneIndexAtPtx10037, r_PackedHalf2AtPtx9736R2840,
		r_PtxRegister2841, r_LaneIndexAtPtx10044, r_PackedHalf2AtPtx9732R2843, r_PtxRegister2844;
	uint32_t r_LaneIndexAtPtx10051, r_PackedHalf2AtPtx9739R2846, r_PtxRegister2847,
		r_MmaAccumulatorHalf2WordAtPtx9569R2848, r_MmaAccumulatorHalf2WordAtPtx9576R2849,
		r_MmaAccumulatorHalf2WordAtPtx9569R2850, r_MmaAccumulatorHalf2WordAtPtx9576R2851,
		r_MmaAccumulatorHalf2WordAtPtx9597R2852, r_MmaAccumulatorHalf2WordAtPtx9604R2853,
		r_MmaAccumulatorHalf2WordAtPtx9597R2854, r_MmaAccumulatorHalf2WordAtPtx9604R2855,
		r_MmaAccumulatorHalf2WordAtPtx9625R2856;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx9632R2857, r_MmaAccumulatorHalf2WordAtPtx9625R2858,
		r_MmaAccumulatorHalf2WordAtPtx9632R2859, r_MmaAccumulatorHalf2WordAtPtx9653R2860,
		r_MmaAccumulatorHalf2WordAtPtx9660R2861, r_MmaAccumulatorHalf2WordAtPtx9653R2862,
		r_MmaAccumulatorHalf2WordAtPtx9660R2863, r_LaneIndexAtPtx10114, r_PtxRegister2865,
		r_PackedE4WordAtPtx10063R2866, r_PackedE4WordAtPtx10070R2867, r_PackedE4WordAtPtx10077R2868;
	uint32_t r_PackedE4WordAtPtx10084R2869, r_LaneIndexAtPtx10122, r_PtxRegister2871,
		r_PackedE4WordAtPtx10091R2872, r_PackedE4WordAtPtx10098R2873, r_PackedE4WordAtPtx10105R2874,
		r_PackedE4WordAtPtx10112R2875, r_LaneIndexAtPtx10135, r_LaneIndexAtPtx10144, r_LaneIndexAtPtx10153,
		r_PtxRegister2879, r_LaneIndexAtPtx10161;
	uint32_t r_PtxRegister2881, r_MmaAE4x4WordAtPtx10158R2882, r_MmaAE4x4WordAtPtx10158R2883,
		r_MmaAE4x4WordAtPtx10158R2884, r_MmaAE4x4WordAtPtx10158R2885, r_MmaBE4x4WordAtPtx10141R2886,
		r_MmaBE4x4WordAtPtx10141R2887, r_PackedHalf2AtPtx9949R2888, r_PackedHalf2AtPtx9956R2889,
		r_MmaBE4x4WordAtPtx10141R2890, r_MmaBE4x4WordAtPtx10141R2891, r_PackedHalf2AtPtx9963R2892;
	uint32_t r_PackedHalf2AtPtx9970R2893, r_MmaBE4x4WordAtPtx10150R2894, r_MmaBE4x4WordAtPtx10150R2895,
		r_PackedHalf2AtPtx9977R2896, r_PackedHalf2AtPtx9984R2897, r_MmaBE4x4WordAtPtx10150R2898,
		r_MmaBE4x4WordAtPtx10150R2899, r_PackedHalf2AtPtx9991R2900, r_PackedHalf2AtPtx9998R2901,
		r_MmaAE4x4WordAtPtx10167R2902, r_MmaAE4x4WordAtPtx10167R2903, r_MmaAE4x4WordAtPtx10167R2904;
	uint32_t r_MmaAE4x4WordAtPtx10167R2905, r_PackedHalf2AtPtx10005R2906, r_PackedHalf2AtPtx10012R2907,
		r_PackedHalf2AtPtx10019R2908, r_PackedHalf2AtPtx10026R2909, r_PackedHalf2AtPtx10033R2910,
		r_PackedHalf2AtPtx10040R2911, r_PackedHalf2AtPtx10047R2912, r_PackedHalf2AtPtx10054R2913,
		r_LaneIndexAtPtx10226, r_LaneIndexAtPtx10235, r_LaneIndexAtPtx10244;
	uint32_t r_PtxRegister2917, r_LaneIndexAtPtx10253, r_PtxRegister2919, r_MmaAE4x4WordAtPtx10250R2920,
		r_MmaAE4x4WordAtPtx10250R2921, r_MmaAE4x4WordAtPtx10250R2922, r_MmaAE4x4WordAtPtx10250R2923,
		r_MmaBE4x4WordAtPtx10232R2924, r_MmaBE4x4WordAtPtx10232R2925,
		r_MmaAccumulatorHalf2WordAtPtx10170R2926, r_MmaAccumulatorHalf2WordAtPtx10170R2927,
		r_MmaBE4x4WordAtPtx10232R2928;
	uint32_t r_MmaBE4x4WordAtPtx10232R2929, r_MmaAccumulatorHalf2WordAtPtx10177R2930,
		r_MmaAccumulatorHalf2WordAtPtx10177R2931, r_MmaBE4x4WordAtPtx10241R2932,
		r_MmaBE4x4WordAtPtx10241R2933, r_MmaAccumulatorHalf2WordAtPtx10184R2934,
		r_MmaAccumulatorHalf2WordAtPtx10184R2935, r_MmaBE4x4WordAtPtx10241R2936,
		r_MmaBE4x4WordAtPtx10241R2937, r_MmaAccumulatorHalf2WordAtPtx10191R2938,
		r_MmaAccumulatorHalf2WordAtPtx10191R2939, r_MmaAE4x4WordAtPtx10259R2940;
	uint32_t r_MmaAE4x4WordAtPtx10259R2941, r_MmaAE4x4WordAtPtx10259R2942, r_MmaAE4x4WordAtPtx10259R2943,
		r_MmaAccumulatorHalf2WordAtPtx10198R2944, r_MmaAccumulatorHalf2WordAtPtx10198R2945,
		r_MmaAccumulatorHalf2WordAtPtx10205R2946, r_MmaAccumulatorHalf2WordAtPtx10205R2947,
		r_MmaAccumulatorHalf2WordAtPtx10212R2948, r_MmaAccumulatorHalf2WordAtPtx10212R2949,
		r_MmaAccumulatorHalf2WordAtPtx10219R2950, r_MmaAccumulatorHalf2WordAtPtx10219R2951, r_PtxRegister2952;
	uint32_t r_PtxRegister2953, r_PtxRegister2954, r_PtxRegister2955, r_PtxRegister2956, r_PtxRegister2957,
		r_PtxRegister2958, r_PtxRegister2959, r_PtxRegister2960, r_PtxRegister2961, r_PtxRegister2962,
		r_PtxRegister2963, r_PtxRegister2964;
	uint32_t r_PtxRegister2965, r_PtxRegister2966, r_PtxRegister2967, r_PtxRegister2968, r_PtxRegister2969,
		r_PtxRegister2970, r_PtxRegister2971, r_PtxRegister2972, r_PtxRegister2973, r_PtxRegister2974,
		r_PtxRegister2975, r_PtxRegister2976;
	uint32_t r_PtxRegister2977, r_PtxRegister2978, r_PtxRegister2979, r_PtxRegister2980, r_PtxRegister2981,
		r_PtxRegister2982, r_PtxRegister2983, r_PtxRegister2984, r_PtxRegister2985, r_PtxRegister2986,
		r_PtxRegister2987, r_PtxRegister2988;
	uint32_t r_PtxRegister2989, r_PtxRegister2990, r_PtxRegister2991, r_PtxRegister2992, r_PtxRegister2993,
		r_PtxRegister2994, r_PtxRegister2995, r_PtxRegister2996, r_PtxRegister2997, r_PtxRegister2998,
		r_PtxRegister2999, r_PtxRegister3000;
	uint32_t r_PtxRegister3001, r_PtxRegister3002, r_PtxRegister3003, r_PtxRegister3004, r_PtxRegister3005,
		r_PtxRegister3006, r_PtxRegister3007, r_PtxRegister3008, r_PtxRegister3009, r_PtxRegister3010,
		r_PtxRegister3011, r_PtxRegister3012;
	uint32_t r_PtxRegister3013, r_PtxRegister3014, r_PtxRegister3015, r_PtxRegister3016, r_PtxRegister3017,
		r_PtxRegister3018, r_PtxRegister3019, r_PtxRegister3020, r_PtxRegister3021, r_PtxRegister3022,
		r_PtxRegister3023, r_PtxRegister3024;
	uint32_t r_PtxRegister3025, r_PtxRegister3026, r_PtxRegister3027, r_PtxRegister3028, r_PtxRegister3029,
		r_PtxRegister3030, r_PtxRegister3031, r_PtxRegister3032, r_PtxRegister3033, r_PtxRegister3034,
		r_PtxRegister3035, r_PtxRegister3036;
	uint32_t r_PtxRegister3037, r_PtxRegister3038, r_PtxRegister3039, r_PtxRegister3040, r_PtxRegister3041,
		r_PtxRegister3042, r_PtxRegister3043, r_PtxRegister3044, r_PtxRegister3045, r_PtxRegister3046,
		r_PtxRegister3047, r_PtxRegister3048;
	uint32_t r_PtxRegister3049, r_PtxRegister3050, r_PtxRegister3051, r_PtxRegister3052, r_PtxRegister3053,
		r_PtxRegister3054, r_PtxRegister3055, r_PtxRegister3056, r_PtxRegister3057, r_PtxRegister3058,
		r_PtxRegister3059, r_PtxRegister3060;
	uint32_t r_PtxRegister3061, r_PtxRegister3062, r_PtxRegister3063, r_PtxRegister3064, r_PtxRegister3065,
		r_PtxRegister3066, r_PtxRegister3067, r_PtxRegister3068, r_PtxRegister3069, r_PtxRegister3070,
		r_PtxRegister3071, r_PtxRegister3072;
	uint32_t r_PtxRegister3073, r_PtxRegister3074, r_PtxRegister3075, r_PtxRegister3076, r_PtxRegister3077,
		r_PtxRegister3078, r_PtxRegister3079, r_PtxRegister3080, r_PtxRegister3081, r_PtxRegister3082,
		r_PtxRegister3083, r_PtxRegister3084;
	uint32_t r_PtxRegister3085, r_PtxRegister3086, r_PtxRegister3087, r_PtxRegister3088, r_PtxRegister3089,
		r_PtxRegister3090, r_PtxRegister3091, r_PtxRegister3092, r_PtxRegister3093, r_PtxRegister3094,
		r_PtxRegister3095, r_PtxRegister3096;
	uint32_t r_PtxRegister3097, r_PtxRegister3098, r_PtxRegister3099, r_PtxRegister3100, r_PtxRegister3101,
		r_PtxRegister3102, r_PtxRegister3103, r_PtxRegister3104, r_PtxRegister3105, r_PtxRegister3106,
		r_PtxRegister3107, r_PtxRegister3108;
	uint32_t r_PtxRegister3109, r_PtxRegister3110, r_PtxRegister3111, r_PtxRegister3112, r_PtxRegister3113,
		r_PtxRegister3114, r_PtxRegister3115, r_PtxRegister3116, r_PtxRegister3117, r_PtxRegister3118,
		r_PtxRegister3119, r_PtxRegister3120;
	uint32_t r_PtxRegister3121, r_PtxRegister3122, r_PtxRegister3123, r_PtxRegister3124, r_PtxRegister3125,
		r_PtxRegister3126, r_PtxRegister3127, r_PtxRegister3128, r_PtxRegister3129, r_PtxRegister3130,
		r_PtxRegister3131, r_PtxRegister3132;
	uint32_t r_PtxRegister3133, r_PtxRegister3134, r_PtxRegister3135, r_PtxRegister3136, r_PtxRegister3137,
		r_PtxRegister3138, r_PtxRegister3139, r_PtxRegister3140, r_PtxRegister3141, r_PtxRegister3142,
		r_PtxRegister3143, r_PtxRegister3144;
	uint32_t r_PtxRegister3145, r_PtxRegister3146, r_PtxRegister3147, r_PtxRegister3148, r_PtxRegister3149,
		r_PtxRegister3150, r_PtxRegister3151, r_PtxRegister3152, r_PtxRegister3153, r_PtxRegister3154,
		r_PtxRegister3155, r_PtxRegister3156;
	uint32_t r_PtxRegister3157, r_PtxRegister3158, r_PtxRegister3159, r_PtxRegister3160, r_PtxRegister3161,
		r_PtxRegister3162, r_PtxRegister3163, r_PtxRegister3164, r_PtxRegister3165, r_PtxRegister3166,
		r_PtxRegister3167, r_PtxRegister3168;
	uint32_t r_PtxRegister3169, r_PtxRegister3170, r_PtxRegister3171, r_PtxRegister3172, r_PtxRegister3173,
		r_PtxRegister3174, r_PtxRegister3175, r_PtxRegister3176, r_PtxRegister3177, r_PtxRegister3178,
		r_PtxRegister3179, r_PtxRegister3180;
	uint32_t r_PtxRegister3181, r_PtxRegister3182, r_PtxRegister3183, r_PtxRegister3184, r_PtxRegister3185,
		r_PtxRegister3186, r_PtxRegister3187, r_PtxRegister3188, r_PtxRegister3189, r_PtxRegister3190,
		r_PtxRegister3191, r_PtxRegister3192;
	uint32_t r_PtxRegister3193, r_PtxRegister3194, r_PtxRegister3195, r_PtxRegister3196, r_PtxRegister3197,
		r_PtxRegister3198, r_PtxRegister3199, r_PtxRegister3200, r_PtxRegister3201, r_PtxRegister3202,
		r_PtxRegister3203, r_PtxRegister3204;
	uint32_t r_PtxRegister3205, r_PtxRegister3206, r_PtxRegister3207, r_PtxRegister3208, r_PtxRegister3209,
		r_PtxRegister3210, r_PtxRegister3211, r_PtxRegister3212, r_PtxRegister3213, r_PtxRegister3214,
		r_PtxRegister3215, r_PtxRegister3216;
	uint32_t r_PtxRegister3217, r_PtxRegister3218, r_PtxRegister3219, r_PtxRegister3220, r_PtxRegister3221,
		r_PtxRegister3222, r_PtxRegister3223, r_PtxRegister3224, r_PtxRegister3225, r_PtxRegister3226,
		r_PtxRegister3227, r_PtxRegister3228;
	uint32_t r_PtxRegister3229, r_PtxRegister3230, r_PtxRegister3231, r_PtxRegister3232, r_PtxRegister3233,
		r_PtxRegister3234, r_PtxRegister3235, r_PtxRegister3236, r_PtxRegister3237, r_PtxRegister3238,
		r_PtxRegister3239, r_PtxRegister3240;
	uint32_t r_PtxRegister3241, r_PtxRegister3242, r_PtxRegister3243, r_PtxRegister3244, r_PtxRegister3245,
		r_PtxRegister3246, r_PtxRegister3247, r_PtxRegister3248, r_PtxRegister3249, r_PtxRegister3250,
		r_PtxRegister3251, r_PtxRegister3252;
	uint32_t r_PtxRegister3253, r_PtxRegister3254, r_PtxRegister3255, r_PtxRegister3256, r_PtxRegister3257,
		r_PtxRegister3258, r_PtxRegister3259, r_PtxRegister3260, r_PtxRegister3261, r_PtxRegister3262,
		r_PtxRegister3263, r_PtxRegister3264;
	uint32_t r_PtxRegister3265, r_PtxRegister3266, r_PtxRegister3267, r_PtxRegister3268, r_PtxRegister3269,
		r_PtxRegister3270, r_PtxRegister3271, r_PtxRegister3272, r_PtxRegister3273, r_PtxRegister3274,
		r_PtxRegister3275, r_PtxRegister3276;
	uint32_t r_PtxRegister3277, r_PtxRegister3278, r_PtxRegister3279, r_PtxRegister3280, r_PtxRegister3281,
		r_PtxRegister3282, r_PtxRegister3283, r_PtxRegister3284, r_PtxRegister3285, r_PtxRegister3286,
		r_PtxRegister3287, r_PtxRegister3288;
	uint32_t r_PtxRegister3289, r_PtxRegister3290, r_PtxRegister3291, r_PtxRegister3292, r_PtxRegister3293,
		r_PtxRegister3294, r_PtxRegister3295, r_PtxRegister3296, r_PtxRegister3297, r_PtxRegister3298,
		r_PtxRegister3299, r_PtxRegister3300;
	uint32_t r_PtxRegister3301, r_PtxRegister3302, r_PtxRegister3303, r_PtxRegister3304, r_PtxRegister3305,
		r_PtxRegister3306, r_PtxRegister3307, r_PtxRegister3308, r_PtxRegister3309, r_PtxRegister3310,
		r_PtxRegister3311, r_PtxRegister3312;
	uint32_t r_PtxRegister3313, r_PtxRegister3314, r_PtxRegister3315, r_PtxRegister3316, r_PtxRegister3317,
		r_PtxRegister3318, r_PtxRegister3319, r_PtxRegister3320, r_PtxRegister3321, r_PtxRegister3322,
		r_PtxRegister3323, r_PtxRegister3324;
	uint32_t r_PtxRegister3325, r_PtxRegister3326, r_CtaYAtPtx10365, r_PtxRegister3328, r_PtxRegister3329,
		r_PtxRegister3330, r_PtxRegister3331, r_LaneIndexAtPtx10385, r_PackedE4WordAtPtx10383R3333,
		r_PackedE4WordAtPtx10382R3334, r_PackedE4WordAtPtx10381R3335, r_PackedE4WordAtPtx10380R3336;
	uint32_t r_LaneIndexAtPtx10397, r_PackedE4WordAtPtx10405R3338, r_PackedE4WordAtPtx10404R3339,
		r_PackedE4WordAtPtx10403R3340, r_PackedE4WordAtPtx10402R3341, r_LaneIndexAtPtx10420,
		r_LaneIndexAtPtx10429, r_LaneIndexAtPtx10438, r_LaneIndexAtPtx10447, r_LaneIndexAtPtx10456,
		r_LaneIndexAtPtx10465, r_LaneIndexAtPtx10474;
	uint32_t r_LaneIndexAtPtx10483, r_MmaAccumulatorHalf2WordAtPtx10426R3350,
		r_MmaAccumulatorHalf2WordAtPtx10426R3351, r_MmaAE4x4WordAtPtx10410R3352,
		r_MmaAE4x4WordAtPtx10411R3353, r_MmaAE4x4WordAtPtx10412R3354, r_MmaAE4x4WordAtPtx10413R3355,
		r_MmaAccumulatorHalf2WordAtPtx10426R3356, r_MmaAccumulatorHalf2WordAtPtx10426R3357,
		r_MmaAccumulatorHalf2WordAtPtx10435R3358, r_MmaAccumulatorHalf2WordAtPtx10435R3359,
		r_MmaAccumulatorHalf2WordAtPtx10435R3360;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx10435R3361, r_MmaAccumulatorHalf2WordAtPtx10444R3362,
		r_MmaAccumulatorHalf2WordAtPtx10444R3363, r_MmaAccumulatorHalf2WordAtPtx10444R3364,
		r_MmaAccumulatorHalf2WordAtPtx10444R3365, r_MmaAccumulatorHalf2WordAtPtx10453R3366,
		r_MmaAccumulatorHalf2WordAtPtx10453R3367, r_MmaAccumulatorHalf2WordAtPtx10453R3368,
		r_MmaAccumulatorHalf2WordAtPtx10453R3369, r_MmaAccumulatorHalf2WordAtPtx10462R3370,
		r_MmaAccumulatorHalf2WordAtPtx10462R3371, r_MmaAE4x4WordAtPtx10414R3372;
	uint32_t r_MmaAE4x4WordAtPtx10415R3373, r_MmaAE4x4WordAtPtx10416R3374, r_MmaAE4x4WordAtPtx10417R3375,
		r_MmaAccumulatorHalf2WordAtPtx10462R3376, r_MmaAccumulatorHalf2WordAtPtx10462R3377,
		r_MmaAccumulatorHalf2WordAtPtx10471R3378, r_MmaAccumulatorHalf2WordAtPtx10471R3379,
		r_MmaAccumulatorHalf2WordAtPtx10471R3380, r_MmaAccumulatorHalf2WordAtPtx10471R3381,
		r_MmaAccumulatorHalf2WordAtPtx10480R3382, r_MmaAccumulatorHalf2WordAtPtx10480R3383,
		r_MmaAccumulatorHalf2WordAtPtx10480R3384;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx10480R3385, r_MmaAccumulatorHalf2WordAtPtx10489R3386,
		r_MmaAccumulatorHalf2WordAtPtx10489R3387, r_MmaAccumulatorHalf2WordAtPtx10489R3388,
		r_MmaAccumulatorHalf2WordAtPtx10489R3389, r_LaneIndexAtPtx10604,
		r_MmaAccumulatorHalf2WordAtPtx10492R3391, r_PackedHalf2AtPtx10607R3392, r_PtxRegister3393,
		r_PackedHalf2AtPtx10611R3394, r_LaneIndexAtPtx10621, r_MmaAccumulatorHalf2WordAtPtx10492R3396;
	uint32_t r_PackedHalf2AtPtx10624R3397, r_PtxRegister3398, r_PackedHalf2AtPtx10628R3399,
		r_LaneIndexAtPtx10638, r_MmaAccumulatorHalf2WordAtPtx10499R3401, r_PackedHalf2AtPtx10641R3402,
		r_PtxRegister3403, r_PackedHalf2AtPtx10645R3404, r_LaneIndexAtPtx10655,
		r_MmaAccumulatorHalf2WordAtPtx10499R3406, r_PackedHalf2AtPtx10658R3407, r_PtxRegister3408;
	uint32_t r_PackedHalf2AtPtx10662R3409, r_LaneIndexAtPtx10672, r_MmaAccumulatorHalf2WordAtPtx10506R3411,
		r_PackedHalf2AtPtx10675R3412, r_PtxRegister3413, r_PackedHalf2AtPtx10679R3414, r_LaneIndexAtPtx10689,
		r_MmaAccumulatorHalf2WordAtPtx10506R3416, r_PackedHalf2AtPtx10692R3417, r_PtxRegister3418,
		r_PackedHalf2AtPtx10696R3419, r_LaneIndexAtPtx10706;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx10513R3421, r_PackedHalf2AtPtx10709R3422, r_PtxRegister3423,
		r_PackedHalf2AtPtx10713R3424, r_LaneIndexAtPtx10723, r_MmaAccumulatorHalf2WordAtPtx10513R3426,
		r_PackedHalf2AtPtx10726R3427, r_PtxRegister3428, r_PackedHalf2AtPtx10730R3429, r_LaneIndexAtPtx10740,
		r_MmaAccumulatorHalf2WordAtPtx10520R3431, r_PackedHalf2AtPtx10743R3432;
	uint32_t r_PtxRegister3433, r_PackedHalf2AtPtx10747R3434, r_LaneIndexAtPtx10757,
		r_MmaAccumulatorHalf2WordAtPtx10520R3436, r_PackedHalf2AtPtx10760R3437, r_PtxRegister3438,
		r_PackedHalf2AtPtx10764R3439, r_LaneIndexAtPtx10774, r_MmaAccumulatorHalf2WordAtPtx10527R3441,
		r_PackedHalf2AtPtx10777R3442, r_PtxRegister3443, r_PackedHalf2AtPtx10781R3444;
	uint32_t r_LaneIndexAtPtx10791, r_MmaAccumulatorHalf2WordAtPtx10527R3446, r_PackedHalf2AtPtx10794R3447,
		r_PtxRegister3448, r_PackedHalf2AtPtx10798R3449, r_LaneIndexAtPtx10808,
		r_MmaAccumulatorHalf2WordAtPtx10534R3451, r_PackedHalf2AtPtx10811R3452, r_PtxRegister3453,
		r_PackedHalf2AtPtx10815R3454, r_LaneIndexAtPtx10825, r_MmaAccumulatorHalf2WordAtPtx10534R3456;
	uint32_t r_PackedHalf2AtPtx10828R3457, r_PtxRegister3458, r_PackedHalf2AtPtx10832R3459,
		r_LaneIndexAtPtx10842, r_MmaAccumulatorHalf2WordAtPtx10541R3461, r_PackedHalf2AtPtx10845R3462,
		r_PtxRegister3463, r_PackedHalf2AtPtx10849R3464, r_LaneIndexAtPtx10859,
		r_MmaAccumulatorHalf2WordAtPtx10541R3466, r_PackedHalf2AtPtx10862R3467, r_PtxRegister3468;
	uint32_t r_PackedHalf2AtPtx10866R3469, r_LaneIndexAtPtx10876, r_MmaAccumulatorHalf2WordAtPtx10548R3471,
		r_PackedHalf2AtPtx10879R3472, r_PtxRegister3473, r_PackedHalf2AtPtx10883R3474, r_LaneIndexAtPtx10893,
		r_MmaAccumulatorHalf2WordAtPtx10548R3476, r_PackedHalf2AtPtx10896R3477, r_PtxRegister3478,
		r_PackedHalf2AtPtx10900R3479, r_LaneIndexAtPtx10910;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx10555R3481, r_PackedHalf2AtPtx10913R3482, r_PtxRegister3483,
		r_PackedHalf2AtPtx10917R3484, r_LaneIndexAtPtx10927, r_MmaAccumulatorHalf2WordAtPtx10555R3486,
		r_PackedHalf2AtPtx10930R3487, r_PtxRegister3488, r_PackedHalf2AtPtx10934R3489, r_LaneIndexAtPtx10944,
		r_MmaAccumulatorHalf2WordAtPtx10562R3491, r_PackedHalf2AtPtx10947R3492;
	uint32_t r_PtxRegister3493, r_PackedHalf2AtPtx10951R3494, r_LaneIndexAtPtx10961,
		r_MmaAccumulatorHalf2WordAtPtx10562R3496, r_PackedHalf2AtPtx10964R3497, r_PtxRegister3498,
		r_PackedHalf2AtPtx10968R3499, r_LaneIndexAtPtx10978, r_MmaAccumulatorHalf2WordAtPtx10569R3501,
		r_PackedHalf2AtPtx10981R3502, r_PtxRegister3503, r_PackedHalf2AtPtx10985R3504;
	uint32_t r_LaneIndexAtPtx10995, r_MmaAccumulatorHalf2WordAtPtx10569R3506, r_PackedHalf2AtPtx10998R3507,
		r_PtxRegister3508, r_PackedHalf2AtPtx11002R3509, r_LaneIndexAtPtx11012,
		r_MmaAccumulatorHalf2WordAtPtx10576R3511, r_PackedHalf2AtPtx11015R3512, r_PtxRegister3513,
		r_PackedHalf2AtPtx11019R3514, r_LaneIndexAtPtx11029, r_MmaAccumulatorHalf2WordAtPtx10576R3516;
	uint32_t r_PackedHalf2AtPtx11032R3517, r_PtxRegister3518, r_PackedHalf2AtPtx11036R3519,
		r_LaneIndexAtPtx11046, r_MmaAccumulatorHalf2WordAtPtx10583R3521, r_PackedHalf2AtPtx11049R3522,
		r_PtxRegister3523, r_PackedHalf2AtPtx11053R3524, r_LaneIndexAtPtx11063,
		r_MmaAccumulatorHalf2WordAtPtx10583R3526, r_PackedHalf2AtPtx11066R3527, r_PtxRegister3528;
	uint32_t r_PackedHalf2AtPtx11070R3529, r_LaneIndexAtPtx11080, r_MmaAccumulatorHalf2WordAtPtx10590R3531,
		r_PackedHalf2AtPtx11083R3532, r_PtxRegister3533, r_PackedHalf2AtPtx11087R3534, r_LaneIndexAtPtx11097,
		r_MmaAccumulatorHalf2WordAtPtx10590R3536, r_PackedHalf2AtPtx11100R3537, r_PtxRegister3538,
		r_PackedHalf2AtPtx11104R3539, r_LaneIndexAtPtx11114;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx10597R3541, r_PackedHalf2AtPtx11117R3542, r_PtxRegister3543,
		r_PackedHalf2AtPtx11121R3544, r_LaneIndexAtPtx11131, r_MmaAccumulatorHalf2WordAtPtx10597R3546,
		r_PackedHalf2AtPtx11134R3547, r_PtxRegister3548, r_PackedHalf2AtPtx11138R3549, r_LaneIndexAtPtx11148,
		r_PackedHalf2AtPtx11151R3551, r_PackedHalf2AtPtx11155R3552;
	uint32_t r_PackedHalf2AtPtx11159R3553, r_PackedHalf2AtPtx11163R3554, r_PtxRegister3555,
		r_PackedHalf2AtPtx11167R3556, r_PackedHalf2AtPtx11171R3557, r_PackedHalf2AtPtx11179R3558,
		r_PackedHalf2AtPtx11183R3559, r_PackedHalf2AtPtx11187R3560, r_PackedHalf2AtPtx11191R3561,
		r_PtxRegister3562, r_PackedHalf2AtPtx11195R3563, r_PackedHalf2AtPtx11199R3564;
	uint32_t r_PackedHalf2AtPtx11207R3565, r_PackedHalf2AtPtx11211R3566, r_PackedHalf2AtPtx11215R3567,
		r_PackedHalf2AtPtx11219R3568, r_PtxRegister3569, r_PackedHalf2AtPtx11223R3570,
		r_PackedHalf2AtPtx11227R3571, r_PackedHalf2AtPtx11235R3572, r_PackedHalf2AtPtx11239R3573,
		r_PackedHalf2AtPtx11243R3574, r_PackedHalf2AtPtx11247R3575, r_PtxRegister3576;
	uint32_t r_PackedHalf2AtPtx11251R3577, r_PackedHalf2AtPtx11255R3578, r_PtxRegister3579, r_PtxRegister3580,
		r_PackedHalf2AtPtx11299R3581, r_PtxRegister3582, r_PtxRegister3583, r_PackedHalf2AtPtx11303R3584,
		r_PtxRegister3585, r_PtxRegister3586, r_PackedHalf2AtPtx11311R3587, r_PackedHalf2AtPtx11312R3588;
	uint32_t r_LaneIndexAtPtx11319, r_PtxRegister3590, r_LaneIndexAtPtx11326, r_PtxRegister3592,
		r_PackedHalf2AtPtx11322R3593, r_LaneIndexAtPtx11342, r_LaneIndexAtPtx11368, r_LaneIndexAtPtx11394,
		r_LaneIndexAtPtx11420, r_LaneIndexAtPtx11446, r_LaneIndexAtPtx11473, r_LaneIndexAtPtx11500;
	uint32_t r_LaneIndexAtPtx11527, r_LaneIndexAtPtx11554, r_PtxRegister3603, r_PtxRegister3604,
		r_LaneIndexAtPtx11561, r_PtxRegister3606, r_PtxRegister3607, r_LaneIndexAtPtx11568, r_PtxRegister3609,
		r_PtxRegister3610, r_LaneIndexAtPtx11575, r_PtxRegister3612;
	uint32_t r_PtxRegister3613, r_LaneIndexAtPtx11582, r_PtxRegister3615, r_PtxRegister3616,
		r_LaneIndexAtPtx11589, r_PtxRegister3618, r_PtxRegister3619, r_LaneIndexAtPtx11596, r_PtxRegister3621,
		r_PtxRegister3622, r_LaneIndexAtPtx11603, r_PtxRegister3624;
	uint32_t r_PtxRegister3625, r_LaneIndexAtPtx11610, r_PtxRegister3627, r_PtxRegister3628,
		r_LaneIndexAtPtx11617, r_PtxRegister3630, r_PtxRegister3631, r_LaneIndexAtPtx11624, r_PtxRegister3633,
		r_PtxRegister3634, r_LaneIndexAtPtx11631, r_PtxRegister3636;
	uint32_t r_PtxRegister3637, r_LaneIndexAtPtx11638, r_PtxRegister3639, r_PtxRegister3640,
		r_LaneIndexAtPtx11645, r_PtxRegister3642, r_PtxRegister3643, r_LaneIndexAtPtx11652, r_PtxRegister3645,
		r_PtxRegister3646, r_LaneIndexAtPtx11659, r_PtxRegister3648;
	uint32_t r_PtxRegister3649, r_LaneIndexAtPtx11666, r_PtxRegister3651, r_PtxRegister3652,
		r_LaneIndexAtPtx11673, r_PtxRegister3654, r_PtxRegister3655, r_LaneIndexAtPtx11680, r_PtxRegister3657,
		r_PtxRegister3658, r_LaneIndexAtPtx11687, r_PtxRegister3660;
	uint32_t r_PtxRegister3661, r_LaneIndexAtPtx11694, r_PtxRegister3663, r_PtxRegister3664,
		r_LaneIndexAtPtx11701, r_PtxRegister3666, r_PtxRegister3667, r_LaneIndexAtPtx11708, r_PtxRegister3669,
		r_PtxRegister3670, r_LaneIndexAtPtx11715, r_PtxRegister3672;
	uint32_t r_PtxRegister3673, r_LaneIndexAtPtx11722, r_PtxRegister3675, r_PtxRegister3676,
		r_LaneIndexAtPtx11729, r_PtxRegister3678, r_PtxRegister3679, r_LaneIndexAtPtx11736, r_PtxRegister3681,
		r_PtxRegister3682, r_LaneIndexAtPtx11743, r_PtxRegister3684;
	uint32_t r_PtxRegister3685, r_LaneIndexAtPtx11750, r_PtxRegister3687, r_PtxRegister3688,
		r_LaneIndexAtPtx11757, r_PtxRegister3690, r_PtxRegister3691, r_LaneIndexAtPtx11764, r_PtxRegister3693,
		r_PtxRegister3694, r_LaneIndexAtPtx11771, r_PtxRegister3696;
	uint32_t r_PtxRegister3697, r_PackedHalf2AtPtx11557R3698, r_PackedHalf2AtPtx11571R3699,
		r_PackedHalf2AtPtx11564R3700, r_PackedHalf2AtPtx11578R3701, r_PackedHalf2AtPtx11585R3702,
		r_PackedHalf2AtPtx11599R3703, r_PackedHalf2AtPtx11592R3704, r_PackedHalf2AtPtx11606R3705,
		r_PackedHalf2AtPtx11613R3706, r_PackedHalf2AtPtx11627R3707, r_PackedHalf2AtPtx11620R3708;
	uint32_t r_PackedHalf2AtPtx11634R3709, r_PackedHalf2AtPtx11641R3710, r_PackedHalf2AtPtx11655R3711,
		r_PackedHalf2AtPtx11648R3712, r_PackedHalf2AtPtx11662R3713, r_PackedHalf2AtPtx11669R3714,
		r_PackedHalf2AtPtx11683R3715, r_PackedHalf2AtPtx11676R3716, r_PackedHalf2AtPtx11690R3717,
		r_PackedHalf2AtPtx11697R3718, r_PackedHalf2AtPtx11711R3719, r_PackedHalf2AtPtx11704R3720;
	uint32_t r_PackedHalf2AtPtx11718R3721, r_PackedHalf2AtPtx11725R3722, r_PackedHalf2AtPtx11739R3723,
		r_PackedHalf2AtPtx11732R3724, r_PackedHalf2AtPtx11746R3725, r_PackedHalf2AtPtx11753R3726,
		r_PackedHalf2AtPtx11767R3727, r_PackedHalf2AtPtx11760R3728, r_PackedHalf2AtPtx11774R3729,
		r_MmaAE4x4WordAtPtx11783R3730, r_MmaAE4x4WordAtPtx11790R3731, r_MmaAE4x4WordAtPtx11797R3732;
	uint32_t r_MmaAE4x4WordAtPtx11804R3733, r_MmaAccumulatorHalf2WordAtPtx11890R3734,
		r_MmaAccumulatorHalf2WordAtPtx11890R3735, r_MmaAE4x4WordAtPtx11811R3736,
		r_MmaAE4x4WordAtPtx11818R3737, r_MmaAE4x4WordAtPtx11825R3738, r_MmaAE4x4WordAtPtx11832R3739,
		r_MmaAccumulatorHalf2WordAtPtx11897R3740, r_MmaAccumulatorHalf2WordAtPtx11897R3741,
		r_MmaAccumulatorHalf2WordAtPtx11918R3742, r_MmaAccumulatorHalf2WordAtPtx11918R3743,
		r_MmaAccumulatorHalf2WordAtPtx11925R3744;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx11925R3745, r_MmaAE4x4WordAtPtx11839R3746,
		r_MmaAE4x4WordAtPtx11846R3747, r_MmaAE4x4WordAtPtx11853R3748, r_MmaAE4x4WordAtPtx11860R3749,
		r_MmaAccumulatorHalf2WordAtPtx11946R3750, r_MmaAccumulatorHalf2WordAtPtx11946R3751,
		r_MmaAE4x4WordAtPtx11867R3752, r_MmaAE4x4WordAtPtx11874R3753, r_MmaAE4x4WordAtPtx11881R3754,
		r_MmaAE4x4WordAtPtx11888R3755, r_MmaAccumulatorHalf2WordAtPtx11953R3756;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx11953R3757, r_MmaAccumulatorHalf2WordAtPtx11974R3758,
		r_MmaAccumulatorHalf2WordAtPtx11974R3759, r_MmaAccumulatorHalf2WordAtPtx11981R3760,
		r_MmaAccumulatorHalf2WordAtPtx11981R3761, r_LaneIndexAtPtx12002, r_PtxRegister3763, r_PtxRegister3764,
		r_PtxRegister3765, r_PtxRegister3766, r_PtxRegister3767, r_LaneIndexAtPtx12011;
	uint32_t r_PtxRegister3769, r_PtxRegister3770, r_PtxRegister3771, r_PtxRegister3772, r_PtxRegister3773,
		r_LaneIndexAtPtx12076, r_LaneIndexAtPtx12091, r_LaneIndexAtPtx12105, r_LaneIndexAtPtx12117,
		r_LaneIndexAtPtx12129, r_LaneIndexAtPtx12141, r_LaneIndexAtPtx12153;
	uint32_t r_LaneIndexAtPtx12165, r_LaneIndexAtPtx12177, r_LaneIndexAtPtx12191, r_LaneIndexAtPtx12205,
		r_LaneIndexAtPtx12217, r_LaneIndexAtPtx12229, r_LaneIndexAtPtx12241, r_LaneIndexAtPtx12253,
		r_LaneIndexAtPtx12265, r_LaneIndexAtPtx12277, r_PackedHalf2AtPtx12021R3791, r_PtxRegister3792;
	uint32_t r_LaneIndexAtPtx12284, r_PackedHalf2AtPtx12028R3794, r_PtxRegister3795, r_LaneIndexAtPtx12291,
		r_PackedHalf2AtPtx12024R3797, r_PtxRegister3798, r_LaneIndexAtPtx12298, r_PackedHalf2AtPtx12031R3800,
		r_PtxRegister3801, r_LaneIndexAtPtx12305, r_PackedHalf2AtPtx12035R3803, r_PtxRegister3804;
	uint32_t r_LaneIndexAtPtx12312, r_PackedHalf2AtPtx12042R3806, r_PtxRegister3807, r_LaneIndexAtPtx12319,
		r_PackedHalf2AtPtx12038R3809, r_PtxRegister3810, r_LaneIndexAtPtx12326, r_PackedHalf2AtPtx12045R3812,
		r_PtxRegister3813, r_LaneIndexAtPtx12333, r_PackedHalf2AtPtx12049R3815, r_PtxRegister3816;
	uint32_t r_LaneIndexAtPtx12340, r_PackedHalf2AtPtx12056R3818, r_PtxRegister3819, r_LaneIndexAtPtx12347,
		r_PackedHalf2AtPtx12052R3821, r_PtxRegister3822, r_LaneIndexAtPtx12354, r_PackedHalf2AtPtx12059R3824,
		r_PtxRegister3825, r_LaneIndexAtPtx12361, r_PackedHalf2AtPtx12063R3827, r_PtxRegister3828;
	uint32_t r_LaneIndexAtPtx12368, r_PackedHalf2AtPtx12070R3830, r_PtxRegister3831, r_LaneIndexAtPtx12375,
		r_PackedHalf2AtPtx12066R3833, r_PtxRegister3834, r_LaneIndexAtPtx12382, r_PackedHalf2AtPtx12073R3836,
		r_PtxRegister3837, r_MmaAccumulatorHalf2WordAtPtx11904R3838, r_MmaAccumulatorHalf2WordAtPtx11911R3839,
		r_MmaAccumulatorHalf2WordAtPtx11904R3840;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx11911R3841, r_MmaAccumulatorHalf2WordAtPtx11932R3842,
		r_MmaAccumulatorHalf2WordAtPtx11939R3843, r_MmaAccumulatorHalf2WordAtPtx11932R3844,
		r_MmaAccumulatorHalf2WordAtPtx11939R3845, r_MmaAccumulatorHalf2WordAtPtx11960R3846,
		r_MmaAccumulatorHalf2WordAtPtx11967R3847, r_MmaAccumulatorHalf2WordAtPtx11960R3848,
		r_MmaAccumulatorHalf2WordAtPtx11967R3849, r_MmaAccumulatorHalf2WordAtPtx11988R3850,
		r_MmaAccumulatorHalf2WordAtPtx11995R3851, r_MmaAccumulatorHalf2WordAtPtx11988R3852;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx11995R3853, r_LaneIndexAtPtx12445, r_PtxRegister3855,
		r_PackedE4WordAtPtx12394R3856, r_PackedE4WordAtPtx12401R3857, r_PackedE4WordAtPtx12408R3858,
		r_PackedE4WordAtPtx12415R3859, r_LaneIndexAtPtx12453, r_PtxRegister3861,
		r_PackedE4WordAtPtx12422R3862, r_PackedE4WordAtPtx12429R3863, r_PackedE4WordAtPtx12436R3864;
	uint32_t r_PackedE4WordAtPtx12443R3865, r_LaneIndexAtPtx12463, r_LaneIndexAtPtx12472,
		r_LaneIndexAtPtx12481, r_PtxRegister3869, r_LaneIndexAtPtx12490, r_PtxRegister3871,
		r_MmaAE4x4WordAtPtx12487R3872, r_MmaAE4x4WordAtPtx12487R3873, r_MmaAE4x4WordAtPtx12487R3874,
		r_MmaAE4x4WordAtPtx12487R3875, r_MmaBE4x4WordAtPtx12469R3876;
	uint32_t r_MmaBE4x4WordAtPtx12469R3877, r_PackedHalf2AtPtx12280R3878, r_PackedHalf2AtPtx12287R3879,
		r_MmaBE4x4WordAtPtx12469R3880, r_MmaBE4x4WordAtPtx12469R3881, r_PackedHalf2AtPtx12294R3882,
		r_PackedHalf2AtPtx12301R3883, r_MmaBE4x4WordAtPtx12478R3884, r_MmaBE4x4WordAtPtx12478R3885,
		r_PackedHalf2AtPtx12308R3886, r_PackedHalf2AtPtx12315R3887, r_MmaBE4x4WordAtPtx12478R3888;
	uint32_t r_MmaBE4x4WordAtPtx12478R3889, r_PackedHalf2AtPtx12322R3890, r_PackedHalf2AtPtx12329R3891,
		r_MmaAE4x4WordAtPtx12496R3892, r_MmaAE4x4WordAtPtx12496R3893, r_MmaAE4x4WordAtPtx12496R3894,
		r_MmaAE4x4WordAtPtx12496R3895, r_PackedHalf2AtPtx12336R3896, r_PackedHalf2AtPtx12343R3897,
		r_PackedHalf2AtPtx12350R3898, r_PackedHalf2AtPtx12357R3899, r_PackedHalf2AtPtx12364R3900;
	uint32_t r_PackedHalf2AtPtx12371R3901, r_PackedHalf2AtPtx12378R3902, r_PackedHalf2AtPtx12385R3903,
		r_LaneIndexAtPtx12555, r_LaneIndexAtPtx12564, r_LaneIndexAtPtx12573, r_PtxRegister3907,
		r_LaneIndexAtPtx12582, r_PtxRegister3909, r_MmaAE4x4WordAtPtx12579R3910,
		r_MmaAE4x4WordAtPtx12579R3911, r_MmaAE4x4WordAtPtx12579R3912;
	uint32_t r_MmaAE4x4WordAtPtx12579R3913, r_MmaBE4x4WordAtPtx12561R3914, r_MmaBE4x4WordAtPtx12561R3915,
		r_MmaAccumulatorHalf2WordAtPtx12499R3916, r_MmaAccumulatorHalf2WordAtPtx12499R3917,
		r_MmaBE4x4WordAtPtx12561R3918, r_MmaBE4x4WordAtPtx12561R3919,
		r_MmaAccumulatorHalf2WordAtPtx12506R3920, r_MmaAccumulatorHalf2WordAtPtx12506R3921,
		r_MmaBE4x4WordAtPtx12570R3922, r_MmaBE4x4WordAtPtx12570R3923,
		r_MmaAccumulatorHalf2WordAtPtx12513R3924;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx12513R3925, r_MmaBE4x4WordAtPtx12570R3926,
		r_MmaBE4x4WordAtPtx12570R3927, r_MmaAccumulatorHalf2WordAtPtx12520R3928,
		r_MmaAccumulatorHalf2WordAtPtx12520R3929, r_MmaAE4x4WordAtPtx12588R3930,
		r_MmaAE4x4WordAtPtx12588R3931, r_MmaAE4x4WordAtPtx12588R3932, r_MmaAE4x4WordAtPtx12588R3933,
		r_MmaAccumulatorHalf2WordAtPtx12527R3934, r_MmaAccumulatorHalf2WordAtPtx12527R3935,
		r_MmaAccumulatorHalf2WordAtPtx12534R3936;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx12534R3937, r_MmaAccumulatorHalf2WordAtPtx12541R3938,
		r_MmaAccumulatorHalf2WordAtPtx12541R3939, r_MmaAccumulatorHalf2WordAtPtx12548R3940,
		r_MmaAccumulatorHalf2WordAtPtx12548R3941, r_PtxRegister3942, r_PtxRegister3943, r_PtxRegister3944,
		r_PtxRegister3945, r_PtxRegister3946, r_PtxRegister3947, r_PtxRegister3948;
	uint32_t r_PtxRegister3949, r_PtxRegister3950, r_PtxRegister3951, r_PtxRegister3952, r_PtxRegister3953,
		r_PtxRegister3954, r_PtxRegister3955, r_PtxRegister3956, r_PtxRegister3957, r_PtxRegister3958,
		r_PtxRegister3959, r_PtxRegister3960;
	uint32_t r_PtxRegister3961, r_PtxRegister3962, r_PtxRegister3963, r_PtxRegister3964, r_PtxRegister3965,
		r_PtxRegister3966, r_PtxRegister3967, r_PtxRegister3968, r_PtxRegister3969, r_PtxRegister3970,
		r_PtxRegister3971, r_PtxRegister3972;
	uint32_t r_PtxRegister3973, r_PtxRegister3974, r_PtxRegister3975, r_PtxRegister3976, r_PtxRegister3977,
		r_PtxRegister3978, r_PtxRegister3979, r_PtxRegister3980, r_PtxRegister3981, r_PtxRegister3982,
		r_PtxRegister3983, r_PtxRegister3984;
	uint32_t r_PtxRegister3985, r_PtxRegister3986, r_PtxRegister3987, r_PtxRegister3988, r_PtxRegister3989,
		r_PtxRegister3990, r_PtxRegister3991, r_PtxRegister3992, r_PtxRegister3993, r_PtxRegister3994,
		r_PtxRegister3995, r_PtxRegister3996;
	uint32_t r_PtxRegister3997, r_PtxRegister3998, r_PtxRegister3999, r_PtxRegister4000, r_PtxRegister4001,
		r_PtxRegister4002, r_PtxRegister4003, r_PtxRegister4004, r_PtxRegister4005, r_PtxRegister4006,
		r_PtxRegister4007, r_PtxRegister4008;
	uint32_t r_PtxRegister4009, r_PtxRegister4010, r_PtxRegister4011, r_PtxRegister4012, r_PtxRegister4013,
		r_PtxRegister4014, r_PtxRegister4015, r_PtxRegister4016, r_PtxRegister4017, r_PtxRegister4018,
		r_PtxRegister4019, r_PtxRegister4020;
	uint32_t r_PtxRegister4021, r_PtxRegister4022, r_PtxRegister4023, r_PtxRegister4024, r_PtxRegister4025,
		r_PtxRegister4026, r_PtxRegister4027, r_PtxRegister4028, r_PtxRegister4029, r_PtxRegister4030,
		r_PtxRegister4031, r_PtxRegister4032;
	uint32_t r_PtxRegister4033, r_PtxRegister4034, r_PtxRegister4035, r_PtxRegister4036, r_PtxRegister4037,
		r_PtxRegister4038, r_PtxRegister4039, r_PtxRegister4040, r_PtxRegister4041, r_PtxRegister4042,
		r_PtxRegister4043, r_PtxRegister4044;
	uint32_t r_PtxRegister4045, r_PtxRegister4046, r_PtxRegister4047, r_PtxRegister4048, r_PtxRegister4049,
		r_PtxRegister4050, r_PtxRegister4051, r_PtxRegister4052, r_PtxRegister4053, r_PtxRegister4054,
		r_PtxRegister4055, r_PtxRegister4056;
	uint32_t r_PtxRegister4057, r_PtxRegister4058, r_PtxRegister4059, r_PtxRegister4060, r_PtxRegister4061,
		r_PtxRegister4062, r_PtxRegister4063, r_PtxRegister4064, r_PtxRegister4065, r_PtxRegister4066,
		r_PtxRegister4067, r_PtxRegister4068;
	uint32_t r_PtxRegister4069, r_PtxRegister4070, r_PtxRegister4071, r_PtxRegister4072, r_PtxRegister4073,
		r_PtxRegister4074, r_PtxRegister4075, r_PtxRegister4076, r_PtxRegister4077, r_PtxRegister4078,
		r_PtxRegister4079, r_PtxRegister4080;
	uint32_t r_PtxRegister4081, r_PtxRegister4082, r_PtxRegister4083, r_PtxRegister4084, r_PtxRegister4085,
		r_PtxRegister4086, r_PtxRegister4087, r_PtxRegister4088, r_PtxRegister4089, r_PtxRegister4090,
		r_PtxRegister4091, r_PtxRegister4092;
	uint32_t r_PtxRegister4093, r_PtxRegister4094, r_PtxRegister4095, r_PtxRegister4096, r_PtxRegister4097,
		r_PtxRegister4098, r_PtxRegister4099, r_PtxRegister4100, r_PtxRegister4101, r_PtxRegister4102,
		r_PtxRegister4103, r_PtxRegister4104;
	uint32_t r_PtxRegister4105, r_PtxRegister4106, r_PtxRegister4107, r_PtxRegister4108, r_PtxRegister4109,
		r_PtxRegister4110, r_PtxRegister4111, r_PtxRegister4112, r_PtxRegister4113, r_PtxRegister4114,
		r_PtxRegister4115, r_PtxRegister4116;
	uint32_t r_PtxRegister4117, r_PtxRegister4118, r_PtxRegister4119, r_PtxRegister4120, r_PtxRegister4121,
		r_PtxRegister4122, r_PtxRegister4123, r_PtxRegister4124, r_PtxRegister4125, r_PtxRegister4126,
		r_PtxRegister4127, r_PtxRegister4128;
	uint32_t r_PtxRegister4129, r_PtxRegister4130, r_PtxRegister4131, r_PtxRegister4132, r_PtxRegister4133,
		r_PtxRegister4134, r_PtxRegister4135, r_PtxRegister4136, r_PtxRegister4137, r_PtxRegister4138,
		r_PtxRegister4139, r_PtxRegister4140;
	uint32_t r_PtxRegister4141, r_PtxRegister4142, r_PtxRegister4143, r_PtxRegister4144, r_PtxRegister4145,
		r_PtxRegister4146, r_PtxRegister4147, r_PtxRegister4148, r_PtxRegister4149, r_PtxRegister4150,
		r_PtxRegister4151, r_PtxRegister4152;
	uint32_t r_PtxRegister4153, r_PtxRegister4154, r_PtxRegister4155, r_PtxRegister4156, r_PtxRegister4157,
		r_PtxRegister4158, r_PtxRegister4159, r_PtxRegister4160, r_PtxRegister4161, r_PtxRegister4162,
		r_PtxRegister4163, r_PtxRegister4164;
	uint32_t r_PtxRegister4165, r_PtxRegister4166, r_PtxRegister4167, r_PtxRegister4168, r_PtxRegister4169,
		r_PtxRegister4170, r_PtxRegister4171, r_PtxRegister4172, r_PtxRegister4173, r_PtxRegister4174,
		r_PtxRegister4175, r_PtxRegister4176;
	uint32_t r_PtxRegister4177, r_PtxRegister4178, r_PtxRegister4179, r_PtxRegister4180, r_PtxRegister4181,
		r_PtxRegister4182, r_PtxRegister4183, r_PtxRegister4184, r_PtxRegister4185, r_PtxRegister4186,
		r_PtxRegister4187, r_PtxRegister4188;
	uint32_t r_PtxRegister4189, r_PtxRegister4190, r_PtxRegister4191, r_PtxRegister4192, r_PtxRegister4193,
		r_PtxRegister4194, r_PtxRegister4195, r_PtxRegister4196, r_PtxRegister4197, r_PtxRegister4198,
		r_PtxRegister4199, r_PtxRegister4200;
	uint32_t r_PtxRegister4201, r_PtxRegister4202, r_PtxRegister4203, r_PtxRegister4204, r_PtxRegister4205,
		r_PtxRegister4206, r_PtxRegister4207, r_PtxRegister4208, r_PtxRegister4209, r_PtxRegister4210,
		r_PtxRegister4211, r_PtxRegister4212;
	uint32_t r_PtxRegister4213, r_PtxRegister4214, r_PtxRegister4215, r_PtxRegister4216, r_PtxRegister4217,
		r_PtxRegister4218, r_PtxRegister4219, r_PtxRegister4220, r_PtxRegister4221, r_PtxRegister4222,
		r_PtxRegister4223, r_PtxRegister4224;
	uint32_t r_PtxRegister4225, r_PtxRegister4226, r_PtxRegister4227, r_PtxRegister4228, r_PtxRegister4229,
		r_PtxRegister4230, r_PtxRegister4231, r_PtxRegister4232, r_PtxRegister4233, r_PtxRegister4234,
		r_PtxRegister4235, r_PtxRegister4236;
	uint32_t r_PtxRegister4237, r_PtxRegister4238, r_PtxRegister4239, r_PtxRegister4240, r_PtxRegister4241,
		r_PtxRegister4242, r_PtxRegister4243, r_PtxRegister4244, r_PtxRegister4245, r_PtxRegister4246,
		r_PtxRegister4247, r_PtxRegister4248;
	uint32_t r_PtxRegister4249, r_PtxRegister4250, r_PtxRegister4251, r_PtxRegister4252, r_PtxRegister4253,
		r_PtxRegister4254, r_PtxRegister4255, r_PtxRegister4256, r_PtxRegister4257, r_PtxRegister4258,
		r_PtxRegister4259, r_PtxRegister4260;
	uint32_t r_PtxRegister4261, r_PtxRegister4262, r_PtxRegister4263, r_PtxRegister4264, r_PtxRegister4265,
		r_PtxRegister4266, r_PtxRegister4267, r_PtxRegister4268, r_PtxRegister4269, r_PtxRegister4270,
		r_PtxRegister4271, r_PtxRegister4272;
	uint32_t r_PtxRegister4273, r_PtxRegister4274, r_PtxRegister4275, r_PtxRegister4276, r_PtxRegister4277,
		r_PtxRegister4278, r_PtxRegister4279, r_PtxRegister4280, r_PtxRegister4281, r_PtxRegister4282,
		r_PtxRegister4283, r_PtxRegister4284;
	uint32_t r_PtxRegister4285, r_PtxRegister4286, r_PtxRegister4287, r_PtxRegister4288, r_PtxRegister4289,
		r_PtxRegister4290, r_PtxRegister4291, r_PtxRegister4292, r_PtxRegister4293, r_LaneIndexAtPtx12712,
		r_PackedE4WordAtPtx12710R4295, r_PackedE4WordAtPtx12709R4296;
	uint32_t r_PackedE4WordAtPtx12708R4297, r_PackedE4WordAtPtx12707R4298, r_LaneIndexAtPtx12724,
		r_PackedE4WordAtPtx12732R4300, r_PackedE4WordAtPtx12731R4301, r_PackedE4WordAtPtx12730R4302,
		r_PackedE4WordAtPtx12729R4303, r_LaneIndexAtPtx12738, r_PtxRegister4305, r_PtxRegister4306,
		r_PtxRegister4307, r_PtxRegister4308;
	uint32_t r_PackedHalf2AtPtx12767R4309, r_PackedHalf2AtPtx12771R4310, r_PtxRegister4311,
		r_PackedHalf2AtPtx12775R4312, r_LaneIndexAtPtx12789, r_PtxRegister4314, r_PtxRegister4315,
		r_PtxRegister4316, r_PtxRegister4317, r_PackedHalf2AtPtx12818R4318, r_PackedHalf2AtPtx12822R4319,
		r_PackedHalf2AtPtx12826R4320;
	uint32_t r_PackedHalf2AtPtx12783R4321, r_LaneIndexAtPtx12834, r_PtxRegister4323, r_PtxRegister4324,
		r_PtxRegister4325, r_PtxRegister4326, r_PackedHalf2AtPtx12863R4327, r_PackedHalf2AtPtx12867R4328,
		r_PackedHalf2AtPtx12871R4329, r_LaneIndexAtPtx12879, r_PtxRegister4331, r_PtxRegister4332;
	uint32_t r_PtxRegister4333, r_PtxRegister4334, r_PackedHalf2AtPtx12908R4335, r_PackedHalf2AtPtx12912R4336,
		r_PackedHalf2AtPtx12916R4337, r_LaneIndexAtPtx12924, r_PtxRegister4339, r_PtxRegister4340,
		r_PtxRegister4341, r_PtxRegister4342, r_PackedHalf2AtPtx12953R4343, r_PackedHalf2AtPtx12957R4344;
	uint32_t r_PackedHalf2AtPtx12961R4345, r_LaneIndexAtPtx12969, r_PtxRegister4347, r_PtxRegister4348,
		r_PtxRegister4349, r_PtxRegister4350, r_PackedHalf2AtPtx12998R4351, r_PackedHalf2AtPtx13002R4352,
		r_PackedHalf2AtPtx13006R4353, r_LaneIndexAtPtx13014, r_PtxRegister4355, r_PtxRegister4356;
	uint32_t r_PtxRegister4357, r_PtxRegister4358, r_PackedHalf2AtPtx13043R4359, r_PackedHalf2AtPtx13047R4360,
		r_PackedHalf2AtPtx13051R4361, r_LaneIndexAtPtx13059, r_PtxRegister4363, r_PtxRegister4364,
		r_PtxRegister4365, r_PtxRegister4366, r_PackedHalf2AtPtx13088R4367, r_PackedHalf2AtPtx13092R4368;
	uint32_t r_PackedHalf2AtPtx13096R4369, r_PackedHalf2AtPtx12785R4370, r_PackedHalf2AtPtx12875R4371,
		r_PackedHalf2AtPtx12830R4372, r_PackedHalf2AtPtx12920R4373, r_PackedHalf2AtPtx12965R4374,
		r_PackedHalf2AtPtx13055R4375, r_PackedHalf2AtPtx13010R4376, r_PackedHalf2AtPtx13100R4377,
		r_LaneIndexAtPtx13134, r_PtxRegister4379, r_PackedE4WordAtPtx13111R4380;
	uint32_t r_PackedE4WordAtPtx13118R4381, r_PackedE4WordAtPtx13125R4382, r_PackedE4WordAtPtx13132R4383,
		r_PtxRegister4384, r_PtxRegister4385, r_PtxRegister4386, r_PtxRegister4387, r_PtxRegister4388,
		r_PtxRegister4389, r_PtxRegister4390, r_PtxRegister4391, r_PtxRegister4392;
	uint32_t r_PtxRegister4393, r_PtxRegister4394, r_PtxRegister4395, r_PtxRegister4396, r_PtxRegister4397,
		r_PtxRegister4398, r_PtxRegister4399, r_PtxRegister4400, r_PtxRegister4401, r_PtxRegister4402,
		r_PtxRegister4403, r_PtxRegister4404;
	uint32_t r_PtxRegister4405, r_PtxRegister4406, r_PtxRegister4407, r_PtxRegister4408, r_PtxRegister4409,
		r_PtxRegister4410, r_PtxRegister4411, r_PtxRegister4412, r_PtxRegister4413, r_PtxRegister4414,
		r_PtxRegister4415, r_PtxRegister4416;
	uint32_t r_PtxRegister4417, r_PtxRegister4418, r_PtxRegister4419, r_PtxRegister4420, r_PtxRegister4421,
		r_PtxRegister4422, r_PtxRegister4423, r_PtxRegister4424, r_PtxRegister4425, r_PtxRegister4426,
		r_PtxRegister4427, r_PtxRegister4428;
	uint32_t r_PtxRegister4429, r_PtxRegister4430, r_PtxRegister4431, r_PtxRegister4432, r_PtxRegister4433,
		r_PtxRegister4434, r_PtxRegister4435, r_PtxRegister4436, r_PtxRegister4437, r_PtxRegister4438,
		r_PtxRegister4439, r_PtxRegister4440;
	uint32_t r_PtxRegister4441, r_PtxRegister4442, r_PtxRegister4443, r_PtxRegister4444, r_PtxRegister4445,
		r_PtxRegister4446, r_PtxRegister4447, r_PtxRegister4448, r_PtxRegister4449, r_PtxRegister4450,
		r_PtxRegister4451, r_PtxRegister4452;
	uint32_t r_PtxRegister4453, r_PtxRegister4454, r_PtxRegister4455, r_PtxRegister4456, r_PtxRegister4457,
		r_PtxRegister4458, r_PtxRegister4459, r_PtxRegister4460, r_PtxRegister4461, r_PtxRegister4462,
		r_PtxRegister4463, r_PtxRegister4464;
	uint32_t r_PtxRegister4465, r_PtxRegister4466, r_PtxRegister4467, r_PtxRegister4468, r_PtxRegister4469,
		r_PtxRegister4470, r_PtxRegister4471, r_PtxRegister4472, r_PtxRegister4473, r_PtxRegister4474,
		r_PtxRegister4475, r_PtxRegister4476;
	uint32_t r_PtxRegister4477, r_PtxRegister4478, r_PtxRegister4479, r_PtxRegister4480, r_PtxRegister4481,
		r_PtxRegister4482, r_PtxRegister4483, r_PtxRegister4484, r_PtxRegister4485, r_PtxRegister4486,
		r_PtxRegister4487, r_PtxRegister4488;
	uint32_t r_PtxRegister4489, r_PtxRegister4490, r_PtxRegister4491, r_PtxRegister4492, r_PtxRegister4493,
		r_PtxRegister4494, r_PtxRegister4495, r_PtxRegister4496, r_PtxRegister4497, r_PtxRegister4498,
		r_PtxRegister4499, r_PtxRegister4500;
	uint32_t r_PtxRegister4501, r_PtxRegister4502, r_PtxRegister4503, r_PtxRegister4504, r_PtxRegister4505,
		r_PtxRegister4506, r_PtxRegister4507, r_PtxRegister4508, r_PtxRegister4509, r_PtxRegister4510,
		r_PtxRegister4511, r_PtxRegister4512;
	uint32_t r_PtxRegister4513, r_PtxRegister4514, r_PtxRegister4515, r_PtxRegister4516, r_PtxRegister4517,
		r_PtxRegister4518, r_PtxRegister4519, r_PtxRegister4520, r_PtxRegister4521, r_PtxRegister4522,
		r_PtxRegister4523, r_PtxRegister4524;
	uint32_t r_PtxRegister4525, r_PtxRegister4526, r_PtxRegister4527, r_PtxRegister4528, r_PtxRegister4529,
		r_PtxRegister4530, r_PtxRegister4531, r_PtxRegister4532, r_PtxRegister4533, r_PtxRegister4534,
		r_PtxRegister4535, r_PtxRegister4536;
	uint32_t r_PtxRegister4537, r_PtxRegister4538, r_PtxRegister4539, r_PtxRegister4540, r_PtxRegister4541,
		r_PtxRegister4542, r_PtxRegister4543, r_PtxRegister4544, r_PtxRegister4545, r_PtxRegister4546,
		r_CtaXAtPtx13145, r_PtxRegister4548;
	uint32_t r_PtxRegister4549, r_PtxRegister4550, r_PtxRegister4551, r_PtxRegister4552, r_PtxRegister4553,
		r_PtxRegister4554, r_PtxRegister4555, r_LaneIndexAtPtx13170, r_LaneIndexAtPtx13182,
		r_LaneIndexAtPtx13191, r_PtxRegister4559, r_MmaAE4x4WordAtPtx13197R4560;
	uint32_t r_MmaAE4x4WordAtPtx13197R4561, r_MmaAE4x4WordAtPtx13197R4562, r_MmaAE4x4WordAtPtx13197R4563,
		r_MmaBE4x4WordAtPtx13176R4564, r_MmaBE4x4WordAtPtx13176R4565, r_MmaBE4x4WordAtPtx13176R4566,
		r_MmaBE4x4WordAtPtx13176R4567, r_MmaBE4x4WordAtPtx13188R4568, r_MmaBE4x4WordAtPtx13188R4569,
		r_MmaBE4x4WordAtPtx13188R4570, r_MmaBE4x4WordAtPtx13188R4571, r_LaneIndexAtPtx13228;
	uint32_t r_LaneIndexAtPtx13240, r_LaneIndexAtPtx13249, r_PtxRegister4575, r_MmaAE4x4WordAtPtx13255R4576,
		r_MmaAE4x4WordAtPtx13255R4577, r_MmaAE4x4WordAtPtx13255R4578, r_MmaAE4x4WordAtPtx13255R4579,
		r_MmaBE4x4WordAtPtx13234R4580, r_MmaBE4x4WordAtPtx13234R4581,
		r_MmaAccumulatorHalf2WordAtPtx13200R4582, r_MmaAccumulatorHalf2WordAtPtx13200R4583,
		r_MmaBE4x4WordAtPtx13234R4584;
	uint32_t r_MmaBE4x4WordAtPtx13234R4585, r_MmaAccumulatorHalf2WordAtPtx13207R4586,
		r_MmaAccumulatorHalf2WordAtPtx13207R4587, r_MmaBE4x4WordAtPtx13246R4588,
		r_MmaBE4x4WordAtPtx13246R4589, r_MmaAccumulatorHalf2WordAtPtx13214R4590,
		r_MmaAccumulatorHalf2WordAtPtx13214R4591, r_MmaBE4x4WordAtPtx13246R4592,
		r_MmaBE4x4WordAtPtx13246R4593, r_MmaAccumulatorHalf2WordAtPtx13221R4594,
		r_MmaAccumulatorHalf2WordAtPtx13221R4595, r_MmaAccumulatorHalf2WordAtPtx13258R4596;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx13265R4597, r_MmaAccumulatorHalf2WordAtPtx13258R4598,
		r_MmaAccumulatorHalf2WordAtPtx13265R4599, r_MmaAccumulatorHalf2WordAtPtx13272R4600,
		r_MmaAccumulatorHalf2WordAtPtx13279R4601, r_MmaAccumulatorHalf2WordAtPtx13272R4602,
		r_MmaAccumulatorHalf2WordAtPtx13279R4603, r_LaneIndexAtPtx13311, r_PtxRegister4605, r_PtxRegister4606,
		r_PtxRegister4607, r_PtxRegister4608;
	uint32_t r_PtxRegister4609, r_PtxRegister4610, r_PtxRegister4611, r_PtxRegister4612, r_PtxRegister4613,
		r_PtxRegister4614, r_PtxRegister4615, r_PtxRegister4616, r_PtxRegister4617, r_PtxRegister4618,
		r_PtxRegister4619, r_PtxRegister4620;
	uint32_t r_PtxRegister4621, r_PtxRegister4622, r_PtxRegister4623, r_PtxRegister4624, r_PtxRegister4625,
		r_PtxRegister4626, r_PtxRegister4627, r_PtxRegister4628, r_PtxRegister4629, r_PtxRegister4630,
		r_LaneIndexAtPtx13346, r_PtxRegister4632;
	uint32_t r_PtxRegister4633, r_PtxRegister4634, r_PtxRegister4635, r_PtxRegister4636, r_PtxRegister4637,
		r_PtxRegister4638, r_PtxRegister4639, r_PtxRegister4640, r_PtxRegister4641, r_PtxRegister4642,
		r_PtxRegister4643, r_PtxRegister4644;
	uint32_t r_PtxRegister4645, r_PtxRegister4646, r_PtxRegister4647, r_PtxRegister4648,
		r_LaneIndexAtPtx13380, r_PtxRegister4650, r_PtxRegister4651, r_PtxRegister4652, r_PtxRegister4653,
		r_PtxRegister4654, r_PtxRegister4655, r_PtxRegister4656;
	uint32_t r_PtxRegister4657, r_PtxRegister4658, r_PtxRegister4659, r_PtxRegister4660, r_PtxRegister4661,
		r_PtxRegister4662, r_PtxRegister4663, r_PtxRegister4664, r_PtxRegister4665, r_PtxRegister4666,
		r_LaneIndexAtPtx13415, r_PtxRegister4668;
	uint32_t r_PtxRegister4669, r_PtxRegister4670, r_PtxRegister4671, r_PtxRegister4672, r_PtxRegister4673,
		r_PtxRegister4674, r_PtxRegister4675, r_PtxRegister4676, r_PtxRegister4677, r_PtxRegister4678,
		r_PtxRegister4679, r_PtxRegister4680;
	uint32_t r_PtxRegister4681, r_PtxRegister4682, r_PtxRegister4683, r_PtxRegister4684, r_PtxRegister4685,
		r_PtxRegister4686, r_PtxRegister4687, r_PtxRegister4688, r_PtxRegister4689, r_PtxRegister4690,
		r_PtxRegister4691, r_PtxRegister4692;
	uint32_t r_GridSizeY, r_PtxRegister4694, r_PtxRegister4695, r_PtxRegister4696, r_PtxRegister4697,
		r_PtxRegister4698, r_PtxRegister4699, r_PtxRegister4700, r_GridSizeX, r_PtxRegister4702,
		r_PtxRegister4703, r_PtxRegister4704;
	uint32_t r_PtxRegister4705, r_PtxRegister4706, r_PtxRegister4707, r_PtxRegister4708, r_PtxRegister4709,
		r_PtxRegister4710, r_PtxRegister4711, r_PtxRegister4712, r_PtxRegister4713, r_PtxRegister4714,
		r_PtxRegister4715, r_PtxRegister4716;
	uint32_t r_PtxRegister4717, r_PtxRegister4718, r_PtxRegister4719, r_PtxRegister4720, r_PtxRegister4721,
		r_PtxRegister4722, r_PtxRegister4723, r_PtxRegister4724, r_PtxRegister4725, r_PtxRegister4726,
		r_PtxRegister4727, r_PtxRegister4728;
	uint32_t r_PtxRegister4729, r_PtxRegister4730, r_PtxRegister4731, r_PtxRegister4732, r_PtxRegister4733,
		r_PtxRegister4734, r_PtxRegister4735, r_PtxRegister4736, r_PtxRegister4737, r_PtxRegister4738,
		r_PtxRegister4739, r_PtxRegister4740;
	uint32_t r_PtxRegister4741, r_PtxRegister4742, r_PtxRegister4743, r_PtxRegister4744, r_PtxRegister4745,
		r_PtxRegister4746, r_PtxRegister4747, r_CtaZ, r_CtaYAtPtx13570, r_PtxRegister4750, r_PtxRegister4751,
		r_PtxRegister4752;
	uint32_t r_PtxRegister4753, r_PtxRegister4754, r_PtxRegister4755, r_PtxRegister4756, r_PtxRegister4757,
		r_PtxRegister4758, r_PtxRegister4759, r_PtxRegister4760, r_PtxRegister4761, r_PtxRegister4762,
		r_PtxRegister4763, r_PtxRegister4764;
	uint32_t r_PtxRegister4765, r_PtxRegister4766, r_PtxRegister4767, r_PtxRegister4768, r_PtxRegister4769,
		r_PtxRegister4770, r_PtxRegister4771, r_PtxRegister4772, r_PtxRegister4773, r_PtxRegister4774,
		r_PtxRegister4775, r_PtxRegister4776;
	uint32_t r_PtxRegister4777, r_PtxRegister4778, r_PtxRegister4779, r_PtxRegister4780, r_PtxRegister4781,
		r_PtxRegister4782, r_PtxRegister4783, r_PtxRegister4784, r_PtxRegister4785, r_PtxRegister4786,
		r_PtxRegister4787, r_PtxRegister4788;
	uint32_t r_PtxRegister4789, r_PtxRegister4790, r_PtxRegister4791, r_PtxRegister4792, r_PtxRegister4793,
		r_PtxRegister4794, r_PtxRegister4795, r_PtxRegister4796, r_PtxRegister4797, r_PtxRegister4798,
		r_PtxRegister4799, r_PtxRegister4800;
	uint32_t r_PtxRegister4801, r_PtxRegister4802, r_PtxRegister4803, r_PtxRegister4804, r_PtxRegister4805,
		r_PtxRegister4806, r_PtxRegister4807, r_PtxRegister4808, r_PtxRegister4809, r_PtxRegister4810,
		r_PtxRegister4811, r_PtxRegister4812;
	uint32_t r_PtxRegister4813, r_PtxRegister4814, r_PtxRegister4815, r_PtxRegister4816, r_PtxRegister4817,
		r_PtxRegister4818, r_PtxRegister4819, r_PtxRegister4820, r_PtxRegister4821, r_PtxRegister4822,
		r_PtxRegister4823, r_PtxRegister4824;
	uint32_t r_PtxRegister4825, r_PtxRegister4826, r_PtxRegister4827, r_PtxRegister4828, r_PtxRegister4829,
		r_PtxRegister4830, r_PtxRegister4831, r_PtxRegister4832, r_PtxRegister4833, r_PtxRegister4834,
		r_PtxRegister4835, r_PtxRegister4836;
	uint32_t r_PtxRegister4837, r_PtxRegister4838, r_PtxRegister4839, r_PtxRegister4840, r_PtxRegister4841,
		r_PtxRegister4842, r_PtxRegister4843, r_PtxRegister4844, r_PtxRegister4845, r_PtxRegister4846,
		r_PtxRegister4847, r_PtxRegister4848;
	uint32_t r_PtxRegister4849, r_PtxRegister4850, r_PtxRegister4851, r_PtxRegister4852, r_PtxRegister4853,
		r_PtxRegister4854, r_PtxRegister4855, r_PtxRegister4856, r_PackedHalf2AtPtx743R4857,
		r_PackedHalf2AtPtx750R4858, r_PackedHalf2AtPtx757R4859, r_PackedHalf2AtPtx764R4860;
	uint32_t r_PackedHalf2AtPtx771R4861, r_PackedHalf2AtPtx778R4862, r_PackedHalf2AtPtx785R4863,
		r_PackedHalf2AtPtx792R4864, r_PackedHalf2AtPtx799R4865, r_PackedHalf2AtPtx806R4866,
		r_PackedHalf2AtPtx813R4867, r_PackedHalf2AtPtx820R4868, r_PackedHalf2AtPtx827R4869,
		r_PackedHalf2AtPtx834R4870, r_PackedHalf2AtPtx841R4871, r_PackedHalf2AtPtx848R4872;
	uint32_t r_PackedHalf2AtPtx855R4873, r_PackedHalf2AtPtx862R4874, r_PackedHalf2AtPtx869R4875,
		r_PackedHalf2AtPtx876R4876, r_PackedHalf2AtPtx883R4877, r_PackedHalf2AtPtx890R4878,
		r_PackedHalf2AtPtx897R4879, r_PackedHalf2AtPtx904R4880, r_PackedHalf2AtPtx911R4881,
		r_PackedHalf2AtPtx918R4882, r_PackedHalf2AtPtx925R4883, r_PackedHalf2AtPtx932R4884;
	uint32_t r_PackedHalf2AtPtx939R4885, r_PackedHalf2AtPtx946R4886, r_PackedHalf2AtPtx953R4887,
		r_PackedHalf2AtPtx960R4888, r_PtxRegister4889, r_PtxRegister4890, r_PtxRegister4891,
		r_PtxRegister4892, r_PtxRegister4893, r_PtxRegister4894, r_PtxRegister4895, r_PtxRegister4896;
	uint32_t r_PtxRegister4897, r_PtxRegister4898;
	uint64_t g_StateBaseAddress, g_RecordByteAddressAtPtx19, g_RecordByteAddressAtPtx8050,
		g_RecordByteAddressAtPtx10133, g_OutputByteAddressAtPtx10377, g_OutputByteAddressAtPtx12704,
		g_DownOutputByteAddressAtPtx13164, g_OutputBaseAddress, g_RecordBaseAddress, g_DownOutputBaseAddress,
		g_StateByteAddressAtPtx77, r_PtxU64Register12;
	uint64_t g_StateByteAddressAtPtx72, r_PtxU64Register14, g_StateByteAddressAtPtx130, r_PtxU64Register16,
		g_StateByteAddressAtPtx124, r_PtxU64Register18, g_StateByteAddressAtPtx129,
		g_StateByteAddressAtPtx186, r_PtxU64Register21, g_StateByteAddressAtPtx181, r_PtxU64Register23,
		g_StateByteAddressAtPtx239;
	uint64_t r_PtxU64Register25, g_StateByteAddressAtPtx233, r_PtxU64Register27, g_StateByteAddressAtPtx238,
		r_PtxU64Register29, g_RecordByteAddressAtPtx368, r_PtxU64Register31, g_RecordByteAddressAtPtx379,
		r_PtxU64Register33, g_RecordByteAddressAtPtx391, r_PtxU64Register35, g_RecordByteAddressAtPtx403;
	uint64_t r_PtxU64Register37, g_RecordByteAddressAtPtx415, r_PtxU64Register39, g_RecordByteAddressAtPtx427,
		r_PtxU64Register41, g_RecordByteAddressAtPtx439, r_PtxU64Register43, g_RecordByteAddressAtPtx451,
		r_PtxU64Register45, g_RecordByteAddressAtPtx463, r_PtxU64Register47, g_RecordByteAddressAtPtx475;
	uint64_t r_PtxU64Register49, g_RecordByteAddressAtPtx487, r_PtxU64Register51, g_RecordByteAddressAtPtx499,
		r_PtxU64Register53, g_RecordByteAddressAtPtx511, r_PtxU64Register55, g_RecordByteAddressAtPtx523,
		r_PtxU64Register57, g_RecordByteAddressAtPtx535, r_PtxU64Register59, g_RecordByteAddressAtPtx547;
	uint64_t r_PtxU64Register61, g_RecordByteAddressAtPtx558, r_PtxU64Register63, g_RecordByteAddressAtPtx569,
		r_PtxU64Register65, g_RecordByteAddressAtPtx581, r_PtxU64Register67, g_RecordByteAddressAtPtx593,
		r_PtxU64Register69, g_RecordByteAddressAtPtx605, r_PtxU64Register71, g_RecordByteAddressAtPtx617;
	uint64_t r_PtxU64Register73, g_RecordByteAddressAtPtx629, r_PtxU64Register75, g_RecordByteAddressAtPtx641,
		r_PtxU64Register77, g_RecordByteAddressAtPtx653, r_PtxU64Register79, g_RecordByteAddressAtPtx665,
		r_PtxU64Register81, g_RecordByteAddressAtPtx677, r_PtxU64Register83, g_RecordByteAddressAtPtx689;
	uint64_t r_PtxU64Register85, g_RecordByteAddressAtPtx701, r_PtxU64Register87, g_RecordByteAddressAtPtx713,
		r_PtxU64Register89, g_RecordByteAddressAtPtx725, r_PtxU64Register91, g_RecordByteAddressAtPtx737,
		g_RecordByteAddressAtPtx980, g_RecordByteAddressAtPtx989, g_RecordByteAddressAtPtx1110,
		g_RecordByteAddressAtPtx1119;
	uint64_t g_RecordByteAddressAtPtx1710, g_RecordByteAddressAtPtx1719, g_RecordByteAddressAtPtx1840,
		g_RecordByteAddressAtPtx1849, g_RecordByteAddressAtPtx1914, g_RecordByteAddressAtPtx1923,
		g_RecordByteAddressAtPtx2420, g_RecordByteAddressAtPtx2429, g_RecordByteAddressAtPtx2550,
		g_RecordByteAddressAtPtx2559, g_RecordByteAddressAtPtx2624, g_RecordByteAddressAtPtx2633;
	uint64_t g_RecordByteAddressAtPtx3130, g_RecordByteAddressAtPtx3139, g_RecordByteAddressAtPtx3260,
		g_RecordByteAddressAtPtx3269, g_RecordByteAddressAtPtx3334, g_RecordByteAddressAtPtx3343,
		g_RecordByteAddressAtPtx3840, g_RecordByteAddressAtPtx3849, g_RecordByteAddressAtPtx3973,
		g_RecordByteAddressAtPtx3982, g_RecordByteAddressAtPtx3991, g_RecordByteAddressAtPtx4000;
	uint64_t r_PtxU64Register121, g_RecordByteAddressAtPtx975, r_PtxU64Register123, r_PtxU64Register124,
		g_RecordByteAddressAtPtx988, r_PtxU64Register126, g_RecordByteAddressAtPtx1109, r_PtxU64Register128,
		g_RecordByteAddressAtPtx1118, r_PtxU64Register130, g_RecordByteAddressAtPtx1704, r_PtxU64Register132;
	uint64_t g_RecordByteAddressAtPtx1709, r_PtxU64Register134, g_RecordByteAddressAtPtx1718,
		r_PtxU64Register136, g_RecordByteAddressAtPtx1839, r_PtxU64Register138, g_RecordByteAddressAtPtx1848,
		r_PtxU64Register140, g_RecordByteAddressAtPtx1913, r_PtxU64Register142, g_RecordByteAddressAtPtx1922,
		r_PtxU64Register144;
	uint64_t g_RecordByteAddressAtPtx2419, r_PtxU64Register146, g_RecordByteAddressAtPtx2428,
		r_PtxU64Register148, g_RecordByteAddressAtPtx2549, r_PtxU64Register150, g_RecordByteAddressAtPtx2558,
		r_PtxU64Register152, g_RecordByteAddressAtPtx2623, r_PtxU64Register154, g_RecordByteAddressAtPtx2632,
		r_PtxU64Register156;
	uint64_t g_RecordByteAddressAtPtx3129, r_PtxU64Register158, g_RecordByteAddressAtPtx3138,
		r_PtxU64Register160, g_RecordByteAddressAtPtx3259, r_PtxU64Register162, g_RecordByteAddressAtPtx3268,
		r_PtxU64Register164, g_RecordByteAddressAtPtx3333, r_PtxU64Register166, g_RecordByteAddressAtPtx3342,
		r_PtxU64Register168;
	uint64_t g_RecordByteAddressAtPtx3839, r_PtxU64Register170, g_RecordByteAddressAtPtx3848,
		r_PtxU64Register172, g_RecordByteAddressAtPtx3967, r_PtxU64Register174, g_RecordByteAddressAtPtx3972,
		r_PtxU64Register176, g_RecordByteAddressAtPtx3981, r_PtxU64Register178, g_RecordByteAddressAtPtx3990,
		r_PtxU64Register180;
	uint64_t g_RecordByteAddressAtPtx3999, g_RecordByteAddressAtPtx4370, g_RecordByteAddressAtPtx4379,
		g_RecordByteAddressAtPtx4388, g_RecordByteAddressAtPtx4397, g_RecordByteAddressAtPtx4406,
		g_RecordByteAddressAtPtx4415, g_RecordByteAddressAtPtx4796, g_RecordByteAddressAtPtx4805,
		g_RecordByteAddressAtPtx4814, g_RecordByteAddressAtPtx4823, g_RecordByteAddressAtPtx4832;
	uint64_t g_RecordByteAddressAtPtx4841, g_RecordByteAddressAtPtx8056, g_RecordByteAddressAtPtx8065,
		g_RecordByteAddressAtPtx8074, g_RecordByteAddressAtPtx8083, g_RecordByteAddressAtPtx8092,
		g_RecordByteAddressAtPtx8101, g_RecordByteAddressAtPtx8110, g_RecordByteAddressAtPtx8119,
		g_RecordByteAddressAtPtx10139, g_RecordByteAddressAtPtx10148, g_RecordByteAddressAtPtx10230;
	uint64_t g_RecordByteAddressAtPtx10239, r_PtxU64Register206, g_RecordByteAddressAtPtx4364,
		r_PtxU64Register208, g_RecordByteAddressAtPtx4369, r_PtxU64Register210, g_RecordByteAddressAtPtx4378,
		r_PtxU64Register212, g_RecordByteAddressAtPtx4387, r_PtxU64Register214, g_RecordByteAddressAtPtx4396,
		r_PtxU64Register216;
	uint64_t g_RecordByteAddressAtPtx4405, r_PtxU64Register218, g_RecordByteAddressAtPtx4414,
		r_PtxU64Register220, g_RecordByteAddressAtPtx4795, r_PtxU64Register222, g_RecordByteAddressAtPtx4804,
		r_PtxU64Register224, g_RecordByteAddressAtPtx4813, r_PtxU64Register226, g_RecordByteAddressAtPtx4822,
		r_PtxU64Register228;
	uint64_t g_RecordByteAddressAtPtx4831, r_PtxU64Register230, g_RecordByteAddressAtPtx4840,
		g_RecordByteAddressAtPtx5181, r_PtxU64Register233, g_RecordByteAddressAtPtx5183, r_PtxU64Register235,
		r_PtxU64Register236, g_RecordByteAddressAtPtx8055, r_PtxU64Register238, g_RecordByteAddressAtPtx8064,
		r_PtxU64Register240;
	uint64_t g_RecordByteAddressAtPtx8073, r_PtxU64Register242, g_RecordByteAddressAtPtx8082,
		r_PtxU64Register244, g_RecordByteAddressAtPtx8091, r_PtxU64Register246, g_RecordByteAddressAtPtx8100,
		r_PtxU64Register248, g_RecordByteAddressAtPtx8109, r_PtxU64Register250, g_RecordByteAddressAtPtx8118,
		r_PtxU64Register252;
	uint64_t g_RecordByteAddressAtPtx9753, r_PtxU64Register254, g_RecordByteAddressAtPtx9767,
		r_PtxU64Register256, g_RecordByteAddressAtPtx9781, r_PtxU64Register258, g_RecordByteAddressAtPtx9793,
		r_PtxU64Register260, g_RecordByteAddressAtPtx9806, r_PtxU64Register262, g_RecordByteAddressAtPtx9818,
		r_PtxU64Register264;
	uint64_t g_RecordByteAddressAtPtx9831, r_PtxU64Register266, g_RecordByteAddressAtPtx9843,
		r_PtxU64Register268, g_RecordByteAddressAtPtx9857, r_PtxU64Register270, g_RecordByteAddressAtPtx9871,
		r_PtxU64Register272, g_RecordByteAddressAtPtx9883, r_PtxU64Register274, g_RecordByteAddressAtPtx9895,
		r_PtxU64Register276;
	uint64_t g_RecordByteAddressAtPtx9907, r_PtxU64Register278, g_RecordByteAddressAtPtx9919,
		r_PtxU64Register280, g_RecordByteAddressAtPtx9931, r_PtxU64Register282, g_RecordByteAddressAtPtx9943,
		r_PtxU64Register284, r_PtxU64Register285, g_RecordByteAddressAtPtx10138, r_PtxU64Register287,
		g_RecordByteAddressAtPtx10147;
	uint64_t r_PtxU64Register289, g_RecordByteAddressAtPtx10229, r_PtxU64Register291,
		g_RecordByteAddressAtPtx10238, r_PtxU64Register293, g_OutputByteAddressAtPtx10388,
		r_PtxU64Register295, g_OutputByteAddressAtPtx10401, r_PtxU64Register297,
		g_OutputByteAddressAtPtx10400, g_RecordByteAddressAtPtx10424, g_RecordByteAddressAtPtx10433;
	uint64_t g_RecordByteAddressAtPtx10442, g_RecordByteAddressAtPtx10451, g_RecordByteAddressAtPtx10460,
		g_RecordByteAddressAtPtx10469, g_RecordByteAddressAtPtx10478, g_RecordByteAddressAtPtx10487,
		g_RecordByteAddressAtPtx12467, g_RecordByteAddressAtPtx12476, g_RecordByteAddressAtPtx12559,
		g_RecordByteAddressAtPtx12568, r_PtxU64Register311, g_RecordByteAddressAtPtx10423;
	uint64_t r_PtxU64Register313, g_RecordByteAddressAtPtx10432, r_PtxU64Register315,
		g_RecordByteAddressAtPtx10441, r_PtxU64Register317, g_RecordByteAddressAtPtx10450,
		r_PtxU64Register319, g_RecordByteAddressAtPtx10459, r_PtxU64Register321,
		g_RecordByteAddressAtPtx10468, r_PtxU64Register323, g_RecordByteAddressAtPtx10477;
	uint64_t r_PtxU64Register325, g_RecordByteAddressAtPtx10486, g_RecordByteAddressAtPtx12086,
		r_PtxU64Register328, g_RecordByteAddressAtPtx12088, r_PtxU64Register330,
		g_RecordByteAddressAtPtx12102, r_PtxU64Register332, g_RecordByteAddressAtPtx12114,
		r_PtxU64Register334, g_RecordByteAddressAtPtx12126, r_PtxU64Register336;
	uint64_t g_RecordByteAddressAtPtx12138, r_PtxU64Register338, g_RecordByteAddressAtPtx12150,
		r_PtxU64Register340, g_RecordByteAddressAtPtx12162, r_PtxU64Register342,
		g_RecordByteAddressAtPtx12174, r_PtxU64Register344, g_RecordByteAddressAtPtx12188,
		r_PtxU64Register346, g_RecordByteAddressAtPtx12202, r_PtxU64Register348;
	uint64_t g_RecordByteAddressAtPtx12214, r_PtxU64Register350, g_RecordByteAddressAtPtx12226,
		r_PtxU64Register352, g_RecordByteAddressAtPtx12238, r_PtxU64Register354,
		g_RecordByteAddressAtPtx12250, r_PtxU64Register356, g_RecordByteAddressAtPtx12262,
		r_PtxU64Register358, g_RecordByteAddressAtPtx12274, r_PtxU64Register360;
	uint64_t g_RecordByteAddressAtPtx12466, r_PtxU64Register362, g_RecordByteAddressAtPtx12475,
		r_PtxU64Register364, g_RecordByteAddressAtPtx12558, r_PtxU64Register366,
		g_RecordByteAddressAtPtx12567, r_PtxU64Register368, g_OutputByteAddressAtPtx12715,
		r_PtxU64Register370, g_OutputByteAddressAtPtx12728, r_PtxU64Register372;
	uint64_t g_OutputByteAddressAtPtx12727, g_RecordByteAddressAtPtx13174, g_RecordByteAddressAtPtx13186,
		g_RecordByteAddressAtPtx13232, g_RecordByteAddressAtPtx13244, r_PtxU64Register378,
		g_RecordByteAddressAtPtx13168, r_PtxU64Register380, g_RecordByteAddressAtPtx13173,
		r_PtxU64Register382, g_RecordByteAddressAtPtx13180, r_PtxU64Register384;
	uint64_t g_RecordByteAddressAtPtx13185, r_PtxU64Register386, g_RecordByteAddressAtPtx13231,
		r_PtxU64Register388, g_RecordByteAddressAtPtx13238, r_PtxU64Register390,
		g_RecordByteAddressAtPtx13243, r_PtxU64Register392, g_DownOutputByteAddressAtPtx13342,
		r_PtxU64Register394, g_DownOutputByteAddressAtPtx13376, r_PtxU64Register396;
	uint64_t g_DownOutputByteAddressAtPtx13411, r_PtxU64Register398, g_DownOutputByteAddressAtPtx13445,
		r_PtxU64Register400, r_PtxU64Register401, r_PtxU64Register402, r_PtxU64Register403,
		r_PtxU64Register404, r_PtxU64Register405, g_DownOutputByteAddressAtPtx13558, r_PtxU64Register407,
		r_PtxU64Register408;
	uint64_t r_PtxU64Register409, r_PtxU64Register410, r_PtxU64Register411, r_PtxU64Register412,
		g_DownOutputByteAddressAtPtx13870, r_PtxU64Register414, r_PtxU64Register415, r_PtxU64Register416,
		r_PtxU64Register417, r_PtxU64Register418, r_PtxU64Register419, g_DownOutputByteAddressAtPtx13901;
	uint64_t r_PtxU64Register421, r_PtxU64Register422, r_PtxU64Register423, r_PtxU64Register424,
		r_PtxU64Register425, r_PtxU64Register426, g_DownOutputByteAddressAtPtx13933, r_PtxU64Register428,
		r_PtxU64Register429, r_PtxU64Register430, r_PtxU64Register431, r_PtxU64Register432;
	uint64_t r_PtxU64Register433, g_DownOutputByteAddressAtPtx13965, r_PtxU64Register435, r_PtxU64Register436,
		r_PtxU64Register437, r_PtxU64Register438, r_PtxU64Register439, r_PtxU64Register440,
		g_DownOutputByteAddressAtPtx13614, r_PtxU64Register442, r_PtxU64Register443, r_PtxU64Register444;
	uint64_t r_PtxU64Register445, r_PtxU64Register446, r_PtxU64Register447, g_DownOutputByteAddressAtPtx13639,
		r_PtxU64Register449, r_PtxU64Register450, r_PtxU64Register451, r_PtxU64Register452,
		r_PtxU64Register453, r_PtxU64Register454, g_DownOutputByteAddressAtPtx13657, r_PtxU64Register456;
	uint64_t r_PtxU64Register457, r_PtxU64Register458, r_PtxU64Register459, r_PtxU64Register460,
		r_PtxU64Register461, g_DownOutputByteAddressAtPtx13675, r_PtxU64Register463, r_PtxU64Register464,
		r_PtxU64Register465, r_PtxU64Register466, r_PtxU64Register467, r_PtxU64Register468;
	uint64_t g_DownOutputByteAddressAtPtx13693, r_PtxU64Register470, r_PtxU64Register471, r_PtxU64Register472,
		r_PtxU64Register473, r_PtxU64Register474, r_PtxU64Register475, g_DownOutputByteAddressAtPtx13737,
		r_PtxU64Register477, r_PtxU64Register478, r_PtxU64Register479, r_PtxU64Register480;
	uint64_t r_PtxU64Register481, r_PtxU64Register482, g_DownOutputByteAddressAtPtx13762, r_PtxU64Register484,
		r_PtxU64Register485, r_PtxU64Register486, r_PtxU64Register487, r_PtxU64Register488,
		r_PtxU64Register489, g_DownOutputByteAddressAtPtx13780, r_PtxU64Register491, r_PtxU64Register492;
	uint64_t r_PtxU64Register493, r_PtxU64Register494, r_PtxU64Register495, r_PtxU64Register496,
		g_DownOutputByteAddressAtPtx13798, r_PtxU64Register498, r_PtxU64Register499, r_PtxU64Register500,
		r_PtxU64Register501, r_PtxU64Register502, r_PtxU64Register503, g_DownOutputByteAddressAtPtx13816;

	// Physical tile64 input and packed-record scalar operands
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	r_DownHeightBits = uint32_t(r_Parameters.DownHeight);
	r_DownWidthBits = uint32_t(r_Parameters.DownWidth);		 // PTX L12
	g_DownOutputBaseAddress = uint64_t(r_Parameters.g_Down); // PTX L13
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);	 // PTX L14
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);	 // PTX L15
	r_HeightBits = uint32_t(r_Parameters.Height);
	r_WidthBits = uint32_t(r_Parameters.Width); // PTX L16
	r_OriginXBits = uint32_t(r_Parameters.OriginX);
	r_OriginYBits = uint32_t(r_Parameters.OriginY);									  // PTX L17
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record);							  // PTX L18
	g_RecordByteAddressAtPtx19 = g_RecordBaseAddress;								  // PTX L19
	r_CtaXAtPtx20 = uint32_t(blockIdx.x);											  // PTX L20
	r_CtaYAtPtx21 = uint32_t(blockIdx.y);											  // PTX L21
	r_PtxRegister88 = ShiftLeft(uint32_t(r_CtaYAtPtx21), uint32_t(3));				  // PTX L22
	r_PtxRegister89 = uint32_t(r_OriginYBits) + uint32_t(r_PtxRegister88);			  // PTX L23
	r_PtxRegister90 = ShiftLeft(uint32_t(r_CtaXAtPtx20), uint32_t(3));				  // PTX L24
	r_PtxRegister1 = uint32_t(r_OriginXBits) + uint32_t(r_PtxRegister90);			  // PTX L25
	r_PtxRegister91 = ShiftRightSigned(int32_t(r_PtxRegister89), uint32_t(31));		  // PTX L26
	r_PtxRegister92 = ShiftRight(uint32_t(r_PtxRegister91), uint32_t(30));			  // PTX L27
	r_PtxRegister93 = uint32_t(r_PtxRegister89) + uint32_t(r_PtxRegister92);		  // PTX L28
	r_PtxRegister2 = ShiftRightSigned(int32_t(r_PtxRegister93), uint32_t(2));		  // PTX L29
	r_PtxRegister94 = ShiftRightSigned(int32_t(r_PtxRegister1), uint32_t(31));		  // PTX L30
	r_PtxRegister95 = ShiftRight(uint32_t(r_PtxRegister94), uint32_t(30));			  // PTX L31
	r_PtxRegister96 = uint32_t(r_PtxRegister1) + uint32_t(r_PtxRegister95);			  // PTX L32
	r_PtxRegister3 = ShiftRightSigned(int32_t(r_PtxRegister96), uint32_t(2));		  // PTX L33
	r_HeightSignBits = ShiftRightSigned(int32_t(r_HeightBits), uint32_t(31));		  // PTX L34
	r_HeightDiv4Bias = ShiftRight(uint32_t(r_HeightSignBits), uint32_t(30));		  // PTX L35
	r_HeightBiasedForDiv4 = uint32_t(r_HeightBits) + uint32_t(r_HeightDiv4Bias);	  // PTX L36
	r_HeightDiv4Bits = ShiftRightSigned(int32_t(r_HeightBiasedForDiv4), uint32_t(2)); // PTX L37
	r_WidthSignBits = ShiftRightSigned(int32_t(r_WidthBits), uint32_t(31));			  // PTX L38
	r_WidthDiv4Bias = ShiftRight(uint32_t(r_WidthSignBits), uint32_t(30));			  // PTX L39
	r_WidthBiasedForDiv4 = uint32_t(r_WidthBits) + uint32_t(r_WidthDiv4Bias);		  // PTX L40
	r_WidthDiv4Bits = ShiftRightSigned(int32_t(r_WidthBiasedForDiv4), uint32_t(2));	  // PTX L41
	r_ThreadYAtPtx42 = uint32_t(threadIdx.y);										  // PTX L42
	r_PtxRegister6 = r_HeightBits & -4;												  // PTX L43
	r_bPtxPredicate7 = uint32_t(r_PtxRegister6) == uint32_t(4);						  // PTX L44
	r_PtxRegister7 = r_WidthBits & -4;												  // PTX L45
	r_PtxRegister8 = uint32_t(r_ThreadYAtPtx42) + uint32_t(r_PtxRegister2);			  // PTX L46
	r_bPtxPredicate291 = bool(-1);													  // PTX L47
	r_bPtxPredicate290 = bool(0);													  // PTX L48
	r_PtxRegister4836 = uint32_t(0);												  // PTX L49
	if (r_bPtxPredicate7)
	{
		goto L__BB11_2;
	} // PTX L50
	r_bPtxPredicate8 = int32_t(r_PtxRegister8) < int32_t(0);				  // PTX L51
	r_bPtxPredicate9 = int32_t(r_PtxRegister8) >= int32_t(r_HeightDiv4Bits);  // PTX L52
	r_bPtxPredicate290 = r_bPtxPredicate8 | r_bPtxPredicate9;				  // PTX L53
	r_PtxRegister4836 = uint32_t(r_PtxRegister8) * uint32_t(r_WidthDiv4Bits); // PTX L54
	r_bPtxPredicate291 = !r_bPtxPredicate290;								  // PTX L55
L__BB11_2:																	  // PTX L56
	r_bPtxPredicate10 = uint32_t(r_PtxRegister7) == uint32_t(4);			  // PTX L57
	r_bPtxPredicate11 = r_bPtxPredicate290 | r_bPtxPredicate10;				  // PTX L58
	r_bPtxPredicate12 = int32_t(r_PtxRegister1) > int32_t(-4);				  // PTX L59
	r_bPtxPredicate13 = int32_t(r_PtxRegister3) < int32_t(r_WidthDiv4Bits);	  // PTX L60
	r_bPtxPredicate1 = r_bPtxPredicate12 & r_bPtxPredicate13;				  // PTX L61
	r_PtxRegister104 = r_bPtxPredicate290 ? r_PtxRegister3 : 0;				  // PTX L62
	r_PtxRegister9 = r_bPtxPredicate10 ? r_PtxRegister104 : r_PtxRegister3;	  // PTX L63
	r_bPtxPredicate14 = r_bPtxPredicate11 | r_bPtxPredicate1;				  // PTX L64
	r_bPtxPredicate15 = r_bPtxPredicate14 & r_bPtxPredicate291;				  // PTX L65
	if (r_bPtxPredicate15)
	{
		goto L__BB11_4;
	} // PTX L66
	goto L__BB11_3;																					// PTX L67
L__BB11_4:																							// PTX L68
	r_PtxRegister108 = uint32_t(r_PtxRegister4836) + uint32_t(r_PtxRegister9);						// PTX L69
	r_PtxRegister109 = ShiftLeft(uint32_t(r_PtxRegister108), uint32_t(8));							// PTX L70
	r_PtxU64Register12 = uint64_t(int64_t(int32_t(r_PtxRegister109)) * int64_t(int32_t(4)));		// PTX L71
	g_StateByteAddressAtPtx72 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register12);		// PTX L72
	r_LaneIndexAtPtx74 = uint32_t((threadIdx.x & 31u));												// PTX L74
	r_PtxU64Register14 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx74)) * int64_t(int32_t(16)));		// PTX L76
	g_StateByteAddressAtPtx77 = uint64_t(g_StateByteAddressAtPtx72) + uint64_t(r_PtxU64Register14); // PTX L77
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_StateByteAddressAtPtx77));
		r_PtxRegister4837 = r_Value.x;
		r_PtxRegister4838 = r_Value.y;
		r_PtxRegister4839 = r_Value.z;
		r_PtxRegister4840 = r_Value.w;
	} // PTX L79
	goto L__BB11_5;																				   // PTX L81
L__BB11_3:																						   // PTX L82
	r_PtxRegister105 = uint32_t(0);																   // PTX L83
	r_PtxU16Register9 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister105)));	   // PTX L85
	r_PackedHalf2AtPtx88R106 = JoinHalfwords(r_PtxU16Register9, r_PtxU16Register9);				   // PTX L88
	r_ConvertedE4PairAtPtx90Rs10 = PublishE4(r_PackedHalf2AtPtx88R106);							   // PTX L90
	r_PtxRegister4837 = JoinHalfwords(r_ConvertedE4PairAtPtx90Rs10, r_ConvertedE4PairAtPtx90Rs10); // PTX L92
	r_PtxRegister4838 = uint32_t(r_PtxRegister4837);											   // PTX L93
	r_PtxRegister4839 = uint32_t(r_PtxRegister4837);											   // PTX L94
	r_PtxRegister4840 = uint32_t(r_PtxRegister4837);											   // PTX L95
L__BB11_5:																						   // PTX L96
	r_bPtxPredicate16 = uint32_t(r_PtxRegister6) == uint32_t(4);								   // PTX L97
	r_PtxU16Register23 = uint16_t(r_PtxRegister4840);
	r_PtxU16Register24 = uint16_t(r_PtxRegister4840 >> 16); // PTX L98
	r_PtxU16Register21 = uint16_t(r_PtxRegister4839);
	r_PtxU16Register22 = uint16_t(r_PtxRegister4839 >> 16); // PTX L99
	r_PtxU16Register19 = uint16_t(r_PtxRegister4838);
	r_PtxU16Register20 = uint16_t(r_PtxRegister4838 >> 16); // PTX L100
	r_PtxU16Register17 = uint16_t(r_PtxRegister4837);
	r_PtxU16Register18 = uint16_t(r_PtxRegister4837 >> 16); // PTX L101
	r_bPtxPredicate293 = bool(-1);							// PTX L102
	r_bPtxPredicate292 = bool(0);							// PTX L103
	r_PtxRegister4841 = uint32_t(0);						// PTX L104
	if (r_bPtxPredicate16)
	{
		goto L__BB11_7;
	} // PTX L105
	r_bPtxPredicate17 = int32_t(r_PtxRegister8) < int32_t(0);				  // PTX L106
	r_bPtxPredicate18 = int32_t(r_PtxRegister8) >= int32_t(r_HeightDiv4Bits); // PTX L107
	r_bPtxPredicate292 = r_bPtxPredicate17 | r_bPtxPredicate18;				  // PTX L108
	r_PtxRegister4841 = uint32_t(r_PtxRegister8) * uint32_t(r_WidthDiv4Bits); // PTX L109
	r_bPtxPredicate293 = !r_bPtxPredicate292;								  // PTX L110
L__BB11_7:																	  // PTX L111
	r_bPtxPredicate19 = uint32_t(r_PtxRegister7) == uint32_t(4);			  // PTX L112
	r_bPtxPredicate20 = r_bPtxPredicate292 | r_bPtxPredicate19;				  // PTX L113
	r_PtxRegister110 = r_bPtxPredicate292 ? r_PtxRegister3 : 0;				  // PTX L114
	r_PtxRegister10 = r_bPtxPredicate19 ? r_PtxRegister110 : r_PtxRegister3;  // PTX L115
	r_bPtxPredicate21 = r_bPtxPredicate20 | r_bPtxPredicate1;				  // PTX L116
	r_bPtxPredicate22 = r_bPtxPredicate21 & r_bPtxPredicate293;				  // PTX L117
	if (r_bPtxPredicate22)
	{
		goto L__BB11_9;
	} // PTX L118
	goto L__BB11_8;																				 // PTX L119
L__BB11_9:																						 // PTX L120
	r_PtxRegister114 = uint32_t(r_PtxRegister4841) + uint32_t(r_PtxRegister10);					 // PTX L121
	r_PtxRegister115 = ShiftLeft(uint32_t(r_PtxRegister114), uint32_t(8));						 // PTX L122
	r_PtxU64Register16 = uint64_t(int64_t(int32_t(r_PtxRegister115)) * int64_t(int32_t(4)));	 // PTX L123
	g_StateByteAddressAtPtx124 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register16);	 // PTX L124
	r_LaneIndexAtPtx126 = uint32_t((threadIdx.x & 31u));										 // PTX L126
	r_PtxU64Register18 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx126)) * int64_t(int32_t(16))); // PTX L128
	g_StateByteAddressAtPtx129 =
		uint64_t(g_StateByteAddressAtPtx124) + uint64_t(r_PtxU64Register18);		   // PTX L129
	g_StateByteAddressAtPtx130 = uint64_t(g_StateByteAddressAtPtx129) + uint64_t(512); // PTX L130
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_StateByteAddressAtPtx130));
		r_PtxRegister4842 = r_Value.x;
		r_PtxRegister4843 = r_Value.y;
		r_PtxRegister4844 = r_Value.z;
		r_PtxRegister4845 = r_Value.w;
	} // PTX L132
	goto L__BB11_10;																		   // PTX L134
L__BB11_8:																					   // PTX L135
	r_PtxRegister111 = uint32_t(0);															   // PTX L136
	r_PtxU16Register11 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister111))); // PTX L138
	r_PackedHalf2AtPtx141R112 = JoinHalfwords(r_PtxU16Register11, r_PtxU16Register11);		   // PTX L141
	r_ConvertedE4PairAtPtx143Rs12 = PublishE4(r_PackedHalf2AtPtx141R112);					   // PTX L143
	r_PtxRegister4842 =
		JoinHalfwords(r_ConvertedE4PairAtPtx143Rs12, r_ConvertedE4PairAtPtx143Rs12); // PTX L145
	r_PtxRegister4843 = uint32_t(r_PtxRegister4842);								 // PTX L146
	r_PtxRegister4844 = uint32_t(r_PtxRegister4842);								 // PTX L147
	r_PtxRegister4845 = uint32_t(r_PtxRegister4842);								 // PTX L148
L__BB11_10:																			 // PTX L149
	r_bPtxPredicate23 = uint32_t(r_PtxRegister6) == uint32_t(4);					 // PTX L150
	r_PtxU16Register31 = uint16_t(r_PtxRegister4845);
	r_PtxU16Register32 = uint16_t(r_PtxRegister4845 >> 16); // PTX L151
	r_PtxU16Register29 = uint16_t(r_PtxRegister4844);
	r_PtxU16Register30 = uint16_t(r_PtxRegister4844 >> 16); // PTX L152
	r_PtxU16Register27 = uint16_t(r_PtxRegister4843);
	r_PtxU16Register28 = uint16_t(r_PtxRegister4843 >> 16); // PTX L153
	r_PtxU16Register25 = uint16_t(r_PtxRegister4842);
	r_PtxU16Register26 = uint16_t(r_PtxRegister4842 >> 16);	  // PTX L154
	r_PtxRegister11 = uint32_t(r_PtxRegister3) + uint32_t(1); // PTX L155
	r_bPtxPredicate295 = bool(-1);							  // PTX L156
	r_bPtxPredicate294 = bool(0);							  // PTX L157
	r_PtxRegister4846 = uint32_t(0);						  // PTX L158
	if (r_bPtxPredicate23)
	{
		goto L__BB11_12;
	} // PTX L159
	r_bPtxPredicate24 = int32_t(r_PtxRegister8) < int32_t(0);				  // PTX L160
	r_bPtxPredicate25 = int32_t(r_PtxRegister8) >= int32_t(r_HeightDiv4Bits); // PTX L161
	r_bPtxPredicate294 = r_bPtxPredicate24 | r_bPtxPredicate25;				  // PTX L162
	r_PtxRegister4846 = uint32_t(r_PtxRegister8) * uint32_t(r_WidthDiv4Bits); // PTX L163
	r_bPtxPredicate295 = !r_bPtxPredicate294;								  // PTX L164
L__BB11_12:																	  // PTX L165
	r_bPtxPredicate26 = uint32_t(r_PtxRegister7) == uint32_t(4);			  // PTX L166
	r_bPtxPredicate27 = r_bPtxPredicate294 | r_bPtxPredicate26;				  // PTX L167
	r_bPtxPredicate28 = int32_t(r_PtxRegister1) > int32_t(-8);				  // PTX L168
	r_bPtxPredicate29 = int32_t(r_PtxRegister11) < int32_t(r_WidthDiv4Bits);  // PTX L169
	r_bPtxPredicate2 = r_bPtxPredicate28 & r_bPtxPredicate29;				  // PTX L170
	r_PtxRegister116 = r_bPtxPredicate294 ? r_PtxRegister11 : 0;			  // PTX L171
	r_PtxRegister12 = r_bPtxPredicate26 ? r_PtxRegister116 : r_PtxRegister11; // PTX L172
	r_bPtxPredicate30 = r_bPtxPredicate27 | r_bPtxPredicate2;				  // PTX L173
	r_bPtxPredicate31 = r_bPtxPredicate30 & r_bPtxPredicate295;				  // PTX L174
	if (r_bPtxPredicate31)
	{
		goto L__BB11_14;
	} // PTX L175
	goto L__BB11_13;																			 // PTX L176
L__BB11_14:																						 // PTX L177
	r_PtxRegister120 = uint32_t(r_PtxRegister4846) + uint32_t(r_PtxRegister12);					 // PTX L178
	r_PtxRegister121 = ShiftLeft(uint32_t(r_PtxRegister120), uint32_t(8));						 // PTX L179
	r_PtxU64Register21 = uint64_t(int64_t(int32_t(r_PtxRegister121)) * int64_t(int32_t(4)));	 // PTX L180
	g_StateByteAddressAtPtx181 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register21);	 // PTX L181
	r_LaneIndexAtPtx183 = uint32_t((threadIdx.x & 31u));										 // PTX L183
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx183)) * int64_t(int32_t(16))); // PTX L185
	g_StateByteAddressAtPtx186 =
		uint64_t(g_StateByteAddressAtPtx181) + uint64_t(r_PtxU64Register23); // PTX L186
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_StateByteAddressAtPtx186));
		r_PtxRegister4847 = r_Value.x;
		r_PtxRegister4848 = r_Value.y;
		r_PtxRegister4849 = r_Value.z;
		r_PtxRegister4850 = r_Value.w;
	} // PTX L188
	goto L__BB11_15;																		   // PTX L190
L__BB11_13:																					   // PTX L191
	r_PtxRegister117 = uint32_t(0);															   // PTX L192
	r_PtxU16Register13 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister117))); // PTX L194
	r_PackedHalf2AtPtx197R118 = JoinHalfwords(r_PtxU16Register13, r_PtxU16Register13);		   // PTX L197
	r_ConvertedE4PairAtPtx199Rs14 = PublishE4(r_PackedHalf2AtPtx197R118);					   // PTX L199
	r_PtxRegister4847 =
		JoinHalfwords(r_ConvertedE4PairAtPtx199Rs14, r_ConvertedE4PairAtPtx199Rs14); // PTX L201
	r_PtxRegister4848 = uint32_t(r_PtxRegister4847);								 // PTX L202
	r_PtxRegister4849 = uint32_t(r_PtxRegister4847);								 // PTX L203
	r_PtxRegister4850 = uint32_t(r_PtxRegister4847);								 // PTX L204
L__BB11_15:																			 // PTX L205
	r_bPtxPredicate32 = uint32_t(r_PtxRegister6) == uint32_t(4);					 // PTX L206
	r_PtxU16Register39 = uint16_t(r_PtxRegister4850);
	r_PtxU16Register40 = uint16_t(r_PtxRegister4850 >> 16); // PTX L207
	r_PtxU16Register37 = uint16_t(r_PtxRegister4849);
	r_PtxU16Register38 = uint16_t(r_PtxRegister4849 >> 16); // PTX L208
	r_PtxU16Register35 = uint16_t(r_PtxRegister4848);
	r_PtxU16Register36 = uint16_t(r_PtxRegister4848 >> 16); // PTX L209
	r_PtxU16Register33 = uint16_t(r_PtxRegister4847);
	r_PtxU16Register34 = uint16_t(r_PtxRegister4847 >> 16); // PTX L210
	r_bPtxPredicate297 = bool(-1);							// PTX L211
	r_bPtxPredicate296 = bool(0);							// PTX L212
	r_PtxRegister4851 = uint32_t(0);						// PTX L213
	if (r_bPtxPredicate32)
	{
		goto L__BB11_17;
	} // PTX L214
	r_bPtxPredicate33 = int32_t(r_PtxRegister8) < int32_t(0);				  // PTX L215
	r_bPtxPredicate34 = int32_t(r_PtxRegister8) >= int32_t(r_HeightDiv4Bits); // PTX L216
	r_bPtxPredicate296 = r_bPtxPredicate33 | r_bPtxPredicate34;				  // PTX L217
	r_PtxRegister4851 = uint32_t(r_PtxRegister8) * uint32_t(r_WidthDiv4Bits); // PTX L218
	r_bPtxPredicate297 = !r_bPtxPredicate296;								  // PTX L219
L__BB11_17:																	  // PTX L220
	r_bPtxPredicate35 = uint32_t(r_PtxRegister7) == uint32_t(4);			  // PTX L221
	r_bPtxPredicate36 = r_bPtxPredicate296 | r_bPtxPredicate35;				  // PTX L222
	r_PtxRegister122 = r_bPtxPredicate296 ? r_PtxRegister11 : 0;			  // PTX L223
	r_PtxRegister13 = r_bPtxPredicate35 ? r_PtxRegister122 : r_PtxRegister11; // PTX L224
	r_bPtxPredicate37 = r_bPtxPredicate36 | r_bPtxPredicate2;				  // PTX L225
	r_bPtxPredicate38 = r_bPtxPredicate37 & r_bPtxPredicate297;				  // PTX L226
	if (r_bPtxPredicate38)
	{
		goto L__BB11_19;
	} // PTX L227
	goto L__BB11_18;																			 // PTX L228
L__BB11_19:																						 // PTX L229
	r_PtxRegister126 = uint32_t(r_PtxRegister4851) + uint32_t(r_PtxRegister13);					 // PTX L230
	r_PtxRegister127 = ShiftLeft(uint32_t(r_PtxRegister126), uint32_t(8));						 // PTX L231
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_PtxRegister127)) * int64_t(int32_t(4)));	 // PTX L232
	g_StateByteAddressAtPtx233 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register25);	 // PTX L233
	r_LaneIndexAtPtx235 = uint32_t((threadIdx.x & 31u));										 // PTX L235
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx235)) * int64_t(int32_t(16))); // PTX L237
	g_StateByteAddressAtPtx238 =
		uint64_t(g_StateByteAddressAtPtx233) + uint64_t(r_PtxU64Register27);		   // PTX L238
	g_StateByteAddressAtPtx239 = uint64_t(g_StateByteAddressAtPtx238) + uint64_t(512); // PTX L239
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_StateByteAddressAtPtx239));
		r_PtxRegister4852 = r_Value.x;
		r_PtxRegister4853 = r_Value.y;
		r_PtxRegister4854 = r_Value.z;
		r_PtxRegister4855 = r_Value.w;
	} // PTX L241
	goto L__BB11_20;																		   // PTX L243
L__BB11_18:																					   // PTX L244
	r_PtxRegister123 = uint32_t(0);															   // PTX L245
	r_PtxU16Register15 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister123))); // PTX L247
	r_PackedHalf2AtPtx250R124 = JoinHalfwords(r_PtxU16Register15, r_PtxU16Register15);		   // PTX L250
	r_ConvertedE4PairAtPtx252Rs16 = PublishE4(r_PackedHalf2AtPtx250R124);					   // PTX L252
	r_PtxRegister4852 =
		JoinHalfwords(r_ConvertedE4PairAtPtx252Rs16, r_ConvertedE4PairAtPtx252Rs16); // PTX L254
	r_PtxRegister4853 = uint32_t(r_PtxRegister4852);								 // PTX L255
	r_PtxRegister4854 = uint32_t(r_PtxRegister4852);								 // PTX L256
	r_PtxRegister4855 = uint32_t(r_PtxRegister4852);								 // PTX L257
L__BB11_20:																			 // PTX L258
	r_PackedHalf2AtPtx260R414 = DecodeE4(r_PtxU16Register17);						 // PTX L260
	r_PackedHalf2AtPtx263R415 = DecodeE4(r_PtxU16Register18);						 // PTX L263
	r_PackedHalf2AtPtx266R416 = DecodeE4(r_PtxU16Register19);						 // PTX L266
	r_PackedHalf2AtPtx269R417 = DecodeE4(r_PtxU16Register20);						 // PTX L269
	r_PackedHalf2AtPtx272R418 = DecodeE4(r_PtxU16Register21);						 // PTX L272
	r_PackedHalf2AtPtx275R419 = DecodeE4(r_PtxU16Register22);						 // PTX L275
	r_PackedHalf2AtPtx278R420 = DecodeE4(r_PtxU16Register23);						 // PTX L278
	r_PackedHalf2AtPtx281R421 = DecodeE4(r_PtxU16Register24);						 // PTX L281
	r_PackedHalf2AtPtx284R448 = DecodeE4(r_PtxU16Register25);						 // PTX L284
	r_PackedHalf2AtPtx287R449 = DecodeE4(r_PtxU16Register26);						 // PTX L287
	r_PackedHalf2AtPtx290R450 = DecodeE4(r_PtxU16Register27);						 // PTX L290
	r_PackedHalf2AtPtx293R451 = DecodeE4(r_PtxU16Register28);						 // PTX L293
	r_PackedHalf2AtPtx296R452 = DecodeE4(r_PtxU16Register29);						 // PTX L296
	r_PackedHalf2AtPtx299R453 = DecodeE4(r_PtxU16Register30);						 // PTX L299
	r_PackedHalf2AtPtx302R454 = DecodeE4(r_PtxU16Register31);						 // PTX L302
	r_PackedHalf2AtPtx305R455 = DecodeE4(r_PtxU16Register32);						 // PTX L305
	r_PackedHalf2AtPtx308R422 = DecodeE4(r_PtxU16Register33);						 // PTX L308
	r_PackedHalf2AtPtx311R423 = DecodeE4(r_PtxU16Register34);						 // PTX L311
	r_PackedHalf2AtPtx314R424 = DecodeE4(r_PtxU16Register35);						 // PTX L314
	r_PackedHalf2AtPtx317R425 = DecodeE4(r_PtxU16Register36);						 // PTX L317
	r_PackedHalf2AtPtx320R426 = DecodeE4(r_PtxU16Register37);						 // PTX L320
	r_PackedHalf2AtPtx323R427 = DecodeE4(r_PtxU16Register38);						 // PTX L323
	r_PackedHalf2AtPtx326R428 = DecodeE4(r_PtxU16Register39);						 // PTX L326
	r_PackedHalf2AtPtx329R429 = DecodeE4(r_PtxU16Register40);						 // PTX L329
	r_PtxU16Register41 = uint16_t(r_PtxRegister4852);
	r_PtxU16Register42 = uint16_t(r_PtxRegister4852 >> 16);	  // PTX L331
	r_PackedHalf2AtPtx333R456 = DecodeE4(r_PtxU16Register41); // PTX L333
	r_PackedHalf2AtPtx336R457 = DecodeE4(r_PtxU16Register42); // PTX L336
	r_PtxU16Register43 = uint16_t(r_PtxRegister4853);
	r_PtxU16Register44 = uint16_t(r_PtxRegister4853 >> 16);	  // PTX L338
	r_PackedHalf2AtPtx340R458 = DecodeE4(r_PtxU16Register43); // PTX L340
	r_PackedHalf2AtPtx343R459 = DecodeE4(r_PtxU16Register44); // PTX L343
	r_PtxU16Register45 = uint16_t(r_PtxRegister4854);
	r_PtxU16Register46 = uint16_t(r_PtxRegister4854 >> 16);	  // PTX L345
	r_PackedHalf2AtPtx347R460 = DecodeE4(r_PtxU16Register45); // PTX L347
	r_PackedHalf2AtPtx350R461 = DecodeE4(r_PtxU16Register46); // PTX L350
	r_PtxU16Register47 = uint16_t(r_PtxRegister4855);
	r_PtxU16Register48 = uint16_t(r_PtxRegister4855 >> 16);									 // PTX L352
	r_PackedHalf2AtPtx354R462 = DecodeE4(r_PtxU16Register47);								 // PTX L354
	r_PackedHalf2AtPtx357R463 = DecodeE4(r_PtxU16Register48);								 // PTX L357
	r_LaneIndexAtPtx360 = uint32_t((threadIdx.x & 31u));									 // PTX L360
	r_PtxRegister224 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx360), uint32_t(31));		 // PTX L362
	r_PtxRegister225 = ShiftRight(uint32_t(r_PtxRegister224), uint32_t(30));				 // PTX L363
	r_PtxRegister226 = uint32_t(r_LaneIndexAtPtx360) + uint32_t(r_PtxRegister225);			 // PTX L364
	r_PtxRegister227 = r_PtxRegister226 & -4;												 // PTX L365
	r_PtxRegister228 = uint32_t(r_LaneIndexAtPtx360) - uint32_t(r_PtxRegister227);			 // PTX L366
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_PtxRegister228)) * int64_t(int32_t(4))); // PTX L367
	g_RecordByteAddressAtPtx368 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register29);					   // PTX L368
	r_PtxRegister161 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx368 + 28688ull); // PTX L369
	r_LaneIndexAtPtx371 = uint32_t((threadIdx.x & 31u));										   // PTX L371
	r_PtxRegister229 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx371), uint32_t(31));			   // PTX L373
	r_PtxRegister230 = ShiftRight(uint32_t(r_PtxRegister229), uint32_t(30));					   // PTX L374
	r_PtxRegister231 = uint32_t(r_LaneIndexAtPtx371) + uint32_t(r_PtxRegister230);				   // PTX L375
	r_PtxRegister232 = r_PtxRegister231 & -4;													   // PTX L376
	r_PtxRegister233 = uint32_t(r_LaneIndexAtPtx371) - uint32_t(r_PtxRegister232);				   // PTX L377
	r_PtxU64Register31 = uint64_t(int64_t(int32_t(r_PtxRegister233)) * int64_t(int32_t(4)));	   // PTX L378
	g_RecordByteAddressAtPtx379 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register31);					   // PTX L379
	r_PtxRegister163 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx379 + 28688ull); // PTX L380
	r_LaneIndexAtPtx382 = uint32_t((threadIdx.x & 31u));										   // PTX L382
	r_PtxRegister234 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx382), uint32_t(31));			   // PTX L384
	r_PtxRegister235 = ShiftRight(uint32_t(r_PtxRegister234), uint32_t(30));					   // PTX L385
	r_PtxRegister236 = uint32_t(r_LaneIndexAtPtx382) + uint32_t(r_PtxRegister235);				   // PTX L386
	r_PtxRegister237 = r_PtxRegister236 & -4;													   // PTX L387
	r_PtxRegister238 = uint32_t(r_LaneIndexAtPtx382) - uint32_t(r_PtxRegister237);				   // PTX L388
	r_PtxRegister239 = uint32_t(r_PtxRegister238) + uint32_t(4);								   // PTX L389
	r_PtxU64Register33 = uint64_t(uint32_t(r_PtxRegister239)) * uint64_t(uint32_t(4));			   // PTX L390
	g_RecordByteAddressAtPtx391 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register33);					   // PTX L391
	r_PtxRegister165 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx391 + 28688ull); // PTX L392
	r_LaneIndexAtPtx394 = uint32_t((threadIdx.x & 31u));										   // PTX L394
	r_PtxRegister240 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx394), uint32_t(31));			   // PTX L396
	r_PtxRegister241 = ShiftRight(uint32_t(r_PtxRegister240), uint32_t(30));					   // PTX L397
	r_PtxRegister242 = uint32_t(r_LaneIndexAtPtx394) + uint32_t(r_PtxRegister241);				   // PTX L398
	r_PtxRegister243 = r_PtxRegister242 & -4;													   // PTX L399
	r_PtxRegister244 = uint32_t(r_LaneIndexAtPtx394) - uint32_t(r_PtxRegister243);				   // PTX L400
	r_PtxRegister245 = uint32_t(r_PtxRegister244) + uint32_t(4);								   // PTX L401
	r_PtxU64Register35 = uint64_t(uint32_t(r_PtxRegister245)) * uint64_t(uint32_t(4));			   // PTX L402
	g_RecordByteAddressAtPtx403 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register35);					   // PTX L403
	r_PtxRegister167 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx403 + 28688ull); // PTX L404
	r_LaneIndexAtPtx406 = uint32_t((threadIdx.x & 31u));										   // PTX L406
	r_PtxRegister246 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx406), uint32_t(31));			   // PTX L408
	r_PtxRegister247 = ShiftRight(uint32_t(r_PtxRegister246), uint32_t(30));					   // PTX L409
	r_PtxRegister248 = uint32_t(r_LaneIndexAtPtx406) + uint32_t(r_PtxRegister247);				   // PTX L410
	r_PtxRegister249 = r_PtxRegister248 & -4;													   // PTX L411
	r_PtxRegister250 = uint32_t(r_LaneIndexAtPtx406) - uint32_t(r_PtxRegister249);				   // PTX L412
	r_PtxRegister251 = uint32_t(r_PtxRegister250) + uint32_t(8);								   // PTX L413
	r_PtxU64Register37 = uint64_t(uint32_t(r_PtxRegister251)) * uint64_t(uint32_t(4));			   // PTX L414
	g_RecordByteAddressAtPtx415 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register37);					   // PTX L415
	r_PtxRegister169 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx415 + 28688ull); // PTX L416
	r_LaneIndexAtPtx418 = uint32_t((threadIdx.x & 31u));										   // PTX L418
	r_PtxRegister252 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx418), uint32_t(31));			   // PTX L420
	r_PtxRegister253 = ShiftRight(uint32_t(r_PtxRegister252), uint32_t(30));					   // PTX L421
	r_PtxRegister254 = uint32_t(r_LaneIndexAtPtx418) + uint32_t(r_PtxRegister253);				   // PTX L422
	r_PtxRegister255 = r_PtxRegister254 & -4;													   // PTX L423
	r_PtxRegister256 = uint32_t(r_LaneIndexAtPtx418) - uint32_t(r_PtxRegister255);				   // PTX L424
	r_PtxRegister257 = uint32_t(r_PtxRegister256) + uint32_t(8);								   // PTX L425
	r_PtxU64Register39 = uint64_t(uint32_t(r_PtxRegister257)) * uint64_t(uint32_t(4));			   // PTX L426
	g_RecordByteAddressAtPtx427 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register39);					   // PTX L427
	r_PtxRegister171 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx427 + 28688ull); // PTX L428
	r_LaneIndexAtPtx430 = uint32_t((threadIdx.x & 31u));										   // PTX L430
	r_PtxRegister258 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx430), uint32_t(31));			   // PTX L432
	r_PtxRegister259 = ShiftRight(uint32_t(r_PtxRegister258), uint32_t(30));					   // PTX L433
	r_PtxRegister260 = uint32_t(r_LaneIndexAtPtx430) + uint32_t(r_PtxRegister259);				   // PTX L434
	r_PtxRegister261 = r_PtxRegister260 & -4;													   // PTX L435
	r_PtxRegister262 = uint32_t(r_LaneIndexAtPtx430) - uint32_t(r_PtxRegister261);				   // PTX L436
	r_PtxRegister263 = uint32_t(r_PtxRegister262) + uint32_t(12);								   // PTX L437
	r_PtxU64Register41 = uint64_t(uint32_t(r_PtxRegister263)) * uint64_t(uint32_t(4));			   // PTX L438
	g_RecordByteAddressAtPtx439 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register41);					   // PTX L439
	r_PtxRegister173 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx439 + 28688ull); // PTX L440
	r_LaneIndexAtPtx442 = uint32_t((threadIdx.x & 31u));										   // PTX L442
	r_PtxRegister264 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx442), uint32_t(31));			   // PTX L444
	r_PtxRegister265 = ShiftRight(uint32_t(r_PtxRegister264), uint32_t(30));					   // PTX L445
	r_PtxRegister266 = uint32_t(r_LaneIndexAtPtx442) + uint32_t(r_PtxRegister265);				   // PTX L446
	r_PtxRegister267 = r_PtxRegister266 & -4;													   // PTX L447
	r_PtxRegister268 = uint32_t(r_LaneIndexAtPtx442) - uint32_t(r_PtxRegister267);				   // PTX L448
	r_PtxRegister269 = uint32_t(r_PtxRegister268) + uint32_t(12);								   // PTX L449
	r_PtxU64Register43 = uint64_t(uint32_t(r_PtxRegister269)) * uint64_t(uint32_t(4));			   // PTX L450
	g_RecordByteAddressAtPtx451 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register43);					   // PTX L451
	r_PtxRegister175 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx451 + 28688ull); // PTX L452
	r_LaneIndexAtPtx454 = uint32_t((threadIdx.x & 31u));										   // PTX L454
	r_PtxRegister270 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx454), uint32_t(31));			   // PTX L456
	r_PtxRegister271 = ShiftRight(uint32_t(r_PtxRegister270), uint32_t(30));					   // PTX L457
	r_PtxRegister272 = uint32_t(r_LaneIndexAtPtx454) + uint32_t(r_PtxRegister271);				   // PTX L458
	r_PtxRegister273 = r_PtxRegister272 & -4;													   // PTX L459
	r_PtxRegister274 = uint32_t(r_LaneIndexAtPtx454) - uint32_t(r_PtxRegister273);				   // PTX L460
	r_PtxRegister275 = uint32_t(r_PtxRegister274) + uint32_t(16);								   // PTX L461
	r_PtxU64Register45 = uint64_t(uint32_t(r_PtxRegister275)) * uint64_t(uint32_t(4));			   // PTX L462
	g_RecordByteAddressAtPtx463 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register45);					   // PTX L463
	r_PtxRegister177 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx463 + 28688ull); // PTX L464
	r_LaneIndexAtPtx466 = uint32_t((threadIdx.x & 31u));										   // PTX L466
	r_PtxRegister276 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx466), uint32_t(31));			   // PTX L468
	r_PtxRegister277 = ShiftRight(uint32_t(r_PtxRegister276), uint32_t(30));					   // PTX L469
	r_PtxRegister278 = uint32_t(r_LaneIndexAtPtx466) + uint32_t(r_PtxRegister277);				   // PTX L470
	r_PtxRegister279 = r_PtxRegister278 & -4;													   // PTX L471
	r_PtxRegister280 = uint32_t(r_LaneIndexAtPtx466) - uint32_t(r_PtxRegister279);				   // PTX L472
	r_PtxRegister281 = uint32_t(r_PtxRegister280) + uint32_t(16);								   // PTX L473
	r_PtxU64Register47 = uint64_t(uint32_t(r_PtxRegister281)) * uint64_t(uint32_t(4));			   // PTX L474
	g_RecordByteAddressAtPtx475 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register47);					   // PTX L475
	r_PtxRegister179 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx475 + 28688ull); // PTX L476
	r_LaneIndexAtPtx478 = uint32_t((threadIdx.x & 31u));										   // PTX L478
	r_PtxRegister282 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx478), uint32_t(31));			   // PTX L480
	r_PtxRegister283 = ShiftRight(uint32_t(r_PtxRegister282), uint32_t(30));					   // PTX L481
	r_PtxRegister284 = uint32_t(r_LaneIndexAtPtx478) + uint32_t(r_PtxRegister283);				   // PTX L482
	r_PtxRegister285 = r_PtxRegister284 & -4;													   // PTX L483
	r_PtxRegister286 = uint32_t(r_LaneIndexAtPtx478) - uint32_t(r_PtxRegister285);				   // PTX L484
	r_PtxRegister287 = uint32_t(r_PtxRegister286) + uint32_t(20);								   // PTX L485
	r_PtxU64Register49 = uint64_t(uint32_t(r_PtxRegister287)) * uint64_t(uint32_t(4));			   // PTX L486
	g_RecordByteAddressAtPtx487 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register49);					   // PTX L487
	r_PtxRegister181 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx487 + 28688ull); // PTX L488
	r_LaneIndexAtPtx490 = uint32_t((threadIdx.x & 31u));										   // PTX L490
	r_PtxRegister288 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx490), uint32_t(31));			   // PTX L492
	r_PtxRegister289 = ShiftRight(uint32_t(r_PtxRegister288), uint32_t(30));					   // PTX L493
	r_PtxRegister290 = uint32_t(r_LaneIndexAtPtx490) + uint32_t(r_PtxRegister289);				   // PTX L494
	r_PtxRegister291 = r_PtxRegister290 & -4;													   // PTX L495
	r_PtxRegister292 = uint32_t(r_LaneIndexAtPtx490) - uint32_t(r_PtxRegister291);				   // PTX L496
	r_PtxRegister293 = uint32_t(r_PtxRegister292) + uint32_t(20);								   // PTX L497
	r_PtxU64Register51 = uint64_t(uint32_t(r_PtxRegister293)) * uint64_t(uint32_t(4));			   // PTX L498
	g_RecordByteAddressAtPtx499 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register51);					   // PTX L499
	r_PtxRegister183 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx499 + 28688ull); // PTX L500
	r_LaneIndexAtPtx502 = uint32_t((threadIdx.x & 31u));										   // PTX L502
	r_PtxRegister294 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx502), uint32_t(31));			   // PTX L504
	r_PtxRegister295 = ShiftRight(uint32_t(r_PtxRegister294), uint32_t(30));					   // PTX L505
	r_PtxRegister296 = uint32_t(r_LaneIndexAtPtx502) + uint32_t(r_PtxRegister295);				   // PTX L506
	r_PtxRegister297 = r_PtxRegister296 & -4;													   // PTX L507
	r_PtxRegister298 = uint32_t(r_LaneIndexAtPtx502) - uint32_t(r_PtxRegister297);				   // PTX L508
	r_PtxRegister299 = uint32_t(r_PtxRegister298) + uint32_t(24);								   // PTX L509
	r_PtxU64Register53 = uint64_t(uint32_t(r_PtxRegister299)) * uint64_t(uint32_t(4));			   // PTX L510
	g_RecordByteAddressAtPtx511 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register53);					   // PTX L511
	r_PtxRegister185 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx511 + 28688ull); // PTX L512
	r_LaneIndexAtPtx514 = uint32_t((threadIdx.x & 31u));										   // PTX L514
	r_PtxRegister300 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx514), uint32_t(31));			   // PTX L516
	r_PtxRegister301 = ShiftRight(uint32_t(r_PtxRegister300), uint32_t(30));					   // PTX L517
	r_PtxRegister302 = uint32_t(r_LaneIndexAtPtx514) + uint32_t(r_PtxRegister301);				   // PTX L518
	r_PtxRegister303 = r_PtxRegister302 & -4;													   // PTX L519
	r_PtxRegister304 = uint32_t(r_LaneIndexAtPtx514) - uint32_t(r_PtxRegister303);				   // PTX L520
	r_PtxRegister305 = uint32_t(r_PtxRegister304) + uint32_t(24);								   // PTX L521
	r_PtxU64Register55 = uint64_t(uint32_t(r_PtxRegister305)) * uint64_t(uint32_t(4));			   // PTX L522
	g_RecordByteAddressAtPtx523 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register55);					   // PTX L523
	r_PtxRegister187 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx523 + 28688ull); // PTX L524
	r_LaneIndexAtPtx526 = uint32_t((threadIdx.x & 31u));										   // PTX L526
	r_PtxRegister306 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx526), uint32_t(31));			   // PTX L528
	r_PtxRegister307 = ShiftRight(uint32_t(r_PtxRegister306), uint32_t(30));					   // PTX L529
	r_PtxRegister308 = uint32_t(r_LaneIndexAtPtx526) + uint32_t(r_PtxRegister307);				   // PTX L530
	r_PtxRegister309 = r_PtxRegister308 & -4;													   // PTX L531
	r_PtxRegister310 = uint32_t(r_LaneIndexAtPtx526) - uint32_t(r_PtxRegister309);				   // PTX L532
	r_PtxRegister311 = uint32_t(r_PtxRegister310) + uint32_t(28);								   // PTX L533
	r_PtxU64Register57 = uint64_t(uint32_t(r_PtxRegister311)) * uint64_t(uint32_t(4));			   // PTX L534
	g_RecordByteAddressAtPtx535 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register57);					   // PTX L535
	r_PtxRegister189 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx535 + 28688ull); // PTX L536
	r_LaneIndexAtPtx538 = uint32_t((threadIdx.x & 31u));										   // PTX L538
	r_PtxRegister312 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx538), uint32_t(31));			   // PTX L540
	r_PtxRegister313 = ShiftRight(uint32_t(r_PtxRegister312), uint32_t(30));					   // PTX L541
	r_PtxRegister314 = uint32_t(r_LaneIndexAtPtx538) + uint32_t(r_PtxRegister313);				   // PTX L542
	r_PtxRegister315 = r_PtxRegister314 & -4;													   // PTX L543
	r_PtxRegister316 = uint32_t(r_LaneIndexAtPtx538) - uint32_t(r_PtxRegister315);				   // PTX L544
	r_PtxRegister317 = uint32_t(r_PtxRegister316) + uint32_t(28);								   // PTX L545
	r_PtxU64Register59 = uint64_t(uint32_t(r_PtxRegister317)) * uint64_t(uint32_t(4));			   // PTX L546
	g_RecordByteAddressAtPtx547 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register59);					   // PTX L547
	r_PtxRegister191 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx547 + 28688ull); // PTX L548
	r_LaneIndexAtPtx550 = uint32_t((threadIdx.x & 31u));										   // PTX L550
	r_PtxRegister318 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx550), uint32_t(31));			   // PTX L552
	r_PtxRegister319 = ShiftRight(uint32_t(r_PtxRegister318), uint32_t(30));					   // PTX L553
	r_PtxRegister320 = uint32_t(r_LaneIndexAtPtx550) + uint32_t(r_PtxRegister319);				   // PTX L554
	r_PtxRegister321 = r_PtxRegister320 & -4;													   // PTX L555
	r_PtxRegister322 = uint32_t(r_LaneIndexAtPtx550) - uint32_t(r_PtxRegister321);				   // PTX L556
	r_PtxU64Register61 = uint64_t(int64_t(int32_t(r_PtxRegister322)) * int64_t(int32_t(4)));	   // PTX L557
	g_RecordByteAddressAtPtx558 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register61);					   // PTX L558
	r_PtxRegister193 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx558 + 28688ull); // PTX L559
	r_LaneIndexAtPtx561 = uint32_t((threadIdx.x & 31u));										   // PTX L561
	r_PtxRegister323 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx561), uint32_t(31));			   // PTX L563
	r_PtxRegister324 = ShiftRight(uint32_t(r_PtxRegister323), uint32_t(30));					   // PTX L564
	r_PtxRegister325 = uint32_t(r_LaneIndexAtPtx561) + uint32_t(r_PtxRegister324);				   // PTX L565
	r_PtxRegister326 = r_PtxRegister325 & -4;													   // PTX L566
	r_PtxRegister327 = uint32_t(r_LaneIndexAtPtx561) - uint32_t(r_PtxRegister326);				   // PTX L567
	r_PtxU64Register63 = uint64_t(int64_t(int32_t(r_PtxRegister327)) * int64_t(int32_t(4)));	   // PTX L568
	g_RecordByteAddressAtPtx569 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register63);					   // PTX L569
	r_PtxRegister195 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx569 + 28688ull); // PTX L570
	r_LaneIndexAtPtx572 = uint32_t((threadIdx.x & 31u));										   // PTX L572
	r_PtxRegister328 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx572), uint32_t(31));			   // PTX L574
	r_PtxRegister329 = ShiftRight(uint32_t(r_PtxRegister328), uint32_t(30));					   // PTX L575
	r_PtxRegister330 = uint32_t(r_LaneIndexAtPtx572) + uint32_t(r_PtxRegister329);				   // PTX L576
	r_PtxRegister331 = r_PtxRegister330 & -4;													   // PTX L577
	r_PtxRegister332 = uint32_t(r_LaneIndexAtPtx572) - uint32_t(r_PtxRegister331);				   // PTX L578
	r_PtxRegister333 = uint32_t(r_PtxRegister332) + uint32_t(4);								   // PTX L579
	r_PtxU64Register65 = uint64_t(uint32_t(r_PtxRegister333)) * uint64_t(uint32_t(4));			   // PTX L580
	g_RecordByteAddressAtPtx581 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register65);					   // PTX L581
	r_PtxRegister197 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx581 + 28688ull); // PTX L582
	r_LaneIndexAtPtx584 = uint32_t((threadIdx.x & 31u));										   // PTX L584
	r_PtxRegister334 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx584), uint32_t(31));			   // PTX L586
	r_PtxRegister335 = ShiftRight(uint32_t(r_PtxRegister334), uint32_t(30));					   // PTX L587
	r_PtxRegister336 = uint32_t(r_LaneIndexAtPtx584) + uint32_t(r_PtxRegister335);				   // PTX L588
	r_PtxRegister337 = r_PtxRegister336 & -4;													   // PTX L589
	r_PtxRegister338 = uint32_t(r_LaneIndexAtPtx584) - uint32_t(r_PtxRegister337);				   // PTX L590
	r_PtxRegister339 = uint32_t(r_PtxRegister338) + uint32_t(4);								   // PTX L591
	r_PtxU64Register67 = uint64_t(uint32_t(r_PtxRegister339)) * uint64_t(uint32_t(4));			   // PTX L592
	g_RecordByteAddressAtPtx593 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register67);					   // PTX L593
	r_PtxRegister199 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx593 + 28688ull); // PTX L594
	r_LaneIndexAtPtx596 = uint32_t((threadIdx.x & 31u));										   // PTX L596
	r_PtxRegister340 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx596), uint32_t(31));			   // PTX L598
	r_PtxRegister341 = ShiftRight(uint32_t(r_PtxRegister340), uint32_t(30));					   // PTX L599
	r_PtxRegister342 = uint32_t(r_LaneIndexAtPtx596) + uint32_t(r_PtxRegister341);				   // PTX L600
	r_PtxRegister343 = r_PtxRegister342 & -4;													   // PTX L601
	r_PtxRegister344 = uint32_t(r_LaneIndexAtPtx596) - uint32_t(r_PtxRegister343);				   // PTX L602
	r_PtxRegister345 = uint32_t(r_PtxRegister344) + uint32_t(8);								   // PTX L603
	r_PtxU64Register69 = uint64_t(uint32_t(r_PtxRegister345)) * uint64_t(uint32_t(4));			   // PTX L604
	g_RecordByteAddressAtPtx605 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register69);					   // PTX L605
	r_PtxRegister201 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx605 + 28688ull); // PTX L606
	r_LaneIndexAtPtx608 = uint32_t((threadIdx.x & 31u));										   // PTX L608
	r_PtxRegister346 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx608), uint32_t(31));			   // PTX L610
	r_PtxRegister347 = ShiftRight(uint32_t(r_PtxRegister346), uint32_t(30));					   // PTX L611
	r_PtxRegister348 = uint32_t(r_LaneIndexAtPtx608) + uint32_t(r_PtxRegister347);				   // PTX L612
	r_PtxRegister349 = r_PtxRegister348 & -4;													   // PTX L613
	r_PtxRegister350 = uint32_t(r_LaneIndexAtPtx608) - uint32_t(r_PtxRegister349);				   // PTX L614
	r_PtxRegister351 = uint32_t(r_PtxRegister350) + uint32_t(8);								   // PTX L615
	r_PtxU64Register71 = uint64_t(uint32_t(r_PtxRegister351)) * uint64_t(uint32_t(4));			   // PTX L616
	g_RecordByteAddressAtPtx617 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register71);					   // PTX L617
	r_PtxRegister203 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx617 + 28688ull); // PTX L618
	r_LaneIndexAtPtx620 = uint32_t((threadIdx.x & 31u));										   // PTX L620
	r_PtxRegister352 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx620), uint32_t(31));			   // PTX L622
	r_PtxRegister353 = ShiftRight(uint32_t(r_PtxRegister352), uint32_t(30));					   // PTX L623
	r_PtxRegister354 = uint32_t(r_LaneIndexAtPtx620) + uint32_t(r_PtxRegister353);				   // PTX L624
	r_PtxRegister355 = r_PtxRegister354 & -4;													   // PTX L625
	r_PtxRegister356 = uint32_t(r_LaneIndexAtPtx620) - uint32_t(r_PtxRegister355);				   // PTX L626
	r_PtxRegister357 = uint32_t(r_PtxRegister356) + uint32_t(12);								   // PTX L627
	r_PtxU64Register73 = uint64_t(uint32_t(r_PtxRegister357)) * uint64_t(uint32_t(4));			   // PTX L628
	g_RecordByteAddressAtPtx629 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register73);					   // PTX L629
	r_PtxRegister205 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx629 + 28688ull); // PTX L630
	r_LaneIndexAtPtx632 = uint32_t((threadIdx.x & 31u));										   // PTX L632
	r_PtxRegister358 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx632), uint32_t(31));			   // PTX L634
	r_PtxRegister359 = ShiftRight(uint32_t(r_PtxRegister358), uint32_t(30));					   // PTX L635
	r_PtxRegister360 = uint32_t(r_LaneIndexAtPtx632) + uint32_t(r_PtxRegister359);				   // PTX L636
	r_PtxRegister361 = r_PtxRegister360 & -4;													   // PTX L637
	r_PtxRegister362 = uint32_t(r_LaneIndexAtPtx632) - uint32_t(r_PtxRegister361);				   // PTX L638
	r_PtxRegister363 = uint32_t(r_PtxRegister362) + uint32_t(12);								   // PTX L639
	r_PtxU64Register75 = uint64_t(uint32_t(r_PtxRegister363)) * uint64_t(uint32_t(4));			   // PTX L640
	g_RecordByteAddressAtPtx641 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register75);					   // PTX L641
	r_PtxRegister207 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx641 + 28688ull); // PTX L642
	r_LaneIndexAtPtx644 = uint32_t((threadIdx.x & 31u));										   // PTX L644
	r_PtxRegister364 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx644), uint32_t(31));			   // PTX L646
	r_PtxRegister365 = ShiftRight(uint32_t(r_PtxRegister364), uint32_t(30));					   // PTX L647
	r_PtxRegister366 = uint32_t(r_LaneIndexAtPtx644) + uint32_t(r_PtxRegister365);				   // PTX L648
	r_PtxRegister367 = r_PtxRegister366 & -4;													   // PTX L649
	r_PtxRegister368 = uint32_t(r_LaneIndexAtPtx644) - uint32_t(r_PtxRegister367);				   // PTX L650
	r_PtxRegister369 = uint32_t(r_PtxRegister368) + uint32_t(16);								   // PTX L651
	r_PtxU64Register77 = uint64_t(uint32_t(r_PtxRegister369)) * uint64_t(uint32_t(4));			   // PTX L652
	g_RecordByteAddressAtPtx653 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register77);					   // PTX L653
	r_PtxRegister209 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx653 + 28688ull); // PTX L654
	r_LaneIndexAtPtx656 = uint32_t((threadIdx.x & 31u));										   // PTX L656
	r_PtxRegister370 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx656), uint32_t(31));			   // PTX L658
	r_PtxRegister371 = ShiftRight(uint32_t(r_PtxRegister370), uint32_t(30));					   // PTX L659
	r_PtxRegister372 = uint32_t(r_LaneIndexAtPtx656) + uint32_t(r_PtxRegister371);				   // PTX L660
	r_PtxRegister373 = r_PtxRegister372 & -4;													   // PTX L661
	r_PtxRegister374 = uint32_t(r_LaneIndexAtPtx656) - uint32_t(r_PtxRegister373);				   // PTX L662
	r_PtxRegister375 = uint32_t(r_PtxRegister374) + uint32_t(16);								   // PTX L663
	r_PtxU64Register79 = uint64_t(uint32_t(r_PtxRegister375)) * uint64_t(uint32_t(4));			   // PTX L664
	g_RecordByteAddressAtPtx665 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register79);					   // PTX L665
	r_PtxRegister211 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx665 + 28688ull); // PTX L666
	r_LaneIndexAtPtx668 = uint32_t((threadIdx.x & 31u));										   // PTX L668
	r_PtxRegister376 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx668), uint32_t(31));			   // PTX L670
	r_PtxRegister377 = ShiftRight(uint32_t(r_PtxRegister376), uint32_t(30));					   // PTX L671
	r_PtxRegister378 = uint32_t(r_LaneIndexAtPtx668) + uint32_t(r_PtxRegister377);				   // PTX L672
	r_PtxRegister379 = r_PtxRegister378 & -4;													   // PTX L673
	r_PtxRegister380 = uint32_t(r_LaneIndexAtPtx668) - uint32_t(r_PtxRegister379);				   // PTX L674
	r_PtxRegister381 = uint32_t(r_PtxRegister380) + uint32_t(20);								   // PTX L675
	r_PtxU64Register81 = uint64_t(uint32_t(r_PtxRegister381)) * uint64_t(uint32_t(4));			   // PTX L676
	g_RecordByteAddressAtPtx677 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register81);					   // PTX L677
	r_PtxRegister213 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx677 + 28688ull); // PTX L678
	r_LaneIndexAtPtx680 = uint32_t((threadIdx.x & 31u));										   // PTX L680
	r_PtxRegister382 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx680), uint32_t(31));			   // PTX L682
	r_PtxRegister383 = ShiftRight(uint32_t(r_PtxRegister382), uint32_t(30));					   // PTX L683
	r_PtxRegister384 = uint32_t(r_LaneIndexAtPtx680) + uint32_t(r_PtxRegister383);				   // PTX L684
	r_PtxRegister385 = r_PtxRegister384 & -4;													   // PTX L685
	r_PtxRegister386 = uint32_t(r_LaneIndexAtPtx680) - uint32_t(r_PtxRegister385);				   // PTX L686
	r_PtxRegister387 = uint32_t(r_PtxRegister386) + uint32_t(20);								   // PTX L687
	r_PtxU64Register83 = uint64_t(uint32_t(r_PtxRegister387)) * uint64_t(uint32_t(4));			   // PTX L688
	g_RecordByteAddressAtPtx689 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register83);					   // PTX L689
	r_PtxRegister215 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx689 + 28688ull); // PTX L690
	r_LaneIndexAtPtx692 = uint32_t((threadIdx.x & 31u));										   // PTX L692
	r_PtxRegister388 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx692), uint32_t(31));			   // PTX L694
	r_PtxRegister389 = ShiftRight(uint32_t(r_PtxRegister388), uint32_t(30));					   // PTX L695
	r_PtxRegister390 = uint32_t(r_LaneIndexAtPtx692) + uint32_t(r_PtxRegister389);				   // PTX L696
	r_PtxRegister391 = r_PtxRegister390 & -4;													   // PTX L697
	r_PtxRegister392 = uint32_t(r_LaneIndexAtPtx692) - uint32_t(r_PtxRegister391);				   // PTX L698
	r_PtxRegister393 = uint32_t(r_PtxRegister392) + uint32_t(24);								   // PTX L699
	r_PtxU64Register85 = uint64_t(uint32_t(r_PtxRegister393)) * uint64_t(uint32_t(4));			   // PTX L700
	g_RecordByteAddressAtPtx701 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register85);					   // PTX L701
	r_PtxRegister217 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx701 + 28688ull); // PTX L702
	r_LaneIndexAtPtx704 = uint32_t((threadIdx.x & 31u));										   // PTX L704
	r_PtxRegister394 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx704), uint32_t(31));			   // PTX L706
	r_PtxRegister395 = ShiftRight(uint32_t(r_PtxRegister394), uint32_t(30));					   // PTX L707
	r_PtxRegister396 = uint32_t(r_LaneIndexAtPtx704) + uint32_t(r_PtxRegister395);				   // PTX L708
	r_PtxRegister397 = r_PtxRegister396 & -4;													   // PTX L709
	r_PtxRegister398 = uint32_t(r_LaneIndexAtPtx704) - uint32_t(r_PtxRegister397);				   // PTX L710
	r_PtxRegister399 = uint32_t(r_PtxRegister398) + uint32_t(24);								   // PTX L711
	r_PtxU64Register87 = uint64_t(uint32_t(r_PtxRegister399)) * uint64_t(uint32_t(4));			   // PTX L712
	g_RecordByteAddressAtPtx713 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register87);					   // PTX L713
	r_PtxRegister219 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx713 + 28688ull); // PTX L714
	r_LaneIndexAtPtx716 = uint32_t((threadIdx.x & 31u));										   // PTX L716
	r_PtxRegister400 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx716), uint32_t(31));			   // PTX L718
	r_PtxRegister401 = ShiftRight(uint32_t(r_PtxRegister400), uint32_t(30));					   // PTX L719
	r_PtxRegister402 = uint32_t(r_LaneIndexAtPtx716) + uint32_t(r_PtxRegister401);				   // PTX L720
	r_PtxRegister403 = r_PtxRegister402 & -4;													   // PTX L721
	r_PtxRegister404 = uint32_t(r_LaneIndexAtPtx716) - uint32_t(r_PtxRegister403);				   // PTX L722
	r_PtxRegister405 = uint32_t(r_PtxRegister404) + uint32_t(28);								   // PTX L723
	r_PtxU64Register89 = uint64_t(uint32_t(r_PtxRegister405)) * uint64_t(uint32_t(4));			   // PTX L724
	g_RecordByteAddressAtPtx725 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register89);					   // PTX L725
	r_PtxRegister221 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx725 + 28688ull); // PTX L726
	r_LaneIndexAtPtx728 = uint32_t((threadIdx.x & 31u));										   // PTX L728
	r_PtxRegister406 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx728), uint32_t(31));			   // PTX L730
	r_PtxRegister407 = ShiftRight(uint32_t(r_PtxRegister406), uint32_t(30));					   // PTX L731
	r_PtxRegister408 = uint32_t(r_LaneIndexAtPtx728) + uint32_t(r_PtxRegister407);				   // PTX L732
	r_PtxRegister409 = r_PtxRegister408 & -4;													   // PTX L733
	r_PtxRegister410 = uint32_t(r_LaneIndexAtPtx728) - uint32_t(r_PtxRegister409);				   // PTX L734
	r_PtxRegister411 = uint32_t(r_PtxRegister410) + uint32_t(28);								   // PTX L735
	r_PtxU64Register91 = uint64_t(uint32_t(r_PtxRegister411)) * uint64_t(uint32_t(4));			   // PTX L736
	g_RecordByteAddressAtPtx737 =
		uint64_t(g_RecordByteAddressAtPtx19) + uint64_t(r_PtxU64Register91);					   // PTX L737
	r_PtxRegister223 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx737 + 28688ull); // PTX L738
	r_LaneIndexAtPtx740 = uint32_t((threadIdx.x & 31u));										   // PTX L740
	r_PackedHalf2AtPtx743R4857 = HalfMul(r_PackedHalf2AtPtx260R414, r_PtxRegister161);			   // PTX L743
	r_LaneIndexAtPtx747 = uint32_t((threadIdx.x & 31u));										   // PTX L747
	r_PackedHalf2AtPtx750R4858 = HalfMul(r_PackedHalf2AtPtx266R416, r_PtxRegister163);			   // PTX L750
	r_LaneIndexAtPtx754 = uint32_t((threadIdx.x & 31u));										   // PTX L754
	r_PackedHalf2AtPtx757R4859 = HalfMul(r_PackedHalf2AtPtx263R415, r_PtxRegister165);			   // PTX L757
	r_LaneIndexAtPtx761 = uint32_t((threadIdx.x & 31u));										   // PTX L761
	r_PackedHalf2AtPtx764R4860 = HalfMul(r_PackedHalf2AtPtx269R417, r_PtxRegister167);			   // PTX L764
	r_LaneIndexAtPtx768 = uint32_t((threadIdx.x & 31u));										   // PTX L768
	r_PackedHalf2AtPtx771R4861 = HalfMul(r_PackedHalf2AtPtx272R418, r_PtxRegister169);			   // PTX L771
	r_LaneIndexAtPtx775 = uint32_t((threadIdx.x & 31u));										   // PTX L775
	r_PackedHalf2AtPtx778R4862 = HalfMul(r_PackedHalf2AtPtx278R420, r_PtxRegister171);			   // PTX L778
	r_LaneIndexAtPtx782 = uint32_t((threadIdx.x & 31u));										   // PTX L782
	r_PackedHalf2AtPtx785R4863 = HalfMul(r_PackedHalf2AtPtx275R419, r_PtxRegister173);			   // PTX L785
	r_LaneIndexAtPtx789 = uint32_t((threadIdx.x & 31u));										   // PTX L789
	r_PackedHalf2AtPtx792R4864 = HalfMul(r_PackedHalf2AtPtx281R421, r_PtxRegister175);			   // PTX L792
	r_LaneIndexAtPtx796 = uint32_t((threadIdx.x & 31u));										   // PTX L796
	r_PackedHalf2AtPtx799R4865 = HalfMul(r_PackedHalf2AtPtx284R448, r_PtxRegister177);			   // PTX L799
	r_LaneIndexAtPtx803 = uint32_t((threadIdx.x & 31u));										   // PTX L803
	r_PackedHalf2AtPtx806R4866 = HalfMul(r_PackedHalf2AtPtx290R450, r_PtxRegister179);			   // PTX L806
	r_LaneIndexAtPtx810 = uint32_t((threadIdx.x & 31u));										   // PTX L810
	r_PackedHalf2AtPtx813R4867 = HalfMul(r_PackedHalf2AtPtx287R449, r_PtxRegister181);			   // PTX L813
	r_LaneIndexAtPtx817 = uint32_t((threadIdx.x & 31u));										   // PTX L817
	r_PackedHalf2AtPtx820R4868 = HalfMul(r_PackedHalf2AtPtx293R451, r_PtxRegister183);			   // PTX L820
	r_LaneIndexAtPtx824 = uint32_t((threadIdx.x & 31u));										   // PTX L824
	r_PackedHalf2AtPtx827R4869 = HalfMul(r_PackedHalf2AtPtx296R452, r_PtxRegister185);			   // PTX L827
	r_LaneIndexAtPtx831 = uint32_t((threadIdx.x & 31u));										   // PTX L831
	r_PackedHalf2AtPtx834R4870 = HalfMul(r_PackedHalf2AtPtx302R454, r_PtxRegister187);			   // PTX L834
	r_LaneIndexAtPtx838 = uint32_t((threadIdx.x & 31u));										   // PTX L838
	r_PackedHalf2AtPtx841R4871 = HalfMul(r_PackedHalf2AtPtx299R453, r_PtxRegister189);			   // PTX L841
	r_LaneIndexAtPtx845 = uint32_t((threadIdx.x & 31u));										   // PTX L845
	r_PackedHalf2AtPtx848R4872 = HalfMul(r_PackedHalf2AtPtx305R455, r_PtxRegister191);			   // PTX L848
	r_LaneIndexAtPtx852 = uint32_t((threadIdx.x & 31u));										   // PTX L852
	r_PackedHalf2AtPtx855R4873 = HalfMul(r_PackedHalf2AtPtx308R422, r_PtxRegister193);			   // PTX L855
	r_LaneIndexAtPtx859 = uint32_t((threadIdx.x & 31u));										   // PTX L859
	r_PackedHalf2AtPtx862R4874 = HalfMul(r_PackedHalf2AtPtx314R424, r_PtxRegister195);			   // PTX L862
	r_LaneIndexAtPtx866 = uint32_t((threadIdx.x & 31u));										   // PTX L866
	r_PackedHalf2AtPtx869R4875 = HalfMul(r_PackedHalf2AtPtx311R423, r_PtxRegister197);			   // PTX L869
	r_LaneIndexAtPtx873 = uint32_t((threadIdx.x & 31u));										   // PTX L873
	r_PackedHalf2AtPtx876R4876 = HalfMul(r_PackedHalf2AtPtx317R425, r_PtxRegister199);			   // PTX L876
	r_LaneIndexAtPtx880 = uint32_t((threadIdx.x & 31u));										   // PTX L880
	r_PackedHalf2AtPtx883R4877 = HalfMul(r_PackedHalf2AtPtx320R426, r_PtxRegister201);			   // PTX L883
	r_LaneIndexAtPtx887 = uint32_t((threadIdx.x & 31u));										   // PTX L887
	r_PackedHalf2AtPtx890R4878 = HalfMul(r_PackedHalf2AtPtx326R428, r_PtxRegister203);			   // PTX L890
	r_LaneIndexAtPtx894 = uint32_t((threadIdx.x & 31u));										   // PTX L894
	r_PackedHalf2AtPtx897R4879 = HalfMul(r_PackedHalf2AtPtx323R427, r_PtxRegister205);			   // PTX L897
	r_LaneIndexAtPtx901 = uint32_t((threadIdx.x & 31u));										   // PTX L901
	r_PackedHalf2AtPtx904R4880 = HalfMul(r_PackedHalf2AtPtx329R429, r_PtxRegister207);			   // PTX L904
	r_LaneIndexAtPtx908 = uint32_t((threadIdx.x & 31u));										   // PTX L908
	r_PackedHalf2AtPtx911R4881 = HalfMul(r_PackedHalf2AtPtx333R456, r_PtxRegister209);			   // PTX L911
	r_LaneIndexAtPtx915 = uint32_t((threadIdx.x & 31u));										   // PTX L915
	r_PackedHalf2AtPtx918R4882 = HalfMul(r_PackedHalf2AtPtx340R458, r_PtxRegister211);			   // PTX L918
	r_LaneIndexAtPtx922 = uint32_t((threadIdx.x & 31u));										   // PTX L922
	r_PackedHalf2AtPtx925R4883 = HalfMul(r_PackedHalf2AtPtx336R457, r_PtxRegister213);			   // PTX L925
	r_LaneIndexAtPtx929 = uint32_t((threadIdx.x & 31u));										   // PTX L929
	r_PackedHalf2AtPtx932R4884 = HalfMul(r_PackedHalf2AtPtx343R459, r_PtxRegister215);			   // PTX L932
	r_LaneIndexAtPtx936 = uint32_t((threadIdx.x & 31u));										   // PTX L936
	r_PackedHalf2AtPtx939R4885 = HalfMul(r_PackedHalf2AtPtx347R460, r_PtxRegister217);			   // PTX L939
	r_LaneIndexAtPtx943 = uint32_t((threadIdx.x & 31u));										   // PTX L943
	r_PackedHalf2AtPtx946R4886 = HalfMul(r_PackedHalf2AtPtx354R462, r_PtxRegister219);			   // PTX L946
	r_LaneIndexAtPtx950 = uint32_t((threadIdx.x & 31u));										   // PTX L950
	r_PackedHalf2AtPtx953R4887 = HalfMul(r_PackedHalf2AtPtx350R461, r_PtxRegister221);			   // PTX L953
	r_LaneIndexAtPtx957 = uint32_t((threadIdx.x & 31u));										   // PTX L957
	r_PackedHalf2AtPtx960R4888 = HalfMul(r_PackedHalf2AtPtx357R463, r_PtxRegister223);			   // PTX L960
	r_PtxRegister4856 = uint32_t(0);															   // PTX L963

	// Expert expansion / cubic activation / contraction; native M32 register ownership
	r_PackedHalf2AtPtx965R2767 = FloatToHalf2(r_PtxRegister4856);								  // PTX L965
	r_bPtxPredicate298 = bool(-1);																  // PTX L970
L__BB11_21:																						  // PTX L971
	r_bPtxPredicate3 = bool(r_bPtxPredicate298);												  // PTX L972
	r_PtxRegister1290 = ShiftLeft(uint32_t(r_PtxRegister4856), uint32_t(11));					  // PTX L973
	r_PtxU64Register121 = uint64_t(uint32_t(r_PtxRegister1290)) * uint64_t(uint32_t(4));		  // PTX L974
	g_RecordByteAddressAtPtx975 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register121);  // PTX L975
	r_LaneIndexAtPtx977 = uint32_t((threadIdx.x & 31u));										  // PTX L977
	r_PtxU64Register123 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx977)) * int64_t(int32_t(16))); // PTX L979
	g_RecordByteAddressAtPtx980 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register123); // PTX L980
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx980));
		r_MmaBE4x4WordAtPtx982R430 = r_Value.x;
		r_MmaBE4x4WordAtPtx982R431 = r_Value.y;
		r_MmaBE4x4WordAtPtx982R436 = r_Value.z;
		r_MmaBE4x4WordAtPtx982R437 = r_Value.w;
	} // PTX L982
	r_LaneIndexAtPtx985 = uint32_t((threadIdx.x & 31u));										  // PTX L985
	r_PtxU64Register124 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx985)) * int64_t(int32_t(16))); // PTX L987
	g_RecordByteAddressAtPtx988 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register124);			 // PTX L988
	g_RecordByteAddressAtPtx989 = uint64_t(g_RecordByteAddressAtPtx988) + uint64_t(512); // PTX L989
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx989));
		r_MmaBE4x4WordAtPtx991R438 = r_Value.x;
		r_MmaBE4x4WordAtPtx991R439 = r_Value.y;
		r_MmaBE4x4WordAtPtx991R440 = r_Value.z;
		r_MmaBE4x4WordAtPtx991R441 = r_Value.w;
	} // PTX L991
	r_ConvertedE4PairAtPtx994Rs49 = PublishE4(r_PackedHalf2AtPtx260R414); // PTX L994
	r_ConvertedE4PairAtPtx997Rs50 = PublishE4(r_PackedHalf2AtPtx263R415); // PTX L997
	r_MmaAE4x4WordAtPtx999R432 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx994Rs49, r_ConvertedE4PairAtPtx997Rs50); // PTX L999
	r_ConvertedE4PairAtPtx1001Rs51 = PublishE4(r_PackedHalf2AtPtx266R416);			   // PTX L1001
	r_ConvertedE4PairAtPtx1004Rs52 = PublishE4(r_PackedHalf2AtPtx269R417);			   // PTX L1004
	r_MmaAE4x4WordAtPtx1006R433 = JoinConvertedE4(r_ConvertedE4PairAtPtx1001Rs51,
												  r_ConvertedE4PairAtPtx1004Rs52); // PTX L1006
	r_ConvertedE4PairAtPtx1008Rs53 = PublishE4(r_PackedHalf2AtPtx272R418);		   // PTX L1008
	r_ConvertedE4PairAtPtx1011Rs54 = PublishE4(r_PackedHalf2AtPtx275R419);		   // PTX L1011
	r_MmaAE4x4WordAtPtx1013R434 = JoinConvertedE4(r_ConvertedE4PairAtPtx1008Rs53,
												  r_ConvertedE4PairAtPtx1011Rs54); // PTX L1013
	r_ConvertedE4PairAtPtx1015Rs55 = PublishE4(r_PackedHalf2AtPtx278R420);		   // PTX L1015
	r_ConvertedE4PairAtPtx1018Rs56 = PublishE4(r_PackedHalf2AtPtx281R421);		   // PTX L1018
	r_MmaAE4x4WordAtPtx1020R435 = JoinConvertedE4(r_ConvertedE4PairAtPtx1015Rs55,
												  r_ConvertedE4PairAtPtx1018Rs56); // PTX L1020
	r_ConvertedE4PairAtPtx1022Rs57 = PublishE4(r_PackedHalf2AtPtx308R422);		   // PTX L1022
	r_ConvertedE4PairAtPtx1025Rs58 = PublishE4(r_PackedHalf2AtPtx311R423);		   // PTX L1025
	r_MmaAE4x4WordAtPtx1027R442 = JoinConvertedE4(r_ConvertedE4PairAtPtx1022Rs57,
												  r_ConvertedE4PairAtPtx1025Rs58); // PTX L1027
	r_ConvertedE4PairAtPtx1029Rs59 = PublishE4(r_PackedHalf2AtPtx314R424);		   // PTX L1029
	r_ConvertedE4PairAtPtx1032Rs60 = PublishE4(r_PackedHalf2AtPtx317R425);		   // PTX L1032
	r_MmaAE4x4WordAtPtx1034R443 = JoinConvertedE4(r_ConvertedE4PairAtPtx1029Rs59,
												  r_ConvertedE4PairAtPtx1032Rs60); // PTX L1034
	r_ConvertedE4PairAtPtx1036Rs61 = PublishE4(r_PackedHalf2AtPtx320R426);		   // PTX L1036
	r_ConvertedE4PairAtPtx1039Rs62 = PublishE4(r_PackedHalf2AtPtx323R427);		   // PTX L1039
	r_MmaAE4x4WordAtPtx1041R444 = JoinConvertedE4(r_ConvertedE4PairAtPtx1036Rs61,
												  r_ConvertedE4PairAtPtx1039Rs62); // PTX L1041
	r_ConvertedE4PairAtPtx1043Rs63 = PublishE4(r_PackedHalf2AtPtx326R428);		   // PTX L1043
	r_ConvertedE4PairAtPtx1046Rs64 = PublishE4(r_PackedHalf2AtPtx329R429);		   // PTX L1046
	r_MmaAE4x4WordAtPtx1048R445 = JoinConvertedE4(r_ConvertedE4PairAtPtx1043Rs63,
												  r_ConvertedE4PairAtPtx1046Rs64); // PTX L1048
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1050R466, r_MmaAccumulatorHalf2WordAtPtx1050R467,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx982R430, r_MmaBE4x4WordAtPtx982R431,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1050
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1057R474, r_MmaAccumulatorHalf2WordAtPtx1057R475,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx982R436, r_MmaBE4x4WordAtPtx982R437,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1057
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1064R478, r_MmaAccumulatorHalf2WordAtPtx1064R479,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx991R438, r_MmaBE4x4WordAtPtx991R439,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1064
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1071R482, r_MmaAccumulatorHalf2WordAtPtx1071R483,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx991R440, r_MmaBE4x4WordAtPtx991R441,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1071
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1078R484, r_MmaAccumulatorHalf2WordAtPtx1078R485,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx982R430, r_MmaBE4x4WordAtPtx982R431,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1078
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1085R490, r_MmaAccumulatorHalf2WordAtPtx1085R491,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx982R436, r_MmaBE4x4WordAtPtx982R437,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1085
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1092R492, r_MmaAccumulatorHalf2WordAtPtx1092R493,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx991R438, r_MmaBE4x4WordAtPtx991R439,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1092
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1099R494, r_MmaAccumulatorHalf2WordAtPtx1099R495,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx991R440, r_MmaBE4x4WordAtPtx991R441,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767);					  // PTX L1099
	r_LaneIndexAtPtx1106 = uint32_t((threadIdx.x & 31u)); // PTX L1106
	r_PtxU64Register126 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1106)) * int64_t(int32_t(16))); // PTX L1108
	g_RecordByteAddressAtPtx1109 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register126);				// PTX L1109
	g_RecordByteAddressAtPtx1110 = uint64_t(g_RecordByteAddressAtPtx1109) + uint64_t(4096); // PTX L1110
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1110));
		r_MmaBE4x4WordAtPtx1112R464 = r_Value.x;
		r_MmaBE4x4WordAtPtx1112R465 = r_Value.y;
		r_MmaBE4x4WordAtPtx1112R472 = r_Value.z;
		r_MmaBE4x4WordAtPtx1112R473 = r_Value.w;
	} // PTX L1112
	r_LaneIndexAtPtx1115 = uint32_t((threadIdx.x & 31u)); // PTX L1115
	r_PtxU64Register128 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1115)) * int64_t(int32_t(16))); // PTX L1117
	g_RecordByteAddressAtPtx1118 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register128);				// PTX L1118
	g_RecordByteAddressAtPtx1119 = uint64_t(g_RecordByteAddressAtPtx1118) + uint64_t(4608); // PTX L1119
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1119));
		r_MmaBE4x4WordAtPtx1121R476 = r_Value.x;
		r_MmaBE4x4WordAtPtx1121R477 = r_Value.y;
		r_MmaBE4x4WordAtPtx1121R480 = r_Value.z;
		r_MmaBE4x4WordAtPtx1121R481 = r_Value.w;
	} // PTX L1121
	r_ConvertedE4PairAtPtx1124Rs65 = PublishE4(r_PackedHalf2AtPtx284R448); // PTX L1124
	r_ConvertedE4PairAtPtx1127Rs66 = PublishE4(r_PackedHalf2AtPtx287R449); // PTX L1127
	r_MmaAE4x4WordAtPtx1129R468 = JoinConvertedE4(r_ConvertedE4PairAtPtx1124Rs65,
												  r_ConvertedE4PairAtPtx1127Rs66); // PTX L1129
	r_ConvertedE4PairAtPtx1131Rs67 = PublishE4(r_PackedHalf2AtPtx290R450);		   // PTX L1131
	r_ConvertedE4PairAtPtx1134Rs68 = PublishE4(r_PackedHalf2AtPtx293R451);		   // PTX L1134
	r_MmaAE4x4WordAtPtx1136R469 = JoinConvertedE4(r_ConvertedE4PairAtPtx1131Rs67,
												  r_ConvertedE4PairAtPtx1134Rs68); // PTX L1136
	r_ConvertedE4PairAtPtx1138Rs69 = PublishE4(r_PackedHalf2AtPtx296R452);		   // PTX L1138
	r_ConvertedE4PairAtPtx1141Rs70 = PublishE4(r_PackedHalf2AtPtx299R453);		   // PTX L1141
	r_MmaAE4x4WordAtPtx1143R470 = JoinConvertedE4(r_ConvertedE4PairAtPtx1138Rs69,
												  r_ConvertedE4PairAtPtx1141Rs70); // PTX L1143
	r_ConvertedE4PairAtPtx1145Rs71 = PublishE4(r_PackedHalf2AtPtx302R454);		   // PTX L1145
	r_ConvertedE4PairAtPtx1148Rs72 = PublishE4(r_PackedHalf2AtPtx305R455);		   // PTX L1148
	r_MmaAE4x4WordAtPtx1150R471 = JoinConvertedE4(r_ConvertedE4PairAtPtx1145Rs71,
												  r_ConvertedE4PairAtPtx1148Rs72); // PTX L1150
	r_ConvertedE4PairAtPtx1152Rs73 = PublishE4(r_PackedHalf2AtPtx333R456);		   // PTX L1152
	r_ConvertedE4PairAtPtx1155Rs74 = PublishE4(r_PackedHalf2AtPtx336R457);		   // PTX L1155
	r_MmaAE4x4WordAtPtx1157R486 = JoinConvertedE4(r_ConvertedE4PairAtPtx1152Rs73,
												  r_ConvertedE4PairAtPtx1155Rs74); // PTX L1157
	r_ConvertedE4PairAtPtx1159Rs75 = PublishE4(r_PackedHalf2AtPtx340R458);		   // PTX L1159
	r_ConvertedE4PairAtPtx1162Rs76 = PublishE4(r_PackedHalf2AtPtx343R459);		   // PTX L1162
	r_MmaAE4x4WordAtPtx1164R487 = JoinConvertedE4(r_ConvertedE4PairAtPtx1159Rs75,
												  r_ConvertedE4PairAtPtx1162Rs76); // PTX L1164
	r_ConvertedE4PairAtPtx1166Rs77 = PublishE4(r_PackedHalf2AtPtx347R460);		   // PTX L1166
	r_ConvertedE4PairAtPtx1169Rs78 = PublishE4(r_PackedHalf2AtPtx350R461);		   // PTX L1169
	r_MmaAE4x4WordAtPtx1171R488 = JoinConvertedE4(r_ConvertedE4PairAtPtx1166Rs77,
												  r_ConvertedE4PairAtPtx1169Rs78); // PTX L1171
	r_ConvertedE4PairAtPtx1173Rs79 = PublishE4(r_PackedHalf2AtPtx354R462);		   // PTX L1173
	r_ConvertedE4PairAtPtx1176Rs80 = PublishE4(r_PackedHalf2AtPtx357R463);		   // PTX L1176
	r_MmaAE4x4WordAtPtx1178R489 = JoinConvertedE4(r_ConvertedE4PairAtPtx1173Rs79,
												  r_ConvertedE4PairAtPtx1176Rs80); // PTX L1178
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1180R502, r_MmaAccumulatorHalf2WordAtPtx1180R514,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx1112R464, r_MmaBE4x4WordAtPtx1112R465,
		  r_MmaAccumulatorHalf2WordAtPtx1050R466,
		  r_MmaAccumulatorHalf2WordAtPtx1050R467); // PTX L1180
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1187R521, r_MmaAccumulatorHalf2WordAtPtx1187R528,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx1112R472, r_MmaBE4x4WordAtPtx1112R473,
		  r_MmaAccumulatorHalf2WordAtPtx1057R474,
		  r_MmaAccumulatorHalf2WordAtPtx1057R475); // PTX L1187
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1194R535, r_MmaAccumulatorHalf2WordAtPtx1194R542,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx1121R476, r_MmaBE4x4WordAtPtx1121R477,
		  r_MmaAccumulatorHalf2WordAtPtx1064R478,
		  r_MmaAccumulatorHalf2WordAtPtx1064R479); // PTX L1194
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1201R549, r_MmaAccumulatorHalf2WordAtPtx1201R556,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx1121R480, r_MmaBE4x4WordAtPtx1121R481,
		  r_MmaAccumulatorHalf2WordAtPtx1071R482,
		  r_MmaAccumulatorHalf2WordAtPtx1071R483); // PTX L1201
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1208R563, r_MmaAccumulatorHalf2WordAtPtx1208R570,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx1112R464, r_MmaBE4x4WordAtPtx1112R465,
		  r_MmaAccumulatorHalf2WordAtPtx1078R484,
		  r_MmaAccumulatorHalf2WordAtPtx1078R485); // PTX L1208
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1215R577, r_MmaAccumulatorHalf2WordAtPtx1215R584,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx1112R472, r_MmaBE4x4WordAtPtx1112R473,
		  r_MmaAccumulatorHalf2WordAtPtx1085R490,
		  r_MmaAccumulatorHalf2WordAtPtx1085R491); // PTX L1215
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1222R591, r_MmaAccumulatorHalf2WordAtPtx1222R598,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx1121R476, r_MmaBE4x4WordAtPtx1121R477,
		  r_MmaAccumulatorHalf2WordAtPtx1092R492,
		  r_MmaAccumulatorHalf2WordAtPtx1092R493); // PTX L1222
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1229R605, r_MmaAccumulatorHalf2WordAtPtx1229R612,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx1121R480, r_MmaBE4x4WordAtPtx1121R481,
		  r_MmaAccumulatorHalf2WordAtPtx1099R494,
		  r_MmaAccumulatorHalf2WordAtPtx1099R495);						   // PTX L1229
	r_LaneIndexAtPtx1236 = uint32_t((threadIdx.x & 31u));				   // PTX L1236
	r_Float32BitsAtPtx1238R497 = uint32_t(-1065353216);					   // PTX L1238
	r_PackedHalf2AtPtx1240R505 = FloatToHalf2(r_Float32BitsAtPtx1238R497); // PTX L1240
	r_Float32BitsAtPtx1245R498 = uint32_t(1082130432);					   // PTX L1245
	r_PackedHalf2AtPtx1247R503 = FloatToHalf2(r_Float32BitsAtPtx1245R498); // PTX L1247
	r_Float32BitsAtPtx1252R499 = uint32_t(1063583744);					   // PTX L1252
	r_PackedHalf2AtPtx1254R511 = FloatToHalf2(r_Float32BitsAtPtx1252R499); // PTX L1254
	r_Float32BitsAtPtx1259R500 = uint32_t(1055195136);					   // PTX L1259
	r_PackedHalf2AtPtx1261R509 = FloatToHalf2(r_Float32BitsAtPtx1259R500); // PTX L1261
	r_Float32BitsAtPtx1266R501 = uint32_t(-1117454336);					   // PTX L1266
	r_PackedHalf2AtPtx1268R507 = FloatToHalf2(r_Float32BitsAtPtx1266R501); // PTX L1268
	r_PackedHalf2AtPtx1274R504 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1180R502, r_PackedHalf2AtPtx1247R503);			  // PTX L1274
	r_PackedHalf2AtPtx1278R506 = HalfMax(r_PackedHalf2AtPtx1274R504, r_PackedHalf2AtPtx1240R505); // PTX L1278
	r_PackedHalf2AtPtx1282R508 = HalfAbs(r_PackedHalf2AtPtx1278R506);							  // PTX L1282
	r_PackedHalf2AtPtx1286R510 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1282R508,
										 r_PackedHalf2AtPtx1261R509); // PTX L1286
	r_PackedHalf2AtPtx1290R512 = HalfFma(r_PackedHalf2AtPtx1278R506, r_PackedHalf2AtPtx1286R510,
										 r_PackedHalf2AtPtx1254R511); // PTX L1290
	r_PackedHalf2AtPtx1294R620 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1180R502, r_PackedHalf2AtPtx1290R512); // PTX L1294
	r_LaneIndexAtPtx1298 = uint32_t((threadIdx.x & 31u));							 // PTX L1298
	r_PackedHalf2AtPtx1301R515 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1180R514, r_PackedHalf2AtPtx1247R503);			  // PTX L1301
	r_PackedHalf2AtPtx1305R516 = HalfMax(r_PackedHalf2AtPtx1301R515, r_PackedHalf2AtPtx1240R505); // PTX L1305
	r_PackedHalf2AtPtx1309R517 = HalfAbs(r_PackedHalf2AtPtx1305R516);							  // PTX L1309
	r_PackedHalf2AtPtx1313R518 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1309R517,
										 r_PackedHalf2AtPtx1261R509); // PTX L1313
	r_PackedHalf2AtPtx1317R519 = HalfFma(r_PackedHalf2AtPtx1305R516, r_PackedHalf2AtPtx1313R518,
										 r_PackedHalf2AtPtx1254R511); // PTX L1317
	r_PackedHalf2AtPtx1321R622 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1180R514, r_PackedHalf2AtPtx1317R519); // PTX L1321
	r_LaneIndexAtPtx1325 = uint32_t((threadIdx.x & 31u));							 // PTX L1325
	r_PackedHalf2AtPtx1328R522 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1187R521, r_PackedHalf2AtPtx1247R503);			  // PTX L1328
	r_PackedHalf2AtPtx1332R523 = HalfMax(r_PackedHalf2AtPtx1328R522, r_PackedHalf2AtPtx1240R505); // PTX L1332
	r_PackedHalf2AtPtx1336R524 = HalfAbs(r_PackedHalf2AtPtx1332R523);							  // PTX L1336
	r_PackedHalf2AtPtx1340R525 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1336R524,
										 r_PackedHalf2AtPtx1261R509); // PTX L1340
	r_PackedHalf2AtPtx1344R526 = HalfFma(r_PackedHalf2AtPtx1332R523, r_PackedHalf2AtPtx1340R525,
										 r_PackedHalf2AtPtx1254R511); // PTX L1344
	r_PackedHalf2AtPtx1348R621 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1187R521, r_PackedHalf2AtPtx1344R526); // PTX L1348
	r_LaneIndexAtPtx1352 = uint32_t((threadIdx.x & 31u));							 // PTX L1352
	r_PackedHalf2AtPtx1355R529 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1187R528, r_PackedHalf2AtPtx1247R503);			  // PTX L1355
	r_PackedHalf2AtPtx1359R530 = HalfMax(r_PackedHalf2AtPtx1355R529, r_PackedHalf2AtPtx1240R505); // PTX L1359
	r_PackedHalf2AtPtx1363R531 = HalfAbs(r_PackedHalf2AtPtx1359R530);							  // PTX L1363
	r_PackedHalf2AtPtx1367R532 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1363R531,
										 r_PackedHalf2AtPtx1261R509); // PTX L1367
	r_PackedHalf2AtPtx1371R533 = HalfFma(r_PackedHalf2AtPtx1359R530, r_PackedHalf2AtPtx1367R532,
										 r_PackedHalf2AtPtx1254R511); // PTX L1371
	r_PackedHalf2AtPtx1375R623 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1187R528, r_PackedHalf2AtPtx1371R533); // PTX L1375
	r_LaneIndexAtPtx1379 = uint32_t((threadIdx.x & 31u));							 // PTX L1379
	r_PackedHalf2AtPtx1382R536 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1194R535, r_PackedHalf2AtPtx1247R503);			  // PTX L1382
	r_PackedHalf2AtPtx1386R537 = HalfMax(r_PackedHalf2AtPtx1382R536, r_PackedHalf2AtPtx1240R505); // PTX L1386
	r_PackedHalf2AtPtx1390R538 = HalfAbs(r_PackedHalf2AtPtx1386R537);							  // PTX L1390
	r_PackedHalf2AtPtx1394R539 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1390R538,
										 r_PackedHalf2AtPtx1261R509); // PTX L1394
	r_PackedHalf2AtPtx1398R540 = HalfFma(r_PackedHalf2AtPtx1386R537, r_PackedHalf2AtPtx1394R539,
										 r_PackedHalf2AtPtx1254R511); // PTX L1398
	r_PackedHalf2AtPtx1402R624 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1194R535, r_PackedHalf2AtPtx1398R540); // PTX L1402
	r_LaneIndexAtPtx1406 = uint32_t((threadIdx.x & 31u));							 // PTX L1406
	r_PackedHalf2AtPtx1409R543 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1194R542, r_PackedHalf2AtPtx1247R503);			  // PTX L1409
	r_PackedHalf2AtPtx1413R544 = HalfMax(r_PackedHalf2AtPtx1409R543, r_PackedHalf2AtPtx1240R505); // PTX L1413
	r_PackedHalf2AtPtx1417R545 = HalfAbs(r_PackedHalf2AtPtx1413R544);							  // PTX L1417
	r_PackedHalf2AtPtx1421R546 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1417R545,
										 r_PackedHalf2AtPtx1261R509); // PTX L1421
	r_PackedHalf2AtPtx1425R547 = HalfFma(r_PackedHalf2AtPtx1413R544, r_PackedHalf2AtPtx1421R546,
										 r_PackedHalf2AtPtx1254R511); // PTX L1425
	r_PackedHalf2AtPtx1429R626 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1194R542, r_PackedHalf2AtPtx1425R547); // PTX L1429
	r_LaneIndexAtPtx1433 = uint32_t((threadIdx.x & 31u));							 // PTX L1433
	r_PackedHalf2AtPtx1436R550 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1201R549, r_PackedHalf2AtPtx1247R503);			  // PTX L1436
	r_PackedHalf2AtPtx1440R551 = HalfMax(r_PackedHalf2AtPtx1436R550, r_PackedHalf2AtPtx1240R505); // PTX L1440
	r_PackedHalf2AtPtx1444R552 = HalfAbs(r_PackedHalf2AtPtx1440R551);							  // PTX L1444
	r_PackedHalf2AtPtx1448R553 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1444R552,
										 r_PackedHalf2AtPtx1261R509); // PTX L1448
	r_PackedHalf2AtPtx1452R554 = HalfFma(r_PackedHalf2AtPtx1440R551, r_PackedHalf2AtPtx1448R553,
										 r_PackedHalf2AtPtx1254R511); // PTX L1452
	r_PackedHalf2AtPtx1456R625 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1201R549, r_PackedHalf2AtPtx1452R554); // PTX L1456
	r_LaneIndexAtPtx1460 = uint32_t((threadIdx.x & 31u));							 // PTX L1460
	r_PackedHalf2AtPtx1463R557 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1201R556, r_PackedHalf2AtPtx1247R503);			  // PTX L1463
	r_PackedHalf2AtPtx1467R558 = HalfMax(r_PackedHalf2AtPtx1463R557, r_PackedHalf2AtPtx1240R505); // PTX L1467
	r_PackedHalf2AtPtx1471R559 = HalfAbs(r_PackedHalf2AtPtx1467R558);							  // PTX L1471
	r_PackedHalf2AtPtx1475R560 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1471R559,
										 r_PackedHalf2AtPtx1261R509); // PTX L1475
	r_PackedHalf2AtPtx1479R561 = HalfFma(r_PackedHalf2AtPtx1467R558, r_PackedHalf2AtPtx1475R560,
										 r_PackedHalf2AtPtx1254R511); // PTX L1479
	r_PackedHalf2AtPtx1483R627 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1201R556, r_PackedHalf2AtPtx1479R561); // PTX L1483
	r_LaneIndexAtPtx1487 = uint32_t((threadIdx.x & 31u));							 // PTX L1487
	r_PackedHalf2AtPtx1490R564 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1208R563, r_PackedHalf2AtPtx1247R503);			  // PTX L1490
	r_PackedHalf2AtPtx1494R565 = HalfMax(r_PackedHalf2AtPtx1490R564, r_PackedHalf2AtPtx1240R505); // PTX L1494
	r_PackedHalf2AtPtx1498R566 = HalfAbs(r_PackedHalf2AtPtx1494R565);							  // PTX L1498
	r_PackedHalf2AtPtx1502R567 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1498R566,
										 r_PackedHalf2AtPtx1261R509); // PTX L1502
	r_PackedHalf2AtPtx1506R568 = HalfFma(r_PackedHalf2AtPtx1494R565, r_PackedHalf2AtPtx1502R567,
										 r_PackedHalf2AtPtx1254R511); // PTX L1506
	r_PackedHalf2AtPtx1510R628 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1208R563, r_PackedHalf2AtPtx1506R568); // PTX L1510
	r_LaneIndexAtPtx1514 = uint32_t((threadIdx.x & 31u));							 // PTX L1514
	r_PackedHalf2AtPtx1517R571 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1208R570, r_PackedHalf2AtPtx1247R503);			  // PTX L1517
	r_PackedHalf2AtPtx1521R572 = HalfMax(r_PackedHalf2AtPtx1517R571, r_PackedHalf2AtPtx1240R505); // PTX L1521
	r_PackedHalf2AtPtx1525R573 = HalfAbs(r_PackedHalf2AtPtx1521R572);							  // PTX L1525
	r_PackedHalf2AtPtx1529R574 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1525R573,
										 r_PackedHalf2AtPtx1261R509); // PTX L1529
	r_PackedHalf2AtPtx1533R575 = HalfFma(r_PackedHalf2AtPtx1521R572, r_PackedHalf2AtPtx1529R574,
										 r_PackedHalf2AtPtx1254R511); // PTX L1533
	r_PackedHalf2AtPtx1537R630 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1208R570, r_PackedHalf2AtPtx1533R575); // PTX L1537
	r_LaneIndexAtPtx1541 = uint32_t((threadIdx.x & 31u));							 // PTX L1541
	r_PackedHalf2AtPtx1544R578 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1215R577, r_PackedHalf2AtPtx1247R503);			  // PTX L1544
	r_PackedHalf2AtPtx1548R579 = HalfMax(r_PackedHalf2AtPtx1544R578, r_PackedHalf2AtPtx1240R505); // PTX L1548
	r_PackedHalf2AtPtx1552R580 = HalfAbs(r_PackedHalf2AtPtx1548R579);							  // PTX L1552
	r_PackedHalf2AtPtx1556R581 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1552R580,
										 r_PackedHalf2AtPtx1261R509); // PTX L1556
	r_PackedHalf2AtPtx1560R582 = HalfFma(r_PackedHalf2AtPtx1548R579, r_PackedHalf2AtPtx1556R581,
										 r_PackedHalf2AtPtx1254R511); // PTX L1560
	r_PackedHalf2AtPtx1564R629 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1215R577, r_PackedHalf2AtPtx1560R582); // PTX L1564
	r_LaneIndexAtPtx1568 = uint32_t((threadIdx.x & 31u));							 // PTX L1568
	r_PackedHalf2AtPtx1571R585 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1215R584, r_PackedHalf2AtPtx1247R503);			  // PTX L1571
	r_PackedHalf2AtPtx1575R586 = HalfMax(r_PackedHalf2AtPtx1571R585, r_PackedHalf2AtPtx1240R505); // PTX L1575
	r_PackedHalf2AtPtx1579R587 = HalfAbs(r_PackedHalf2AtPtx1575R586);							  // PTX L1579
	r_PackedHalf2AtPtx1583R588 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1579R587,
										 r_PackedHalf2AtPtx1261R509); // PTX L1583
	r_PackedHalf2AtPtx1587R589 = HalfFma(r_PackedHalf2AtPtx1575R586, r_PackedHalf2AtPtx1583R588,
										 r_PackedHalf2AtPtx1254R511); // PTX L1587
	r_PackedHalf2AtPtx1591R631 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1215R584, r_PackedHalf2AtPtx1587R589); // PTX L1591
	r_LaneIndexAtPtx1595 = uint32_t((threadIdx.x & 31u));							 // PTX L1595
	r_PackedHalf2AtPtx1598R592 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1222R591, r_PackedHalf2AtPtx1247R503);			  // PTX L1598
	r_PackedHalf2AtPtx1602R593 = HalfMax(r_PackedHalf2AtPtx1598R592, r_PackedHalf2AtPtx1240R505); // PTX L1602
	r_PackedHalf2AtPtx1606R594 = HalfAbs(r_PackedHalf2AtPtx1602R593);							  // PTX L1606
	r_PackedHalf2AtPtx1610R595 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1606R594,
										 r_PackedHalf2AtPtx1261R509); // PTX L1610
	r_PackedHalf2AtPtx1614R596 = HalfFma(r_PackedHalf2AtPtx1602R593, r_PackedHalf2AtPtx1610R595,
										 r_PackedHalf2AtPtx1254R511); // PTX L1614
	r_PackedHalf2AtPtx1618R632 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1222R591, r_PackedHalf2AtPtx1614R596); // PTX L1618
	r_LaneIndexAtPtx1622 = uint32_t((threadIdx.x & 31u));							 // PTX L1622
	r_PackedHalf2AtPtx1625R599 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1222R598, r_PackedHalf2AtPtx1247R503);			  // PTX L1625
	r_PackedHalf2AtPtx1629R600 = HalfMax(r_PackedHalf2AtPtx1625R599, r_PackedHalf2AtPtx1240R505); // PTX L1629
	r_PackedHalf2AtPtx1633R601 = HalfAbs(r_PackedHalf2AtPtx1629R600);							  // PTX L1633
	r_PackedHalf2AtPtx1637R602 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1633R601,
										 r_PackedHalf2AtPtx1261R509); // PTX L1637
	r_PackedHalf2AtPtx1641R603 = HalfFma(r_PackedHalf2AtPtx1629R600, r_PackedHalf2AtPtx1637R602,
										 r_PackedHalf2AtPtx1254R511); // PTX L1641
	r_PackedHalf2AtPtx1645R634 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1222R598, r_PackedHalf2AtPtx1641R603); // PTX L1645
	r_LaneIndexAtPtx1649 = uint32_t((threadIdx.x & 31u));							 // PTX L1649
	r_PackedHalf2AtPtx1652R606 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1229R605, r_PackedHalf2AtPtx1247R503);			  // PTX L1652
	r_PackedHalf2AtPtx1656R607 = HalfMax(r_PackedHalf2AtPtx1652R606, r_PackedHalf2AtPtx1240R505); // PTX L1656
	r_PackedHalf2AtPtx1660R608 = HalfAbs(r_PackedHalf2AtPtx1656R607);							  // PTX L1660
	r_PackedHalf2AtPtx1664R609 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1660R608,
										 r_PackedHalf2AtPtx1261R509); // PTX L1664
	r_PackedHalf2AtPtx1668R610 = HalfFma(r_PackedHalf2AtPtx1656R607, r_PackedHalf2AtPtx1664R609,
										 r_PackedHalf2AtPtx1254R511); // PTX L1668
	r_PackedHalf2AtPtx1672R633 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1229R605, r_PackedHalf2AtPtx1668R610); // PTX L1672
	r_LaneIndexAtPtx1676 = uint32_t((threadIdx.x & 31u));							 // PTX L1676
	r_PackedHalf2AtPtx1679R613 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1229R612, r_PackedHalf2AtPtx1247R503);			  // PTX L1679
	r_PackedHalf2AtPtx1683R614 = HalfMax(r_PackedHalf2AtPtx1679R613, r_PackedHalf2AtPtx1240R505); // PTX L1683
	r_PackedHalf2AtPtx1687R615 = HalfAbs(r_PackedHalf2AtPtx1683R614);							  // PTX L1687
	r_PackedHalf2AtPtx1691R616 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1687R615,
										 r_PackedHalf2AtPtx1261R509); // PTX L1691
	r_PackedHalf2AtPtx1695R617 = HalfFma(r_PackedHalf2AtPtx1683R614, r_PackedHalf2AtPtx1691R616,
										 r_PackedHalf2AtPtx1254R511); // PTX L1695
	r_PackedHalf2AtPtx1699R635 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1229R612, r_PackedHalf2AtPtx1695R617);			  // PTX L1699
	r_PtxRegister1291 = ShiftLeft(uint32_t(r_PtxRegister4856), uint32_t(10));					  // PTX L1702
	r_PtxU64Register130 = uint64_t(uint32_t(r_PtxRegister1291)) * uint64_t(uint32_t(4));		  // PTX L1703
	g_RecordByteAddressAtPtx1704 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register130); // PTX L1704
	r_LaneIndexAtPtx1706 = uint32_t((threadIdx.x & 31u));										  // PTX L1706
	r_PtxU64Register132 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1706)) * int64_t(int32_t(16))); // PTX L1708
	g_RecordByteAddressAtPtx1709 =
		uint64_t(g_RecordByteAddressAtPtx1704) + uint64_t(r_PtxU64Register132);				 // PTX L1709
	g_RecordByteAddressAtPtx1710 = uint64_t(g_RecordByteAddressAtPtx1709) + uint64_t(16384); // PTX L1710
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1710));
		r_MmaBE4x4WordAtPtx1712R636 = r_Value.x;
		r_MmaBE4x4WordAtPtx1712R637 = r_Value.y;
		r_MmaBE4x4WordAtPtx1712R642 = r_Value.z;
		r_MmaBE4x4WordAtPtx1712R643 = r_Value.w;
	} // PTX L1712
	r_LaneIndexAtPtx1715 = uint32_t((threadIdx.x & 31u)); // PTX L1715
	r_PtxU64Register134 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1715)) * int64_t(int32_t(16))); // PTX L1717
	g_RecordByteAddressAtPtx1718 =
		uint64_t(g_RecordByteAddressAtPtx1704) + uint64_t(r_PtxU64Register134);				 // PTX L1718
	g_RecordByteAddressAtPtx1719 = uint64_t(g_RecordByteAddressAtPtx1718) + uint64_t(16896); // PTX L1719
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1719));
		r_MmaBE4x4WordAtPtx1721R644 = r_Value.x;
		r_MmaBE4x4WordAtPtx1721R645 = r_Value.y;
		r_MmaBE4x4WordAtPtx1721R646 = r_Value.z;
		r_MmaBE4x4WordAtPtx1721R647 = r_Value.w;
	} // PTX L1721
	r_ConvertedE4PairAtPtx1724Rs81 = PublishE4(r_PackedHalf2AtPtx1294R620); // PTX L1724
	r_ConvertedE4PairAtPtx1727Rs82 = PublishE4(r_PackedHalf2AtPtx1348R621); // PTX L1727
	r_MmaAE4x4WordAtPtx1729R638 = JoinConvertedE4(r_ConvertedE4PairAtPtx1724Rs81,
												  r_ConvertedE4PairAtPtx1727Rs82); // PTX L1729
	r_ConvertedE4PairAtPtx1731Rs83 = PublishE4(r_PackedHalf2AtPtx1321R622);		   // PTX L1731
	r_ConvertedE4PairAtPtx1734Rs84 = PublishE4(r_PackedHalf2AtPtx1375R623);		   // PTX L1734
	r_MmaAE4x4WordAtPtx1736R639 = JoinConvertedE4(r_ConvertedE4PairAtPtx1731Rs83,
												  r_ConvertedE4PairAtPtx1734Rs84); // PTX L1736
	r_ConvertedE4PairAtPtx1738Rs85 = PublishE4(r_PackedHalf2AtPtx1402R624);		   // PTX L1738
	r_ConvertedE4PairAtPtx1741Rs86 = PublishE4(r_PackedHalf2AtPtx1456R625);		   // PTX L1741
	r_MmaAE4x4WordAtPtx1743R640 = JoinConvertedE4(r_ConvertedE4PairAtPtx1738Rs85,
												  r_ConvertedE4PairAtPtx1741Rs86); // PTX L1743
	r_ConvertedE4PairAtPtx1745Rs87 = PublishE4(r_PackedHalf2AtPtx1429R626);		   // PTX L1745
	r_ConvertedE4PairAtPtx1748Rs88 = PublishE4(r_PackedHalf2AtPtx1483R627);		   // PTX L1748
	r_MmaAE4x4WordAtPtx1750R641 = JoinConvertedE4(r_ConvertedE4PairAtPtx1745Rs87,
												  r_ConvertedE4PairAtPtx1748Rs88); // PTX L1750
	r_ConvertedE4PairAtPtx1752Rs89 = PublishE4(r_PackedHalf2AtPtx1510R628);		   // PTX L1752
	r_ConvertedE4PairAtPtx1755Rs90 = PublishE4(r_PackedHalf2AtPtx1564R629);		   // PTX L1755
	r_MmaAE4x4WordAtPtx1757R648 = JoinConvertedE4(r_ConvertedE4PairAtPtx1752Rs89,
												  r_ConvertedE4PairAtPtx1755Rs90); // PTX L1757
	r_ConvertedE4PairAtPtx1759Rs91 = PublishE4(r_PackedHalf2AtPtx1537R630);		   // PTX L1759
	r_ConvertedE4PairAtPtx1762Rs92 = PublishE4(r_PackedHalf2AtPtx1591R631);		   // PTX L1762
	r_MmaAE4x4WordAtPtx1764R649 = JoinConvertedE4(r_ConvertedE4PairAtPtx1759Rs91,
												  r_ConvertedE4PairAtPtx1762Rs92); // PTX L1764
	r_ConvertedE4PairAtPtx1766Rs93 = PublishE4(r_PackedHalf2AtPtx1618R632);		   // PTX L1766
	r_ConvertedE4PairAtPtx1769Rs94 = PublishE4(r_PackedHalf2AtPtx1672R633);		   // PTX L1769
	r_MmaAE4x4WordAtPtx1771R650 = JoinConvertedE4(r_ConvertedE4PairAtPtx1766Rs93,
												  r_ConvertedE4PairAtPtx1769Rs94); // PTX L1771
	r_ConvertedE4PairAtPtx1773Rs95 = PublishE4(r_PackedHalf2AtPtx1645R634);		   // PTX L1773
	r_ConvertedE4PairAtPtx1776Rs96 = PublishE4(r_PackedHalf2AtPtx1699R635);		   // PTX L1776
	r_MmaAE4x4WordAtPtx1778R651 = JoinConvertedE4(r_ConvertedE4PairAtPtx1773Rs95,
												  r_ConvertedE4PairAtPtx1776Rs96); // PTX L1778
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1780R820, r_MmaAccumulatorHalf2WordAtPtx1780R821,
		  r_MmaAE4x4WordAtPtx1729R638, r_MmaAE4x4WordAtPtx1736R639, r_MmaAE4x4WordAtPtx1743R640,
		  r_MmaAE4x4WordAtPtx1750R641, r_MmaBE4x4WordAtPtx1712R636, r_MmaBE4x4WordAtPtx1712R637,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1780
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1787R828, r_MmaAccumulatorHalf2WordAtPtx1787R829,
		  r_MmaAE4x4WordAtPtx1729R638, r_MmaAE4x4WordAtPtx1736R639, r_MmaAE4x4WordAtPtx1743R640,
		  r_MmaAE4x4WordAtPtx1750R641, r_MmaBE4x4WordAtPtx1712R642, r_MmaBE4x4WordAtPtx1712R643,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1787
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1794R832, r_MmaAccumulatorHalf2WordAtPtx1794R833,
		  r_MmaAE4x4WordAtPtx1729R638, r_MmaAE4x4WordAtPtx1736R639, r_MmaAE4x4WordAtPtx1743R640,
		  r_MmaAE4x4WordAtPtx1750R641, r_MmaBE4x4WordAtPtx1721R644, r_MmaBE4x4WordAtPtx1721R645,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1794
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1801R836, r_MmaAccumulatorHalf2WordAtPtx1801R837,
		  r_MmaAE4x4WordAtPtx1729R638, r_MmaAE4x4WordAtPtx1736R639, r_MmaAE4x4WordAtPtx1743R640,
		  r_MmaAE4x4WordAtPtx1750R641, r_MmaBE4x4WordAtPtx1721R646, r_MmaBE4x4WordAtPtx1721R647,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1801
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1808R838, r_MmaAccumulatorHalf2WordAtPtx1808R839,
		  r_MmaAE4x4WordAtPtx1757R648, r_MmaAE4x4WordAtPtx1764R649, r_MmaAE4x4WordAtPtx1771R650,
		  r_MmaAE4x4WordAtPtx1778R651, r_MmaBE4x4WordAtPtx1712R636, r_MmaBE4x4WordAtPtx1712R637,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1808
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1815R844, r_MmaAccumulatorHalf2WordAtPtx1815R845,
		  r_MmaAE4x4WordAtPtx1757R648, r_MmaAE4x4WordAtPtx1764R649, r_MmaAE4x4WordAtPtx1771R650,
		  r_MmaAE4x4WordAtPtx1778R651, r_MmaBE4x4WordAtPtx1712R642, r_MmaBE4x4WordAtPtx1712R643,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1815
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1822R846, r_MmaAccumulatorHalf2WordAtPtx1822R847,
		  r_MmaAE4x4WordAtPtx1757R648, r_MmaAE4x4WordAtPtx1764R649, r_MmaAE4x4WordAtPtx1771R650,
		  r_MmaAE4x4WordAtPtx1778R651, r_MmaBE4x4WordAtPtx1721R644, r_MmaBE4x4WordAtPtx1721R645,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1822
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1829R848, r_MmaAccumulatorHalf2WordAtPtx1829R849,
		  r_MmaAE4x4WordAtPtx1757R648, r_MmaAE4x4WordAtPtx1764R649, r_MmaAE4x4WordAtPtx1771R650,
		  r_MmaAE4x4WordAtPtx1778R651, r_MmaBE4x4WordAtPtx1721R646, r_MmaBE4x4WordAtPtx1721R647,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767);					  // PTX L1829
	r_LaneIndexAtPtx1836 = uint32_t((threadIdx.x & 31u)); // PTX L1836
	r_PtxU64Register136 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1836)) * int64_t(int32_t(16))); // PTX L1838
	g_RecordByteAddressAtPtx1839 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register136);				// PTX L1839
	g_RecordByteAddressAtPtx1840 = uint64_t(g_RecordByteAddressAtPtx1839) + uint64_t(1024); // PTX L1840
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1840));
		r_MmaBE4x4WordAtPtx1842R654 = r_Value.x;
		r_MmaBE4x4WordAtPtx1842R655 = r_Value.y;
		r_MmaBE4x4WordAtPtx1842R656 = r_Value.z;
		r_MmaBE4x4WordAtPtx1842R657 = r_Value.w;
	} // PTX L1842
	r_LaneIndexAtPtx1845 = uint32_t((threadIdx.x & 31u)); // PTX L1845
	r_PtxU64Register138 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1845)) * int64_t(int32_t(16))); // PTX L1847
	g_RecordByteAddressAtPtx1848 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register138);				// PTX L1848
	g_RecordByteAddressAtPtx1849 = uint64_t(g_RecordByteAddressAtPtx1848) + uint64_t(1536); // PTX L1849
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1849));
		r_MmaBE4x4WordAtPtx1851R658 = r_Value.x;
		r_MmaBE4x4WordAtPtx1851R659 = r_Value.y;
		r_MmaBE4x4WordAtPtx1851R660 = r_Value.z;
		r_MmaBE4x4WordAtPtx1851R661 = r_Value.w;
	} // PTX L1851
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1854R666, r_MmaAccumulatorHalf2WordAtPtx1854R667,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx1842R654, r_MmaBE4x4WordAtPtx1842R655,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1854
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1861R670, r_MmaAccumulatorHalf2WordAtPtx1861R671,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx1842R656, r_MmaBE4x4WordAtPtx1842R657,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1861
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1868R674, r_MmaAccumulatorHalf2WordAtPtx1868R675,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx1851R658, r_MmaBE4x4WordAtPtx1851R659,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1868
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1875R678, r_MmaAccumulatorHalf2WordAtPtx1875R679,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx1851R660, r_MmaBE4x4WordAtPtx1851R661,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1875
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1882R680, r_MmaAccumulatorHalf2WordAtPtx1882R681,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx1842R654, r_MmaBE4x4WordAtPtx1842R655,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1882
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1889R682, r_MmaAccumulatorHalf2WordAtPtx1889R683,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx1842R656, r_MmaBE4x4WordAtPtx1842R657,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1889
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1896R684, r_MmaAccumulatorHalf2WordAtPtx1896R685,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx1851R658, r_MmaBE4x4WordAtPtx1851R659,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L1896
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1903R686, r_MmaAccumulatorHalf2WordAtPtx1903R687,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx1851R660, r_MmaBE4x4WordAtPtx1851R661,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767);					  // PTX L1903
	r_LaneIndexAtPtx1910 = uint32_t((threadIdx.x & 31u)); // PTX L1910
	r_PtxU64Register140 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1910)) * int64_t(int32_t(16))); // PTX L1912
	g_RecordByteAddressAtPtx1913 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register140);				// PTX L1913
	g_RecordByteAddressAtPtx1914 = uint64_t(g_RecordByteAddressAtPtx1913) + uint64_t(5120); // PTX L1914
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1914));
		r_MmaBE4x4WordAtPtx1916R664 = r_Value.x;
		r_MmaBE4x4WordAtPtx1916R665 = r_Value.y;
		r_MmaBE4x4WordAtPtx1916R668 = r_Value.z;
		r_MmaBE4x4WordAtPtx1916R669 = r_Value.w;
	} // PTX L1916
	r_LaneIndexAtPtx1919 = uint32_t((threadIdx.x & 31u)); // PTX L1919
	r_PtxU64Register142 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1919)) * int64_t(int32_t(16))); // PTX L1921
	g_RecordByteAddressAtPtx1922 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register142);				// PTX L1922
	g_RecordByteAddressAtPtx1923 = uint64_t(g_RecordByteAddressAtPtx1922) + uint64_t(5632); // PTX L1923
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1923));
		r_MmaBE4x4WordAtPtx1925R672 = r_Value.x;
		r_MmaBE4x4WordAtPtx1925R673 = r_Value.y;
		r_MmaBE4x4WordAtPtx1925R676 = r_Value.z;
		r_MmaBE4x4WordAtPtx1925R677 = r_Value.w;
	} // PTX L1925
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1928R689, r_MmaAccumulatorHalf2WordAtPtx1928R696,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx1916R664, r_MmaBE4x4WordAtPtx1916R665,
		  r_MmaAccumulatorHalf2WordAtPtx1854R666,
		  r_MmaAccumulatorHalf2WordAtPtx1854R667); // PTX L1928
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1935R703, r_MmaAccumulatorHalf2WordAtPtx1935R710,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx1916R668, r_MmaBE4x4WordAtPtx1916R669,
		  r_MmaAccumulatorHalf2WordAtPtx1861R670,
		  r_MmaAccumulatorHalf2WordAtPtx1861R671); // PTX L1935
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1942R717, r_MmaAccumulatorHalf2WordAtPtx1942R724,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx1925R672, r_MmaBE4x4WordAtPtx1925R673,
		  r_MmaAccumulatorHalf2WordAtPtx1868R674,
		  r_MmaAccumulatorHalf2WordAtPtx1868R675); // PTX L1942
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1949R731, r_MmaAccumulatorHalf2WordAtPtx1949R738,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx1925R676, r_MmaBE4x4WordAtPtx1925R677,
		  r_MmaAccumulatorHalf2WordAtPtx1875R678,
		  r_MmaAccumulatorHalf2WordAtPtx1875R679); // PTX L1949
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1956R745, r_MmaAccumulatorHalf2WordAtPtx1956R752,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx1916R664, r_MmaBE4x4WordAtPtx1916R665,
		  r_MmaAccumulatorHalf2WordAtPtx1882R680,
		  r_MmaAccumulatorHalf2WordAtPtx1882R681); // PTX L1956
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1963R759, r_MmaAccumulatorHalf2WordAtPtx1963R766,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx1916R668, r_MmaBE4x4WordAtPtx1916R669,
		  r_MmaAccumulatorHalf2WordAtPtx1889R682,
		  r_MmaAccumulatorHalf2WordAtPtx1889R683); // PTX L1963
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1970R773, r_MmaAccumulatorHalf2WordAtPtx1970R780,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx1925R672, r_MmaBE4x4WordAtPtx1925R673,
		  r_MmaAccumulatorHalf2WordAtPtx1896R684,
		  r_MmaAccumulatorHalf2WordAtPtx1896R685); // PTX L1970
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1977R787, r_MmaAccumulatorHalf2WordAtPtx1977R794,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx1925R676, r_MmaBE4x4WordAtPtx1925R677,
		  r_MmaAccumulatorHalf2WordAtPtx1903R686,
		  r_MmaAccumulatorHalf2WordAtPtx1903R687);		  // PTX L1977
	r_LaneIndexAtPtx1984 = uint32_t((threadIdx.x & 31u)); // PTX L1984
	r_PackedHalf2AtPtx1987R690 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1928R689, r_PackedHalf2AtPtx1247R503);			  // PTX L1987
	r_PackedHalf2AtPtx1991R691 = HalfMax(r_PackedHalf2AtPtx1987R690, r_PackedHalf2AtPtx1240R505); // PTX L1991
	r_PackedHalf2AtPtx1995R692 = HalfAbs(r_PackedHalf2AtPtx1991R691);							  // PTX L1995
	r_PackedHalf2AtPtx1999R693 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx1995R692,
										 r_PackedHalf2AtPtx1261R509); // PTX L1999
	r_PackedHalf2AtPtx2003R694 = HalfFma(r_PackedHalf2AtPtx1991R691, r_PackedHalf2AtPtx1999R693,
										 r_PackedHalf2AtPtx1254R511); // PTX L2003
	r_PackedHalf2AtPtx2007R802 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1928R689, r_PackedHalf2AtPtx2003R694); // PTX L2007
	r_LaneIndexAtPtx2011 = uint32_t((threadIdx.x & 31u));							 // PTX L2011
	r_PackedHalf2AtPtx2014R697 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1928R696, r_PackedHalf2AtPtx1247R503);			  // PTX L2014
	r_PackedHalf2AtPtx2018R698 = HalfMax(r_PackedHalf2AtPtx2014R697, r_PackedHalf2AtPtx1240R505); // PTX L2018
	r_PackedHalf2AtPtx2022R699 = HalfAbs(r_PackedHalf2AtPtx2018R698);							  // PTX L2022
	r_PackedHalf2AtPtx2026R700 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2022R699,
										 r_PackedHalf2AtPtx1261R509); // PTX L2026
	r_PackedHalf2AtPtx2030R701 = HalfFma(r_PackedHalf2AtPtx2018R698, r_PackedHalf2AtPtx2026R700,
										 r_PackedHalf2AtPtx1254R511); // PTX L2030
	r_PackedHalf2AtPtx2034R804 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1928R696, r_PackedHalf2AtPtx2030R701); // PTX L2034
	r_LaneIndexAtPtx2038 = uint32_t((threadIdx.x & 31u));							 // PTX L2038
	r_PackedHalf2AtPtx2041R704 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1935R703, r_PackedHalf2AtPtx1247R503);			  // PTX L2041
	r_PackedHalf2AtPtx2045R705 = HalfMax(r_PackedHalf2AtPtx2041R704, r_PackedHalf2AtPtx1240R505); // PTX L2045
	r_PackedHalf2AtPtx2049R706 = HalfAbs(r_PackedHalf2AtPtx2045R705);							  // PTX L2049
	r_PackedHalf2AtPtx2053R707 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2049R706,
										 r_PackedHalf2AtPtx1261R509); // PTX L2053
	r_PackedHalf2AtPtx2057R708 = HalfFma(r_PackedHalf2AtPtx2045R705, r_PackedHalf2AtPtx2053R707,
										 r_PackedHalf2AtPtx1254R511); // PTX L2057
	r_PackedHalf2AtPtx2061R803 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1935R703, r_PackedHalf2AtPtx2057R708); // PTX L2061
	r_LaneIndexAtPtx2065 = uint32_t((threadIdx.x & 31u));							 // PTX L2065
	r_PackedHalf2AtPtx2068R711 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1935R710, r_PackedHalf2AtPtx1247R503);			  // PTX L2068
	r_PackedHalf2AtPtx2072R712 = HalfMax(r_PackedHalf2AtPtx2068R711, r_PackedHalf2AtPtx1240R505); // PTX L2072
	r_PackedHalf2AtPtx2076R713 = HalfAbs(r_PackedHalf2AtPtx2072R712);							  // PTX L2076
	r_PackedHalf2AtPtx2080R714 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2076R713,
										 r_PackedHalf2AtPtx1261R509); // PTX L2080
	r_PackedHalf2AtPtx2084R715 = HalfFma(r_PackedHalf2AtPtx2072R712, r_PackedHalf2AtPtx2080R714,
										 r_PackedHalf2AtPtx1254R511); // PTX L2084
	r_PackedHalf2AtPtx2088R805 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1935R710, r_PackedHalf2AtPtx2084R715); // PTX L2088
	r_LaneIndexAtPtx2092 = uint32_t((threadIdx.x & 31u));							 // PTX L2092
	r_PackedHalf2AtPtx2095R718 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1942R717, r_PackedHalf2AtPtx1247R503);			  // PTX L2095
	r_PackedHalf2AtPtx2099R719 = HalfMax(r_PackedHalf2AtPtx2095R718, r_PackedHalf2AtPtx1240R505); // PTX L2099
	r_PackedHalf2AtPtx2103R720 = HalfAbs(r_PackedHalf2AtPtx2099R719);							  // PTX L2103
	r_PackedHalf2AtPtx2107R721 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2103R720,
										 r_PackedHalf2AtPtx1261R509); // PTX L2107
	r_PackedHalf2AtPtx2111R722 = HalfFma(r_PackedHalf2AtPtx2099R719, r_PackedHalf2AtPtx2107R721,
										 r_PackedHalf2AtPtx1254R511); // PTX L2111
	r_PackedHalf2AtPtx2115R806 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1942R717, r_PackedHalf2AtPtx2111R722); // PTX L2115
	r_LaneIndexAtPtx2119 = uint32_t((threadIdx.x & 31u));							 // PTX L2119
	r_PackedHalf2AtPtx2122R725 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1942R724, r_PackedHalf2AtPtx1247R503);			  // PTX L2122
	r_PackedHalf2AtPtx2126R726 = HalfMax(r_PackedHalf2AtPtx2122R725, r_PackedHalf2AtPtx1240R505); // PTX L2126
	r_PackedHalf2AtPtx2130R727 = HalfAbs(r_PackedHalf2AtPtx2126R726);							  // PTX L2130
	r_PackedHalf2AtPtx2134R728 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2130R727,
										 r_PackedHalf2AtPtx1261R509); // PTX L2134
	r_PackedHalf2AtPtx2138R729 = HalfFma(r_PackedHalf2AtPtx2126R726, r_PackedHalf2AtPtx2134R728,
										 r_PackedHalf2AtPtx1254R511); // PTX L2138
	r_PackedHalf2AtPtx2142R808 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1942R724, r_PackedHalf2AtPtx2138R729); // PTX L2142
	r_LaneIndexAtPtx2146 = uint32_t((threadIdx.x & 31u));							 // PTX L2146
	r_PackedHalf2AtPtx2149R732 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1949R731, r_PackedHalf2AtPtx1247R503);			  // PTX L2149
	r_PackedHalf2AtPtx2153R733 = HalfMax(r_PackedHalf2AtPtx2149R732, r_PackedHalf2AtPtx1240R505); // PTX L2153
	r_PackedHalf2AtPtx2157R734 = HalfAbs(r_PackedHalf2AtPtx2153R733);							  // PTX L2157
	r_PackedHalf2AtPtx2161R735 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2157R734,
										 r_PackedHalf2AtPtx1261R509); // PTX L2161
	r_PackedHalf2AtPtx2165R736 = HalfFma(r_PackedHalf2AtPtx2153R733, r_PackedHalf2AtPtx2161R735,
										 r_PackedHalf2AtPtx1254R511); // PTX L2165
	r_PackedHalf2AtPtx2169R807 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1949R731, r_PackedHalf2AtPtx2165R736); // PTX L2169
	r_LaneIndexAtPtx2173 = uint32_t((threadIdx.x & 31u));							 // PTX L2173
	r_PackedHalf2AtPtx2176R739 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1949R738, r_PackedHalf2AtPtx1247R503);			  // PTX L2176
	r_PackedHalf2AtPtx2180R740 = HalfMax(r_PackedHalf2AtPtx2176R739, r_PackedHalf2AtPtx1240R505); // PTX L2180
	r_PackedHalf2AtPtx2184R741 = HalfAbs(r_PackedHalf2AtPtx2180R740);							  // PTX L2184
	r_PackedHalf2AtPtx2188R742 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2184R741,
										 r_PackedHalf2AtPtx1261R509); // PTX L2188
	r_PackedHalf2AtPtx2192R743 = HalfFma(r_PackedHalf2AtPtx2180R740, r_PackedHalf2AtPtx2188R742,
										 r_PackedHalf2AtPtx1254R511); // PTX L2192
	r_PackedHalf2AtPtx2196R809 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1949R738, r_PackedHalf2AtPtx2192R743); // PTX L2196
	r_LaneIndexAtPtx2200 = uint32_t((threadIdx.x & 31u));							 // PTX L2200
	r_PackedHalf2AtPtx2203R746 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1956R745, r_PackedHalf2AtPtx1247R503);			  // PTX L2203
	r_PackedHalf2AtPtx2207R747 = HalfMax(r_PackedHalf2AtPtx2203R746, r_PackedHalf2AtPtx1240R505); // PTX L2207
	r_PackedHalf2AtPtx2211R748 = HalfAbs(r_PackedHalf2AtPtx2207R747);							  // PTX L2211
	r_PackedHalf2AtPtx2215R749 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2211R748,
										 r_PackedHalf2AtPtx1261R509); // PTX L2215
	r_PackedHalf2AtPtx2219R750 = HalfFma(r_PackedHalf2AtPtx2207R747, r_PackedHalf2AtPtx2215R749,
										 r_PackedHalf2AtPtx1254R511); // PTX L2219
	r_PackedHalf2AtPtx2223R810 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1956R745, r_PackedHalf2AtPtx2219R750); // PTX L2223
	r_LaneIndexAtPtx2227 = uint32_t((threadIdx.x & 31u));							 // PTX L2227
	r_PackedHalf2AtPtx2230R753 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1956R752, r_PackedHalf2AtPtx1247R503);			  // PTX L2230
	r_PackedHalf2AtPtx2234R754 = HalfMax(r_PackedHalf2AtPtx2230R753, r_PackedHalf2AtPtx1240R505); // PTX L2234
	r_PackedHalf2AtPtx2238R755 = HalfAbs(r_PackedHalf2AtPtx2234R754);							  // PTX L2238
	r_PackedHalf2AtPtx2242R756 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2238R755,
										 r_PackedHalf2AtPtx1261R509); // PTX L2242
	r_PackedHalf2AtPtx2246R757 = HalfFma(r_PackedHalf2AtPtx2234R754, r_PackedHalf2AtPtx2242R756,
										 r_PackedHalf2AtPtx1254R511); // PTX L2246
	r_PackedHalf2AtPtx2250R812 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1956R752, r_PackedHalf2AtPtx2246R757); // PTX L2250
	r_LaneIndexAtPtx2254 = uint32_t((threadIdx.x & 31u));							 // PTX L2254
	r_PackedHalf2AtPtx2257R760 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1963R759, r_PackedHalf2AtPtx1247R503);			  // PTX L2257
	r_PackedHalf2AtPtx2261R761 = HalfMax(r_PackedHalf2AtPtx2257R760, r_PackedHalf2AtPtx1240R505); // PTX L2261
	r_PackedHalf2AtPtx2265R762 = HalfAbs(r_PackedHalf2AtPtx2261R761);							  // PTX L2265
	r_PackedHalf2AtPtx2269R763 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2265R762,
										 r_PackedHalf2AtPtx1261R509); // PTX L2269
	r_PackedHalf2AtPtx2273R764 = HalfFma(r_PackedHalf2AtPtx2261R761, r_PackedHalf2AtPtx2269R763,
										 r_PackedHalf2AtPtx1254R511); // PTX L2273
	r_PackedHalf2AtPtx2277R811 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1963R759, r_PackedHalf2AtPtx2273R764); // PTX L2277
	r_LaneIndexAtPtx2281 = uint32_t((threadIdx.x & 31u));							 // PTX L2281
	r_PackedHalf2AtPtx2284R767 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1963R766, r_PackedHalf2AtPtx1247R503);			  // PTX L2284
	r_PackedHalf2AtPtx2288R768 = HalfMax(r_PackedHalf2AtPtx2284R767, r_PackedHalf2AtPtx1240R505); // PTX L2288
	r_PackedHalf2AtPtx2292R769 = HalfAbs(r_PackedHalf2AtPtx2288R768);							  // PTX L2292
	r_PackedHalf2AtPtx2296R770 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2292R769,
										 r_PackedHalf2AtPtx1261R509); // PTX L2296
	r_PackedHalf2AtPtx2300R771 = HalfFma(r_PackedHalf2AtPtx2288R768, r_PackedHalf2AtPtx2296R770,
										 r_PackedHalf2AtPtx1254R511); // PTX L2300
	r_PackedHalf2AtPtx2304R813 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1963R766, r_PackedHalf2AtPtx2300R771); // PTX L2304
	r_LaneIndexAtPtx2308 = uint32_t((threadIdx.x & 31u));							 // PTX L2308
	r_PackedHalf2AtPtx2311R774 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1970R773, r_PackedHalf2AtPtx1247R503);			  // PTX L2311
	r_PackedHalf2AtPtx2315R775 = HalfMax(r_PackedHalf2AtPtx2311R774, r_PackedHalf2AtPtx1240R505); // PTX L2315
	r_PackedHalf2AtPtx2319R776 = HalfAbs(r_PackedHalf2AtPtx2315R775);							  // PTX L2319
	r_PackedHalf2AtPtx2323R777 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2319R776,
										 r_PackedHalf2AtPtx1261R509); // PTX L2323
	r_PackedHalf2AtPtx2327R778 = HalfFma(r_PackedHalf2AtPtx2315R775, r_PackedHalf2AtPtx2323R777,
										 r_PackedHalf2AtPtx1254R511); // PTX L2327
	r_PackedHalf2AtPtx2331R814 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1970R773, r_PackedHalf2AtPtx2327R778); // PTX L2331
	r_LaneIndexAtPtx2335 = uint32_t((threadIdx.x & 31u));							 // PTX L2335
	r_PackedHalf2AtPtx2338R781 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1970R780, r_PackedHalf2AtPtx1247R503);			  // PTX L2338
	r_PackedHalf2AtPtx2342R782 = HalfMax(r_PackedHalf2AtPtx2338R781, r_PackedHalf2AtPtx1240R505); // PTX L2342
	r_PackedHalf2AtPtx2346R783 = HalfAbs(r_PackedHalf2AtPtx2342R782);							  // PTX L2346
	r_PackedHalf2AtPtx2350R784 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2346R783,
										 r_PackedHalf2AtPtx1261R509); // PTX L2350
	r_PackedHalf2AtPtx2354R785 = HalfFma(r_PackedHalf2AtPtx2342R782, r_PackedHalf2AtPtx2350R784,
										 r_PackedHalf2AtPtx1254R511); // PTX L2354
	r_PackedHalf2AtPtx2358R816 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1970R780, r_PackedHalf2AtPtx2354R785); // PTX L2358
	r_LaneIndexAtPtx2362 = uint32_t((threadIdx.x & 31u));							 // PTX L2362
	r_PackedHalf2AtPtx2365R788 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1977R787, r_PackedHalf2AtPtx1247R503);			  // PTX L2365
	r_PackedHalf2AtPtx2369R789 = HalfMax(r_PackedHalf2AtPtx2365R788, r_PackedHalf2AtPtx1240R505); // PTX L2369
	r_PackedHalf2AtPtx2373R790 = HalfAbs(r_PackedHalf2AtPtx2369R789);							  // PTX L2373
	r_PackedHalf2AtPtx2377R791 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2373R790,
										 r_PackedHalf2AtPtx1261R509); // PTX L2377
	r_PackedHalf2AtPtx2381R792 = HalfFma(r_PackedHalf2AtPtx2369R789, r_PackedHalf2AtPtx2377R791,
										 r_PackedHalf2AtPtx1254R511); // PTX L2381
	r_PackedHalf2AtPtx2385R815 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1977R787, r_PackedHalf2AtPtx2381R792); // PTX L2385
	r_LaneIndexAtPtx2389 = uint32_t((threadIdx.x & 31u));							 // PTX L2389
	r_PackedHalf2AtPtx2392R795 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1977R794, r_PackedHalf2AtPtx1247R503);			  // PTX L2392
	r_PackedHalf2AtPtx2396R796 = HalfMax(r_PackedHalf2AtPtx2392R795, r_PackedHalf2AtPtx1240R505); // PTX L2396
	r_PackedHalf2AtPtx2400R797 = HalfAbs(r_PackedHalf2AtPtx2396R796);							  // PTX L2400
	r_PackedHalf2AtPtx2404R798 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2400R797,
										 r_PackedHalf2AtPtx1261R509); // PTX L2404
	r_PackedHalf2AtPtx2408R799 = HalfFma(r_PackedHalf2AtPtx2396R796, r_PackedHalf2AtPtx2404R798,
										 r_PackedHalf2AtPtx1254R511); // PTX L2408
	r_PackedHalf2AtPtx2412R817 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1977R794, r_PackedHalf2AtPtx2408R799); // PTX L2412
	r_LaneIndexAtPtx2416 = uint32_t((threadIdx.x & 31u));							 // PTX L2416
	r_PtxU64Register144 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2416)) * int64_t(int32_t(16))); // PTX L2418
	g_RecordByteAddressAtPtx2419 =
		uint64_t(g_RecordByteAddressAtPtx1704) + uint64_t(r_PtxU64Register144);				 // PTX L2419
	g_RecordByteAddressAtPtx2420 = uint64_t(g_RecordByteAddressAtPtx2419) + uint64_t(17408); // PTX L2420
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2420));
		r_MmaBE4x4WordAtPtx2422R818 = r_Value.x;
		r_MmaBE4x4WordAtPtx2422R819 = r_Value.y;
		r_MmaBE4x4WordAtPtx2422R826 = r_Value.z;
		r_MmaBE4x4WordAtPtx2422R827 = r_Value.w;
	} // PTX L2422
	r_LaneIndexAtPtx2425 = uint32_t((threadIdx.x & 31u)); // PTX L2425
	r_PtxU64Register146 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2425)) * int64_t(int32_t(16))); // PTX L2427
	g_RecordByteAddressAtPtx2428 =
		uint64_t(g_RecordByteAddressAtPtx1704) + uint64_t(r_PtxU64Register146);				 // PTX L2428
	g_RecordByteAddressAtPtx2429 = uint64_t(g_RecordByteAddressAtPtx2428) + uint64_t(17920); // PTX L2429
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2429));
		r_MmaBE4x4WordAtPtx2431R830 = r_Value.x;
		r_MmaBE4x4WordAtPtx2431R831 = r_Value.y;
		r_MmaBE4x4WordAtPtx2431R834 = r_Value.z;
		r_MmaBE4x4WordAtPtx2431R835 = r_Value.w;
	} // PTX L2431
	r_ConvertedE4PairAtPtx2434Rs97 = PublishE4(r_PackedHalf2AtPtx2007R802); // PTX L2434
	r_ConvertedE4PairAtPtx2437Rs98 = PublishE4(r_PackedHalf2AtPtx2061R803); // PTX L2437
	r_MmaAE4x4WordAtPtx2439R822 = JoinConvertedE4(r_ConvertedE4PairAtPtx2434Rs97,
												  r_ConvertedE4PairAtPtx2437Rs98); // PTX L2439
	r_ConvertedE4PairAtPtx2441Rs99 = PublishE4(r_PackedHalf2AtPtx2034R804);		   // PTX L2441
	r_ConvertedE4PairAtPtx2444Rs100 = PublishE4(r_PackedHalf2AtPtx2088R805);	   // PTX L2444
	r_MmaAE4x4WordAtPtx2446R823 = JoinConvertedE4(r_ConvertedE4PairAtPtx2441Rs99,
												  r_ConvertedE4PairAtPtx2444Rs100); // PTX L2446
	r_ConvertedE4PairAtPtx2448Rs101 = PublishE4(r_PackedHalf2AtPtx2115R806);		// PTX L2448
	r_ConvertedE4PairAtPtx2451Rs102 = PublishE4(r_PackedHalf2AtPtx2169R807);		// PTX L2451
	r_MmaAE4x4WordAtPtx2453R824 = JoinConvertedE4(r_ConvertedE4PairAtPtx2448Rs101,
												  r_ConvertedE4PairAtPtx2451Rs102); // PTX L2453
	r_ConvertedE4PairAtPtx2455Rs103 = PublishE4(r_PackedHalf2AtPtx2142R808);		// PTX L2455
	r_ConvertedE4PairAtPtx2458Rs104 = PublishE4(r_PackedHalf2AtPtx2196R809);		// PTX L2458
	r_MmaAE4x4WordAtPtx2460R825 = JoinConvertedE4(r_ConvertedE4PairAtPtx2455Rs103,
												  r_ConvertedE4PairAtPtx2458Rs104); // PTX L2460
	r_ConvertedE4PairAtPtx2462Rs105 = PublishE4(r_PackedHalf2AtPtx2223R810);		// PTX L2462
	r_ConvertedE4PairAtPtx2465Rs106 = PublishE4(r_PackedHalf2AtPtx2277R811);		// PTX L2465
	r_MmaAE4x4WordAtPtx2467R840 = JoinConvertedE4(r_ConvertedE4PairAtPtx2462Rs105,
												  r_ConvertedE4PairAtPtx2465Rs106); // PTX L2467
	r_ConvertedE4PairAtPtx2469Rs107 = PublishE4(r_PackedHalf2AtPtx2250R812);		// PTX L2469
	r_ConvertedE4PairAtPtx2472Rs108 = PublishE4(r_PackedHalf2AtPtx2304R813);		// PTX L2472
	r_MmaAE4x4WordAtPtx2474R841 = JoinConvertedE4(r_ConvertedE4PairAtPtx2469Rs107,
												  r_ConvertedE4PairAtPtx2472Rs108); // PTX L2474
	r_ConvertedE4PairAtPtx2476Rs109 = PublishE4(r_PackedHalf2AtPtx2331R814);		// PTX L2476
	r_ConvertedE4PairAtPtx2479Rs110 = PublishE4(r_PackedHalf2AtPtx2385R815);		// PTX L2479
	r_MmaAE4x4WordAtPtx2481R842 = JoinConvertedE4(r_ConvertedE4PairAtPtx2476Rs109,
												  r_ConvertedE4PairAtPtx2479Rs110); // PTX L2481
	r_ConvertedE4PairAtPtx2483Rs111 = PublishE4(r_PackedHalf2AtPtx2358R816);		// PTX L2483
	r_ConvertedE4PairAtPtx2486Rs112 = PublishE4(r_PackedHalf2AtPtx2412R817);		// PTX L2486
	r_MmaAE4x4WordAtPtx2488R843 = JoinConvertedE4(r_ConvertedE4PairAtPtx2483Rs111,
												  r_ConvertedE4PairAtPtx2486Rs112); // PTX L2488
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2490R1018, r_MmaAccumulatorHalf2WordAtPtx2490R1019,
		  r_MmaAE4x4WordAtPtx2439R822, r_MmaAE4x4WordAtPtx2446R823, r_MmaAE4x4WordAtPtx2453R824,
		  r_MmaAE4x4WordAtPtx2460R825, r_MmaBE4x4WordAtPtx2422R818, r_MmaBE4x4WordAtPtx2422R819,
		  r_MmaAccumulatorHalf2WordAtPtx1780R820,
		  r_MmaAccumulatorHalf2WordAtPtx1780R821); // PTX L2490
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2497R1026, r_MmaAccumulatorHalf2WordAtPtx2497R1027,
		  r_MmaAE4x4WordAtPtx2439R822, r_MmaAE4x4WordAtPtx2446R823, r_MmaAE4x4WordAtPtx2453R824,
		  r_MmaAE4x4WordAtPtx2460R825, r_MmaBE4x4WordAtPtx2422R826, r_MmaBE4x4WordAtPtx2422R827,
		  r_MmaAccumulatorHalf2WordAtPtx1787R828,
		  r_MmaAccumulatorHalf2WordAtPtx1787R829); // PTX L2497
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2504R1030, r_MmaAccumulatorHalf2WordAtPtx2504R1031,
		  r_MmaAE4x4WordAtPtx2439R822, r_MmaAE4x4WordAtPtx2446R823, r_MmaAE4x4WordAtPtx2453R824,
		  r_MmaAE4x4WordAtPtx2460R825, r_MmaBE4x4WordAtPtx2431R830, r_MmaBE4x4WordAtPtx2431R831,
		  r_MmaAccumulatorHalf2WordAtPtx1794R832,
		  r_MmaAccumulatorHalf2WordAtPtx1794R833); // PTX L2504
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2511R1034, r_MmaAccumulatorHalf2WordAtPtx2511R1035,
		  r_MmaAE4x4WordAtPtx2439R822, r_MmaAE4x4WordAtPtx2446R823, r_MmaAE4x4WordAtPtx2453R824,
		  r_MmaAE4x4WordAtPtx2460R825, r_MmaBE4x4WordAtPtx2431R834, r_MmaBE4x4WordAtPtx2431R835,
		  r_MmaAccumulatorHalf2WordAtPtx1801R836,
		  r_MmaAccumulatorHalf2WordAtPtx1801R837); // PTX L2511
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2518R1036, r_MmaAccumulatorHalf2WordAtPtx2518R1037,
		  r_MmaAE4x4WordAtPtx2467R840, r_MmaAE4x4WordAtPtx2474R841, r_MmaAE4x4WordAtPtx2481R842,
		  r_MmaAE4x4WordAtPtx2488R843, r_MmaBE4x4WordAtPtx2422R818, r_MmaBE4x4WordAtPtx2422R819,
		  r_MmaAccumulatorHalf2WordAtPtx1808R838,
		  r_MmaAccumulatorHalf2WordAtPtx1808R839); // PTX L2518
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2525R1042, r_MmaAccumulatorHalf2WordAtPtx2525R1043,
		  r_MmaAE4x4WordAtPtx2467R840, r_MmaAE4x4WordAtPtx2474R841, r_MmaAE4x4WordAtPtx2481R842,
		  r_MmaAE4x4WordAtPtx2488R843, r_MmaBE4x4WordAtPtx2422R826, r_MmaBE4x4WordAtPtx2422R827,
		  r_MmaAccumulatorHalf2WordAtPtx1815R844,
		  r_MmaAccumulatorHalf2WordAtPtx1815R845); // PTX L2525
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2532R1044, r_MmaAccumulatorHalf2WordAtPtx2532R1045,
		  r_MmaAE4x4WordAtPtx2467R840, r_MmaAE4x4WordAtPtx2474R841, r_MmaAE4x4WordAtPtx2481R842,
		  r_MmaAE4x4WordAtPtx2488R843, r_MmaBE4x4WordAtPtx2431R830, r_MmaBE4x4WordAtPtx2431R831,
		  r_MmaAccumulatorHalf2WordAtPtx1822R846,
		  r_MmaAccumulatorHalf2WordAtPtx1822R847); // PTX L2532
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2539R1046, r_MmaAccumulatorHalf2WordAtPtx2539R1047,
		  r_MmaAE4x4WordAtPtx2467R840, r_MmaAE4x4WordAtPtx2474R841, r_MmaAE4x4WordAtPtx2481R842,
		  r_MmaAE4x4WordAtPtx2488R843, r_MmaBE4x4WordAtPtx2431R834, r_MmaBE4x4WordAtPtx2431R835,
		  r_MmaAccumulatorHalf2WordAtPtx1829R848,
		  r_MmaAccumulatorHalf2WordAtPtx1829R849);		  // PTX L2539
	r_LaneIndexAtPtx2546 = uint32_t((threadIdx.x & 31u)); // PTX L2546
	r_PtxU64Register148 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2546)) * int64_t(int32_t(16))); // PTX L2548
	g_RecordByteAddressAtPtx2549 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register148);				// PTX L2549
	g_RecordByteAddressAtPtx2550 = uint64_t(g_RecordByteAddressAtPtx2549) + uint64_t(2048); // PTX L2550
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2550));
		r_MmaBE4x4WordAtPtx2552R852 = r_Value.x;
		r_MmaBE4x4WordAtPtx2552R853 = r_Value.y;
		r_MmaBE4x4WordAtPtx2552R854 = r_Value.z;
		r_MmaBE4x4WordAtPtx2552R855 = r_Value.w;
	} // PTX L2552
	r_LaneIndexAtPtx2555 = uint32_t((threadIdx.x & 31u)); // PTX L2555
	r_PtxU64Register150 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2555)) * int64_t(int32_t(16))); // PTX L2557
	g_RecordByteAddressAtPtx2558 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register150);				// PTX L2558
	g_RecordByteAddressAtPtx2559 = uint64_t(g_RecordByteAddressAtPtx2558) + uint64_t(2560); // PTX L2559
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2559));
		r_MmaBE4x4WordAtPtx2561R856 = r_Value.x;
		r_MmaBE4x4WordAtPtx2561R857 = r_Value.y;
		r_MmaBE4x4WordAtPtx2561R858 = r_Value.z;
		r_MmaBE4x4WordAtPtx2561R859 = r_Value.w;
	} // PTX L2561
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2564R864, r_MmaAccumulatorHalf2WordAtPtx2564R865,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx2552R852, r_MmaBE4x4WordAtPtx2552R853,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L2564
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2571R868, r_MmaAccumulatorHalf2WordAtPtx2571R869,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx2552R854, r_MmaBE4x4WordAtPtx2552R855,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L2571
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2578R872, r_MmaAccumulatorHalf2WordAtPtx2578R873,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx2561R856, r_MmaBE4x4WordAtPtx2561R857,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L2578
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2585R876, r_MmaAccumulatorHalf2WordAtPtx2585R877,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx2561R858, r_MmaBE4x4WordAtPtx2561R859,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L2585
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2592R878, r_MmaAccumulatorHalf2WordAtPtx2592R879,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx2552R852, r_MmaBE4x4WordAtPtx2552R853,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L2592
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2599R880, r_MmaAccumulatorHalf2WordAtPtx2599R881,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx2552R854, r_MmaBE4x4WordAtPtx2552R855,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L2599
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2606R882, r_MmaAccumulatorHalf2WordAtPtx2606R883,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx2561R856, r_MmaBE4x4WordAtPtx2561R857,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767); // PTX L2606
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2613R884, r_MmaAccumulatorHalf2WordAtPtx2613R885,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx2561R858, r_MmaBE4x4WordAtPtx2561R859,
		  r_PackedHalf2AtPtx965R2767,
		  r_PackedHalf2AtPtx965R2767);					  // PTX L2613
	r_LaneIndexAtPtx2620 = uint32_t((threadIdx.x & 31u)); // PTX L2620
	r_PtxU64Register152 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2620)) * int64_t(int32_t(16))); // PTX L2622
	g_RecordByteAddressAtPtx2623 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register152);				// PTX L2623
	g_RecordByteAddressAtPtx2624 = uint64_t(g_RecordByteAddressAtPtx2623) + uint64_t(6144); // PTX L2624
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2624));
		r_MmaBE4x4WordAtPtx2626R862 = r_Value.x;
		r_MmaBE4x4WordAtPtx2626R863 = r_Value.y;
		r_MmaBE4x4WordAtPtx2626R866 = r_Value.z;
		r_MmaBE4x4WordAtPtx2626R867 = r_Value.w;
	} // PTX L2626
	r_LaneIndexAtPtx2629 = uint32_t((threadIdx.x & 31u)); // PTX L2629
	r_PtxU64Register154 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2629)) * int64_t(int32_t(16))); // PTX L2631
	g_RecordByteAddressAtPtx2632 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register154);				// PTX L2632
	g_RecordByteAddressAtPtx2633 = uint64_t(g_RecordByteAddressAtPtx2632) + uint64_t(6656); // PTX L2633
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2633));
		r_MmaBE4x4WordAtPtx2635R870 = r_Value.x;
		r_MmaBE4x4WordAtPtx2635R871 = r_Value.y;
		r_MmaBE4x4WordAtPtx2635R874 = r_Value.z;
		r_MmaBE4x4WordAtPtx2635R875 = r_Value.w;
	} // PTX L2635
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2638R887, r_MmaAccumulatorHalf2WordAtPtx2638R894,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx2626R862, r_MmaBE4x4WordAtPtx2626R863,
		  r_MmaAccumulatorHalf2WordAtPtx2564R864,
		  r_MmaAccumulatorHalf2WordAtPtx2564R865); // PTX L2638
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2645R901, r_MmaAccumulatorHalf2WordAtPtx2645R908,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx2626R866, r_MmaBE4x4WordAtPtx2626R867,
		  r_MmaAccumulatorHalf2WordAtPtx2571R868,
		  r_MmaAccumulatorHalf2WordAtPtx2571R869); // PTX L2645
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2652R915, r_MmaAccumulatorHalf2WordAtPtx2652R922,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx2635R870, r_MmaBE4x4WordAtPtx2635R871,
		  r_MmaAccumulatorHalf2WordAtPtx2578R872,
		  r_MmaAccumulatorHalf2WordAtPtx2578R873); // PTX L2652
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2659R929, r_MmaAccumulatorHalf2WordAtPtx2659R936,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx2635R874, r_MmaBE4x4WordAtPtx2635R875,
		  r_MmaAccumulatorHalf2WordAtPtx2585R876,
		  r_MmaAccumulatorHalf2WordAtPtx2585R877); // PTX L2659
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2666R943, r_MmaAccumulatorHalf2WordAtPtx2666R950,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx2626R862, r_MmaBE4x4WordAtPtx2626R863,
		  r_MmaAccumulatorHalf2WordAtPtx2592R878,
		  r_MmaAccumulatorHalf2WordAtPtx2592R879); // PTX L2666
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2673R957, r_MmaAccumulatorHalf2WordAtPtx2673R964,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx2626R866, r_MmaBE4x4WordAtPtx2626R867,
		  r_MmaAccumulatorHalf2WordAtPtx2599R880,
		  r_MmaAccumulatorHalf2WordAtPtx2599R881); // PTX L2673
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2680R971, r_MmaAccumulatorHalf2WordAtPtx2680R978,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx2635R870, r_MmaBE4x4WordAtPtx2635R871,
		  r_MmaAccumulatorHalf2WordAtPtx2606R882,
		  r_MmaAccumulatorHalf2WordAtPtx2606R883); // PTX L2680
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2687R985, r_MmaAccumulatorHalf2WordAtPtx2687R992,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx2635R874, r_MmaBE4x4WordAtPtx2635R875,
		  r_MmaAccumulatorHalf2WordAtPtx2613R884,
		  r_MmaAccumulatorHalf2WordAtPtx2613R885);		  // PTX L2687
	r_LaneIndexAtPtx2694 = uint32_t((threadIdx.x & 31u)); // PTX L2694
	r_PackedHalf2AtPtx2697R888 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2638R887, r_PackedHalf2AtPtx1247R503);			  // PTX L2697
	r_PackedHalf2AtPtx2701R889 = HalfMax(r_PackedHalf2AtPtx2697R888, r_PackedHalf2AtPtx1240R505); // PTX L2701
	r_PackedHalf2AtPtx2705R890 = HalfAbs(r_PackedHalf2AtPtx2701R889);							  // PTX L2705
	r_PackedHalf2AtPtx2709R891 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2705R890,
										 r_PackedHalf2AtPtx1261R509); // PTX L2709
	r_PackedHalf2AtPtx2713R892 = HalfFma(r_PackedHalf2AtPtx2701R889, r_PackedHalf2AtPtx2709R891,
										 r_PackedHalf2AtPtx1254R511); // PTX L2713
	r_PackedHalf2AtPtx2717R1000 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2638R887, r_PackedHalf2AtPtx2713R892); // PTX L2717
	r_LaneIndexAtPtx2721 = uint32_t((threadIdx.x & 31u));							 // PTX L2721
	r_PackedHalf2AtPtx2724R895 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2638R894, r_PackedHalf2AtPtx1247R503);			  // PTX L2724
	r_PackedHalf2AtPtx2728R896 = HalfMax(r_PackedHalf2AtPtx2724R895, r_PackedHalf2AtPtx1240R505); // PTX L2728
	r_PackedHalf2AtPtx2732R897 = HalfAbs(r_PackedHalf2AtPtx2728R896);							  // PTX L2732
	r_PackedHalf2AtPtx2736R898 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2732R897,
										 r_PackedHalf2AtPtx1261R509); // PTX L2736
	r_PackedHalf2AtPtx2740R899 = HalfFma(r_PackedHalf2AtPtx2728R896, r_PackedHalf2AtPtx2736R898,
										 r_PackedHalf2AtPtx1254R511); // PTX L2740
	r_PackedHalf2AtPtx2744R1002 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2638R894, r_PackedHalf2AtPtx2740R899); // PTX L2744
	r_LaneIndexAtPtx2748 = uint32_t((threadIdx.x & 31u));							 // PTX L2748
	r_PackedHalf2AtPtx2751R902 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2645R901, r_PackedHalf2AtPtx1247R503);			  // PTX L2751
	r_PackedHalf2AtPtx2755R903 = HalfMax(r_PackedHalf2AtPtx2751R902, r_PackedHalf2AtPtx1240R505); // PTX L2755
	r_PackedHalf2AtPtx2759R904 = HalfAbs(r_PackedHalf2AtPtx2755R903);							  // PTX L2759
	r_PackedHalf2AtPtx2763R905 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2759R904,
										 r_PackedHalf2AtPtx1261R509); // PTX L2763
	r_PackedHalf2AtPtx2767R906 = HalfFma(r_PackedHalf2AtPtx2755R903, r_PackedHalf2AtPtx2763R905,
										 r_PackedHalf2AtPtx1254R511); // PTX L2767
	r_PackedHalf2AtPtx2771R1001 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2645R901, r_PackedHalf2AtPtx2767R906); // PTX L2771
	r_LaneIndexAtPtx2775 = uint32_t((threadIdx.x & 31u));							 // PTX L2775
	r_PackedHalf2AtPtx2778R909 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2645R908, r_PackedHalf2AtPtx1247R503);			  // PTX L2778
	r_PackedHalf2AtPtx2782R910 = HalfMax(r_PackedHalf2AtPtx2778R909, r_PackedHalf2AtPtx1240R505); // PTX L2782
	r_PackedHalf2AtPtx2786R911 = HalfAbs(r_PackedHalf2AtPtx2782R910);							  // PTX L2786
	r_PackedHalf2AtPtx2790R912 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2786R911,
										 r_PackedHalf2AtPtx1261R509); // PTX L2790
	r_PackedHalf2AtPtx2794R913 = HalfFma(r_PackedHalf2AtPtx2782R910, r_PackedHalf2AtPtx2790R912,
										 r_PackedHalf2AtPtx1254R511); // PTX L2794
	r_PackedHalf2AtPtx2798R1003 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2645R908, r_PackedHalf2AtPtx2794R913); // PTX L2798
	r_LaneIndexAtPtx2802 = uint32_t((threadIdx.x & 31u));							 // PTX L2802
	r_PackedHalf2AtPtx2805R916 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2652R915, r_PackedHalf2AtPtx1247R503);			  // PTX L2805
	r_PackedHalf2AtPtx2809R917 = HalfMax(r_PackedHalf2AtPtx2805R916, r_PackedHalf2AtPtx1240R505); // PTX L2809
	r_PackedHalf2AtPtx2813R918 = HalfAbs(r_PackedHalf2AtPtx2809R917);							  // PTX L2813
	r_PackedHalf2AtPtx2817R919 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2813R918,
										 r_PackedHalf2AtPtx1261R509); // PTX L2817
	r_PackedHalf2AtPtx2821R920 = HalfFma(r_PackedHalf2AtPtx2809R917, r_PackedHalf2AtPtx2817R919,
										 r_PackedHalf2AtPtx1254R511); // PTX L2821
	r_PackedHalf2AtPtx2825R1004 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2652R915, r_PackedHalf2AtPtx2821R920); // PTX L2825
	r_LaneIndexAtPtx2829 = uint32_t((threadIdx.x & 31u));							 // PTX L2829
	r_PackedHalf2AtPtx2832R923 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2652R922, r_PackedHalf2AtPtx1247R503);			  // PTX L2832
	r_PackedHalf2AtPtx2836R924 = HalfMax(r_PackedHalf2AtPtx2832R923, r_PackedHalf2AtPtx1240R505); // PTX L2836
	r_PackedHalf2AtPtx2840R925 = HalfAbs(r_PackedHalf2AtPtx2836R924);							  // PTX L2840
	r_PackedHalf2AtPtx2844R926 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2840R925,
										 r_PackedHalf2AtPtx1261R509); // PTX L2844
	r_PackedHalf2AtPtx2848R927 = HalfFma(r_PackedHalf2AtPtx2836R924, r_PackedHalf2AtPtx2844R926,
										 r_PackedHalf2AtPtx1254R511); // PTX L2848
	r_PackedHalf2AtPtx2852R1006 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2652R922, r_PackedHalf2AtPtx2848R927); // PTX L2852
	r_LaneIndexAtPtx2856 = uint32_t((threadIdx.x & 31u));							 // PTX L2856
	r_PackedHalf2AtPtx2859R930 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2659R929, r_PackedHalf2AtPtx1247R503);			  // PTX L2859
	r_PackedHalf2AtPtx2863R931 = HalfMax(r_PackedHalf2AtPtx2859R930, r_PackedHalf2AtPtx1240R505); // PTX L2863
	r_PackedHalf2AtPtx2867R932 = HalfAbs(r_PackedHalf2AtPtx2863R931);							  // PTX L2867
	r_PackedHalf2AtPtx2871R933 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2867R932,
										 r_PackedHalf2AtPtx1261R509); // PTX L2871
	r_PackedHalf2AtPtx2875R934 = HalfFma(r_PackedHalf2AtPtx2863R931, r_PackedHalf2AtPtx2871R933,
										 r_PackedHalf2AtPtx1254R511); // PTX L2875
	r_PackedHalf2AtPtx2879R1005 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2659R929, r_PackedHalf2AtPtx2875R934); // PTX L2879
	r_LaneIndexAtPtx2883 = uint32_t((threadIdx.x & 31u));							 // PTX L2883
	r_PackedHalf2AtPtx2886R937 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2659R936, r_PackedHalf2AtPtx1247R503);			  // PTX L2886
	r_PackedHalf2AtPtx2890R938 = HalfMax(r_PackedHalf2AtPtx2886R937, r_PackedHalf2AtPtx1240R505); // PTX L2890
	r_PackedHalf2AtPtx2894R939 = HalfAbs(r_PackedHalf2AtPtx2890R938);							  // PTX L2894
	r_PackedHalf2AtPtx2898R940 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2894R939,
										 r_PackedHalf2AtPtx1261R509); // PTX L2898
	r_PackedHalf2AtPtx2902R941 = HalfFma(r_PackedHalf2AtPtx2890R938, r_PackedHalf2AtPtx2898R940,
										 r_PackedHalf2AtPtx1254R511); // PTX L2902
	r_PackedHalf2AtPtx2906R1007 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2659R936, r_PackedHalf2AtPtx2902R941); // PTX L2906
	r_LaneIndexAtPtx2910 = uint32_t((threadIdx.x & 31u));							 // PTX L2910
	r_PackedHalf2AtPtx2913R944 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2666R943, r_PackedHalf2AtPtx1247R503);			  // PTX L2913
	r_PackedHalf2AtPtx2917R945 = HalfMax(r_PackedHalf2AtPtx2913R944, r_PackedHalf2AtPtx1240R505); // PTX L2917
	r_PackedHalf2AtPtx2921R946 = HalfAbs(r_PackedHalf2AtPtx2917R945);							  // PTX L2921
	r_PackedHalf2AtPtx2925R947 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2921R946,
										 r_PackedHalf2AtPtx1261R509); // PTX L2925
	r_PackedHalf2AtPtx2929R948 = HalfFma(r_PackedHalf2AtPtx2917R945, r_PackedHalf2AtPtx2925R947,
										 r_PackedHalf2AtPtx1254R511); // PTX L2929
	r_PackedHalf2AtPtx2933R1008 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2666R943, r_PackedHalf2AtPtx2929R948); // PTX L2933
	r_LaneIndexAtPtx2937 = uint32_t((threadIdx.x & 31u));							 // PTX L2937
	r_PackedHalf2AtPtx2940R951 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2666R950, r_PackedHalf2AtPtx1247R503);			  // PTX L2940
	r_PackedHalf2AtPtx2944R952 = HalfMax(r_PackedHalf2AtPtx2940R951, r_PackedHalf2AtPtx1240R505); // PTX L2944
	r_PackedHalf2AtPtx2948R953 = HalfAbs(r_PackedHalf2AtPtx2944R952);							  // PTX L2948
	r_PackedHalf2AtPtx2952R954 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2948R953,
										 r_PackedHalf2AtPtx1261R509); // PTX L2952
	r_PackedHalf2AtPtx2956R955 = HalfFma(r_PackedHalf2AtPtx2944R952, r_PackedHalf2AtPtx2952R954,
										 r_PackedHalf2AtPtx1254R511); // PTX L2956
	r_PackedHalf2AtPtx2960R1010 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2666R950, r_PackedHalf2AtPtx2956R955); // PTX L2960
	r_LaneIndexAtPtx2964 = uint32_t((threadIdx.x & 31u));							 // PTX L2964
	r_PackedHalf2AtPtx2967R958 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2673R957, r_PackedHalf2AtPtx1247R503);			  // PTX L2967
	r_PackedHalf2AtPtx2971R959 = HalfMax(r_PackedHalf2AtPtx2967R958, r_PackedHalf2AtPtx1240R505); // PTX L2971
	r_PackedHalf2AtPtx2975R960 = HalfAbs(r_PackedHalf2AtPtx2971R959);							  // PTX L2975
	r_PackedHalf2AtPtx2979R961 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx2975R960,
										 r_PackedHalf2AtPtx1261R509); // PTX L2979
	r_PackedHalf2AtPtx2983R962 = HalfFma(r_PackedHalf2AtPtx2971R959, r_PackedHalf2AtPtx2979R961,
										 r_PackedHalf2AtPtx1254R511); // PTX L2983
	r_PackedHalf2AtPtx2987R1009 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2673R957, r_PackedHalf2AtPtx2983R962); // PTX L2987
	r_LaneIndexAtPtx2991 = uint32_t((threadIdx.x & 31u));							 // PTX L2991
	r_PackedHalf2AtPtx2994R965 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2673R964, r_PackedHalf2AtPtx1247R503);			  // PTX L2994
	r_PackedHalf2AtPtx2998R966 = HalfMax(r_PackedHalf2AtPtx2994R965, r_PackedHalf2AtPtx1240R505); // PTX L2998
	r_PackedHalf2AtPtx3002R967 = HalfAbs(r_PackedHalf2AtPtx2998R966);							  // PTX L3002
	r_PackedHalf2AtPtx3006R968 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3002R967,
										 r_PackedHalf2AtPtx1261R509); // PTX L3006
	r_PackedHalf2AtPtx3010R969 = HalfFma(r_PackedHalf2AtPtx2998R966, r_PackedHalf2AtPtx3006R968,
										 r_PackedHalf2AtPtx1254R511); // PTX L3010
	r_PackedHalf2AtPtx3014R1011 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2673R964, r_PackedHalf2AtPtx3010R969); // PTX L3014
	r_LaneIndexAtPtx3018 = uint32_t((threadIdx.x & 31u));							 // PTX L3018
	r_PackedHalf2AtPtx3021R972 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2680R971, r_PackedHalf2AtPtx1247R503);			  // PTX L3021
	r_PackedHalf2AtPtx3025R973 = HalfMax(r_PackedHalf2AtPtx3021R972, r_PackedHalf2AtPtx1240R505); // PTX L3025
	r_PackedHalf2AtPtx3029R974 = HalfAbs(r_PackedHalf2AtPtx3025R973);							  // PTX L3029
	r_PackedHalf2AtPtx3033R975 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3029R974,
										 r_PackedHalf2AtPtx1261R509); // PTX L3033
	r_PackedHalf2AtPtx3037R976 = HalfFma(r_PackedHalf2AtPtx3025R973, r_PackedHalf2AtPtx3033R975,
										 r_PackedHalf2AtPtx1254R511); // PTX L3037
	r_PackedHalf2AtPtx3041R1012 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2680R971, r_PackedHalf2AtPtx3037R976); // PTX L3041
	r_LaneIndexAtPtx3045 = uint32_t((threadIdx.x & 31u));							 // PTX L3045
	r_PackedHalf2AtPtx3048R979 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2680R978, r_PackedHalf2AtPtx1247R503);			  // PTX L3048
	r_PackedHalf2AtPtx3052R980 = HalfMax(r_PackedHalf2AtPtx3048R979, r_PackedHalf2AtPtx1240R505); // PTX L3052
	r_PackedHalf2AtPtx3056R981 = HalfAbs(r_PackedHalf2AtPtx3052R980);							  // PTX L3056
	r_PackedHalf2AtPtx3060R982 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3056R981,
										 r_PackedHalf2AtPtx1261R509); // PTX L3060
	r_PackedHalf2AtPtx3064R983 = HalfFma(r_PackedHalf2AtPtx3052R980, r_PackedHalf2AtPtx3060R982,
										 r_PackedHalf2AtPtx1254R511); // PTX L3064
	r_PackedHalf2AtPtx3068R1014 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2680R978, r_PackedHalf2AtPtx3064R983); // PTX L3068
	r_LaneIndexAtPtx3072 = uint32_t((threadIdx.x & 31u));							 // PTX L3072
	r_PackedHalf2AtPtx3075R986 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2687R985, r_PackedHalf2AtPtx1247R503);			  // PTX L3075
	r_PackedHalf2AtPtx3079R987 = HalfMax(r_PackedHalf2AtPtx3075R986, r_PackedHalf2AtPtx1240R505); // PTX L3079
	r_PackedHalf2AtPtx3083R988 = HalfAbs(r_PackedHalf2AtPtx3079R987);							  // PTX L3083
	r_PackedHalf2AtPtx3087R989 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3083R988,
										 r_PackedHalf2AtPtx1261R509); // PTX L3087
	r_PackedHalf2AtPtx3091R990 = HalfFma(r_PackedHalf2AtPtx3079R987, r_PackedHalf2AtPtx3087R989,
										 r_PackedHalf2AtPtx1254R511); // PTX L3091
	r_PackedHalf2AtPtx3095R1013 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2687R985, r_PackedHalf2AtPtx3091R990); // PTX L3095
	r_LaneIndexAtPtx3099 = uint32_t((threadIdx.x & 31u));							 // PTX L3099
	r_PackedHalf2AtPtx3102R993 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2687R992, r_PackedHalf2AtPtx1247R503);			  // PTX L3102
	r_PackedHalf2AtPtx3106R994 = HalfMax(r_PackedHalf2AtPtx3102R993, r_PackedHalf2AtPtx1240R505); // PTX L3106
	r_PackedHalf2AtPtx3110R995 = HalfAbs(r_PackedHalf2AtPtx3106R994);							  // PTX L3110
	r_PackedHalf2AtPtx3114R996 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3110R995,
										 r_PackedHalf2AtPtx1261R509); // PTX L3114
	r_PackedHalf2AtPtx3118R997 = HalfFma(r_PackedHalf2AtPtx3106R994, r_PackedHalf2AtPtx3114R996,
										 r_PackedHalf2AtPtx1254R511); // PTX L3118
	r_PackedHalf2AtPtx3122R1015 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2687R992, r_PackedHalf2AtPtx3118R997); // PTX L3122
	r_LaneIndexAtPtx3126 = uint32_t((threadIdx.x & 31u));							 // PTX L3126
	r_PtxU64Register156 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3126)) * int64_t(int32_t(16))); // PTX L3128
	g_RecordByteAddressAtPtx3129 =
		uint64_t(g_RecordByteAddressAtPtx1704) + uint64_t(r_PtxU64Register156);				 // PTX L3129
	g_RecordByteAddressAtPtx3130 = uint64_t(g_RecordByteAddressAtPtx3129) + uint64_t(18432); // PTX L3130
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3130));
		r_MmaBE4x4WordAtPtx3132R1016 = r_Value.x;
		r_MmaBE4x4WordAtPtx3132R1017 = r_Value.y;
		r_MmaBE4x4WordAtPtx3132R1024 = r_Value.z;
		r_MmaBE4x4WordAtPtx3132R1025 = r_Value.w;
	} // PTX L3132
	r_LaneIndexAtPtx3135 = uint32_t((threadIdx.x & 31u)); // PTX L3135
	r_PtxU64Register158 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3135)) * int64_t(int32_t(16))); // PTX L3137
	g_RecordByteAddressAtPtx3138 =
		uint64_t(g_RecordByteAddressAtPtx1704) + uint64_t(r_PtxU64Register158);				 // PTX L3138
	g_RecordByteAddressAtPtx3139 = uint64_t(g_RecordByteAddressAtPtx3138) + uint64_t(18944); // PTX L3139
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3139));
		r_MmaBE4x4WordAtPtx3141R1028 = r_Value.x;
		r_MmaBE4x4WordAtPtx3141R1029 = r_Value.y;
		r_MmaBE4x4WordAtPtx3141R1032 = r_Value.z;
		r_MmaBE4x4WordAtPtx3141R1033 = r_Value.w;
	} // PTX L3141
	r_ConvertedE4PairAtPtx3144Rs113 = PublishE4(r_PackedHalf2AtPtx2717R1000); // PTX L3144
	r_ConvertedE4PairAtPtx3147Rs114 = PublishE4(r_PackedHalf2AtPtx2771R1001); // PTX L3147
	r_MmaAE4x4WordAtPtx3149R1020 = JoinConvertedE4(r_ConvertedE4PairAtPtx3144Rs113,
												   r_ConvertedE4PairAtPtx3147Rs114); // PTX L3149
	r_ConvertedE4PairAtPtx3151Rs115 = PublishE4(r_PackedHalf2AtPtx2744R1002);		 // PTX L3151
	r_ConvertedE4PairAtPtx3154Rs116 = PublishE4(r_PackedHalf2AtPtx2798R1003);		 // PTX L3154
	r_MmaAE4x4WordAtPtx3156R1021 = JoinConvertedE4(r_ConvertedE4PairAtPtx3151Rs115,
												   r_ConvertedE4PairAtPtx3154Rs116); // PTX L3156
	r_ConvertedE4PairAtPtx3158Rs117 = PublishE4(r_PackedHalf2AtPtx2825R1004);		 // PTX L3158
	r_ConvertedE4PairAtPtx3161Rs118 = PublishE4(r_PackedHalf2AtPtx2879R1005);		 // PTX L3161
	r_MmaAE4x4WordAtPtx3163R1022 = JoinConvertedE4(r_ConvertedE4PairAtPtx3158Rs117,
												   r_ConvertedE4PairAtPtx3161Rs118); // PTX L3163
	r_ConvertedE4PairAtPtx3165Rs119 = PublishE4(r_PackedHalf2AtPtx2852R1006);		 // PTX L3165
	r_ConvertedE4PairAtPtx3168Rs120 = PublishE4(r_PackedHalf2AtPtx2906R1007);		 // PTX L3168
	r_MmaAE4x4WordAtPtx3170R1023 = JoinConvertedE4(r_ConvertedE4PairAtPtx3165Rs119,
												   r_ConvertedE4PairAtPtx3168Rs120); // PTX L3170
	r_ConvertedE4PairAtPtx3172Rs121 = PublishE4(r_PackedHalf2AtPtx2933R1008);		 // PTX L3172
	r_ConvertedE4PairAtPtx3175Rs122 = PublishE4(r_PackedHalf2AtPtx2987R1009);		 // PTX L3175
	r_MmaAE4x4WordAtPtx3177R1038 = JoinConvertedE4(r_ConvertedE4PairAtPtx3172Rs121,
												   r_ConvertedE4PairAtPtx3175Rs122); // PTX L3177
	r_ConvertedE4PairAtPtx3179Rs123 = PublishE4(r_PackedHalf2AtPtx2960R1010);		 // PTX L3179
	r_ConvertedE4PairAtPtx3182Rs124 = PublishE4(r_PackedHalf2AtPtx3014R1011);		 // PTX L3182
	r_MmaAE4x4WordAtPtx3184R1039 = JoinConvertedE4(r_ConvertedE4PairAtPtx3179Rs123,
												   r_ConvertedE4PairAtPtx3182Rs124); // PTX L3184
	r_ConvertedE4PairAtPtx3186Rs125 = PublishE4(r_PackedHalf2AtPtx3041R1012);		 // PTX L3186
	r_ConvertedE4PairAtPtx3189Rs126 = PublishE4(r_PackedHalf2AtPtx3095R1013);		 // PTX L3189
	r_MmaAE4x4WordAtPtx3191R1040 = JoinConvertedE4(r_ConvertedE4PairAtPtx3186Rs125,
												   r_ConvertedE4PairAtPtx3189Rs126); // PTX L3191
	r_ConvertedE4PairAtPtx3193Rs127 = PublishE4(r_PackedHalf2AtPtx3068R1014);		 // PTX L3193
	r_ConvertedE4PairAtPtx3196Rs128 = PublishE4(r_PackedHalf2AtPtx3122R1015);		 // PTX L3196
	r_MmaAE4x4WordAtPtx3198R1041 = JoinConvertedE4(r_ConvertedE4PairAtPtx3193Rs127,
												   r_ConvertedE4PairAtPtx3196Rs128); // PTX L3198
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3200R1216, r_MmaAccumulatorHalf2WordAtPtx3200R1217,
		  r_MmaAE4x4WordAtPtx3149R1020, r_MmaAE4x4WordAtPtx3156R1021, r_MmaAE4x4WordAtPtx3163R1022,
		  r_MmaAE4x4WordAtPtx3170R1023, r_MmaBE4x4WordAtPtx3132R1016, r_MmaBE4x4WordAtPtx3132R1017,
		  r_MmaAccumulatorHalf2WordAtPtx2490R1018,
		  r_MmaAccumulatorHalf2WordAtPtx2490R1019); // PTX L3200
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3207R1224, r_MmaAccumulatorHalf2WordAtPtx3207R1225,
		  r_MmaAE4x4WordAtPtx3149R1020, r_MmaAE4x4WordAtPtx3156R1021, r_MmaAE4x4WordAtPtx3163R1022,
		  r_MmaAE4x4WordAtPtx3170R1023, r_MmaBE4x4WordAtPtx3132R1024, r_MmaBE4x4WordAtPtx3132R1025,
		  r_MmaAccumulatorHalf2WordAtPtx2497R1026,
		  r_MmaAccumulatorHalf2WordAtPtx2497R1027); // PTX L3207
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3214R1228, r_MmaAccumulatorHalf2WordAtPtx3214R1229,
		  r_MmaAE4x4WordAtPtx3149R1020, r_MmaAE4x4WordAtPtx3156R1021, r_MmaAE4x4WordAtPtx3163R1022,
		  r_MmaAE4x4WordAtPtx3170R1023, r_MmaBE4x4WordAtPtx3141R1028, r_MmaBE4x4WordAtPtx3141R1029,
		  r_MmaAccumulatorHalf2WordAtPtx2504R1030,
		  r_MmaAccumulatorHalf2WordAtPtx2504R1031); // PTX L3214
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3221R1232, r_MmaAccumulatorHalf2WordAtPtx3221R1233,
		  r_MmaAE4x4WordAtPtx3149R1020, r_MmaAE4x4WordAtPtx3156R1021, r_MmaAE4x4WordAtPtx3163R1022,
		  r_MmaAE4x4WordAtPtx3170R1023, r_MmaBE4x4WordAtPtx3141R1032, r_MmaBE4x4WordAtPtx3141R1033,
		  r_MmaAccumulatorHalf2WordAtPtx2511R1034,
		  r_MmaAccumulatorHalf2WordAtPtx2511R1035); // PTX L3221
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3228R1234, r_MmaAccumulatorHalf2WordAtPtx3228R1235,
		  r_MmaAE4x4WordAtPtx3177R1038, r_MmaAE4x4WordAtPtx3184R1039, r_MmaAE4x4WordAtPtx3191R1040,
		  r_MmaAE4x4WordAtPtx3198R1041, r_MmaBE4x4WordAtPtx3132R1016, r_MmaBE4x4WordAtPtx3132R1017,
		  r_MmaAccumulatorHalf2WordAtPtx2518R1036,
		  r_MmaAccumulatorHalf2WordAtPtx2518R1037); // PTX L3228
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3235R1240, r_MmaAccumulatorHalf2WordAtPtx3235R1241,
		  r_MmaAE4x4WordAtPtx3177R1038, r_MmaAE4x4WordAtPtx3184R1039, r_MmaAE4x4WordAtPtx3191R1040,
		  r_MmaAE4x4WordAtPtx3198R1041, r_MmaBE4x4WordAtPtx3132R1024, r_MmaBE4x4WordAtPtx3132R1025,
		  r_MmaAccumulatorHalf2WordAtPtx2525R1042,
		  r_MmaAccumulatorHalf2WordAtPtx2525R1043); // PTX L3235
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3242R1242, r_MmaAccumulatorHalf2WordAtPtx3242R1243,
		  r_MmaAE4x4WordAtPtx3177R1038, r_MmaAE4x4WordAtPtx3184R1039, r_MmaAE4x4WordAtPtx3191R1040,
		  r_MmaAE4x4WordAtPtx3198R1041, r_MmaBE4x4WordAtPtx3141R1028, r_MmaBE4x4WordAtPtx3141R1029,
		  r_MmaAccumulatorHalf2WordAtPtx2532R1044,
		  r_MmaAccumulatorHalf2WordAtPtx2532R1045); // PTX L3242
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3249R1244, r_MmaAccumulatorHalf2WordAtPtx3249R1245,
		  r_MmaAE4x4WordAtPtx3177R1038, r_MmaAE4x4WordAtPtx3184R1039, r_MmaAE4x4WordAtPtx3191R1040,
		  r_MmaAE4x4WordAtPtx3198R1041, r_MmaBE4x4WordAtPtx3141R1032, r_MmaBE4x4WordAtPtx3141R1033,
		  r_MmaAccumulatorHalf2WordAtPtx2539R1046,
		  r_MmaAccumulatorHalf2WordAtPtx2539R1047);		  // PTX L3249
	r_LaneIndexAtPtx3256 = uint32_t((threadIdx.x & 31u)); // PTX L3256
	r_PtxU64Register160 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3256)) * int64_t(int32_t(16))); // PTX L3258
	g_RecordByteAddressAtPtx3259 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register160);				// PTX L3259
	g_RecordByteAddressAtPtx3260 = uint64_t(g_RecordByteAddressAtPtx3259) + uint64_t(3072); // PTX L3260
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3260));
		r_MmaBE4x4WordAtPtx3262R1050 = r_Value.x;
		r_MmaBE4x4WordAtPtx3262R1051 = r_Value.y;
		r_MmaBE4x4WordAtPtx3262R1052 = r_Value.z;
		r_MmaBE4x4WordAtPtx3262R1053 = r_Value.w;
	} // PTX L3262
	r_LaneIndexAtPtx3265 = uint32_t((threadIdx.x & 31u)); // PTX L3265
	r_PtxU64Register162 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3265)) * int64_t(int32_t(16))); // PTX L3267
	g_RecordByteAddressAtPtx3268 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register162);				// PTX L3268
	g_RecordByteAddressAtPtx3269 = uint64_t(g_RecordByteAddressAtPtx3268) + uint64_t(3584); // PTX L3269
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3269));
		r_MmaBE4x4WordAtPtx3271R1054 = r_Value.x;
		r_MmaBE4x4WordAtPtx3271R1055 = r_Value.y;
		r_MmaBE4x4WordAtPtx3271R1056 = r_Value.z;
		r_MmaBE4x4WordAtPtx3271R1057 = r_Value.w;
	} // PTX L3271
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3274R1062, r_MmaAccumulatorHalf2WordAtPtx3274R1063,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx3262R1050, r_MmaBE4x4WordAtPtx3262R1051,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L3274
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3281R1066, r_MmaAccumulatorHalf2WordAtPtx3281R1067,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx3262R1052, r_MmaBE4x4WordAtPtx3262R1053,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L3281
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3288R1070, r_MmaAccumulatorHalf2WordAtPtx3288R1071,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx3271R1054, r_MmaBE4x4WordAtPtx3271R1055,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L3288
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3295R1074, r_MmaAccumulatorHalf2WordAtPtx3295R1075,
		  r_MmaAE4x4WordAtPtx999R432, r_MmaAE4x4WordAtPtx1006R433, r_MmaAE4x4WordAtPtx1013R434,
		  r_MmaAE4x4WordAtPtx1020R435, r_MmaBE4x4WordAtPtx3271R1056, r_MmaBE4x4WordAtPtx3271R1057,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L3295
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3302R1076, r_MmaAccumulatorHalf2WordAtPtx3302R1077,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx3262R1050, r_MmaBE4x4WordAtPtx3262R1051,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L3302
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3309R1078, r_MmaAccumulatorHalf2WordAtPtx3309R1079,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx3262R1052, r_MmaBE4x4WordAtPtx3262R1053,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L3309
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3316R1080, r_MmaAccumulatorHalf2WordAtPtx3316R1081,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx3271R1054, r_MmaBE4x4WordAtPtx3271R1055,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L3316
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3323R1082, r_MmaAccumulatorHalf2WordAtPtx3323R1083,
		  r_MmaAE4x4WordAtPtx1027R442, r_MmaAE4x4WordAtPtx1034R443, r_MmaAE4x4WordAtPtx1041R444,
		  r_MmaAE4x4WordAtPtx1048R445, r_MmaBE4x4WordAtPtx3271R1056, r_MmaBE4x4WordAtPtx3271R1057,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L3323
	r_LaneIndexAtPtx3330 = uint32_t((threadIdx.x & 31u));		   // PTX L3330
	r_PtxU64Register164 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3330)) * int64_t(int32_t(16))); // PTX L3332
	g_RecordByteAddressAtPtx3333 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register164);				// PTX L3333
	g_RecordByteAddressAtPtx3334 = uint64_t(g_RecordByteAddressAtPtx3333) + uint64_t(7168); // PTX L3334
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3334));
		r_MmaBE4x4WordAtPtx3336R1060 = r_Value.x;
		r_MmaBE4x4WordAtPtx3336R1061 = r_Value.y;
		r_MmaBE4x4WordAtPtx3336R1064 = r_Value.z;
		r_MmaBE4x4WordAtPtx3336R1065 = r_Value.w;
	} // PTX L3336
	r_LaneIndexAtPtx3339 = uint32_t((threadIdx.x & 31u)); // PTX L3339
	r_PtxU64Register166 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3339)) * int64_t(int32_t(16))); // PTX L3341
	g_RecordByteAddressAtPtx3342 =
		uint64_t(g_RecordByteAddressAtPtx975) + uint64_t(r_PtxU64Register166);				// PTX L3342
	g_RecordByteAddressAtPtx3343 = uint64_t(g_RecordByteAddressAtPtx3342) + uint64_t(7680); // PTX L3343
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3343));
		r_MmaBE4x4WordAtPtx3345R1068 = r_Value.x;
		r_MmaBE4x4WordAtPtx3345R1069 = r_Value.y;
		r_MmaBE4x4WordAtPtx3345R1072 = r_Value.z;
		r_MmaBE4x4WordAtPtx3345R1073 = r_Value.w;
	} // PTX L3345
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3348R1085, r_MmaAccumulatorHalf2WordAtPtx3348R1092,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx3336R1060, r_MmaBE4x4WordAtPtx3336R1061,
		  r_MmaAccumulatorHalf2WordAtPtx3274R1062,
		  r_MmaAccumulatorHalf2WordAtPtx3274R1063); // PTX L3348
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3355R1099, r_MmaAccumulatorHalf2WordAtPtx3355R1106,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx3336R1064, r_MmaBE4x4WordAtPtx3336R1065,
		  r_MmaAccumulatorHalf2WordAtPtx3281R1066,
		  r_MmaAccumulatorHalf2WordAtPtx3281R1067); // PTX L3355
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3362R1113, r_MmaAccumulatorHalf2WordAtPtx3362R1120,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx3345R1068, r_MmaBE4x4WordAtPtx3345R1069,
		  r_MmaAccumulatorHalf2WordAtPtx3288R1070,
		  r_MmaAccumulatorHalf2WordAtPtx3288R1071); // PTX L3362
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3369R1127, r_MmaAccumulatorHalf2WordAtPtx3369R1134,
		  r_MmaAE4x4WordAtPtx1129R468, r_MmaAE4x4WordAtPtx1136R469, r_MmaAE4x4WordAtPtx1143R470,
		  r_MmaAE4x4WordAtPtx1150R471, r_MmaBE4x4WordAtPtx3345R1072, r_MmaBE4x4WordAtPtx3345R1073,
		  r_MmaAccumulatorHalf2WordAtPtx3295R1074,
		  r_MmaAccumulatorHalf2WordAtPtx3295R1075); // PTX L3369
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3376R1141, r_MmaAccumulatorHalf2WordAtPtx3376R1148,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx3336R1060, r_MmaBE4x4WordAtPtx3336R1061,
		  r_MmaAccumulatorHalf2WordAtPtx3302R1076,
		  r_MmaAccumulatorHalf2WordAtPtx3302R1077); // PTX L3376
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3383R1155, r_MmaAccumulatorHalf2WordAtPtx3383R1162,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx3336R1064, r_MmaBE4x4WordAtPtx3336R1065,
		  r_MmaAccumulatorHalf2WordAtPtx3309R1078,
		  r_MmaAccumulatorHalf2WordAtPtx3309R1079); // PTX L3383
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3390R1169, r_MmaAccumulatorHalf2WordAtPtx3390R1176,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx3345R1068, r_MmaBE4x4WordAtPtx3345R1069,
		  r_MmaAccumulatorHalf2WordAtPtx3316R1080,
		  r_MmaAccumulatorHalf2WordAtPtx3316R1081); // PTX L3390
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3397R1183, r_MmaAccumulatorHalf2WordAtPtx3397R1190,
		  r_MmaAE4x4WordAtPtx1157R486, r_MmaAE4x4WordAtPtx1164R487, r_MmaAE4x4WordAtPtx1171R488,
		  r_MmaAE4x4WordAtPtx1178R489, r_MmaBE4x4WordAtPtx3345R1072, r_MmaBE4x4WordAtPtx3345R1073,
		  r_MmaAccumulatorHalf2WordAtPtx3323R1082,
		  r_MmaAccumulatorHalf2WordAtPtx3323R1083);		  // PTX L3397
	r_LaneIndexAtPtx3404 = uint32_t((threadIdx.x & 31u)); // PTX L3404
	r_PackedHalf2AtPtx3407R1086 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3348R1085, r_PackedHalf2AtPtx1247R503); // PTX L3407
	r_PackedHalf2AtPtx3411R1087 =
		HalfMax(r_PackedHalf2AtPtx3407R1086, r_PackedHalf2AtPtx1240R505); // PTX L3411
	r_PackedHalf2AtPtx3415R1088 = HalfAbs(r_PackedHalf2AtPtx3411R1087);	  // PTX L3415
	r_PackedHalf2AtPtx3419R1089 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3415R1088,
										  r_PackedHalf2AtPtx1261R509); // PTX L3419
	r_PackedHalf2AtPtx3423R1090 = HalfFma(r_PackedHalf2AtPtx3411R1087, r_PackedHalf2AtPtx3419R1089,
										  r_PackedHalf2AtPtx1254R511); // PTX L3423
	r_PackedHalf2AtPtx3427R1198 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3348R1085, r_PackedHalf2AtPtx3423R1090); // PTX L3427
	r_LaneIndexAtPtx3431 = uint32_t((threadIdx.x & 31u));							   // PTX L3431
	r_PackedHalf2AtPtx3434R1093 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3348R1092, r_PackedHalf2AtPtx1247R503); // PTX L3434
	r_PackedHalf2AtPtx3438R1094 =
		HalfMax(r_PackedHalf2AtPtx3434R1093, r_PackedHalf2AtPtx1240R505); // PTX L3438
	r_PackedHalf2AtPtx3442R1095 = HalfAbs(r_PackedHalf2AtPtx3438R1094);	  // PTX L3442
	r_PackedHalf2AtPtx3446R1096 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3442R1095,
										  r_PackedHalf2AtPtx1261R509); // PTX L3446
	r_PackedHalf2AtPtx3450R1097 = HalfFma(r_PackedHalf2AtPtx3438R1094, r_PackedHalf2AtPtx3446R1096,
										  r_PackedHalf2AtPtx1254R511); // PTX L3450
	r_PackedHalf2AtPtx3454R1200 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3348R1092, r_PackedHalf2AtPtx3450R1097); // PTX L3454
	r_LaneIndexAtPtx3458 = uint32_t((threadIdx.x & 31u));							   // PTX L3458
	r_PackedHalf2AtPtx3461R1100 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3355R1099, r_PackedHalf2AtPtx1247R503); // PTX L3461
	r_PackedHalf2AtPtx3465R1101 =
		HalfMax(r_PackedHalf2AtPtx3461R1100, r_PackedHalf2AtPtx1240R505); // PTX L3465
	r_PackedHalf2AtPtx3469R1102 = HalfAbs(r_PackedHalf2AtPtx3465R1101);	  // PTX L3469
	r_PackedHalf2AtPtx3473R1103 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3469R1102,
										  r_PackedHalf2AtPtx1261R509); // PTX L3473
	r_PackedHalf2AtPtx3477R1104 = HalfFma(r_PackedHalf2AtPtx3465R1101, r_PackedHalf2AtPtx3473R1103,
										  r_PackedHalf2AtPtx1254R511); // PTX L3477
	r_PackedHalf2AtPtx3481R1199 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3355R1099, r_PackedHalf2AtPtx3477R1104); // PTX L3481
	r_LaneIndexAtPtx3485 = uint32_t((threadIdx.x & 31u));							   // PTX L3485
	r_PackedHalf2AtPtx3488R1107 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3355R1106, r_PackedHalf2AtPtx1247R503); // PTX L3488
	r_PackedHalf2AtPtx3492R1108 =
		HalfMax(r_PackedHalf2AtPtx3488R1107, r_PackedHalf2AtPtx1240R505); // PTX L3492
	r_PackedHalf2AtPtx3496R1109 = HalfAbs(r_PackedHalf2AtPtx3492R1108);	  // PTX L3496
	r_PackedHalf2AtPtx3500R1110 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3496R1109,
										  r_PackedHalf2AtPtx1261R509); // PTX L3500
	r_PackedHalf2AtPtx3504R1111 = HalfFma(r_PackedHalf2AtPtx3492R1108, r_PackedHalf2AtPtx3500R1110,
										  r_PackedHalf2AtPtx1254R511); // PTX L3504
	r_PackedHalf2AtPtx3508R1201 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3355R1106, r_PackedHalf2AtPtx3504R1111); // PTX L3508
	r_LaneIndexAtPtx3512 = uint32_t((threadIdx.x & 31u));							   // PTX L3512
	r_PackedHalf2AtPtx3515R1114 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3362R1113, r_PackedHalf2AtPtx1247R503); // PTX L3515
	r_PackedHalf2AtPtx3519R1115 =
		HalfMax(r_PackedHalf2AtPtx3515R1114, r_PackedHalf2AtPtx1240R505); // PTX L3519
	r_PackedHalf2AtPtx3523R1116 = HalfAbs(r_PackedHalf2AtPtx3519R1115);	  // PTX L3523
	r_PackedHalf2AtPtx3527R1117 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3523R1116,
										  r_PackedHalf2AtPtx1261R509); // PTX L3527
	r_PackedHalf2AtPtx3531R1118 = HalfFma(r_PackedHalf2AtPtx3519R1115, r_PackedHalf2AtPtx3527R1117,
										  r_PackedHalf2AtPtx1254R511); // PTX L3531
	r_PackedHalf2AtPtx3535R1202 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3362R1113, r_PackedHalf2AtPtx3531R1118); // PTX L3535
	r_LaneIndexAtPtx3539 = uint32_t((threadIdx.x & 31u));							   // PTX L3539
	r_PackedHalf2AtPtx3542R1121 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3362R1120, r_PackedHalf2AtPtx1247R503); // PTX L3542
	r_PackedHalf2AtPtx3546R1122 =
		HalfMax(r_PackedHalf2AtPtx3542R1121, r_PackedHalf2AtPtx1240R505); // PTX L3546
	r_PackedHalf2AtPtx3550R1123 = HalfAbs(r_PackedHalf2AtPtx3546R1122);	  // PTX L3550
	r_PackedHalf2AtPtx3554R1124 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3550R1123,
										  r_PackedHalf2AtPtx1261R509); // PTX L3554
	r_PackedHalf2AtPtx3558R1125 = HalfFma(r_PackedHalf2AtPtx3546R1122, r_PackedHalf2AtPtx3554R1124,
										  r_PackedHalf2AtPtx1254R511); // PTX L3558
	r_PackedHalf2AtPtx3562R1204 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3362R1120, r_PackedHalf2AtPtx3558R1125); // PTX L3562
	r_LaneIndexAtPtx3566 = uint32_t((threadIdx.x & 31u));							   // PTX L3566
	r_PackedHalf2AtPtx3569R1128 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3369R1127, r_PackedHalf2AtPtx1247R503); // PTX L3569
	r_PackedHalf2AtPtx3573R1129 =
		HalfMax(r_PackedHalf2AtPtx3569R1128, r_PackedHalf2AtPtx1240R505); // PTX L3573
	r_PackedHalf2AtPtx3577R1130 = HalfAbs(r_PackedHalf2AtPtx3573R1129);	  // PTX L3577
	r_PackedHalf2AtPtx3581R1131 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3577R1130,
										  r_PackedHalf2AtPtx1261R509); // PTX L3581
	r_PackedHalf2AtPtx3585R1132 = HalfFma(r_PackedHalf2AtPtx3573R1129, r_PackedHalf2AtPtx3581R1131,
										  r_PackedHalf2AtPtx1254R511); // PTX L3585
	r_PackedHalf2AtPtx3589R1203 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3369R1127, r_PackedHalf2AtPtx3585R1132); // PTX L3589
	r_LaneIndexAtPtx3593 = uint32_t((threadIdx.x & 31u));							   // PTX L3593
	r_PackedHalf2AtPtx3596R1135 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3369R1134, r_PackedHalf2AtPtx1247R503); // PTX L3596
	r_PackedHalf2AtPtx3600R1136 =
		HalfMax(r_PackedHalf2AtPtx3596R1135, r_PackedHalf2AtPtx1240R505); // PTX L3600
	r_PackedHalf2AtPtx3604R1137 = HalfAbs(r_PackedHalf2AtPtx3600R1136);	  // PTX L3604
	r_PackedHalf2AtPtx3608R1138 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3604R1137,
										  r_PackedHalf2AtPtx1261R509); // PTX L3608
	r_PackedHalf2AtPtx3612R1139 = HalfFma(r_PackedHalf2AtPtx3600R1136, r_PackedHalf2AtPtx3608R1138,
										  r_PackedHalf2AtPtx1254R511); // PTX L3612
	r_PackedHalf2AtPtx3616R1205 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3369R1134, r_PackedHalf2AtPtx3612R1139); // PTX L3616
	r_LaneIndexAtPtx3620 = uint32_t((threadIdx.x & 31u));							   // PTX L3620
	r_PackedHalf2AtPtx3623R1142 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3376R1141, r_PackedHalf2AtPtx1247R503); // PTX L3623
	r_PackedHalf2AtPtx3627R1143 =
		HalfMax(r_PackedHalf2AtPtx3623R1142, r_PackedHalf2AtPtx1240R505); // PTX L3627
	r_PackedHalf2AtPtx3631R1144 = HalfAbs(r_PackedHalf2AtPtx3627R1143);	  // PTX L3631
	r_PackedHalf2AtPtx3635R1145 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3631R1144,
										  r_PackedHalf2AtPtx1261R509); // PTX L3635
	r_PackedHalf2AtPtx3639R1146 = HalfFma(r_PackedHalf2AtPtx3627R1143, r_PackedHalf2AtPtx3635R1145,
										  r_PackedHalf2AtPtx1254R511); // PTX L3639
	r_PackedHalf2AtPtx3643R1206 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3376R1141, r_PackedHalf2AtPtx3639R1146); // PTX L3643
	r_LaneIndexAtPtx3647 = uint32_t((threadIdx.x & 31u));							   // PTX L3647
	r_PackedHalf2AtPtx3650R1149 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3376R1148, r_PackedHalf2AtPtx1247R503); // PTX L3650
	r_PackedHalf2AtPtx3654R1150 =
		HalfMax(r_PackedHalf2AtPtx3650R1149, r_PackedHalf2AtPtx1240R505); // PTX L3654
	r_PackedHalf2AtPtx3658R1151 = HalfAbs(r_PackedHalf2AtPtx3654R1150);	  // PTX L3658
	r_PackedHalf2AtPtx3662R1152 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3658R1151,
										  r_PackedHalf2AtPtx1261R509); // PTX L3662
	r_PackedHalf2AtPtx3666R1153 = HalfFma(r_PackedHalf2AtPtx3654R1150, r_PackedHalf2AtPtx3662R1152,
										  r_PackedHalf2AtPtx1254R511); // PTX L3666
	r_PackedHalf2AtPtx3670R1208 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3376R1148, r_PackedHalf2AtPtx3666R1153); // PTX L3670
	r_LaneIndexAtPtx3674 = uint32_t((threadIdx.x & 31u));							   // PTX L3674
	r_PackedHalf2AtPtx3677R1156 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3383R1155, r_PackedHalf2AtPtx1247R503); // PTX L3677
	r_PackedHalf2AtPtx3681R1157 =
		HalfMax(r_PackedHalf2AtPtx3677R1156, r_PackedHalf2AtPtx1240R505); // PTX L3681
	r_PackedHalf2AtPtx3685R1158 = HalfAbs(r_PackedHalf2AtPtx3681R1157);	  // PTX L3685
	r_PackedHalf2AtPtx3689R1159 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3685R1158,
										  r_PackedHalf2AtPtx1261R509); // PTX L3689
	r_PackedHalf2AtPtx3693R1160 = HalfFma(r_PackedHalf2AtPtx3681R1157, r_PackedHalf2AtPtx3689R1159,
										  r_PackedHalf2AtPtx1254R511); // PTX L3693
	r_PackedHalf2AtPtx3697R1207 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3383R1155, r_PackedHalf2AtPtx3693R1160); // PTX L3697
	r_LaneIndexAtPtx3701 = uint32_t((threadIdx.x & 31u));							   // PTX L3701
	r_PackedHalf2AtPtx3704R1163 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3383R1162, r_PackedHalf2AtPtx1247R503); // PTX L3704
	r_PackedHalf2AtPtx3708R1164 =
		HalfMax(r_PackedHalf2AtPtx3704R1163, r_PackedHalf2AtPtx1240R505); // PTX L3708
	r_PackedHalf2AtPtx3712R1165 = HalfAbs(r_PackedHalf2AtPtx3708R1164);	  // PTX L3712
	r_PackedHalf2AtPtx3716R1166 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3712R1165,
										  r_PackedHalf2AtPtx1261R509); // PTX L3716
	r_PackedHalf2AtPtx3720R1167 = HalfFma(r_PackedHalf2AtPtx3708R1164, r_PackedHalf2AtPtx3716R1166,
										  r_PackedHalf2AtPtx1254R511); // PTX L3720
	r_PackedHalf2AtPtx3724R1209 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3383R1162, r_PackedHalf2AtPtx3720R1167); // PTX L3724
	r_LaneIndexAtPtx3728 = uint32_t((threadIdx.x & 31u));							   // PTX L3728
	r_PackedHalf2AtPtx3731R1170 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3390R1169, r_PackedHalf2AtPtx1247R503); // PTX L3731
	r_PackedHalf2AtPtx3735R1171 =
		HalfMax(r_PackedHalf2AtPtx3731R1170, r_PackedHalf2AtPtx1240R505); // PTX L3735
	r_PackedHalf2AtPtx3739R1172 = HalfAbs(r_PackedHalf2AtPtx3735R1171);	  // PTX L3739
	r_PackedHalf2AtPtx3743R1173 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3739R1172,
										  r_PackedHalf2AtPtx1261R509); // PTX L3743
	r_PackedHalf2AtPtx3747R1174 = HalfFma(r_PackedHalf2AtPtx3735R1171, r_PackedHalf2AtPtx3743R1173,
										  r_PackedHalf2AtPtx1254R511); // PTX L3747
	r_PackedHalf2AtPtx3751R1210 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3390R1169, r_PackedHalf2AtPtx3747R1174); // PTX L3751
	r_LaneIndexAtPtx3755 = uint32_t((threadIdx.x & 31u));							   // PTX L3755
	r_PackedHalf2AtPtx3758R1177 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3390R1176, r_PackedHalf2AtPtx1247R503); // PTX L3758
	r_PackedHalf2AtPtx3762R1178 =
		HalfMax(r_PackedHalf2AtPtx3758R1177, r_PackedHalf2AtPtx1240R505); // PTX L3762
	r_PackedHalf2AtPtx3766R1179 = HalfAbs(r_PackedHalf2AtPtx3762R1178);	  // PTX L3766
	r_PackedHalf2AtPtx3770R1180 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3766R1179,
										  r_PackedHalf2AtPtx1261R509); // PTX L3770
	r_PackedHalf2AtPtx3774R1181 = HalfFma(r_PackedHalf2AtPtx3762R1178, r_PackedHalf2AtPtx3770R1180,
										  r_PackedHalf2AtPtx1254R511); // PTX L3774
	r_PackedHalf2AtPtx3778R1212 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3390R1176, r_PackedHalf2AtPtx3774R1181); // PTX L3778
	r_LaneIndexAtPtx3782 = uint32_t((threadIdx.x & 31u));							   // PTX L3782
	r_PackedHalf2AtPtx3785R1184 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3397R1183, r_PackedHalf2AtPtx1247R503); // PTX L3785
	r_PackedHalf2AtPtx3789R1185 =
		HalfMax(r_PackedHalf2AtPtx3785R1184, r_PackedHalf2AtPtx1240R505); // PTX L3789
	r_PackedHalf2AtPtx3793R1186 = HalfAbs(r_PackedHalf2AtPtx3789R1185);	  // PTX L3793
	r_PackedHalf2AtPtx3797R1187 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3793R1186,
										  r_PackedHalf2AtPtx1261R509); // PTX L3797
	r_PackedHalf2AtPtx3801R1188 = HalfFma(r_PackedHalf2AtPtx3789R1185, r_PackedHalf2AtPtx3797R1187,
										  r_PackedHalf2AtPtx1254R511); // PTX L3801
	r_PackedHalf2AtPtx3805R1211 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3397R1183, r_PackedHalf2AtPtx3801R1188); // PTX L3805
	r_LaneIndexAtPtx3809 = uint32_t((threadIdx.x & 31u));							   // PTX L3809
	r_PackedHalf2AtPtx3812R1191 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx3397R1190, r_PackedHalf2AtPtx1247R503); // PTX L3812
	r_PackedHalf2AtPtx3816R1192 =
		HalfMax(r_PackedHalf2AtPtx3812R1191, r_PackedHalf2AtPtx1240R505); // PTX L3816
	r_PackedHalf2AtPtx3820R1193 = HalfAbs(r_PackedHalf2AtPtx3816R1192);	  // PTX L3820
	r_PackedHalf2AtPtx3824R1194 = HalfFma(r_PackedHalf2AtPtx1268R507, r_PackedHalf2AtPtx3820R1193,
										  r_PackedHalf2AtPtx1261R509); // PTX L3824
	r_PackedHalf2AtPtx3828R1195 = HalfFma(r_PackedHalf2AtPtx3816R1192, r_PackedHalf2AtPtx3824R1194,
										  r_PackedHalf2AtPtx1254R511); // PTX L3828
	r_PackedHalf2AtPtx3832R1213 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx3397R1190, r_PackedHalf2AtPtx3828R1195); // PTX L3832
	r_LaneIndexAtPtx3836 = uint32_t((threadIdx.x & 31u));							   // PTX L3836
	r_PtxU64Register168 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3836)) * int64_t(int32_t(16))); // PTX L3838
	g_RecordByteAddressAtPtx3839 =
		uint64_t(g_RecordByteAddressAtPtx1704) + uint64_t(r_PtxU64Register168);				 // PTX L3839
	g_RecordByteAddressAtPtx3840 = uint64_t(g_RecordByteAddressAtPtx3839) + uint64_t(19456); // PTX L3840
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3840));
		r_MmaBE4x4WordAtPtx3842R1214 = r_Value.x;
		r_MmaBE4x4WordAtPtx3842R1215 = r_Value.y;
		r_MmaBE4x4WordAtPtx3842R1222 = r_Value.z;
		r_MmaBE4x4WordAtPtx3842R1223 = r_Value.w;
	} // PTX L3842
	r_LaneIndexAtPtx3845 = uint32_t((threadIdx.x & 31u)); // PTX L3845
	r_PtxU64Register170 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3845)) * int64_t(int32_t(16))); // PTX L3847
	g_RecordByteAddressAtPtx3848 =
		uint64_t(g_RecordByteAddressAtPtx1704) + uint64_t(r_PtxU64Register170);				 // PTX L3848
	g_RecordByteAddressAtPtx3849 = uint64_t(g_RecordByteAddressAtPtx3848) + uint64_t(19968); // PTX L3849
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3849));
		r_MmaBE4x4WordAtPtx3851R1226 = r_Value.x;
		r_MmaBE4x4WordAtPtx3851R1227 = r_Value.y;
		r_MmaBE4x4WordAtPtx3851R1230 = r_Value.z;
		r_MmaBE4x4WordAtPtx3851R1231 = r_Value.w;
	} // PTX L3851
	r_ConvertedE4PairAtPtx3854Rs129 = PublishE4(r_PackedHalf2AtPtx3427R1198); // PTX L3854
	r_ConvertedE4PairAtPtx3857Rs130 = PublishE4(r_PackedHalf2AtPtx3481R1199); // PTX L3857
	r_MmaAE4x4WordAtPtx3859R1218 = JoinConvertedE4(r_ConvertedE4PairAtPtx3854Rs129,
												   r_ConvertedE4PairAtPtx3857Rs130); // PTX L3859
	r_ConvertedE4PairAtPtx3861Rs131 = PublishE4(r_PackedHalf2AtPtx3454R1200);		 // PTX L3861
	r_ConvertedE4PairAtPtx3864Rs132 = PublishE4(r_PackedHalf2AtPtx3508R1201);		 // PTX L3864
	r_MmaAE4x4WordAtPtx3866R1219 = JoinConvertedE4(r_ConvertedE4PairAtPtx3861Rs131,
												   r_ConvertedE4PairAtPtx3864Rs132); // PTX L3866
	r_ConvertedE4PairAtPtx3868Rs133 = PublishE4(r_PackedHalf2AtPtx3535R1202);		 // PTX L3868
	r_ConvertedE4PairAtPtx3871Rs134 = PublishE4(r_PackedHalf2AtPtx3589R1203);		 // PTX L3871
	r_MmaAE4x4WordAtPtx3873R1220 = JoinConvertedE4(r_ConvertedE4PairAtPtx3868Rs133,
												   r_ConvertedE4PairAtPtx3871Rs134); // PTX L3873
	r_ConvertedE4PairAtPtx3875Rs135 = PublishE4(r_PackedHalf2AtPtx3562R1204);		 // PTX L3875
	r_ConvertedE4PairAtPtx3878Rs136 = PublishE4(r_PackedHalf2AtPtx3616R1205);		 // PTX L3878
	r_MmaAE4x4WordAtPtx3880R1221 = JoinConvertedE4(r_ConvertedE4PairAtPtx3875Rs135,
												   r_ConvertedE4PairAtPtx3878Rs136); // PTX L3880
	r_ConvertedE4PairAtPtx3882Rs137 = PublishE4(r_PackedHalf2AtPtx3643R1206);		 // PTX L3882
	r_ConvertedE4PairAtPtx3885Rs138 = PublishE4(r_PackedHalf2AtPtx3697R1207);		 // PTX L3885
	r_MmaAE4x4WordAtPtx3887R1236 = JoinConvertedE4(r_ConvertedE4PairAtPtx3882Rs137,
												   r_ConvertedE4PairAtPtx3885Rs138); // PTX L3887
	r_ConvertedE4PairAtPtx3889Rs139 = PublishE4(r_PackedHalf2AtPtx3670R1208);		 // PTX L3889
	r_ConvertedE4PairAtPtx3892Rs140 = PublishE4(r_PackedHalf2AtPtx3724R1209);		 // PTX L3892
	r_MmaAE4x4WordAtPtx3894R1237 = JoinConvertedE4(r_ConvertedE4PairAtPtx3889Rs139,
												   r_ConvertedE4PairAtPtx3892Rs140); // PTX L3894
	r_ConvertedE4PairAtPtx3896Rs141 = PublishE4(r_PackedHalf2AtPtx3751R1210);		 // PTX L3896
	r_ConvertedE4PairAtPtx3899Rs142 = PublishE4(r_PackedHalf2AtPtx3805R1211);		 // PTX L3899
	r_MmaAE4x4WordAtPtx3901R1238 = JoinConvertedE4(r_ConvertedE4PairAtPtx3896Rs141,
												   r_ConvertedE4PairAtPtx3899Rs142); // PTX L3901
	r_ConvertedE4PairAtPtx3903Rs143 = PublishE4(r_PackedHalf2AtPtx3778R1212);		 // PTX L3903
	r_ConvertedE4PairAtPtx3906Rs144 = PublishE4(r_PackedHalf2AtPtx3832R1213);		 // PTX L3906
	r_MmaAE4x4WordAtPtx3908R1239 = JoinConvertedE4(r_ConvertedE4PairAtPtx3903Rs143,
												   r_ConvertedE4PairAtPtx3906Rs144); // PTX L3908
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3910R1250, r_MmaAccumulatorHalf2WordAtPtx3910R1252,
		  r_MmaAE4x4WordAtPtx3859R1218, r_MmaAE4x4WordAtPtx3866R1219, r_MmaAE4x4WordAtPtx3873R1220,
		  r_MmaAE4x4WordAtPtx3880R1221, r_MmaBE4x4WordAtPtx3842R1214, r_MmaBE4x4WordAtPtx3842R1215,
		  r_MmaAccumulatorHalf2WordAtPtx3200R1216,
		  r_MmaAccumulatorHalf2WordAtPtx3200R1217); // PTX L3910
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3917R1251, r_MmaAccumulatorHalf2WordAtPtx3917R1253,
		  r_MmaAE4x4WordAtPtx3859R1218, r_MmaAE4x4WordAtPtx3866R1219, r_MmaAE4x4WordAtPtx3873R1220,
		  r_MmaAE4x4WordAtPtx3880R1221, r_MmaBE4x4WordAtPtx3842R1222, r_MmaBE4x4WordAtPtx3842R1223,
		  r_MmaAccumulatorHalf2WordAtPtx3207R1224,
		  r_MmaAccumulatorHalf2WordAtPtx3207R1225); // PTX L3917
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3924R1254, r_MmaAccumulatorHalf2WordAtPtx3924R1256,
		  r_MmaAE4x4WordAtPtx3859R1218, r_MmaAE4x4WordAtPtx3866R1219, r_MmaAE4x4WordAtPtx3873R1220,
		  r_MmaAE4x4WordAtPtx3880R1221, r_MmaBE4x4WordAtPtx3851R1226, r_MmaBE4x4WordAtPtx3851R1227,
		  r_MmaAccumulatorHalf2WordAtPtx3214R1228,
		  r_MmaAccumulatorHalf2WordAtPtx3214R1229); // PTX L3924
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3931R1255, r_MmaAccumulatorHalf2WordAtPtx3931R1257,
		  r_MmaAE4x4WordAtPtx3859R1218, r_MmaAE4x4WordAtPtx3866R1219, r_MmaAE4x4WordAtPtx3873R1220,
		  r_MmaAE4x4WordAtPtx3880R1221, r_MmaBE4x4WordAtPtx3851R1230, r_MmaBE4x4WordAtPtx3851R1231,
		  r_MmaAccumulatorHalf2WordAtPtx3221R1232,
		  r_MmaAccumulatorHalf2WordAtPtx3221R1233); // PTX L3931
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3938R1258, r_MmaAccumulatorHalf2WordAtPtx3938R1260,
		  r_MmaAE4x4WordAtPtx3887R1236, r_MmaAE4x4WordAtPtx3894R1237, r_MmaAE4x4WordAtPtx3901R1238,
		  r_MmaAE4x4WordAtPtx3908R1239, r_MmaBE4x4WordAtPtx3842R1214, r_MmaBE4x4WordAtPtx3842R1215,
		  r_MmaAccumulatorHalf2WordAtPtx3228R1234,
		  r_MmaAccumulatorHalf2WordAtPtx3228R1235); // PTX L3938
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3945R1259, r_MmaAccumulatorHalf2WordAtPtx3945R1261,
		  r_MmaAE4x4WordAtPtx3887R1236, r_MmaAE4x4WordAtPtx3894R1237, r_MmaAE4x4WordAtPtx3901R1238,
		  r_MmaAE4x4WordAtPtx3908R1239, r_MmaBE4x4WordAtPtx3842R1222, r_MmaBE4x4WordAtPtx3842R1223,
		  r_MmaAccumulatorHalf2WordAtPtx3235R1240,
		  r_MmaAccumulatorHalf2WordAtPtx3235R1241); // PTX L3945
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3952R1262, r_MmaAccumulatorHalf2WordAtPtx3952R1264,
		  r_MmaAE4x4WordAtPtx3887R1236, r_MmaAE4x4WordAtPtx3894R1237, r_MmaAE4x4WordAtPtx3901R1238,
		  r_MmaAE4x4WordAtPtx3908R1239, r_MmaBE4x4WordAtPtx3851R1226, r_MmaBE4x4WordAtPtx3851R1227,
		  r_MmaAccumulatorHalf2WordAtPtx3242R1242,
		  r_MmaAccumulatorHalf2WordAtPtx3242R1243); // PTX L3952
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3959R1263, r_MmaAccumulatorHalf2WordAtPtx3959R1265,
		  r_MmaAE4x4WordAtPtx3887R1236, r_MmaAE4x4WordAtPtx3894R1237, r_MmaAE4x4WordAtPtx3901R1238,
		  r_MmaAE4x4WordAtPtx3908R1239, r_MmaBE4x4WordAtPtx3851R1230, r_MmaBE4x4WordAtPtx3851R1231,
		  r_MmaAccumulatorHalf2WordAtPtx3249R1244,
		  r_MmaAccumulatorHalf2WordAtPtx3249R1245);												  // PTX L3959
	r_PtxRegister1292 = ShiftLeft(uint32_t(r_PtxRegister4856), uint32_t(9));					  // PTX L3965
	r_PtxU64Register172 = uint64_t(uint32_t(r_PtxRegister1292)) * uint64_t(uint32_t(4));		  // PTX L3966
	g_RecordByteAddressAtPtx3967 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register172); // PTX L3967
	r_LaneIndexAtPtx3969 = uint32_t((threadIdx.x & 31u));										  // PTX L3969
	r_PtxU64Register174 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3969)) * int64_t(int32_t(16))); // PTX L3971
	g_RecordByteAddressAtPtx3972 =
		uint64_t(g_RecordByteAddressAtPtx3967) + uint64_t(r_PtxU64Register174);				 // PTX L3972
	g_RecordByteAddressAtPtx3973 = uint64_t(g_RecordByteAddressAtPtx3972) + uint64_t(24576); // PTX L3973
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3973));
		r_MmaBE4x4WordAtPtx3975R1266 = r_Value.x;
		r_MmaBE4x4WordAtPtx3975R1267 = r_Value.y;
		r_MmaBE4x4WordAtPtx3975R1272 = r_Value.z;
		r_MmaBE4x4WordAtPtx3975R1273 = r_Value.w;
	} // PTX L3975
	r_LaneIndexAtPtx3978 = uint32_t((threadIdx.x & 31u)); // PTX L3978
	r_PtxU64Register176 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3978)) * int64_t(int32_t(16))); // PTX L3980
	g_RecordByteAddressAtPtx3981 =
		uint64_t(g_RecordByteAddressAtPtx3967) + uint64_t(r_PtxU64Register176);				 // PTX L3981
	g_RecordByteAddressAtPtx3982 = uint64_t(g_RecordByteAddressAtPtx3981) + uint64_t(25088); // PTX L3982
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3982));
		r_MmaBE4x4WordAtPtx3984R1274 = r_Value.x;
		r_MmaBE4x4WordAtPtx3984R1275 = r_Value.y;
		r_MmaBE4x4WordAtPtx3984R1276 = r_Value.z;
		r_MmaBE4x4WordAtPtx3984R1277 = r_Value.w;
	} // PTX L3984
	r_LaneIndexAtPtx3987 = uint32_t((threadIdx.x & 31u)); // PTX L3987
	r_PtxU64Register178 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3987)) * int64_t(int32_t(16))); // PTX L3989
	g_RecordByteAddressAtPtx3990 =
		uint64_t(g_RecordByteAddressAtPtx3967) + uint64_t(r_PtxU64Register178);				 // PTX L3990
	g_RecordByteAddressAtPtx3991 = uint64_t(g_RecordByteAddressAtPtx3990) + uint64_t(25600); // PTX L3991
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3991));
		r_MmaBE4x4WordAtPtx3993R1278 = r_Value.x;
		r_MmaBE4x4WordAtPtx3993R1279 = r_Value.y;
		r_MmaBE4x4WordAtPtx3993R1280 = r_Value.z;
		r_MmaBE4x4WordAtPtx3993R1281 = r_Value.w;
	} // PTX L3993
	r_LaneIndexAtPtx3996 = uint32_t((threadIdx.x & 31u)); // PTX L3996
	r_PtxU64Register180 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3996)) * int64_t(int32_t(16))); // PTX L3998
	g_RecordByteAddressAtPtx3999 =
		uint64_t(g_RecordByteAddressAtPtx3967) + uint64_t(r_PtxU64Register180);				 // PTX L3999
	g_RecordByteAddressAtPtx4000 = uint64_t(g_RecordByteAddressAtPtx3999) + uint64_t(26112); // PTX L4000
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4000));
		r_MmaBE4x4WordAtPtx4002R1282 = r_Value.x;
		r_MmaBE4x4WordAtPtx4002R1283 = r_Value.y;
		r_MmaBE4x4WordAtPtx4002R1284 = r_Value.z;
		r_MmaBE4x4WordAtPtx4002R1285 = r_Value.w;
	} // PTX L4002
	r_ConvertedE4PairAtPtx4005Rs145 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3910R1250); // PTX L4005
	r_ConvertedE4PairAtPtx4008Rs146 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3917R1251); // PTX L4008
	r_MmaAE4x4WordAtPtx4010R1268 = JoinConvertedE4(r_ConvertedE4PairAtPtx4005Rs145,
												   r_ConvertedE4PairAtPtx4008Rs146);	  // PTX L4010
	r_ConvertedE4PairAtPtx4012Rs147 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3910R1252); // PTX L4012
	r_ConvertedE4PairAtPtx4015Rs148 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3917R1253); // PTX L4015
	r_MmaAE4x4WordAtPtx4017R1269 = JoinConvertedE4(r_ConvertedE4PairAtPtx4012Rs147,
												   r_ConvertedE4PairAtPtx4015Rs148);	  // PTX L4017
	r_ConvertedE4PairAtPtx4019Rs149 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3924R1254); // PTX L4019
	r_ConvertedE4PairAtPtx4022Rs150 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3931R1255); // PTX L4022
	r_MmaAE4x4WordAtPtx4024R1270 = JoinConvertedE4(r_ConvertedE4PairAtPtx4019Rs149,
												   r_ConvertedE4PairAtPtx4022Rs150);	  // PTX L4024
	r_ConvertedE4PairAtPtx4026Rs151 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3924R1256); // PTX L4026
	r_ConvertedE4PairAtPtx4029Rs152 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3931R1257); // PTX L4029
	r_MmaAE4x4WordAtPtx4031R1271 = JoinConvertedE4(r_ConvertedE4PairAtPtx4026Rs151,
												   r_ConvertedE4PairAtPtx4029Rs152);	  // PTX L4031
	r_ConvertedE4PairAtPtx4033Rs153 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3938R1258); // PTX L4033
	r_ConvertedE4PairAtPtx4036Rs154 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3945R1259); // PTX L4036
	r_MmaAE4x4WordAtPtx4038R1286 = JoinConvertedE4(r_ConvertedE4PairAtPtx4033Rs153,
												   r_ConvertedE4PairAtPtx4036Rs154);	  // PTX L4038
	r_ConvertedE4PairAtPtx4040Rs155 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3938R1260); // PTX L4040
	r_ConvertedE4PairAtPtx4043Rs156 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3945R1261); // PTX L4043
	r_MmaAE4x4WordAtPtx4045R1287 = JoinConvertedE4(r_ConvertedE4PairAtPtx4040Rs155,
												   r_ConvertedE4PairAtPtx4043Rs156);	  // PTX L4045
	r_ConvertedE4PairAtPtx4047Rs157 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3952R1262); // PTX L4047
	r_ConvertedE4PairAtPtx4050Rs158 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3959R1263); // PTX L4050
	r_MmaAE4x4WordAtPtx4052R1288 = JoinConvertedE4(r_ConvertedE4PairAtPtx4047Rs157,
												   r_ConvertedE4PairAtPtx4050Rs158);	  // PTX L4052
	r_ConvertedE4PairAtPtx4054Rs159 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3952R1264); // PTX L4054
	r_ConvertedE4PairAtPtx4057Rs160 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx3959R1265); // PTX L4057
	r_MmaAE4x4WordAtPtx4059R1289 = JoinConvertedE4(r_ConvertedE4PairAtPtx4054Rs159,
												   r_ConvertedE4PairAtPtx4057Rs160); // PTX L4059
	MmaE4(r_PackedHalf2AtPtx743R4857, r_PackedHalf2AtPtx750R4858, r_MmaAE4x4WordAtPtx4010R1268,
		  r_MmaAE4x4WordAtPtx4017R1269, r_MmaAE4x4WordAtPtx4024R1270, r_MmaAE4x4WordAtPtx4031R1271,
		  r_MmaBE4x4WordAtPtx3975R1266, r_MmaBE4x4WordAtPtx3975R1267, r_PackedHalf2AtPtx743R4857,
		  r_PackedHalf2AtPtx750R4858); // PTX L4061
	MmaE4(r_PackedHalf2AtPtx757R4859, r_PackedHalf2AtPtx764R4860, r_MmaAE4x4WordAtPtx4010R1268,
		  r_MmaAE4x4WordAtPtx4017R1269, r_MmaAE4x4WordAtPtx4024R1270, r_MmaAE4x4WordAtPtx4031R1271,
		  r_MmaBE4x4WordAtPtx3975R1272, r_MmaBE4x4WordAtPtx3975R1273, r_PackedHalf2AtPtx757R4859,
		  r_PackedHalf2AtPtx764R4860); // PTX L4068
	MmaE4(r_PackedHalf2AtPtx771R4861, r_PackedHalf2AtPtx778R4862, r_MmaAE4x4WordAtPtx4010R1268,
		  r_MmaAE4x4WordAtPtx4017R1269, r_MmaAE4x4WordAtPtx4024R1270, r_MmaAE4x4WordAtPtx4031R1271,
		  r_MmaBE4x4WordAtPtx3984R1274, r_MmaBE4x4WordAtPtx3984R1275, r_PackedHalf2AtPtx771R4861,
		  r_PackedHalf2AtPtx778R4862); // PTX L4075
	MmaE4(r_PackedHalf2AtPtx785R4863, r_PackedHalf2AtPtx792R4864, r_MmaAE4x4WordAtPtx4010R1268,
		  r_MmaAE4x4WordAtPtx4017R1269, r_MmaAE4x4WordAtPtx4024R1270, r_MmaAE4x4WordAtPtx4031R1271,
		  r_MmaBE4x4WordAtPtx3984R1276, r_MmaBE4x4WordAtPtx3984R1277, r_PackedHalf2AtPtx785R4863,
		  r_PackedHalf2AtPtx792R4864); // PTX L4082
	MmaE4(r_PackedHalf2AtPtx799R4865, r_PackedHalf2AtPtx806R4866, r_MmaAE4x4WordAtPtx4010R1268,
		  r_MmaAE4x4WordAtPtx4017R1269, r_MmaAE4x4WordAtPtx4024R1270, r_MmaAE4x4WordAtPtx4031R1271,
		  r_MmaBE4x4WordAtPtx3993R1278, r_MmaBE4x4WordAtPtx3993R1279, r_PackedHalf2AtPtx799R4865,
		  r_PackedHalf2AtPtx806R4866); // PTX L4089
	MmaE4(r_PackedHalf2AtPtx813R4867, r_PackedHalf2AtPtx820R4868, r_MmaAE4x4WordAtPtx4010R1268,
		  r_MmaAE4x4WordAtPtx4017R1269, r_MmaAE4x4WordAtPtx4024R1270, r_MmaAE4x4WordAtPtx4031R1271,
		  r_MmaBE4x4WordAtPtx3993R1280, r_MmaBE4x4WordAtPtx3993R1281, r_PackedHalf2AtPtx813R4867,
		  r_PackedHalf2AtPtx820R4868); // PTX L4096
	MmaE4(r_PackedHalf2AtPtx827R4869, r_PackedHalf2AtPtx834R4870, r_MmaAE4x4WordAtPtx4010R1268,
		  r_MmaAE4x4WordAtPtx4017R1269, r_MmaAE4x4WordAtPtx4024R1270, r_MmaAE4x4WordAtPtx4031R1271,
		  r_MmaBE4x4WordAtPtx4002R1282, r_MmaBE4x4WordAtPtx4002R1283, r_PackedHalf2AtPtx827R4869,
		  r_PackedHalf2AtPtx834R4870); // PTX L4103
	MmaE4(r_PackedHalf2AtPtx841R4871, r_PackedHalf2AtPtx848R4872, r_MmaAE4x4WordAtPtx4010R1268,
		  r_MmaAE4x4WordAtPtx4017R1269, r_MmaAE4x4WordAtPtx4024R1270, r_MmaAE4x4WordAtPtx4031R1271,
		  r_MmaBE4x4WordAtPtx4002R1284, r_MmaBE4x4WordAtPtx4002R1285, r_PackedHalf2AtPtx841R4871,
		  r_PackedHalf2AtPtx848R4872); // PTX L4110
	MmaE4(r_PackedHalf2AtPtx855R4873, r_PackedHalf2AtPtx862R4874, r_MmaAE4x4WordAtPtx4038R1286,
		  r_MmaAE4x4WordAtPtx4045R1287, r_MmaAE4x4WordAtPtx4052R1288, r_MmaAE4x4WordAtPtx4059R1289,
		  r_MmaBE4x4WordAtPtx3975R1266, r_MmaBE4x4WordAtPtx3975R1267, r_PackedHalf2AtPtx855R4873,
		  r_PackedHalf2AtPtx862R4874); // PTX L4117
	MmaE4(r_PackedHalf2AtPtx869R4875, r_PackedHalf2AtPtx876R4876, r_MmaAE4x4WordAtPtx4038R1286,
		  r_MmaAE4x4WordAtPtx4045R1287, r_MmaAE4x4WordAtPtx4052R1288, r_MmaAE4x4WordAtPtx4059R1289,
		  r_MmaBE4x4WordAtPtx3975R1272, r_MmaBE4x4WordAtPtx3975R1273, r_PackedHalf2AtPtx869R4875,
		  r_PackedHalf2AtPtx876R4876); // PTX L4124
	MmaE4(r_PackedHalf2AtPtx883R4877, r_PackedHalf2AtPtx890R4878, r_MmaAE4x4WordAtPtx4038R1286,
		  r_MmaAE4x4WordAtPtx4045R1287, r_MmaAE4x4WordAtPtx4052R1288, r_MmaAE4x4WordAtPtx4059R1289,
		  r_MmaBE4x4WordAtPtx3984R1274, r_MmaBE4x4WordAtPtx3984R1275, r_PackedHalf2AtPtx883R4877,
		  r_PackedHalf2AtPtx890R4878); // PTX L4131
	MmaE4(r_PackedHalf2AtPtx897R4879, r_PackedHalf2AtPtx904R4880, r_MmaAE4x4WordAtPtx4038R1286,
		  r_MmaAE4x4WordAtPtx4045R1287, r_MmaAE4x4WordAtPtx4052R1288, r_MmaAE4x4WordAtPtx4059R1289,
		  r_MmaBE4x4WordAtPtx3984R1276, r_MmaBE4x4WordAtPtx3984R1277, r_PackedHalf2AtPtx897R4879,
		  r_PackedHalf2AtPtx904R4880); // PTX L4138
	MmaE4(r_PackedHalf2AtPtx911R4881, r_PackedHalf2AtPtx918R4882, r_MmaAE4x4WordAtPtx4038R1286,
		  r_MmaAE4x4WordAtPtx4045R1287, r_MmaAE4x4WordAtPtx4052R1288, r_MmaAE4x4WordAtPtx4059R1289,
		  r_MmaBE4x4WordAtPtx3993R1278, r_MmaBE4x4WordAtPtx3993R1279, r_PackedHalf2AtPtx911R4881,
		  r_PackedHalf2AtPtx918R4882); // PTX L4145
	MmaE4(r_PackedHalf2AtPtx925R4883, r_PackedHalf2AtPtx932R4884, r_MmaAE4x4WordAtPtx4038R1286,
		  r_MmaAE4x4WordAtPtx4045R1287, r_MmaAE4x4WordAtPtx4052R1288, r_MmaAE4x4WordAtPtx4059R1289,
		  r_MmaBE4x4WordAtPtx3993R1280, r_MmaBE4x4WordAtPtx3993R1281, r_PackedHalf2AtPtx925R4883,
		  r_PackedHalf2AtPtx932R4884); // PTX L4152
	MmaE4(r_PackedHalf2AtPtx939R4885, r_PackedHalf2AtPtx946R4886, r_MmaAE4x4WordAtPtx4038R1286,
		  r_MmaAE4x4WordAtPtx4045R1287, r_MmaAE4x4WordAtPtx4052R1288, r_MmaAE4x4WordAtPtx4059R1289,
		  r_MmaBE4x4WordAtPtx4002R1282, r_MmaBE4x4WordAtPtx4002R1283, r_PackedHalf2AtPtx939R4885,
		  r_PackedHalf2AtPtx946R4886); // PTX L4159
	MmaE4(r_PackedHalf2AtPtx953R4887, r_PackedHalf2AtPtx960R4888, r_MmaAE4x4WordAtPtx4038R1286,
		  r_MmaAE4x4WordAtPtx4045R1287, r_MmaAE4x4WordAtPtx4052R1288, r_MmaAE4x4WordAtPtx4059R1289,
		  r_MmaBE4x4WordAtPtx4002R1284, r_MmaBE4x4WordAtPtx4002R1285, r_PackedHalf2AtPtx953R4887,
		  r_PackedHalf2AtPtx960R4888); // PTX L4166
	r_PtxRegister4856 = uint32_t(1);   // PTX L4172
	r_bPtxPredicate298 = bool(0);	   // PTX L4173
	if (r_bPtxPredicate3)
	{
		goto L__BB11_21;
	} // PTX L4174
	r_ConvertedE4PairAtPtx4176Rs161 = PublishE4(r_PackedHalf2AtPtx743R4857); // PTX L4176
	r_ConvertedE4PairAtPtx4179Rs162 = PublishE4(r_PackedHalf2AtPtx757R4859); // PTX L4179
	r_PackedE4WordAtPtx4181R1295 = JoinConvertedE4(r_ConvertedE4PairAtPtx4176Rs161,
												   r_ConvertedE4PairAtPtx4179Rs162); // PTX L4181
	r_ConvertedE4PairAtPtx4183Rs163 = PublishE4(r_PackedHalf2AtPtx750R4858);		 // PTX L4183
	r_ConvertedE4PairAtPtx4186Rs164 = PublishE4(r_PackedHalf2AtPtx764R4860);		 // PTX L4186
	r_PackedE4WordAtPtx4188R1296 = JoinConvertedE4(r_ConvertedE4PairAtPtx4183Rs163,
												   r_ConvertedE4PairAtPtx4186Rs164); // PTX L4188
	r_ConvertedE4PairAtPtx4190Rs165 = PublishE4(r_PackedHalf2AtPtx771R4861);		 // PTX L4190
	r_ConvertedE4PairAtPtx4193Rs166 = PublishE4(r_PackedHalf2AtPtx785R4863);		 // PTX L4193
	r_PackedE4WordAtPtx4195R1297 = JoinConvertedE4(r_ConvertedE4PairAtPtx4190Rs165,
												   r_ConvertedE4PairAtPtx4193Rs166); // PTX L4195
	r_ConvertedE4PairAtPtx4197Rs167 = PublishE4(r_PackedHalf2AtPtx778R4862);		 // PTX L4197
	r_ConvertedE4PairAtPtx4200Rs168 = PublishE4(r_PackedHalf2AtPtx792R4864);		 // PTX L4200
	r_PackedE4WordAtPtx4202R1298 = JoinConvertedE4(r_ConvertedE4PairAtPtx4197Rs167,
												   r_ConvertedE4PairAtPtx4200Rs168); // PTX L4202
	r_ConvertedE4PairAtPtx4204Rs169 = PublishE4(r_PackedHalf2AtPtx799R4865);		 // PTX L4204
	r_ConvertedE4PairAtPtx4207Rs170 = PublishE4(r_PackedHalf2AtPtx813R4867);		 // PTX L4207
	r_PackedE4WordAtPtx4209R1301 = JoinConvertedE4(r_ConvertedE4PairAtPtx4204Rs169,
												   r_ConvertedE4PairAtPtx4207Rs170); // PTX L4209
	r_ConvertedE4PairAtPtx4211Rs171 = PublishE4(r_PackedHalf2AtPtx806R4866);		 // PTX L4211
	r_ConvertedE4PairAtPtx4214Rs172 = PublishE4(r_PackedHalf2AtPtx820R4868);		 // PTX L4214
	r_PackedE4WordAtPtx4216R1302 = JoinConvertedE4(r_ConvertedE4PairAtPtx4211Rs171,
												   r_ConvertedE4PairAtPtx4214Rs172); // PTX L4216
	r_ConvertedE4PairAtPtx4218Rs173 = PublishE4(r_PackedHalf2AtPtx827R4869);		 // PTX L4218
	r_ConvertedE4PairAtPtx4221Rs174 = PublishE4(r_PackedHalf2AtPtx841R4871);		 // PTX L4221
	r_PackedE4WordAtPtx4223R1303 = JoinConvertedE4(r_ConvertedE4PairAtPtx4218Rs173,
												   r_ConvertedE4PairAtPtx4221Rs174); // PTX L4223
	r_ConvertedE4PairAtPtx4225Rs175 = PublishE4(r_PackedHalf2AtPtx834R4870);		 // PTX L4225
	r_ConvertedE4PairAtPtx4228Rs176 = PublishE4(r_PackedHalf2AtPtx848R4872);		 // PTX L4228
	r_PackedE4WordAtPtx4230R1304 = JoinConvertedE4(r_ConvertedE4PairAtPtx4225Rs175,
												   r_ConvertedE4PairAtPtx4228Rs176); // PTX L4230
	r_ConvertedE4PairAtPtx4232Rs177 = PublishE4(r_PackedHalf2AtPtx855R4873);		 // PTX L4232
	r_ConvertedE4PairAtPtx4235Rs178 = PublishE4(r_PackedHalf2AtPtx869R4875);		 // PTX L4235
	r_PackedE4WordAtPtx4237R1307 = JoinConvertedE4(r_ConvertedE4PairAtPtx4232Rs177,
												   r_ConvertedE4PairAtPtx4235Rs178); // PTX L4237
	r_ConvertedE4PairAtPtx4239Rs179 = PublishE4(r_PackedHalf2AtPtx862R4874);		 // PTX L4239
	r_ConvertedE4PairAtPtx4242Rs180 = PublishE4(r_PackedHalf2AtPtx876R4876);		 // PTX L4242
	r_PackedE4WordAtPtx4244R1308 = JoinConvertedE4(r_ConvertedE4PairAtPtx4239Rs179,
												   r_ConvertedE4PairAtPtx4242Rs180); // PTX L4244
	r_ConvertedE4PairAtPtx4246Rs181 = PublishE4(r_PackedHalf2AtPtx883R4877);		 // PTX L4246
	r_ConvertedE4PairAtPtx4249Rs182 = PublishE4(r_PackedHalf2AtPtx897R4879);		 // PTX L4249
	r_PackedE4WordAtPtx4251R1309 = JoinConvertedE4(r_ConvertedE4PairAtPtx4246Rs181,
												   r_ConvertedE4PairAtPtx4249Rs182); // PTX L4251
	r_ConvertedE4PairAtPtx4253Rs183 = PublishE4(r_PackedHalf2AtPtx890R4878);		 // PTX L4253
	r_ConvertedE4PairAtPtx4256Rs184 = PublishE4(r_PackedHalf2AtPtx904R4880);		 // PTX L4256
	r_PackedE4WordAtPtx4258R1310 = JoinConvertedE4(r_ConvertedE4PairAtPtx4253Rs183,
												   r_ConvertedE4PairAtPtx4256Rs184); // PTX L4258
	r_ConvertedE4PairAtPtx4260Rs185 = PublishE4(r_PackedHalf2AtPtx911R4881);		 // PTX L4260
	r_ConvertedE4PairAtPtx4263Rs186 = PublishE4(r_PackedHalf2AtPtx925R4883);		 // PTX L4263
	r_PackedE4WordAtPtx4265R1313 = JoinConvertedE4(r_ConvertedE4PairAtPtx4260Rs185,
												   r_ConvertedE4PairAtPtx4263Rs186); // PTX L4265
	r_ConvertedE4PairAtPtx4267Rs187 = PublishE4(r_PackedHalf2AtPtx918R4882);		 // PTX L4267
	r_ConvertedE4PairAtPtx4270Rs188 = PublishE4(r_PackedHalf2AtPtx932R4884);		 // PTX L4270
	r_PackedE4WordAtPtx4272R1314 = JoinConvertedE4(r_ConvertedE4PairAtPtx4267Rs187,
												   r_ConvertedE4PairAtPtx4270Rs188); // PTX L4272
	r_ConvertedE4PairAtPtx4274Rs189 = PublishE4(r_PackedHalf2AtPtx939R4885);		 // PTX L4274
	r_ConvertedE4PairAtPtx4277Rs190 = PublishE4(r_PackedHalf2AtPtx953R4887);		 // PTX L4277
	r_PackedE4WordAtPtx4279R1315 = JoinConvertedE4(r_ConvertedE4PairAtPtx4274Rs189,
												   r_ConvertedE4PairAtPtx4277Rs190); // PTX L4279
	r_ConvertedE4PairAtPtx4281Rs191 = PublishE4(r_PackedHalf2AtPtx946R4886);		 // PTX L4281
	r_ConvertedE4PairAtPtx4284Rs192 = PublishE4(r_PackedHalf2AtPtx960R4888);		 // PTX L4284
	r_PackedE4WordAtPtx4286R1316 = JoinConvertedE4(r_ConvertedE4PairAtPtx4281Rs191,
												   r_ConvertedE4PairAtPtx4284Rs192); // PTX L4286
	r_ThreadYAtPtx4287 = uint32_t(threadIdx.y);										 // PTX L4287
	r_PtxRegister2968 = ShiftLeft(uint32_t(r_ThreadYAtPtx4287), uint32_t(11));		 // PTX L4288

	// FFN result publication into native 4 KiB shared layout
	r_LaneIndexAtPtx4290 = uint32_t((threadIdx.x & 31u));						   // PTX L4290
	r_PtxRegister2969 = uint32_t(0u /* native shared-region base */);			   // PTX L4292
	r_PtxRegister2970 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister2968); // PTX L4293
	r_PtxRegister2971 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4290), uint32_t(4));	   // PTX L4294
	r_PtxRegister1294 = uint32_t(r_PtxRegister2970) + uint32_t(r_PtxRegister2971); // PTX L4295
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1294)) =
		make_uint4(r_PackedE4WordAtPtx4181R1295, r_PackedE4WordAtPtx4188R1296, r_PackedE4WordAtPtx4195R1297,
				   r_PackedE4WordAtPtx4202R1298);								   // PTX L4297
	r_LaneIndexAtPtx4300 = uint32_t((threadIdx.x & 31u));						   // PTX L4300
	r_PtxRegister2972 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4300), uint32_t(4));	   // PTX L4302
	r_PtxRegister2973 = uint32_t(r_PtxRegister2970) + uint32_t(r_PtxRegister2972); // PTX L4303
	r_PtxRegister1300 = uint32_t(r_PtxRegister2973) + uint32_t(512);			   // PTX L4304
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1300)) =
		make_uint4(r_PackedE4WordAtPtx4209R1301, r_PackedE4WordAtPtx4216R1302, r_PackedE4WordAtPtx4223R1303,
				   r_PackedE4WordAtPtx4230R1304);								   // PTX L4306
	r_LaneIndexAtPtx4309 = uint32_t((threadIdx.x & 31u));						   // PTX L4309
	r_PtxRegister2974 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4309), uint32_t(4));	   // PTX L4311
	r_PtxRegister2975 = uint32_t(r_PtxRegister2970) + uint32_t(r_PtxRegister2974); // PTX L4312
	r_PtxRegister1306 = uint32_t(r_PtxRegister2975) + uint32_t(1024);			   // PTX L4313
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1306)) =
		make_uint4(r_PackedE4WordAtPtx4237R1307, r_PackedE4WordAtPtx4244R1308, r_PackedE4WordAtPtx4251R1309,
				   r_PackedE4WordAtPtx4258R1310);								   // PTX L4315
	r_LaneIndexAtPtx4318 = uint32_t((threadIdx.x & 31u));						   // PTX L4318
	r_PtxRegister2976 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4318), uint32_t(4));	   // PTX L4320
	r_PtxRegister2977 = uint32_t(r_PtxRegister2970) + uint32_t(r_PtxRegister2976); // PTX L4321
	r_PtxRegister1312 = uint32_t(r_PtxRegister2977) + uint32_t(1536);			   // PTX L4322
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1312)) =
		make_uint4(r_PackedE4WordAtPtx4265R1313, r_PackedE4WordAtPtx4272R1314, r_PackedE4WordAtPtx4279R1315,
				   r_PackedE4WordAtPtx4286R1316); // PTX L4324

	// First cross-warp shared FFN exchange and joint Q/K/V projection
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();															   // PTX L4326
	r_LaneIndexAtPtx4328 = uint32_t((threadIdx.x & 31u));						   // PTX L4328
	r_PtxRegister2978 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4328), uint32_t(4));	   // PTX L4330
	r_PtxRegister1318 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister2978); // PTX L4331
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1318));
		r_MmaAE4x4WordAtPtx4333R1331 = r_Value.x;
		r_MmaAE4x4WordAtPtx4333R1332 = r_Value.y;
		r_MmaAE4x4WordAtPtx4333R1333 = r_Value.z;
		r_MmaAE4x4WordAtPtx4333R1334 = r_Value.w;
	} // PTX L4333
	r_LaneIndexAtPtx4336 = uint32_t((threadIdx.x & 31u));						   // PTX L4336
	r_PtxRegister2979 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4336), uint32_t(4));	   // PTX L4338
	r_PtxRegister2980 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister2979); // PTX L4339
	r_PtxRegister1320 = uint32_t(r_PtxRegister2980) + uint32_t(1024);			   // PTX L4340
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1320));
		r_MmaAE4x4WordAtPtx4342R1359 = r_Value.x;
		r_MmaAE4x4WordAtPtx4342R1360 = r_Value.y;
		r_MmaAE4x4WordAtPtx4342R1361 = r_Value.z;
		r_MmaAE4x4WordAtPtx4342R1362 = r_Value.w;
	} // PTX L4342
	r_LaneIndexAtPtx4345 = uint32_t((threadIdx.x & 31u));						   // PTX L4345
	r_PtxRegister2981 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4345), uint32_t(4));	   // PTX L4347
	r_PtxRegister2982 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister2981); // PTX L4348
	r_PtxRegister1322 = uint32_t(r_PtxRegister2982) + uint32_t(2048);			   // PTX L4349
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1322));
		r_MmaAE4x4WordAtPtx4351R1363 = r_Value.x;
		r_MmaAE4x4WordAtPtx4351R1364 = r_Value.y;
		r_MmaAE4x4WordAtPtx4351R1365 = r_Value.z;
		r_MmaAE4x4WordAtPtx4351R1366 = r_Value.w;
	} // PTX L4351
	r_LaneIndexAtPtx4354 = uint32_t((threadIdx.x & 31u));						   // PTX L4354
	r_PtxRegister2983 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4354), uint32_t(4));	   // PTX L4356
	r_PtxRegister2984 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister2983); // PTX L4357
	r_PtxRegister1324 = uint32_t(r_PtxRegister2984) + uint32_t(3072);			   // PTX L4358
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1324));
		r_MmaAE4x4WordAtPtx4360R1367 = r_Value.x;
		r_MmaAE4x4WordAtPtx4360R1368 = r_Value.y;
		r_MmaAE4x4WordAtPtx4360R1369 = r_Value.z;
		r_MmaAE4x4WordAtPtx4360R1370 = r_Value.w;
	} // PTX L4360
	r_PtxRegister2985 = uint32_t(r_ThreadYAtPtx4287) * uint32_t(768);							  // PTX L4362
	r_PtxU64Register206 = uint64_t(uint32_t(r_PtxRegister2985)) * uint64_t(uint32_t(4));		  // PTX L4363
	g_RecordByteAddressAtPtx4364 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register206); // PTX L4364
	r_LaneIndexAtPtx4366 = uint32_t((threadIdx.x & 31u));										  // PTX L4366
	r_PtxU64Register208 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4366)) * int64_t(int32_t(16))); // PTX L4368
	g_RecordByteAddressAtPtx4369 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register208);				 // PTX L4369
	g_RecordByteAddressAtPtx4370 = uint64_t(g_RecordByteAddressAtPtx4369) + uint64_t(28832); // PTX L4370
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4370));
		r_MmaBE4x4WordAtPtx4372R1335 = r_Value.x;
		r_MmaBE4x4WordAtPtx4372R1336 = r_Value.y;
		r_MmaBE4x4WordAtPtx4372R1337 = r_Value.z;
		r_MmaBE4x4WordAtPtx4372R1338 = r_Value.w;
	} // PTX L4372
	r_LaneIndexAtPtx4375 = uint32_t((threadIdx.x & 31u)); // PTX L4375
	r_PtxU64Register210 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4375)) * int64_t(int32_t(16))); // PTX L4377
	g_RecordByteAddressAtPtx4378 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register210);				 // PTX L4378
	g_RecordByteAddressAtPtx4379 = uint64_t(g_RecordByteAddressAtPtx4378) + uint64_t(29344); // PTX L4379
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4379));
		r_MmaBE4x4WordAtPtx4381R1339 = r_Value.x;
		r_MmaBE4x4WordAtPtx4381R1340 = r_Value.y;
		r_MmaBE4x4WordAtPtx4381R1341 = r_Value.z;
		r_MmaBE4x4WordAtPtx4381R1342 = r_Value.w;
	} // PTX L4381
	r_LaneIndexAtPtx4384 = uint32_t((threadIdx.x & 31u)); // PTX L4384
	r_PtxU64Register212 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4384)) * int64_t(int32_t(16))); // PTX L4386
	g_RecordByteAddressAtPtx4387 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register212);				 // PTX L4387
	g_RecordByteAddressAtPtx4388 = uint64_t(g_RecordByteAddressAtPtx4387) + uint64_t(29856); // PTX L4388
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4388));
		r_MmaBE4x4WordAtPtx4390R1343 = r_Value.x;
		r_MmaBE4x4WordAtPtx4390R1344 = r_Value.y;
		r_MmaBE4x4WordAtPtx4390R1345 = r_Value.z;
		r_MmaBE4x4WordAtPtx4390R1346 = r_Value.w;
	} // PTX L4390
	r_LaneIndexAtPtx4393 = uint32_t((threadIdx.x & 31u)); // PTX L4393
	r_PtxU64Register214 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4393)) * int64_t(int32_t(16))); // PTX L4395
	g_RecordByteAddressAtPtx4396 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register214);				 // PTX L4396
	g_RecordByteAddressAtPtx4397 = uint64_t(g_RecordByteAddressAtPtx4396) + uint64_t(30368); // PTX L4397
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4397));
		r_MmaBE4x4WordAtPtx4399R1347 = r_Value.x;
		r_MmaBE4x4WordAtPtx4399R1348 = r_Value.y;
		r_MmaBE4x4WordAtPtx4399R1349 = r_Value.z;
		r_MmaBE4x4WordAtPtx4399R1350 = r_Value.w;
	} // PTX L4399
	r_LaneIndexAtPtx4402 = uint32_t((threadIdx.x & 31u)); // PTX L4402
	r_PtxU64Register216 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4402)) * int64_t(int32_t(16))); // PTX L4404
	g_RecordByteAddressAtPtx4405 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register216);				 // PTX L4405
	g_RecordByteAddressAtPtx4406 = uint64_t(g_RecordByteAddressAtPtx4405) + uint64_t(30880); // PTX L4406
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4406));
		r_MmaBE4x4WordAtPtx4408R1351 = r_Value.x;
		r_MmaBE4x4WordAtPtx4408R1352 = r_Value.y;
		r_MmaBE4x4WordAtPtx4408R1353 = r_Value.z;
		r_MmaBE4x4WordAtPtx4408R1354 = r_Value.w;
	} // PTX L4408
	r_LaneIndexAtPtx4411 = uint32_t((threadIdx.x & 31u)); // PTX L4411
	r_PtxU64Register218 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4411)) * int64_t(int32_t(16))); // PTX L4413
	g_RecordByteAddressAtPtx4414 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register218);				 // PTX L4414
	g_RecordByteAddressAtPtx4415 = uint64_t(g_RecordByteAddressAtPtx4414) + uint64_t(31392); // PTX L4415
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4415));
		r_MmaBE4x4WordAtPtx4417R1355 = r_Value.x;
		r_MmaBE4x4WordAtPtx4417R1356 = r_Value.y;
		r_MmaBE4x4WordAtPtx4417R1357 = r_Value.z;
		r_MmaBE4x4WordAtPtx4417R1358 = r_Value.w;
	} // PTX L4417
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4420R1391, r_MmaAccumulatorHalf2WordAtPtx4420R1392,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4372R1335, r_MmaBE4x4WordAtPtx4372R1336,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4420
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4427R1395, r_MmaAccumulatorHalf2WordAtPtx4427R1396,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4372R1337, r_MmaBE4x4WordAtPtx4372R1338,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4427
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4434R1399, r_MmaAccumulatorHalf2WordAtPtx4434R1400,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4381R1339, r_MmaBE4x4WordAtPtx4381R1340,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4434
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4441R1403, r_MmaAccumulatorHalf2WordAtPtx4441R1404,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4381R1341, r_MmaBE4x4WordAtPtx4381R1342,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4441
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4448R1407, r_MmaAccumulatorHalf2WordAtPtx4448R1408,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4390R1343, r_MmaBE4x4WordAtPtx4390R1344,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4448
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4455R1411, r_MmaAccumulatorHalf2WordAtPtx4455R1412,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4390R1345, r_MmaBE4x4WordAtPtx4390R1346,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4455
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4462R1415, r_MmaAccumulatorHalf2WordAtPtx4462R1416,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4399R1347, r_MmaBE4x4WordAtPtx4399R1348,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4462
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4469R1419, r_MmaAccumulatorHalf2WordAtPtx4469R1420,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4399R1349, r_MmaBE4x4WordAtPtx4399R1350,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4469
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4476R1423, r_MmaAccumulatorHalf2WordAtPtx4476R1424,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4408R1351, r_MmaBE4x4WordAtPtx4408R1352,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4476
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4483R1427, r_MmaAccumulatorHalf2WordAtPtx4483R1428,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4408R1353, r_MmaBE4x4WordAtPtx4408R1354,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4483
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4490R1431, r_MmaAccumulatorHalf2WordAtPtx4490R1432,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4417R1355, r_MmaBE4x4WordAtPtx4417R1356,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4490
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4497R1435, r_MmaAccumulatorHalf2WordAtPtx4497R1436,
		  r_MmaAE4x4WordAtPtx4333R1331, r_MmaAE4x4WordAtPtx4333R1332, r_MmaAE4x4WordAtPtx4333R1333,
		  r_MmaAE4x4WordAtPtx4333R1334, r_MmaBE4x4WordAtPtx4417R1357, r_MmaBE4x4WordAtPtx4417R1358,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4497
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4504R1441, r_MmaAccumulatorHalf2WordAtPtx4504R1442,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4372R1335, r_MmaBE4x4WordAtPtx4372R1336,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4504
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4511R1443, r_MmaAccumulatorHalf2WordAtPtx4511R1444,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4372R1337, r_MmaBE4x4WordAtPtx4372R1338,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4511
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4518R1445, r_MmaAccumulatorHalf2WordAtPtx4518R1446,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4381R1339, r_MmaBE4x4WordAtPtx4381R1340,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4518
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4525R1447, r_MmaAccumulatorHalf2WordAtPtx4525R1448,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4381R1341, r_MmaBE4x4WordAtPtx4381R1342,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4525
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4532R1449, r_MmaAccumulatorHalf2WordAtPtx4532R1450,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4390R1343, r_MmaBE4x4WordAtPtx4390R1344,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4532
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4539R1451, r_MmaAccumulatorHalf2WordAtPtx4539R1452,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4390R1345, r_MmaBE4x4WordAtPtx4390R1346,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4539
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4546R1453, r_MmaAccumulatorHalf2WordAtPtx4546R1454,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4399R1347, r_MmaBE4x4WordAtPtx4399R1348,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4546
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4553R1455, r_MmaAccumulatorHalf2WordAtPtx4553R1456,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4399R1349, r_MmaBE4x4WordAtPtx4399R1350,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4553
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4560R1457, r_MmaAccumulatorHalf2WordAtPtx4560R1458,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4408R1351, r_MmaBE4x4WordAtPtx4408R1352,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4560
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4567R1459, r_MmaAccumulatorHalf2WordAtPtx4567R1460,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4408R1353, r_MmaBE4x4WordAtPtx4408R1354,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4567
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4574R1461, r_MmaAccumulatorHalf2WordAtPtx4574R1462,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4417R1355, r_MmaBE4x4WordAtPtx4417R1356,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4574
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4581R1463, r_MmaAccumulatorHalf2WordAtPtx4581R1464,
		  r_MmaAE4x4WordAtPtx4342R1359, r_MmaAE4x4WordAtPtx4342R1360, r_MmaAE4x4WordAtPtx4342R1361,
		  r_MmaAE4x4WordAtPtx4342R1362, r_MmaBE4x4WordAtPtx4417R1357, r_MmaBE4x4WordAtPtx4417R1358,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4581
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4588R1469, r_MmaAccumulatorHalf2WordAtPtx4588R1470,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4372R1335, r_MmaBE4x4WordAtPtx4372R1336,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4588
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4595R1471, r_MmaAccumulatorHalf2WordAtPtx4595R1472,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4372R1337, r_MmaBE4x4WordAtPtx4372R1338,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4595
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4602R1473, r_MmaAccumulatorHalf2WordAtPtx4602R1474,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4381R1339, r_MmaBE4x4WordAtPtx4381R1340,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4602
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4609R1475, r_MmaAccumulatorHalf2WordAtPtx4609R1476,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4381R1341, r_MmaBE4x4WordAtPtx4381R1342,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4609
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4616R1477, r_MmaAccumulatorHalf2WordAtPtx4616R1478,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4390R1343, r_MmaBE4x4WordAtPtx4390R1344,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4616
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4623R1479, r_MmaAccumulatorHalf2WordAtPtx4623R1480,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4390R1345, r_MmaBE4x4WordAtPtx4390R1346,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4623
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4630R1481, r_MmaAccumulatorHalf2WordAtPtx4630R1482,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4399R1347, r_MmaBE4x4WordAtPtx4399R1348,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4630
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4637R1483, r_MmaAccumulatorHalf2WordAtPtx4637R1484,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4399R1349, r_MmaBE4x4WordAtPtx4399R1350,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4637
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4644R1485, r_MmaAccumulatorHalf2WordAtPtx4644R1486,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4408R1351, r_MmaBE4x4WordAtPtx4408R1352,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4644
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4651R1487, r_MmaAccumulatorHalf2WordAtPtx4651R1488,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4408R1353, r_MmaBE4x4WordAtPtx4408R1354,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4651
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4658R1489, r_MmaAccumulatorHalf2WordAtPtx4658R1490,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4417R1355, r_MmaBE4x4WordAtPtx4417R1356,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4658
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4665R1491, r_MmaAccumulatorHalf2WordAtPtx4665R1492,
		  r_MmaAE4x4WordAtPtx4351R1363, r_MmaAE4x4WordAtPtx4351R1364, r_MmaAE4x4WordAtPtx4351R1365,
		  r_MmaAE4x4WordAtPtx4351R1366, r_MmaBE4x4WordAtPtx4417R1357, r_MmaBE4x4WordAtPtx4417R1358,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4665
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4672R1497, r_MmaAccumulatorHalf2WordAtPtx4672R1498,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4372R1335, r_MmaBE4x4WordAtPtx4372R1336,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4672
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4679R1499, r_MmaAccumulatorHalf2WordAtPtx4679R1500,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4372R1337, r_MmaBE4x4WordAtPtx4372R1338,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4679
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4686R1501, r_MmaAccumulatorHalf2WordAtPtx4686R1502,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4381R1339, r_MmaBE4x4WordAtPtx4381R1340,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4686
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4693R1503, r_MmaAccumulatorHalf2WordAtPtx4693R1504,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4381R1341, r_MmaBE4x4WordAtPtx4381R1342,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4693
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4700R1505, r_MmaAccumulatorHalf2WordAtPtx4700R1506,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4390R1343, r_MmaBE4x4WordAtPtx4390R1344,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4700
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4707R1507, r_MmaAccumulatorHalf2WordAtPtx4707R1508,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4390R1345, r_MmaBE4x4WordAtPtx4390R1346,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4707
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4714R1509, r_MmaAccumulatorHalf2WordAtPtx4714R1510,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4399R1347, r_MmaBE4x4WordAtPtx4399R1348,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4714
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4721R1511, r_MmaAccumulatorHalf2WordAtPtx4721R1512,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4399R1349, r_MmaBE4x4WordAtPtx4399R1350,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4721
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4728R1513, r_MmaAccumulatorHalf2WordAtPtx4728R1514,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4408R1351, r_MmaBE4x4WordAtPtx4408R1352,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4728
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4735R1515, r_MmaAccumulatorHalf2WordAtPtx4735R1516,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4408R1353, r_MmaBE4x4WordAtPtx4408R1354,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4735
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4742R1517, r_MmaAccumulatorHalf2WordAtPtx4742R1518,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4417R1355, r_MmaBE4x4WordAtPtx4417R1356,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L4742
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4749R1519, r_MmaAccumulatorHalf2WordAtPtx4749R1520,
		  r_MmaAE4x4WordAtPtx4360R1367, r_MmaAE4x4WordAtPtx4360R1368, r_MmaAE4x4WordAtPtx4360R1369,
		  r_MmaAE4x4WordAtPtx4360R1370, r_MmaBE4x4WordAtPtx4417R1357, r_MmaBE4x4WordAtPtx4417R1358,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767);				   // PTX L4749
	r_LaneIndexAtPtx4756 = uint32_t((threadIdx.x & 31u));						   // PTX L4756
	r_PtxRegister2986 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4756), uint32_t(4));	   // PTX L4758
	r_PtxRegister2987 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister2986); // PTX L4759
	r_PtxRegister1372 = uint32_t(r_PtxRegister2987) + uint32_t(512);			   // PTX L4760
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1372));
		r_MmaAE4x4WordAtPtx4762R1385 = r_Value.x;
		r_MmaAE4x4WordAtPtx4762R1386 = r_Value.y;
		r_MmaAE4x4WordAtPtx4762R1387 = r_Value.z;
		r_MmaAE4x4WordAtPtx4762R1388 = r_Value.w;
	} // PTX L4762
	r_LaneIndexAtPtx4765 = uint32_t((threadIdx.x & 31u));						   // PTX L4765
	r_PtxRegister2988 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4765), uint32_t(4));	   // PTX L4767
	r_PtxRegister2989 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister2988); // PTX L4768
	r_PtxRegister1374 = uint32_t(r_PtxRegister2989) + uint32_t(1536);			   // PTX L4769
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1374));
		r_MmaAE4x4WordAtPtx4771R1437 = r_Value.x;
		r_MmaAE4x4WordAtPtx4771R1438 = r_Value.y;
		r_MmaAE4x4WordAtPtx4771R1439 = r_Value.z;
		r_MmaAE4x4WordAtPtx4771R1440 = r_Value.w;
	} // PTX L4771
	r_LaneIndexAtPtx4774 = uint32_t((threadIdx.x & 31u));						   // PTX L4774
	r_PtxRegister2990 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4774), uint32_t(4));	   // PTX L4776
	r_PtxRegister2991 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister2990); // PTX L4777
	r_PtxRegister1376 = uint32_t(r_PtxRegister2991) + uint32_t(2560);			   // PTX L4778
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1376));
		r_MmaAE4x4WordAtPtx4780R1465 = r_Value.x;
		r_MmaAE4x4WordAtPtx4780R1466 = r_Value.y;
		r_MmaAE4x4WordAtPtx4780R1467 = r_Value.z;
		r_MmaAE4x4WordAtPtx4780R1468 = r_Value.w;
	} // PTX L4780
	r_LaneIndexAtPtx4783 = uint32_t((threadIdx.x & 31u));						   // PTX L4783
	r_PtxRegister2992 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4783), uint32_t(4));	   // PTX L4785
	r_PtxRegister2993 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister2992); // PTX L4786
	r_PtxRegister1378 = uint32_t(r_PtxRegister2993) + uint32_t(3584);			   // PTX L4787
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1378));
		r_MmaAE4x4WordAtPtx4789R1493 = r_Value.x;
		r_MmaAE4x4WordAtPtx4789R1494 = r_Value.y;
		r_MmaAE4x4WordAtPtx4789R1495 = r_Value.z;
		r_MmaAE4x4WordAtPtx4789R1496 = r_Value.w;
	} // PTX L4789
	r_LaneIndexAtPtx4792 = uint32_t((threadIdx.x & 31u)); // PTX L4792
	r_PtxU64Register220 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4792)) * int64_t(int32_t(16))); // PTX L4794
	g_RecordByteAddressAtPtx4795 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register220);				 // PTX L4795
	g_RecordByteAddressAtPtx4796 = uint64_t(g_RecordByteAddressAtPtx4795) + uint64_t(34976); // PTX L4796
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4796));
		r_MmaBE4x4WordAtPtx4798R1389 = r_Value.x;
		r_MmaBE4x4WordAtPtx4798R1390 = r_Value.y;
		r_MmaBE4x4WordAtPtx4798R1393 = r_Value.z;
		r_MmaBE4x4WordAtPtx4798R1394 = r_Value.w;
	} // PTX L4798
	r_LaneIndexAtPtx4801 = uint32_t((threadIdx.x & 31u)); // PTX L4801
	r_PtxU64Register222 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4801)) * int64_t(int32_t(16))); // PTX L4803
	g_RecordByteAddressAtPtx4804 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register222);				 // PTX L4804
	g_RecordByteAddressAtPtx4805 = uint64_t(g_RecordByteAddressAtPtx4804) + uint64_t(35488); // PTX L4805
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4805));
		r_MmaBE4x4WordAtPtx4807R1397 = r_Value.x;
		r_MmaBE4x4WordAtPtx4807R1398 = r_Value.y;
		r_MmaBE4x4WordAtPtx4807R1401 = r_Value.z;
		r_MmaBE4x4WordAtPtx4807R1402 = r_Value.w;
	} // PTX L4807
	r_LaneIndexAtPtx4810 = uint32_t((threadIdx.x & 31u)); // PTX L4810
	r_PtxU64Register224 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4810)) * int64_t(int32_t(16))); // PTX L4812
	g_RecordByteAddressAtPtx4813 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register224);				 // PTX L4813
	g_RecordByteAddressAtPtx4814 = uint64_t(g_RecordByteAddressAtPtx4813) + uint64_t(36000); // PTX L4814
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4814));
		r_MmaBE4x4WordAtPtx4816R1405 = r_Value.x;
		r_MmaBE4x4WordAtPtx4816R1406 = r_Value.y;
		r_MmaBE4x4WordAtPtx4816R1409 = r_Value.z;
		r_MmaBE4x4WordAtPtx4816R1410 = r_Value.w;
	} // PTX L4816
	r_LaneIndexAtPtx4819 = uint32_t((threadIdx.x & 31u)); // PTX L4819
	r_PtxU64Register226 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4819)) * int64_t(int32_t(16))); // PTX L4821
	g_RecordByteAddressAtPtx4822 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register226);				 // PTX L4822
	g_RecordByteAddressAtPtx4823 = uint64_t(g_RecordByteAddressAtPtx4822) + uint64_t(36512); // PTX L4823
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4823));
		r_MmaBE4x4WordAtPtx4825R1413 = r_Value.x;
		r_MmaBE4x4WordAtPtx4825R1414 = r_Value.y;
		r_MmaBE4x4WordAtPtx4825R1417 = r_Value.z;
		r_MmaBE4x4WordAtPtx4825R1418 = r_Value.w;
	} // PTX L4825
	r_LaneIndexAtPtx4828 = uint32_t((threadIdx.x & 31u)); // PTX L4828
	r_PtxU64Register228 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4828)) * int64_t(int32_t(16))); // PTX L4830
	g_RecordByteAddressAtPtx4831 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register228);				 // PTX L4831
	g_RecordByteAddressAtPtx4832 = uint64_t(g_RecordByteAddressAtPtx4831) + uint64_t(37024); // PTX L4832
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4832));
		r_MmaBE4x4WordAtPtx4834R1421 = r_Value.x;
		r_MmaBE4x4WordAtPtx4834R1422 = r_Value.y;
		r_MmaBE4x4WordAtPtx4834R1425 = r_Value.z;
		r_MmaBE4x4WordAtPtx4834R1426 = r_Value.w;
	} // PTX L4834
	r_LaneIndexAtPtx4837 = uint32_t((threadIdx.x & 31u)); // PTX L4837
	r_PtxU64Register230 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4837)) * int64_t(int32_t(16))); // PTX L4839

	// Native Q/K/V continuation and packed normalization flow
	g_RecordByteAddressAtPtx4840 =
		uint64_t(g_RecordByteAddressAtPtx4364) + uint64_t(r_PtxU64Register230);				 // PTX L4840
	g_RecordByteAddressAtPtx4841 = uint64_t(g_RecordByteAddressAtPtx4840) + uint64_t(37536); // PTX L4841
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4841));
		r_MmaBE4x4WordAtPtx4843R1429 = r_Value.x;
		r_MmaBE4x4WordAtPtx4843R1430 = r_Value.y;
		r_MmaBE4x4WordAtPtx4843R1433 = r_Value.z;
		r_MmaBE4x4WordAtPtx4843R1434 = r_Value.w;
	} // PTX L4843
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4846R1522, r_MmaAccumulatorHalf2WordAtPtx4846R1524,
		  r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386, r_MmaAE4x4WordAtPtx4762R1387,
		  r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4798R1389, r_MmaBE4x4WordAtPtx4798R1390,
		  r_MmaAccumulatorHalf2WordAtPtx4420R1391,
		  r_MmaAccumulatorHalf2WordAtPtx4420R1392); // PTX L4846
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4853R1526, r_MmaAccumulatorHalf2WordAtPtx4853R1528,
		  r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386, r_MmaAE4x4WordAtPtx4762R1387,
		  r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4798R1393, r_MmaBE4x4WordAtPtx4798R1394,
		  r_MmaAccumulatorHalf2WordAtPtx4427R1395,
		  r_MmaAccumulatorHalf2WordAtPtx4427R1396); // PTX L4853
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4860R1530, r_MmaAccumulatorHalf2WordAtPtx4860R1532,
		  r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386, r_MmaAE4x4WordAtPtx4762R1387,
		  r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4807R1397, r_MmaBE4x4WordAtPtx4807R1398,
		  r_MmaAccumulatorHalf2WordAtPtx4434R1399,
		  r_MmaAccumulatorHalf2WordAtPtx4434R1400); // PTX L4860
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4867R1534, r_MmaAccumulatorHalf2WordAtPtx4867R1536,
		  r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386, r_MmaAE4x4WordAtPtx4762R1387,
		  r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4807R1401, r_MmaBE4x4WordAtPtx4807R1402,
		  r_MmaAccumulatorHalf2WordAtPtx4441R1403,
		  r_MmaAccumulatorHalf2WordAtPtx4441R1404); // PTX L4867
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4874R1923, r_MmaAccumulatorHalf2WordAtPtx4874R1925,
		  r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386, r_MmaAE4x4WordAtPtx4762R1387,
		  r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4816R1405, r_MmaBE4x4WordAtPtx4816R1406,
		  r_MmaAccumulatorHalf2WordAtPtx4448R1407,
		  r_MmaAccumulatorHalf2WordAtPtx4448R1408); // PTX L4874
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4881R1927, r_MmaAccumulatorHalf2WordAtPtx4881R1929,
		  r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386, r_MmaAE4x4WordAtPtx4762R1387,
		  r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4816R1409, r_MmaBE4x4WordAtPtx4816R1410,
		  r_MmaAccumulatorHalf2WordAtPtx4455R1411,
		  r_MmaAccumulatorHalf2WordAtPtx4455R1412); // PTX L4881
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4888R1931, r_MmaAccumulatorHalf2WordAtPtx4888R1933,
		  r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386, r_MmaAE4x4WordAtPtx4762R1387,
		  r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4825R1413, r_MmaBE4x4WordAtPtx4825R1414,
		  r_MmaAccumulatorHalf2WordAtPtx4462R1415,
		  r_MmaAccumulatorHalf2WordAtPtx4462R1416); // PTX L4888
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4895R1935, r_MmaAccumulatorHalf2WordAtPtx4895R1937,
		  r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386, r_MmaAE4x4WordAtPtx4762R1387,
		  r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4825R1417, r_MmaBE4x4WordAtPtx4825R1418,
		  r_MmaAccumulatorHalf2WordAtPtx4469R1419,
		  r_MmaAccumulatorHalf2WordAtPtx4469R1420); // PTX L4895
	MmaE4(r_PtxRegister2250, r_PtxRegister2251, r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386,
		  r_MmaAE4x4WordAtPtx4762R1387, r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4834R1421,
		  r_MmaBE4x4WordAtPtx4834R1422, r_MmaAccumulatorHalf2WordAtPtx4476R1423,
		  r_MmaAccumulatorHalf2WordAtPtx4476R1424); // PTX L4902
	MmaE4(r_PtxRegister2252, r_PtxRegister2253, r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386,
		  r_MmaAE4x4WordAtPtx4762R1387, r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4834R1425,
		  r_MmaBE4x4WordAtPtx4834R1426, r_MmaAccumulatorHalf2WordAtPtx4483R1427,
		  r_MmaAccumulatorHalf2WordAtPtx4483R1428); // PTX L4909
	MmaE4(r_PtxRegister2254, r_PtxRegister2255, r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386,
		  r_MmaAE4x4WordAtPtx4762R1387, r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4843R1429,
		  r_MmaBE4x4WordAtPtx4843R1430, r_MmaAccumulatorHalf2WordAtPtx4490R1431,
		  r_MmaAccumulatorHalf2WordAtPtx4490R1432); // PTX L4916
	MmaE4(r_PtxRegister2256, r_PtxRegister2257, r_MmaAE4x4WordAtPtx4762R1385, r_MmaAE4x4WordAtPtx4762R1386,
		  r_MmaAE4x4WordAtPtx4762R1387, r_MmaAE4x4WordAtPtx4762R1388, r_MmaBE4x4WordAtPtx4843R1433,
		  r_MmaBE4x4WordAtPtx4843R1434, r_MmaAccumulatorHalf2WordAtPtx4497R1435,
		  r_MmaAccumulatorHalf2WordAtPtx4497R1436); // PTX L4923
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4930R1538, r_MmaAccumulatorHalf2WordAtPtx4930R1540,
		  r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438, r_MmaAE4x4WordAtPtx4771R1439,
		  r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4798R1389, r_MmaBE4x4WordAtPtx4798R1390,
		  r_MmaAccumulatorHalf2WordAtPtx4504R1441,
		  r_MmaAccumulatorHalf2WordAtPtx4504R1442); // PTX L4930
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4937R1542, r_MmaAccumulatorHalf2WordAtPtx4937R1544,
		  r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438, r_MmaAE4x4WordAtPtx4771R1439,
		  r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4798R1393, r_MmaBE4x4WordAtPtx4798R1394,
		  r_MmaAccumulatorHalf2WordAtPtx4511R1443,
		  r_MmaAccumulatorHalf2WordAtPtx4511R1444); // PTX L4937
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4944R1546, r_MmaAccumulatorHalf2WordAtPtx4944R1548,
		  r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438, r_MmaAE4x4WordAtPtx4771R1439,
		  r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4807R1397, r_MmaBE4x4WordAtPtx4807R1398,
		  r_MmaAccumulatorHalf2WordAtPtx4518R1445,
		  r_MmaAccumulatorHalf2WordAtPtx4518R1446); // PTX L4944
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4951R1550, r_MmaAccumulatorHalf2WordAtPtx4951R1552,
		  r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438, r_MmaAE4x4WordAtPtx4771R1439,
		  r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4807R1401, r_MmaBE4x4WordAtPtx4807R1402,
		  r_MmaAccumulatorHalf2WordAtPtx4525R1447,
		  r_MmaAccumulatorHalf2WordAtPtx4525R1448); // PTX L4951
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4958R1939, r_MmaAccumulatorHalf2WordAtPtx4958R1941,
		  r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438, r_MmaAE4x4WordAtPtx4771R1439,
		  r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4816R1405, r_MmaBE4x4WordAtPtx4816R1406,
		  r_MmaAccumulatorHalf2WordAtPtx4532R1449,
		  r_MmaAccumulatorHalf2WordAtPtx4532R1450); // PTX L4958
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4965R1943, r_MmaAccumulatorHalf2WordAtPtx4965R1945,
		  r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438, r_MmaAE4x4WordAtPtx4771R1439,
		  r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4816R1409, r_MmaBE4x4WordAtPtx4816R1410,
		  r_MmaAccumulatorHalf2WordAtPtx4539R1451,
		  r_MmaAccumulatorHalf2WordAtPtx4539R1452); // PTX L4965
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4972R1947, r_MmaAccumulatorHalf2WordAtPtx4972R1949,
		  r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438, r_MmaAE4x4WordAtPtx4771R1439,
		  r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4825R1413, r_MmaBE4x4WordAtPtx4825R1414,
		  r_MmaAccumulatorHalf2WordAtPtx4546R1453,
		  r_MmaAccumulatorHalf2WordAtPtx4546R1454); // PTX L4972
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4979R1951, r_MmaAccumulatorHalf2WordAtPtx4979R1953,
		  r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438, r_MmaAE4x4WordAtPtx4771R1439,
		  r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4825R1417, r_MmaBE4x4WordAtPtx4825R1418,
		  r_MmaAccumulatorHalf2WordAtPtx4553R1455,
		  r_MmaAccumulatorHalf2WordAtPtx4553R1456); // PTX L4979
	MmaE4(r_PtxRegister2258, r_PtxRegister2259, r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438,
		  r_MmaAE4x4WordAtPtx4771R1439, r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4834R1421,
		  r_MmaBE4x4WordAtPtx4834R1422, r_MmaAccumulatorHalf2WordAtPtx4560R1457,
		  r_MmaAccumulatorHalf2WordAtPtx4560R1458); // PTX L4986
	MmaE4(r_PtxRegister2260, r_PtxRegister2261, r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438,
		  r_MmaAE4x4WordAtPtx4771R1439, r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4834R1425,
		  r_MmaBE4x4WordAtPtx4834R1426, r_MmaAccumulatorHalf2WordAtPtx4567R1459,
		  r_MmaAccumulatorHalf2WordAtPtx4567R1460); // PTX L4993
	MmaE4(r_PtxRegister2262, r_PtxRegister2263, r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438,
		  r_MmaAE4x4WordAtPtx4771R1439, r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4843R1429,
		  r_MmaBE4x4WordAtPtx4843R1430, r_MmaAccumulatorHalf2WordAtPtx4574R1461,
		  r_MmaAccumulatorHalf2WordAtPtx4574R1462); // PTX L5000
	MmaE4(r_PtxRegister2264, r_PtxRegister2265, r_MmaAE4x4WordAtPtx4771R1437, r_MmaAE4x4WordAtPtx4771R1438,
		  r_MmaAE4x4WordAtPtx4771R1439, r_MmaAE4x4WordAtPtx4771R1440, r_MmaBE4x4WordAtPtx4843R1433,
		  r_MmaBE4x4WordAtPtx4843R1434, r_MmaAccumulatorHalf2WordAtPtx4581R1463,
		  r_MmaAccumulatorHalf2WordAtPtx4581R1464); // PTX L5007
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5014R1554, r_MmaAccumulatorHalf2WordAtPtx5014R1556,
		  r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466, r_MmaAE4x4WordAtPtx4780R1467,
		  r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4798R1389, r_MmaBE4x4WordAtPtx4798R1390,
		  r_MmaAccumulatorHalf2WordAtPtx4588R1469,
		  r_MmaAccumulatorHalf2WordAtPtx4588R1470); // PTX L5014
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5021R1558, r_MmaAccumulatorHalf2WordAtPtx5021R1560,
		  r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466, r_MmaAE4x4WordAtPtx4780R1467,
		  r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4798R1393, r_MmaBE4x4WordAtPtx4798R1394,
		  r_MmaAccumulatorHalf2WordAtPtx4595R1471,
		  r_MmaAccumulatorHalf2WordAtPtx4595R1472); // PTX L5021
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5028R1562, r_MmaAccumulatorHalf2WordAtPtx5028R1564,
		  r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466, r_MmaAE4x4WordAtPtx4780R1467,
		  r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4807R1397, r_MmaBE4x4WordAtPtx4807R1398,
		  r_MmaAccumulatorHalf2WordAtPtx4602R1473,
		  r_MmaAccumulatorHalf2WordAtPtx4602R1474); // PTX L5028
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5035R1566, r_MmaAccumulatorHalf2WordAtPtx5035R1568,
		  r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466, r_MmaAE4x4WordAtPtx4780R1467,
		  r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4807R1401, r_MmaBE4x4WordAtPtx4807R1402,
		  r_MmaAccumulatorHalf2WordAtPtx4609R1475,
		  r_MmaAccumulatorHalf2WordAtPtx4609R1476); // PTX L5035
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5042R1955, r_MmaAccumulatorHalf2WordAtPtx5042R1957,
		  r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466, r_MmaAE4x4WordAtPtx4780R1467,
		  r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4816R1405, r_MmaBE4x4WordAtPtx4816R1406,
		  r_MmaAccumulatorHalf2WordAtPtx4616R1477,
		  r_MmaAccumulatorHalf2WordAtPtx4616R1478); // PTX L5042
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5049R1959, r_MmaAccumulatorHalf2WordAtPtx5049R1961,
		  r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466, r_MmaAE4x4WordAtPtx4780R1467,
		  r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4816R1409, r_MmaBE4x4WordAtPtx4816R1410,
		  r_MmaAccumulatorHalf2WordAtPtx4623R1479,
		  r_MmaAccumulatorHalf2WordAtPtx4623R1480); // PTX L5049
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5056R1963, r_MmaAccumulatorHalf2WordAtPtx5056R1965,
		  r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466, r_MmaAE4x4WordAtPtx4780R1467,
		  r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4825R1413, r_MmaBE4x4WordAtPtx4825R1414,
		  r_MmaAccumulatorHalf2WordAtPtx4630R1481,
		  r_MmaAccumulatorHalf2WordAtPtx4630R1482); // PTX L5056
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5063R1967, r_MmaAccumulatorHalf2WordAtPtx5063R1969,
		  r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466, r_MmaAE4x4WordAtPtx4780R1467,
		  r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4825R1417, r_MmaBE4x4WordAtPtx4825R1418,
		  r_MmaAccumulatorHalf2WordAtPtx4637R1483,
		  r_MmaAccumulatorHalf2WordAtPtx4637R1484); // PTX L5063
	MmaE4(r_PtxRegister2266, r_PtxRegister2267, r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466,
		  r_MmaAE4x4WordAtPtx4780R1467, r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4834R1421,
		  r_MmaBE4x4WordAtPtx4834R1422, r_MmaAccumulatorHalf2WordAtPtx4644R1485,
		  r_MmaAccumulatorHalf2WordAtPtx4644R1486); // PTX L5070
	MmaE4(r_PtxRegister2268, r_PtxRegister2269, r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466,
		  r_MmaAE4x4WordAtPtx4780R1467, r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4834R1425,
		  r_MmaBE4x4WordAtPtx4834R1426, r_MmaAccumulatorHalf2WordAtPtx4651R1487,
		  r_MmaAccumulatorHalf2WordAtPtx4651R1488); // PTX L5077
	MmaE4(r_PtxRegister2270, r_PtxRegister2271, r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466,
		  r_MmaAE4x4WordAtPtx4780R1467, r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4843R1429,
		  r_MmaBE4x4WordAtPtx4843R1430, r_MmaAccumulatorHalf2WordAtPtx4658R1489,
		  r_MmaAccumulatorHalf2WordAtPtx4658R1490); // PTX L5084
	MmaE4(r_PtxRegister2272, r_PtxRegister2273, r_MmaAE4x4WordAtPtx4780R1465, r_MmaAE4x4WordAtPtx4780R1466,
		  r_MmaAE4x4WordAtPtx4780R1467, r_MmaAE4x4WordAtPtx4780R1468, r_MmaBE4x4WordAtPtx4843R1433,
		  r_MmaBE4x4WordAtPtx4843R1434, r_MmaAccumulatorHalf2WordAtPtx4665R1491,
		  r_MmaAccumulatorHalf2WordAtPtx4665R1492); // PTX L5091
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5098R1570, r_MmaAccumulatorHalf2WordAtPtx5098R1572,
		  r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494, r_MmaAE4x4WordAtPtx4789R1495,
		  r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4798R1389, r_MmaBE4x4WordAtPtx4798R1390,
		  r_MmaAccumulatorHalf2WordAtPtx4672R1497,
		  r_MmaAccumulatorHalf2WordAtPtx4672R1498); // PTX L5098
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5105R1574, r_MmaAccumulatorHalf2WordAtPtx5105R1576,
		  r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494, r_MmaAE4x4WordAtPtx4789R1495,
		  r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4798R1393, r_MmaBE4x4WordAtPtx4798R1394,
		  r_MmaAccumulatorHalf2WordAtPtx4679R1499,
		  r_MmaAccumulatorHalf2WordAtPtx4679R1500); // PTX L5105
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5112R1578, r_MmaAccumulatorHalf2WordAtPtx5112R1580,
		  r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494, r_MmaAE4x4WordAtPtx4789R1495,
		  r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4807R1397, r_MmaBE4x4WordAtPtx4807R1398,
		  r_MmaAccumulatorHalf2WordAtPtx4686R1501,
		  r_MmaAccumulatorHalf2WordAtPtx4686R1502); // PTX L5112
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5119R1582, r_MmaAccumulatorHalf2WordAtPtx5119R1584,
		  r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494, r_MmaAE4x4WordAtPtx4789R1495,
		  r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4807R1401, r_MmaBE4x4WordAtPtx4807R1402,
		  r_MmaAccumulatorHalf2WordAtPtx4693R1503,
		  r_MmaAccumulatorHalf2WordAtPtx4693R1504); // PTX L5119
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5126R1971, r_MmaAccumulatorHalf2WordAtPtx5126R1973,
		  r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494, r_MmaAE4x4WordAtPtx4789R1495,
		  r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4816R1405, r_MmaBE4x4WordAtPtx4816R1406,
		  r_MmaAccumulatorHalf2WordAtPtx4700R1505,
		  r_MmaAccumulatorHalf2WordAtPtx4700R1506); // PTX L5126
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5133R1975, r_MmaAccumulatorHalf2WordAtPtx5133R1977,
		  r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494, r_MmaAE4x4WordAtPtx4789R1495,
		  r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4816R1409, r_MmaBE4x4WordAtPtx4816R1410,
		  r_MmaAccumulatorHalf2WordAtPtx4707R1507,
		  r_MmaAccumulatorHalf2WordAtPtx4707R1508); // PTX L5133
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5140R1979, r_MmaAccumulatorHalf2WordAtPtx5140R1981,
		  r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494, r_MmaAE4x4WordAtPtx4789R1495,
		  r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4825R1413, r_MmaBE4x4WordAtPtx4825R1414,
		  r_MmaAccumulatorHalf2WordAtPtx4714R1509,
		  r_MmaAccumulatorHalf2WordAtPtx4714R1510); // PTX L5140
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx5147R1983, r_MmaAccumulatorHalf2WordAtPtx5147R1985,
		  r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494, r_MmaAE4x4WordAtPtx4789R1495,
		  r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4825R1417, r_MmaBE4x4WordAtPtx4825R1418,
		  r_MmaAccumulatorHalf2WordAtPtx4721R1511,
		  r_MmaAccumulatorHalf2WordAtPtx4721R1512); // PTX L5147
	MmaE4(r_PtxRegister2274, r_PtxRegister2275, r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494,
		  r_MmaAE4x4WordAtPtx4789R1495, r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4834R1421,
		  r_MmaBE4x4WordAtPtx4834R1422, r_MmaAccumulatorHalf2WordAtPtx4728R1513,
		  r_MmaAccumulatorHalf2WordAtPtx4728R1514); // PTX L5154
	MmaE4(r_PtxRegister2276, r_PtxRegister2277, r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494,
		  r_MmaAE4x4WordAtPtx4789R1495, r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4834R1425,
		  r_MmaBE4x4WordAtPtx4834R1426, r_MmaAccumulatorHalf2WordAtPtx4735R1515,
		  r_MmaAccumulatorHalf2WordAtPtx4735R1516); // PTX L5161
	MmaE4(r_PtxRegister2278, r_PtxRegister2279, r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494,
		  r_MmaAE4x4WordAtPtx4789R1495, r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4843R1429,
		  r_MmaBE4x4WordAtPtx4843R1430, r_MmaAccumulatorHalf2WordAtPtx4742R1517,
		  r_MmaAccumulatorHalf2WordAtPtx4742R1518); // PTX L5168
	MmaE4(r_PtxRegister2280, r_PtxRegister2281, r_MmaAE4x4WordAtPtx4789R1493, r_MmaAE4x4WordAtPtx4789R1494,
		  r_MmaAE4x4WordAtPtx4789R1495, r_MmaAE4x4WordAtPtx4789R1496, r_MmaBE4x4WordAtPtx4843R1433,
		  r_MmaBE4x4WordAtPtx4843R1434, r_MmaAccumulatorHalf2WordAtPtx4749R1519,
		  r_MmaAccumulatorHalf2WordAtPtx4749R1520);										  // PTX L5175
	g_RecordByteAddressAtPtx5181 = g_RecordBaseAddress;									  // PTX L5181
	r_PtxU64Register233 = uint64_t(uint32_t(r_ThreadYAtPtx4287)) * uint64_t(uint32_t(4)); // PTX L5182
	g_RecordByteAddressAtPtx5183 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register233); // PTX L5183
	r_PtxRegister1824 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx5183 + 57504ull); // PTX L5184
	r_LaneIndexAtPtx5186 = uint32_t((threadIdx.x & 31u));							 // PTX L5186
	r_PackedHalf2AtPtx5189R1586 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4846R1522,
										  r_MmaAccumulatorHalf2WordAtPtx4846R1522); // PTX L5189
	r_LaneIndexAtPtx5193 = uint32_t((threadIdx.x & 31u));							// PTX L5193
	r_PackedHalf2AtPtx5196R1589 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4846R1524,
										  r_MmaAccumulatorHalf2WordAtPtx4846R1524); // PTX L5196
	r_LaneIndexAtPtx5200 = uint32_t((threadIdx.x & 31u));							// PTX L5200
	r_PackedHalf2AtPtx5203R1592 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4853R1526,
										  r_MmaAccumulatorHalf2WordAtPtx4853R1526); // PTX L5203
	r_LaneIndexAtPtx5207 = uint32_t((threadIdx.x & 31u));							// PTX L5207
	r_PackedHalf2AtPtx5210R1595 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4853R1528,
										  r_MmaAccumulatorHalf2WordAtPtx4853R1528); // PTX L5210
	r_LaneIndexAtPtx5214 = uint32_t((threadIdx.x & 31u));							// PTX L5214
	r_PackedHalf2AtPtx5217R1587 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4860R1530,
										  r_MmaAccumulatorHalf2WordAtPtx4860R1530); // PTX L5217
	r_LaneIndexAtPtx5221 = uint32_t((threadIdx.x & 31u));							// PTX L5221
	r_PackedHalf2AtPtx5224R1590 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4860R1532,
										  r_MmaAccumulatorHalf2WordAtPtx4860R1532); // PTX L5224
	r_LaneIndexAtPtx5228 = uint32_t((threadIdx.x & 31u));							// PTX L5228
	r_PackedHalf2AtPtx5231R1593 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4867R1534,
										  r_MmaAccumulatorHalf2WordAtPtx4867R1534); // PTX L5231
	r_LaneIndexAtPtx5235 = uint32_t((threadIdx.x & 31u));							// PTX L5235
	r_PackedHalf2AtPtx5238R1596 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4867R1536,
										  r_MmaAccumulatorHalf2WordAtPtx4867R1536); // PTX L5238
	r_LaneIndexAtPtx5242 = uint32_t((threadIdx.x & 31u));							// PTX L5242
	r_PackedHalf2AtPtx5245R1598 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4930R1538,
										  r_MmaAccumulatorHalf2WordAtPtx4930R1538); // PTX L5245
	r_LaneIndexAtPtx5249 = uint32_t((threadIdx.x & 31u));							// PTX L5249
	r_PackedHalf2AtPtx5252R1601 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4930R1540,
										  r_MmaAccumulatorHalf2WordAtPtx4930R1540); // PTX L5252
	r_LaneIndexAtPtx5256 = uint32_t((threadIdx.x & 31u));							// PTX L5256
	r_PackedHalf2AtPtx5259R1604 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4937R1542,
										  r_MmaAccumulatorHalf2WordAtPtx4937R1542); // PTX L5259
	r_LaneIndexAtPtx5263 = uint32_t((threadIdx.x & 31u));							// PTX L5263
	r_PackedHalf2AtPtx5266R1607 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4937R1544,
										  r_MmaAccumulatorHalf2WordAtPtx4937R1544); // PTX L5266
	r_LaneIndexAtPtx5270 = uint32_t((threadIdx.x & 31u));							// PTX L5270
	r_PackedHalf2AtPtx5273R1599 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4944R1546,
										  r_MmaAccumulatorHalf2WordAtPtx4944R1546); // PTX L5273
	r_LaneIndexAtPtx5277 = uint32_t((threadIdx.x & 31u));							// PTX L5277
	r_PackedHalf2AtPtx5280R1602 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4944R1548,
										  r_MmaAccumulatorHalf2WordAtPtx4944R1548); // PTX L5280
	r_LaneIndexAtPtx5284 = uint32_t((threadIdx.x & 31u));							// PTX L5284
	r_PackedHalf2AtPtx5287R1605 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4951R1550,
										  r_MmaAccumulatorHalf2WordAtPtx4951R1550); // PTX L5287
	r_LaneIndexAtPtx5291 = uint32_t((threadIdx.x & 31u));							// PTX L5291
	r_PackedHalf2AtPtx5294R1608 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4951R1552,
										  r_MmaAccumulatorHalf2WordAtPtx4951R1552); // PTX L5294
	r_LaneIndexAtPtx5298 = uint32_t((threadIdx.x & 31u));							// PTX L5298
	r_PackedHalf2AtPtx5301R1610 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5014R1554,
										  r_MmaAccumulatorHalf2WordAtPtx5014R1554); // PTX L5301
	r_LaneIndexAtPtx5305 = uint32_t((threadIdx.x & 31u));							// PTX L5305
	r_PackedHalf2AtPtx5308R1613 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5014R1556,
										  r_MmaAccumulatorHalf2WordAtPtx5014R1556); // PTX L5308
	r_LaneIndexAtPtx5312 = uint32_t((threadIdx.x & 31u));							// PTX L5312
	r_PackedHalf2AtPtx5315R1616 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5021R1558,
										  r_MmaAccumulatorHalf2WordAtPtx5021R1558); // PTX L5315
	r_LaneIndexAtPtx5319 = uint32_t((threadIdx.x & 31u));							// PTX L5319
	r_PackedHalf2AtPtx5322R1619 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5021R1560,
										  r_MmaAccumulatorHalf2WordAtPtx5021R1560); // PTX L5322
	r_LaneIndexAtPtx5326 = uint32_t((threadIdx.x & 31u));							// PTX L5326
	r_PackedHalf2AtPtx5329R1611 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5028R1562,
										  r_MmaAccumulatorHalf2WordAtPtx5028R1562); // PTX L5329
	r_LaneIndexAtPtx5333 = uint32_t((threadIdx.x & 31u));							// PTX L5333
	r_PackedHalf2AtPtx5336R1614 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5028R1564,
										  r_MmaAccumulatorHalf2WordAtPtx5028R1564); // PTX L5336
	r_LaneIndexAtPtx5340 = uint32_t((threadIdx.x & 31u));							// PTX L5340
	r_PackedHalf2AtPtx5343R1617 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5035R1566,
										  r_MmaAccumulatorHalf2WordAtPtx5035R1566); // PTX L5343
	r_LaneIndexAtPtx5347 = uint32_t((threadIdx.x & 31u));							// PTX L5347
	r_PackedHalf2AtPtx5350R1620 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5035R1568,
										  r_MmaAccumulatorHalf2WordAtPtx5035R1568); // PTX L5350
	r_LaneIndexAtPtx5354 = uint32_t((threadIdx.x & 31u));							// PTX L5354
	r_PackedHalf2AtPtx5357R1622 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5098R1570,
										  r_MmaAccumulatorHalf2WordAtPtx5098R1570); // PTX L5357
	r_LaneIndexAtPtx5361 = uint32_t((threadIdx.x & 31u));							// PTX L5361
	r_PackedHalf2AtPtx5364R1625 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5098R1572,
										  r_MmaAccumulatorHalf2WordAtPtx5098R1572); // PTX L5364
	r_LaneIndexAtPtx5368 = uint32_t((threadIdx.x & 31u));							// PTX L5368
	r_PackedHalf2AtPtx5371R1628 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5105R1574,
										  r_MmaAccumulatorHalf2WordAtPtx5105R1574); // PTX L5371
	r_LaneIndexAtPtx5375 = uint32_t((threadIdx.x & 31u));							// PTX L5375
	r_PackedHalf2AtPtx5378R1631 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5105R1576,
										  r_MmaAccumulatorHalf2WordAtPtx5105R1576); // PTX L5378
	r_LaneIndexAtPtx5382 = uint32_t((threadIdx.x & 31u));							// PTX L5382
	r_PackedHalf2AtPtx5385R1623 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5112R1578,
										  r_MmaAccumulatorHalf2WordAtPtx5112R1578); // PTX L5385
	r_LaneIndexAtPtx5389 = uint32_t((threadIdx.x & 31u));							// PTX L5389
	r_PackedHalf2AtPtx5392R1626 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5112R1580,
										  r_MmaAccumulatorHalf2WordAtPtx5112R1580); // PTX L5392
	r_LaneIndexAtPtx5396 = uint32_t((threadIdx.x & 31u));							// PTX L5396
	r_PackedHalf2AtPtx5399R1629 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5119R1582,
										  r_MmaAccumulatorHalf2WordAtPtx5119R1582); // PTX L5399
	r_LaneIndexAtPtx5403 = uint32_t((threadIdx.x & 31u));							// PTX L5403
	r_PackedHalf2AtPtx5406R1632 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5119R1584,
										  r_MmaAccumulatorHalf2WordAtPtx5119R1584); // PTX L5406
	r_LaneIndexAtPtx5410 = uint32_t((threadIdx.x & 31u));							// PTX L5410
	r_PackedHalf2AtPtx5413R1634 =
		HalfAdd(r_PackedHalf2AtPtx5189R1586, r_PackedHalf2AtPtx5217R1587); // PTX L5413
	r_LaneIndexAtPtx5417 = uint32_t((threadIdx.x & 31u));				   // PTX L5417
	r_PackedHalf2AtPtx5420R1636 =
		HalfAdd(r_PackedHalf2AtPtx5196R1589, r_PackedHalf2AtPtx5224R1590); // PTX L5420
	r_LaneIndexAtPtx5424 = uint32_t((threadIdx.x & 31u));				   // PTX L5424
	r_PackedHalf2AtPtx5427R1633 =
		HalfAdd(r_PackedHalf2AtPtx5203R1592, r_PackedHalf2AtPtx5231R1593); // PTX L5427
	r_LaneIndexAtPtx5431 = uint32_t((threadIdx.x & 31u));				   // PTX L5431
	r_PackedHalf2AtPtx5434R1635 =
		HalfAdd(r_PackedHalf2AtPtx5210R1595, r_PackedHalf2AtPtx5238R1596); // PTX L5434
	r_LaneIndexAtPtx5438 = uint32_t((threadIdx.x & 31u));				   // PTX L5438
	r_PackedHalf2AtPtx5441R1655 =
		HalfAdd(r_PackedHalf2AtPtx5245R1598, r_PackedHalf2AtPtx5273R1599); // PTX L5441
	r_LaneIndexAtPtx5445 = uint32_t((threadIdx.x & 31u));				   // PTX L5445
	r_PackedHalf2AtPtx5448R1657 =
		HalfAdd(r_PackedHalf2AtPtx5252R1601, r_PackedHalf2AtPtx5280R1602); // PTX L5448
	r_LaneIndexAtPtx5452 = uint32_t((threadIdx.x & 31u));				   // PTX L5452
	r_PackedHalf2AtPtx5455R1654 =
		HalfAdd(r_PackedHalf2AtPtx5259R1604, r_PackedHalf2AtPtx5287R1605); // PTX L5455
	r_LaneIndexAtPtx5459 = uint32_t((threadIdx.x & 31u));				   // PTX L5459
	r_PackedHalf2AtPtx5462R1656 =
		HalfAdd(r_PackedHalf2AtPtx5266R1607, r_PackedHalf2AtPtx5294R1608); // PTX L5462
	r_LaneIndexAtPtx5466 = uint32_t((threadIdx.x & 31u));				   // PTX L5466
	r_PackedHalf2AtPtx5469R1671 =
		HalfAdd(r_PackedHalf2AtPtx5301R1610, r_PackedHalf2AtPtx5329R1611); // PTX L5469
	r_LaneIndexAtPtx5473 = uint32_t((threadIdx.x & 31u));				   // PTX L5473
	r_PackedHalf2AtPtx5476R1673 =
		HalfAdd(r_PackedHalf2AtPtx5308R1613, r_PackedHalf2AtPtx5336R1614); // PTX L5476
	r_LaneIndexAtPtx5480 = uint32_t((threadIdx.x & 31u));				   // PTX L5480
	r_PackedHalf2AtPtx5483R1670 =
		HalfAdd(r_PackedHalf2AtPtx5315R1616, r_PackedHalf2AtPtx5343R1617); // PTX L5483
	r_LaneIndexAtPtx5487 = uint32_t((threadIdx.x & 31u));				   // PTX L5487
	r_PackedHalf2AtPtx5490R1672 =
		HalfAdd(r_PackedHalf2AtPtx5322R1619, r_PackedHalf2AtPtx5350R1620); // PTX L5490
	r_LaneIndexAtPtx5494 = uint32_t((threadIdx.x & 31u));				   // PTX L5494
	r_PackedHalf2AtPtx5497R1687 =
		HalfAdd(r_PackedHalf2AtPtx5357R1622, r_PackedHalf2AtPtx5385R1623); // PTX L5497
	r_LaneIndexAtPtx5501 = uint32_t((threadIdx.x & 31u));				   // PTX L5501
	r_PackedHalf2AtPtx5504R1689 =
		HalfAdd(r_PackedHalf2AtPtx5364R1625, r_PackedHalf2AtPtx5392R1626); // PTX L5504
	r_LaneIndexAtPtx5508 = uint32_t((threadIdx.x & 31u));				   // PTX L5508
	r_PackedHalf2AtPtx5511R1686 =
		HalfAdd(r_PackedHalf2AtPtx5371R1628, r_PackedHalf2AtPtx5399R1629); // PTX L5511
	r_LaneIndexAtPtx5515 = uint32_t((threadIdx.x & 31u));				   // PTX L5515
	r_PackedHalf2AtPtx5518R1688 =
		HalfAdd(r_PackedHalf2AtPtx5378R1631, r_PackedHalf2AtPtx5406R1632); // PTX L5518
	r_PackedHalf2AtPtx5522R1638 =
		HalfAdd(r_PackedHalf2AtPtx5427R1633, r_PackedHalf2AtPtx5413R1634); // PTX L5522
	r_PackedHalf2AtPtx5526R1648 =
		HalfAdd(r_PackedHalf2AtPtx5434R1635, r_PackedHalf2AtPtx5420R1636);	 // PTX L5526
	r_PtxRegister1637 = uint32_t(32u);										 // PTX L5530
	r_PtxRegister2994 = ShiftLeft(uint32_t(r_PtxRegister1637), uint32_t(8)); // PTX L5533
	r_PtxRegister1640 = uint32_t(r_PtxRegister2994) + uint32_t(-8161);		 // PTX L5534
	r_PtxRegister1639 = uint32_t(2);										 // PTX L5535
	r_PtxRegister1641 = uint32_t(-1);										 // PTX L5536
	r_PackedHalf2AtPtx5538R1642 = ShuffleBfly(r_PackedHalf2AtPtx5522R1638, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L5538
	r_PackedHalf2AtPtx5542R1643 =
		HalfAdd(r_PackedHalf2AtPtx5522R1638, r_PackedHalf2AtPtx5538R1642); // PTX L5542
	r_PtxRegister1644 = uint32_t(1);									   // PTX L5545
	r_PackedHalf2AtPtx5547R1645 = ShuffleBfly(r_PackedHalf2AtPtx5542R1643, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L5547
	r_PtxRegister1646 = HalfAdd(r_PackedHalf2AtPtx5542R1643, r_PackedHalf2AtPtx5547R1645); // PTX L5551
	r_PtxU16Register370 = uint16_t(r_PtxRegister1646);
	r_PtxU16Register371 = uint16_t(r_PtxRegister1646 >> 16);							   // PTX L5554
	r_PackedHalf2AtPtx5555R1647 = JoinHalfwords(r_PtxU16Register371, r_PtxU16Register370); // PTX L5555
	r_PackedHalf2AtPtx5557R1704 = HalfAdd(r_PtxRegister1646, r_PackedHalf2AtPtx5555R1647); // PTX L5557
	r_PackedHalf2AtPtx5561R1649 = ShuffleBfly(r_PackedHalf2AtPtx5526R1648, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L5561
	r_PackedHalf2AtPtx5565R1650 =
		HalfAdd(r_PackedHalf2AtPtx5526R1648, r_PackedHalf2AtPtx5561R1649); // PTX L5565
	r_PackedHalf2AtPtx5569R1651 = ShuffleBfly(r_PackedHalf2AtPtx5565R1650, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L5569
	r_PtxRegister1652 = HalfAdd(r_PackedHalf2AtPtx5565R1650, r_PackedHalf2AtPtx5569R1651); // PTX L5573
	r_PtxU16Register372 = uint16_t(r_PtxRegister1652);
	r_PtxU16Register373 = uint16_t(r_PtxRegister1652 >> 16);							   // PTX L5576
	r_PackedHalf2AtPtx5577R1653 = JoinHalfwords(r_PtxU16Register373, r_PtxU16Register372); // PTX L5577
	r_PackedHalf2AtPtx5579R1707 = HalfAdd(r_PtxRegister1652, r_PackedHalf2AtPtx5577R1653); // PTX L5579
	r_PackedHalf2AtPtx5583R1658 =
		HalfAdd(r_PackedHalf2AtPtx5455R1654, r_PackedHalf2AtPtx5441R1655); // PTX L5583
	r_PackedHalf2AtPtx5587R1664 =
		HalfAdd(r_PackedHalf2AtPtx5462R1656, r_PackedHalf2AtPtx5448R1657); // PTX L5587
	r_PackedHalf2AtPtx5591R1659 = ShuffleBfly(r_PackedHalf2AtPtx5583R1658, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L5591
	r_PackedHalf2AtPtx5595R1660 =
		HalfAdd(r_PackedHalf2AtPtx5583R1658, r_PackedHalf2AtPtx5591R1659); // PTX L5595
	r_PackedHalf2AtPtx5599R1661 = ShuffleBfly(r_PackedHalf2AtPtx5595R1660, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L5599
	r_PtxRegister1662 = HalfAdd(r_PackedHalf2AtPtx5595R1660, r_PackedHalf2AtPtx5599R1661); // PTX L5603
	r_PtxU16Register374 = uint16_t(r_PtxRegister1662);
	r_PtxU16Register375 = uint16_t(r_PtxRegister1662 >> 16);							   // PTX L5606
	r_PackedHalf2AtPtx5607R1663 = JoinHalfwords(r_PtxU16Register375, r_PtxU16Register374); // PTX L5607
	r_PackedHalf2AtPtx5609R1715 = HalfAdd(r_PtxRegister1662, r_PackedHalf2AtPtx5607R1663); // PTX L5609
	r_PackedHalf2AtPtx5613R1665 = ShuffleBfly(r_PackedHalf2AtPtx5587R1664, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L5613
	r_PackedHalf2AtPtx5617R1666 =
		HalfAdd(r_PackedHalf2AtPtx5587R1664, r_PackedHalf2AtPtx5613R1665); // PTX L5617
	r_PackedHalf2AtPtx5621R1667 = ShuffleBfly(r_PackedHalf2AtPtx5617R1666, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L5621
	r_PtxRegister1668 = HalfAdd(r_PackedHalf2AtPtx5617R1666, r_PackedHalf2AtPtx5621R1667); // PTX L5625
	r_PtxU16Register376 = uint16_t(r_PtxRegister1668);
	r_PtxU16Register377 = uint16_t(r_PtxRegister1668 >> 16);							   // PTX L5628
	r_PackedHalf2AtPtx5629R1669 = JoinHalfwords(r_PtxU16Register377, r_PtxU16Register376); // PTX L5629
	r_PackedHalf2AtPtx5631R1717 = HalfAdd(r_PtxRegister1668, r_PackedHalf2AtPtx5629R1669); // PTX L5631
	r_PackedHalf2AtPtx5635R1674 =
		HalfAdd(r_PackedHalf2AtPtx5483R1670, r_PackedHalf2AtPtx5469R1671); // PTX L5635
	r_PackedHalf2AtPtx5639R1680 =
		HalfAdd(r_PackedHalf2AtPtx5490R1672, r_PackedHalf2AtPtx5476R1673); // PTX L5639
	r_PackedHalf2AtPtx5643R1675 = ShuffleBfly(r_PackedHalf2AtPtx5635R1674, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L5643
	r_PackedHalf2AtPtx5647R1676 =
		HalfAdd(r_PackedHalf2AtPtx5635R1674, r_PackedHalf2AtPtx5643R1675); // PTX L5647
	r_PackedHalf2AtPtx5651R1677 = ShuffleBfly(r_PackedHalf2AtPtx5647R1676, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L5651
	r_PtxRegister1678 = HalfAdd(r_PackedHalf2AtPtx5647R1676, r_PackedHalf2AtPtx5651R1677); // PTX L5655
	r_PtxU16Register378 = uint16_t(r_PtxRegister1678);
	r_PtxU16Register379 = uint16_t(r_PtxRegister1678 >> 16);							   // PTX L5658
	r_PackedHalf2AtPtx5659R1679 = JoinHalfwords(r_PtxU16Register379, r_PtxU16Register378); // PTX L5659
	r_PackedHalf2AtPtx5661R1725 = HalfAdd(r_PtxRegister1678, r_PackedHalf2AtPtx5659R1679); // PTX L5661
	r_PackedHalf2AtPtx5665R1681 = ShuffleBfly(r_PackedHalf2AtPtx5639R1680, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L5665
	r_PackedHalf2AtPtx5669R1682 =
		HalfAdd(r_PackedHalf2AtPtx5639R1680, r_PackedHalf2AtPtx5665R1681); // PTX L5669
	r_PackedHalf2AtPtx5673R1683 = ShuffleBfly(r_PackedHalf2AtPtx5669R1682, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L5673
	r_PtxRegister1684 = HalfAdd(r_PackedHalf2AtPtx5669R1682, r_PackedHalf2AtPtx5673R1683); // PTX L5677
	r_PtxU16Register380 = uint16_t(r_PtxRegister1684);
	r_PtxU16Register381 = uint16_t(r_PtxRegister1684 >> 16);							   // PTX L5680
	r_PackedHalf2AtPtx5681R1685 = JoinHalfwords(r_PtxU16Register381, r_PtxU16Register380); // PTX L5681
	r_PackedHalf2AtPtx5683R1727 = HalfAdd(r_PtxRegister1684, r_PackedHalf2AtPtx5681R1685); // PTX L5683
	r_PackedHalf2AtPtx5687R1690 =
		HalfAdd(r_PackedHalf2AtPtx5511R1686, r_PackedHalf2AtPtx5497R1687); // PTX L5687
	r_PackedHalf2AtPtx5691R1696 =
		HalfAdd(r_PackedHalf2AtPtx5518R1688, r_PackedHalf2AtPtx5504R1689); // PTX L5691
	r_PackedHalf2AtPtx5695R1691 = ShuffleBfly(r_PackedHalf2AtPtx5687R1690, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L5695
	r_PackedHalf2AtPtx5699R1692 =
		HalfAdd(r_PackedHalf2AtPtx5687R1690, r_PackedHalf2AtPtx5695R1691); // PTX L5699
	r_PackedHalf2AtPtx5703R1693 = ShuffleBfly(r_PackedHalf2AtPtx5699R1692, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L5703
	r_PtxRegister1694 = HalfAdd(r_PackedHalf2AtPtx5699R1692, r_PackedHalf2AtPtx5703R1693); // PTX L5707
	r_PtxU16Register382 = uint16_t(r_PtxRegister1694);
	r_PtxU16Register383 = uint16_t(r_PtxRegister1694 >> 16);							   // PTX L5710
	r_PackedHalf2AtPtx5711R1695 = JoinHalfwords(r_PtxU16Register383, r_PtxU16Register382); // PTX L5711
	r_PackedHalf2AtPtx5713R1735 = HalfAdd(r_PtxRegister1694, r_PackedHalf2AtPtx5711R1695); // PTX L5713
	r_PackedHalf2AtPtx5717R1697 = ShuffleBfly(r_PackedHalf2AtPtx5691R1696, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L5717
	r_PackedHalf2AtPtx5721R1698 =
		HalfAdd(r_PackedHalf2AtPtx5691R1696, r_PackedHalf2AtPtx5717R1697); // PTX L5721
	r_PackedHalf2AtPtx5725R1699 = ShuffleBfly(r_PackedHalf2AtPtx5721R1698, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L5725
	r_PtxRegister1700 = HalfAdd(r_PackedHalf2AtPtx5721R1698, r_PackedHalf2AtPtx5725R1699); // PTX L5729
	r_PtxU16Register384 = uint16_t(r_PtxRegister1700);
	r_PtxU16Register385 = uint16_t(r_PtxRegister1700 >> 16);							   // PTX L5732
	r_PackedHalf2AtPtx5733R1701 = JoinHalfwords(r_PtxU16Register385, r_PtxU16Register384); // PTX L5733
	r_PackedHalf2AtPtx5735R1737 = HalfAdd(r_PtxRegister1700, r_PackedHalf2AtPtx5733R1701); // PTX L5735
	r_PtxRegister1702 = uint32_t(948045311);											   // PTX L5738
	r_PackedHalf2AtPtx5740R1705 = FloatToHalf2(r_PtxRegister1702);						   // PTX L5740
	r_LaneIndexAtPtx5746 = uint32_t((threadIdx.x & 31u));								   // PTX L5746
	r_PackedHalf2AtPtx5749R1745 =
		HalfMax(r_PackedHalf2AtPtx5557R1704, r_PackedHalf2AtPtx5740R1705); // PTX L5749
	r_LaneIndexAtPtx5753 = uint32_t((threadIdx.x & 31u));				   // PTX L5753
	r_PackedHalf2AtPtx5756R1747 =
		HalfMax(r_PackedHalf2AtPtx5579R1707, r_PackedHalf2AtPtx5740R1705); // PTX L5756
	r_LaneIndexAtPtx5760 = uint32_t((threadIdx.x & 31u));				   // PTX L5760
	r_LaneIndexAtPtx5763 = uint32_t((threadIdx.x & 31u));				   // PTX L5763
	r_LaneIndexAtPtx5766 = uint32_t((threadIdx.x & 31u));				   // PTX L5766
	r_LaneIndexAtPtx5769 = uint32_t((threadIdx.x & 31u));				   // PTX L5769
	r_LaneIndexAtPtx5772 = uint32_t((threadIdx.x & 31u));				   // PTX L5772
	r_LaneIndexAtPtx5775 = uint32_t((threadIdx.x & 31u));				   // PTX L5775
	r_LaneIndexAtPtx5778 = uint32_t((threadIdx.x & 31u));				   // PTX L5778
	r_PackedHalf2AtPtx5781R1755 =
		HalfMax(r_PackedHalf2AtPtx5609R1715, r_PackedHalf2AtPtx5740R1705); // PTX L5781
	r_LaneIndexAtPtx5785 = uint32_t((threadIdx.x & 31u));				   // PTX L5785
	r_PackedHalf2AtPtx5788R1757 =
		HalfMax(r_PackedHalf2AtPtx5631R1717, r_PackedHalf2AtPtx5740R1705); // PTX L5788
	r_LaneIndexAtPtx5792 = uint32_t((threadIdx.x & 31u));				   // PTX L5792
	r_LaneIndexAtPtx5795 = uint32_t((threadIdx.x & 31u));				   // PTX L5795
	r_LaneIndexAtPtx5798 = uint32_t((threadIdx.x & 31u));				   // PTX L5798
	r_LaneIndexAtPtx5801 = uint32_t((threadIdx.x & 31u));				   // PTX L5801
	r_LaneIndexAtPtx5804 = uint32_t((threadIdx.x & 31u));				   // PTX L5804
	r_LaneIndexAtPtx5807 = uint32_t((threadIdx.x & 31u));				   // PTX L5807
	r_LaneIndexAtPtx5810 = uint32_t((threadIdx.x & 31u));				   // PTX L5810
	r_PackedHalf2AtPtx5813R1765 =
		HalfMax(r_PackedHalf2AtPtx5661R1725, r_PackedHalf2AtPtx5740R1705); // PTX L5813
	r_LaneIndexAtPtx5817 = uint32_t((threadIdx.x & 31u));				   // PTX L5817
	r_PackedHalf2AtPtx5820R1767 =
		HalfMax(r_PackedHalf2AtPtx5683R1727, r_PackedHalf2AtPtx5740R1705); // PTX L5820
	r_LaneIndexAtPtx5824 = uint32_t((threadIdx.x & 31u));				   // PTX L5824
	r_LaneIndexAtPtx5827 = uint32_t((threadIdx.x & 31u));				   // PTX L5827
	r_LaneIndexAtPtx5830 = uint32_t((threadIdx.x & 31u));				   // PTX L5830
	r_LaneIndexAtPtx5833 = uint32_t((threadIdx.x & 31u));				   // PTX L5833
	r_LaneIndexAtPtx5836 = uint32_t((threadIdx.x & 31u));				   // PTX L5836
	r_LaneIndexAtPtx5839 = uint32_t((threadIdx.x & 31u));				   // PTX L5839
	r_LaneIndexAtPtx5842 = uint32_t((threadIdx.x & 31u));				   // PTX L5842
	r_PackedHalf2AtPtx5845R1775 =
		HalfMax(r_PackedHalf2AtPtx5713R1735, r_PackedHalf2AtPtx5740R1705); // PTX L5845
	r_LaneIndexAtPtx5849 = uint32_t((threadIdx.x & 31u));				   // PTX L5849
	r_PackedHalf2AtPtx5852R1777 =
		HalfMax(r_PackedHalf2AtPtx5735R1737, r_PackedHalf2AtPtx5740R1705); // PTX L5852
	r_LaneIndexAtPtx5856 = uint32_t((threadIdx.x & 31u));				   // PTX L5856
	r_LaneIndexAtPtx5859 = uint32_t((threadIdx.x & 31u));				   // PTX L5859
	r_LaneIndexAtPtx5862 = uint32_t((threadIdx.x & 31u));				   // PTX L5862
	r_LaneIndexAtPtx5865 = uint32_t((threadIdx.x & 31u));				   // PTX L5865
	r_LaneIndexAtPtx5868 = uint32_t((threadIdx.x & 31u));				   // PTX L5868
	r_LaneIndexAtPtx5871 = uint32_t((threadIdx.x & 31u));				   // PTX L5871
	r_LaneIndexAtPtx5874 = uint32_t((threadIdx.x & 31u));				   // PTX L5874
	// Phase: reciprocal_square_root. Reciprocal-square-root stage: keep per-Half widening, FTZ approximation, rounding and surrounding arithmetic order.
	r_PackedHalf2AtPtx5877R1785 = RsqrtHalf2(r_PackedHalf2AtPtx5749R1745); // PTX L5877
	r_LaneIndexAtPtx5890 = uint32_t((threadIdx.x & 31u));				   // PTX L5890
	r_PackedHalf2AtPtx5893R1787 = RsqrtHalf2(r_PackedHalf2AtPtx5756R1747); // PTX L5893
	r_LaneIndexAtPtx5906 = uint32_t((threadIdx.x & 31u));				   // PTX L5906
	r_LaneIndexAtPtx5909 = uint32_t((threadIdx.x & 31u));				   // PTX L5909
	r_LaneIndexAtPtx5912 = uint32_t((threadIdx.x & 31u));				   // PTX L5912
	r_LaneIndexAtPtx5915 = uint32_t((threadIdx.x & 31u));				   // PTX L5915
	r_LaneIndexAtPtx5918 = uint32_t((threadIdx.x & 31u));				   // PTX L5918
	r_LaneIndexAtPtx5921 = uint32_t((threadIdx.x & 31u));				   // PTX L5921
	r_LaneIndexAtPtx5924 = uint32_t((threadIdx.x & 31u));				   // PTX L5924
	r_PackedHalf2AtPtx5927R1795 = RsqrtHalf2(r_PackedHalf2AtPtx5781R1755); // PTX L5927
	r_LaneIndexAtPtx5940 = uint32_t((threadIdx.x & 31u));				   // PTX L5940
	r_PackedHalf2AtPtx5943R1797 = RsqrtHalf2(r_PackedHalf2AtPtx5788R1757); // PTX L5943
	r_LaneIndexAtPtx5956 = uint32_t((threadIdx.x & 31u));				   // PTX L5956
	r_LaneIndexAtPtx5959 = uint32_t((threadIdx.x & 31u));				   // PTX L5959
	r_LaneIndexAtPtx5962 = uint32_t((threadIdx.x & 31u));				   // PTX L5962
	r_LaneIndexAtPtx5965 = uint32_t((threadIdx.x & 31u));				   // PTX L5965
	r_LaneIndexAtPtx5968 = uint32_t((threadIdx.x & 31u));				   // PTX L5968
	r_LaneIndexAtPtx5971 = uint32_t((threadIdx.x & 31u));				   // PTX L5971
	r_LaneIndexAtPtx5974 = uint32_t((threadIdx.x & 31u));				   // PTX L5974
	r_PackedHalf2AtPtx5977R1805 = RsqrtHalf2(r_PackedHalf2AtPtx5813R1765); // PTX L5977
	r_LaneIndexAtPtx5990 = uint32_t((threadIdx.x & 31u));				   // PTX L5990
	r_PackedHalf2AtPtx5993R1807 = RsqrtHalf2(r_PackedHalf2AtPtx5820R1767); // PTX L5993
	r_LaneIndexAtPtx6006 = uint32_t((threadIdx.x & 31u));				   // PTX L6006
	r_LaneIndexAtPtx6009 = uint32_t((threadIdx.x & 31u));				   // PTX L6009
	r_LaneIndexAtPtx6012 = uint32_t((threadIdx.x & 31u));				   // PTX L6012
	r_LaneIndexAtPtx6015 = uint32_t((threadIdx.x & 31u));				   // PTX L6015
	r_LaneIndexAtPtx6018 = uint32_t((threadIdx.x & 31u));				   // PTX L6018
	r_LaneIndexAtPtx6021 = uint32_t((threadIdx.x & 31u));				   // PTX L6021
	r_LaneIndexAtPtx6024 = uint32_t((threadIdx.x & 31u));				   // PTX L6024
	r_PackedHalf2AtPtx6027R1815 = RsqrtHalf2(r_PackedHalf2AtPtx5845R1775); // PTX L6027
	r_LaneIndexAtPtx6040 = uint32_t((threadIdx.x & 31u));				   // PTX L6040
	r_PackedHalf2AtPtx6043R1817 = RsqrtHalf2(r_PackedHalf2AtPtx5852R1777); // PTX L6043
	r_LaneIndexAtPtx6056 = uint32_t((threadIdx.x & 31u));				   // PTX L6056
	r_LaneIndexAtPtx6059 = uint32_t((threadIdx.x & 31u));				   // PTX L6059
	r_LaneIndexAtPtx6062 = uint32_t((threadIdx.x & 31u));				   // PTX L6062
	r_LaneIndexAtPtx6065 = uint32_t((threadIdx.x & 31u));				   // PTX L6065
	r_LaneIndexAtPtx6068 = uint32_t((threadIdx.x & 31u));				   // PTX L6068
	r_LaneIndexAtPtx6071 = uint32_t((threadIdx.x & 31u));				   // PTX L6071
	r_LaneIndexAtPtx6074 = uint32_t((threadIdx.x & 31u));				   // PTX L6074
	r_PackedHalf2AtPtx6077R1826 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4846R1522, r_PackedHalf2AtPtx5877R1785); // PTX L6077
	r_LaneIndexAtPtx6081 = uint32_t((threadIdx.x & 31u));							   // PTX L6081
	r_PackedHalf2AtPtx6084R1829 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4846R1524, r_PackedHalf2AtPtx5893R1787); // PTX L6084
	r_LaneIndexAtPtx6088 = uint32_t((threadIdx.x & 31u));							   // PTX L6088
	r_PackedHalf2AtPtx6091R1831 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4853R1526, r_PackedHalf2AtPtx5877R1785); // PTX L6091
	r_LaneIndexAtPtx6095 = uint32_t((threadIdx.x & 31u));							   // PTX L6095
	r_PackedHalf2AtPtx6098R1833 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4853R1528, r_PackedHalf2AtPtx5893R1787); // PTX L6098
	r_LaneIndexAtPtx6102 = uint32_t((threadIdx.x & 31u));							   // PTX L6102
	r_PackedHalf2AtPtx6105R1835 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4860R1530, r_PackedHalf2AtPtx5877R1785); // PTX L6105
	r_LaneIndexAtPtx6109 = uint32_t((threadIdx.x & 31u));							   // PTX L6109
	r_PackedHalf2AtPtx6112R1837 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4860R1532, r_PackedHalf2AtPtx5893R1787); // PTX L6112
	r_LaneIndexAtPtx6116 = uint32_t((threadIdx.x & 31u));							   // PTX L6116
	r_PackedHalf2AtPtx6119R1839 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4867R1534, r_PackedHalf2AtPtx5877R1785); // PTX L6119
	r_LaneIndexAtPtx6123 = uint32_t((threadIdx.x & 31u));							   // PTX L6123
	r_PackedHalf2AtPtx6126R1841 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4867R1536, r_PackedHalf2AtPtx5893R1787); // PTX L6126
	r_LaneIndexAtPtx6130 = uint32_t((threadIdx.x & 31u));							   // PTX L6130
	r_PackedHalf2AtPtx6133R1843 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4930R1538, r_PackedHalf2AtPtx5927R1795); // PTX L6133
	r_LaneIndexAtPtx6137 = uint32_t((threadIdx.x & 31u));							   // PTX L6137
	r_PackedHalf2AtPtx6140R1845 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4930R1540, r_PackedHalf2AtPtx5943R1797); // PTX L6140
	r_LaneIndexAtPtx6144 = uint32_t((threadIdx.x & 31u));							   // PTX L6144
	r_PackedHalf2AtPtx6147R1847 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4937R1542, r_PackedHalf2AtPtx5927R1795); // PTX L6147
	r_LaneIndexAtPtx6151 = uint32_t((threadIdx.x & 31u));							   // PTX L6151
	r_PackedHalf2AtPtx6154R1849 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4937R1544, r_PackedHalf2AtPtx5943R1797); // PTX L6154
	r_LaneIndexAtPtx6158 = uint32_t((threadIdx.x & 31u));							   // PTX L6158
	r_PackedHalf2AtPtx6161R1851 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4944R1546, r_PackedHalf2AtPtx5927R1795); // PTX L6161
	r_LaneIndexAtPtx6165 = uint32_t((threadIdx.x & 31u));							   // PTX L6165
	r_PackedHalf2AtPtx6168R1853 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4944R1548, r_PackedHalf2AtPtx5943R1797); // PTX L6168
	r_LaneIndexAtPtx6172 = uint32_t((threadIdx.x & 31u));							   // PTX L6172
	r_PackedHalf2AtPtx6175R1855 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4951R1550, r_PackedHalf2AtPtx5927R1795); // PTX L6175
	r_LaneIndexAtPtx6179 = uint32_t((threadIdx.x & 31u));							   // PTX L6179
	r_PackedHalf2AtPtx6182R1857 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4951R1552, r_PackedHalf2AtPtx5943R1797); // PTX L6182
	r_LaneIndexAtPtx6186 = uint32_t((threadIdx.x & 31u));							   // PTX L6186
	r_PackedHalf2AtPtx6189R1859 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5014R1554, r_PackedHalf2AtPtx5977R1805); // PTX L6189
	r_LaneIndexAtPtx6193 = uint32_t((threadIdx.x & 31u));							   // PTX L6193
	r_PackedHalf2AtPtx6196R1861 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5014R1556, r_PackedHalf2AtPtx5993R1807); // PTX L6196
	r_LaneIndexAtPtx6200 = uint32_t((threadIdx.x & 31u));							   // PTX L6200
	r_PackedHalf2AtPtx6203R1863 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5021R1558, r_PackedHalf2AtPtx5977R1805); // PTX L6203
	r_LaneIndexAtPtx6207 = uint32_t((threadIdx.x & 31u));							   // PTX L6207
	r_PackedHalf2AtPtx6210R1865 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5021R1560, r_PackedHalf2AtPtx5993R1807); // PTX L6210
	r_LaneIndexAtPtx6214 = uint32_t((threadIdx.x & 31u));							   // PTX L6214
	r_PackedHalf2AtPtx6217R1867 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5028R1562, r_PackedHalf2AtPtx5977R1805); // PTX L6217
	r_LaneIndexAtPtx6221 = uint32_t((threadIdx.x & 31u));							   // PTX L6221
	r_PackedHalf2AtPtx6224R1869 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5028R1564, r_PackedHalf2AtPtx5993R1807); // PTX L6224
	r_LaneIndexAtPtx6228 = uint32_t((threadIdx.x & 31u));							   // PTX L6228
	r_PackedHalf2AtPtx6231R1871 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5035R1566, r_PackedHalf2AtPtx5977R1805); // PTX L6231
	r_LaneIndexAtPtx6235 = uint32_t((threadIdx.x & 31u));							   // PTX L6235
	r_PackedHalf2AtPtx6238R1873 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5035R1568, r_PackedHalf2AtPtx5993R1807); // PTX L6238
	r_LaneIndexAtPtx6242 = uint32_t((threadIdx.x & 31u));							   // PTX L6242
	r_PackedHalf2AtPtx6245R1875 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5098R1570, r_PackedHalf2AtPtx6027R1815); // PTX L6245
	r_LaneIndexAtPtx6249 = uint32_t((threadIdx.x & 31u));							   // PTX L6249
	r_PackedHalf2AtPtx6252R1877 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5098R1572, r_PackedHalf2AtPtx6043R1817); // PTX L6252
	r_LaneIndexAtPtx6256 = uint32_t((threadIdx.x & 31u));							   // PTX L6256
	r_PackedHalf2AtPtx6259R1879 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5105R1574, r_PackedHalf2AtPtx6027R1815); // PTX L6259
	r_LaneIndexAtPtx6263 = uint32_t((threadIdx.x & 31u));							   // PTX L6263
	r_PackedHalf2AtPtx6266R1881 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5105R1576, r_PackedHalf2AtPtx6043R1817); // PTX L6266
	r_LaneIndexAtPtx6270 = uint32_t((threadIdx.x & 31u));							   // PTX L6270
	r_PackedHalf2AtPtx6273R1883 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5112R1578, r_PackedHalf2AtPtx6027R1815); // PTX L6273
	r_LaneIndexAtPtx6277 = uint32_t((threadIdx.x & 31u));							   // PTX L6277
	r_PackedHalf2AtPtx6280R1885 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5112R1580, r_PackedHalf2AtPtx6043R1817); // PTX L6280
	r_LaneIndexAtPtx6284 = uint32_t((threadIdx.x & 31u));							   // PTX L6284
	r_PackedHalf2AtPtx6287R1887 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5119R1582, r_PackedHalf2AtPtx6027R1815); // PTX L6287
	r_LaneIndexAtPtx6291 = uint32_t((threadIdx.x & 31u));							   // PTX L6291
	r_PackedHalf2AtPtx6294R1889 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5119R1584, r_PackedHalf2AtPtx6043R1817); // PTX L6294
	r_PackedHalf2AtPtx6298R1827 = FloatToHalf2(r_PtxRegister1824);					   // PTX L6298
	r_LaneIndexAtPtx6304 = uint32_t((threadIdx.x & 31u));							   // PTX L6304
	r_PackedHalf2AtPtx6307R1890 =
		HalfMul(r_PackedHalf2AtPtx6077R1826, r_PackedHalf2AtPtx6298R1827); // PTX L6307
	r_LaneIndexAtPtx6311 = uint32_t((threadIdx.x & 31u));				   // PTX L6311
	r_PackedHalf2AtPtx6314R1892 =
		HalfMul(r_PackedHalf2AtPtx6084R1829, r_PackedHalf2AtPtx6298R1827); // PTX L6314
	r_LaneIndexAtPtx6318 = uint32_t((threadIdx.x & 31u));				   // PTX L6318
	r_PackedHalf2AtPtx6321R1891 =
		HalfMul(r_PackedHalf2AtPtx6091R1831, r_PackedHalf2AtPtx6298R1827); // PTX L6321
	r_LaneIndexAtPtx6325 = uint32_t((threadIdx.x & 31u));				   // PTX L6325
	r_PackedHalf2AtPtx6328R1893 =
		HalfMul(r_PackedHalf2AtPtx6098R1833, r_PackedHalf2AtPtx6298R1827); // PTX L6328
	r_LaneIndexAtPtx6332 = uint32_t((threadIdx.x & 31u));				   // PTX L6332
	r_PackedHalf2AtPtx6335R1894 =
		HalfMul(r_PackedHalf2AtPtx6105R1835, r_PackedHalf2AtPtx6298R1827); // PTX L6335
	r_LaneIndexAtPtx6339 = uint32_t((threadIdx.x & 31u));				   // PTX L6339
	r_PackedHalf2AtPtx6342R1896 =
		HalfMul(r_PackedHalf2AtPtx6112R1837, r_PackedHalf2AtPtx6298R1827); // PTX L6342
	r_LaneIndexAtPtx6346 = uint32_t((threadIdx.x & 31u));				   // PTX L6346
	r_PackedHalf2AtPtx6349R1895 =
		HalfMul(r_PackedHalf2AtPtx6119R1839, r_PackedHalf2AtPtx6298R1827); // PTX L6349
	r_LaneIndexAtPtx6353 = uint32_t((threadIdx.x & 31u));				   // PTX L6353
	r_PackedHalf2AtPtx6356R1897 =
		HalfMul(r_PackedHalf2AtPtx6126R1841, r_PackedHalf2AtPtx6298R1827); // PTX L6356
	r_LaneIndexAtPtx6360 = uint32_t((threadIdx.x & 31u));				   // PTX L6360
	r_PackedHalf2AtPtx6363R1898 =
		HalfMul(r_PackedHalf2AtPtx6133R1843, r_PackedHalf2AtPtx6298R1827); // PTX L6363
	r_LaneIndexAtPtx6367 = uint32_t((threadIdx.x & 31u));				   // PTX L6367
	r_PackedHalf2AtPtx6370R1900 =
		HalfMul(r_PackedHalf2AtPtx6140R1845, r_PackedHalf2AtPtx6298R1827); // PTX L6370
	r_LaneIndexAtPtx6374 = uint32_t((threadIdx.x & 31u));				   // PTX L6374
	r_PackedHalf2AtPtx6377R1899 =
		HalfMul(r_PackedHalf2AtPtx6147R1847, r_PackedHalf2AtPtx6298R1827); // PTX L6377
	r_LaneIndexAtPtx6381 = uint32_t((threadIdx.x & 31u));				   // PTX L6381
	r_PackedHalf2AtPtx6384R1901 =
		HalfMul(r_PackedHalf2AtPtx6154R1849, r_PackedHalf2AtPtx6298R1827); // PTX L6384
	r_LaneIndexAtPtx6388 = uint32_t((threadIdx.x & 31u));				   // PTX L6388
	r_PackedHalf2AtPtx6391R1902 =
		HalfMul(r_PackedHalf2AtPtx6161R1851, r_PackedHalf2AtPtx6298R1827); // PTX L6391
	r_LaneIndexAtPtx6395 = uint32_t((threadIdx.x & 31u));				   // PTX L6395
	r_PackedHalf2AtPtx6398R1904 =
		HalfMul(r_PackedHalf2AtPtx6168R1853, r_PackedHalf2AtPtx6298R1827); // PTX L6398
	r_LaneIndexAtPtx6402 = uint32_t((threadIdx.x & 31u));				   // PTX L6402
	r_PackedHalf2AtPtx6405R1903 =
		HalfMul(r_PackedHalf2AtPtx6175R1855, r_PackedHalf2AtPtx6298R1827); // PTX L6405
	r_LaneIndexAtPtx6409 = uint32_t((threadIdx.x & 31u));				   // PTX L6409
	r_PackedHalf2AtPtx6412R1905 =
		HalfMul(r_PackedHalf2AtPtx6182R1857, r_PackedHalf2AtPtx6298R1827); // PTX L6412
	r_LaneIndexAtPtx6416 = uint32_t((threadIdx.x & 31u));				   // PTX L6416
	r_PackedHalf2AtPtx6419R1906 =
		HalfMul(r_PackedHalf2AtPtx6189R1859, r_PackedHalf2AtPtx6298R1827); // PTX L6419
	r_LaneIndexAtPtx6423 = uint32_t((threadIdx.x & 31u));				   // PTX L6423
	r_PackedHalf2AtPtx6426R1908 =
		HalfMul(r_PackedHalf2AtPtx6196R1861, r_PackedHalf2AtPtx6298R1827); // PTX L6426
	r_LaneIndexAtPtx6430 = uint32_t((threadIdx.x & 31u));				   // PTX L6430
	r_PackedHalf2AtPtx6433R1907 =
		HalfMul(r_PackedHalf2AtPtx6203R1863, r_PackedHalf2AtPtx6298R1827); // PTX L6433
	r_LaneIndexAtPtx6437 = uint32_t((threadIdx.x & 31u));				   // PTX L6437
	r_PackedHalf2AtPtx6440R1909 =
		HalfMul(r_PackedHalf2AtPtx6210R1865, r_PackedHalf2AtPtx6298R1827); // PTX L6440
	r_LaneIndexAtPtx6444 = uint32_t((threadIdx.x & 31u));				   // PTX L6444
	r_PackedHalf2AtPtx6447R1910 =
		HalfMul(r_PackedHalf2AtPtx6217R1867, r_PackedHalf2AtPtx6298R1827); // PTX L6447
	r_LaneIndexAtPtx6451 = uint32_t((threadIdx.x & 31u));				   // PTX L6451
	r_PackedHalf2AtPtx6454R1912 =
		HalfMul(r_PackedHalf2AtPtx6224R1869, r_PackedHalf2AtPtx6298R1827); // PTX L6454
	r_LaneIndexAtPtx6458 = uint32_t((threadIdx.x & 31u));				   // PTX L6458
	r_PackedHalf2AtPtx6461R1911 =
		HalfMul(r_PackedHalf2AtPtx6231R1871, r_PackedHalf2AtPtx6298R1827); // PTX L6461
	r_LaneIndexAtPtx6465 = uint32_t((threadIdx.x & 31u));				   // PTX L6465
	r_PackedHalf2AtPtx6468R1913 =
		HalfMul(r_PackedHalf2AtPtx6238R1873, r_PackedHalf2AtPtx6298R1827); // PTX L6468
	r_LaneIndexAtPtx6472 = uint32_t((threadIdx.x & 31u));				   // PTX L6472
	r_PackedHalf2AtPtx6475R1914 =
		HalfMul(r_PackedHalf2AtPtx6245R1875, r_PackedHalf2AtPtx6298R1827); // PTX L6475
	r_LaneIndexAtPtx6479 = uint32_t((threadIdx.x & 31u));				   // PTX L6479
	r_PackedHalf2AtPtx6482R1916 =
		HalfMul(r_PackedHalf2AtPtx6252R1877, r_PackedHalf2AtPtx6298R1827); // PTX L6482
	r_LaneIndexAtPtx6486 = uint32_t((threadIdx.x & 31u));				   // PTX L6486
	r_PackedHalf2AtPtx6489R1915 =
		HalfMul(r_PackedHalf2AtPtx6259R1879, r_PackedHalf2AtPtx6298R1827); // PTX L6489
	r_LaneIndexAtPtx6493 = uint32_t((threadIdx.x & 31u));				   // PTX L6493
	r_PackedHalf2AtPtx6496R1917 =
		HalfMul(r_PackedHalf2AtPtx6266R1881, r_PackedHalf2AtPtx6298R1827); // PTX L6496
	r_LaneIndexAtPtx6500 = uint32_t((threadIdx.x & 31u));				   // PTX L6500
	r_PackedHalf2AtPtx6503R1918 =
		HalfMul(r_PackedHalf2AtPtx6273R1883, r_PackedHalf2AtPtx6298R1827); // PTX L6503
	r_LaneIndexAtPtx6507 = uint32_t((threadIdx.x & 31u));				   // PTX L6507
	r_PackedHalf2AtPtx6510R1920 =
		HalfMul(r_PackedHalf2AtPtx6280R1885, r_PackedHalf2AtPtx6298R1827); // PTX L6510
	r_LaneIndexAtPtx6514 = uint32_t((threadIdx.x & 31u));				   // PTX L6514
	r_PackedHalf2AtPtx6517R1919 =
		HalfMul(r_PackedHalf2AtPtx6287R1887, r_PackedHalf2AtPtx6298R1827); // PTX L6517
	r_LaneIndexAtPtx6521 = uint32_t((threadIdx.x & 31u));				   // PTX L6521
	r_PackedHalf2AtPtx6524R1921 =
		HalfMul(r_PackedHalf2AtPtx6294R1889, r_PackedHalf2AtPtx6298R1827);	  // PTX L6524
	r_ConvertedE4PairAtPtx6528Rs193 = PublishE4(r_PackedHalf2AtPtx6307R1890); // PTX L6528
	r_ConvertedE4PairAtPtx6531Rs194 = PublishE4(r_PackedHalf2AtPtx6321R1891); // PTX L6531
	r_MmaAE4x4WordAtPtx6533R2326 = JoinConvertedE4(r_ConvertedE4PairAtPtx6528Rs193,
												   r_ConvertedE4PairAtPtx6531Rs194); // PTX L6533
	r_ConvertedE4PairAtPtx6535Rs195 = PublishE4(r_PackedHalf2AtPtx6314R1892);		 // PTX L6535
	r_ConvertedE4PairAtPtx6538Rs196 = PublishE4(r_PackedHalf2AtPtx6328R1893);		 // PTX L6538
	r_MmaAE4x4WordAtPtx6540R2327 = JoinConvertedE4(r_ConvertedE4PairAtPtx6535Rs195,
												   r_ConvertedE4PairAtPtx6538Rs196); // PTX L6540
	r_ConvertedE4PairAtPtx6542Rs197 = PublishE4(r_PackedHalf2AtPtx6335R1894);		 // PTX L6542
	r_ConvertedE4PairAtPtx6545Rs198 = PublishE4(r_PackedHalf2AtPtx6349R1895);		 // PTX L6545
	r_MmaAE4x4WordAtPtx6547R2328 = JoinConvertedE4(r_ConvertedE4PairAtPtx6542Rs197,
												   r_ConvertedE4PairAtPtx6545Rs198); // PTX L6547
	r_ConvertedE4PairAtPtx6549Rs199 = PublishE4(r_PackedHalf2AtPtx6342R1896);		 // PTX L6549
	r_ConvertedE4PairAtPtx6552Rs200 = PublishE4(r_PackedHalf2AtPtx6356R1897);		 // PTX L6552
	r_MmaAE4x4WordAtPtx6554R2329 = JoinConvertedE4(r_ConvertedE4PairAtPtx6549Rs199,
												   r_ConvertedE4PairAtPtx6552Rs200); // PTX L6554
	r_ConvertedE4PairAtPtx6556Rs201 = PublishE4(r_PackedHalf2AtPtx6363R1898);		 // PTX L6556
	r_ConvertedE4PairAtPtx6559Rs202 = PublishE4(r_PackedHalf2AtPtx6377R1899);		 // PTX L6559
	r_MmaAE4x4WordAtPtx6561R2360 = JoinConvertedE4(r_ConvertedE4PairAtPtx6556Rs201,
												   r_ConvertedE4PairAtPtx6559Rs202); // PTX L6561
	r_ConvertedE4PairAtPtx6563Rs203 = PublishE4(r_PackedHalf2AtPtx6370R1900);		 // PTX L6563
	r_ConvertedE4PairAtPtx6566Rs204 = PublishE4(r_PackedHalf2AtPtx6384R1901);		 // PTX L6566
	r_MmaAE4x4WordAtPtx6568R2361 = JoinConvertedE4(r_ConvertedE4PairAtPtx6563Rs203,
												   r_ConvertedE4PairAtPtx6566Rs204); // PTX L6568
	r_ConvertedE4PairAtPtx6570Rs205 = PublishE4(r_PackedHalf2AtPtx6391R1902);		 // PTX L6570
	r_ConvertedE4PairAtPtx6573Rs206 = PublishE4(r_PackedHalf2AtPtx6405R1903);		 // PTX L6573
	r_MmaAE4x4WordAtPtx6575R2362 = JoinConvertedE4(r_ConvertedE4PairAtPtx6570Rs205,
												   r_ConvertedE4PairAtPtx6573Rs206); // PTX L6575
	r_ConvertedE4PairAtPtx6577Rs207 = PublishE4(r_PackedHalf2AtPtx6398R1904);		 // PTX L6577
	r_ConvertedE4PairAtPtx6580Rs208 = PublishE4(r_PackedHalf2AtPtx6412R1905);		 // PTX L6580
	r_MmaAE4x4WordAtPtx6582R2363 = JoinConvertedE4(r_ConvertedE4PairAtPtx6577Rs207,
												   r_ConvertedE4PairAtPtx6580Rs208); // PTX L6582
	r_ConvertedE4PairAtPtx6584Rs209 = PublishE4(r_PackedHalf2AtPtx6419R1906);		 // PTX L6584
	r_ConvertedE4PairAtPtx6587Rs210 = PublishE4(r_PackedHalf2AtPtx6433R1907);		 // PTX L6587
	r_ConvertedE4PairAtPtx6590Rs211 = PublishE4(r_PackedHalf2AtPtx6426R1908);		 // PTX L6590
	r_ConvertedE4PairAtPtx6593Rs212 = PublishE4(r_PackedHalf2AtPtx6440R1909);		 // PTX L6593
	r_ConvertedE4PairAtPtx6596Rs213 = PublishE4(r_PackedHalf2AtPtx6447R1910);		 // PTX L6596
	r_ConvertedE4PairAtPtx6599Rs214 = PublishE4(r_PackedHalf2AtPtx6461R1911);		 // PTX L6599
	r_ConvertedE4PairAtPtx6602Rs215 = PublishE4(r_PackedHalf2AtPtx6454R1912);		 // PTX L6602
	r_ConvertedE4PairAtPtx6605Rs216 = PublishE4(r_PackedHalf2AtPtx6468R1913);		 // PTX L6605
	r_ConvertedE4PairAtPtx6608Rs217 = PublishE4(r_PackedHalf2AtPtx6475R1914);		 // PTX L6608
	r_ConvertedE4PairAtPtx6611Rs218 = PublishE4(r_PackedHalf2AtPtx6489R1915);		 // PTX L6611
	r_ConvertedE4PairAtPtx6614Rs219 = PublishE4(r_PackedHalf2AtPtx6482R1916);		 // PTX L6614
	r_ConvertedE4PairAtPtx6617Rs220 = PublishE4(r_PackedHalf2AtPtx6496R1917);		 // PTX L6617
	r_ConvertedE4PairAtPtx6620Rs221 = PublishE4(r_PackedHalf2AtPtx6503R1918);		 // PTX L6620
	r_ConvertedE4PairAtPtx6623Rs222 = PublishE4(r_PackedHalf2AtPtx6517R1919);		 // PTX L6623
	r_ConvertedE4PairAtPtx6626Rs223 = PublishE4(r_PackedHalf2AtPtx6510R1920);		 // PTX L6626
	r_ConvertedE4PairAtPtx6629Rs224 = PublishE4(r_PackedHalf2AtPtx6524R1921);		 // PTX L6629
	r_LaneIndexAtPtx6632 = uint32_t((threadIdx.x & 31u));							 // PTX L6632
	r_PackedHalf2AtPtx6635R1987 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4874R1923,
										  r_MmaAccumulatorHalf2WordAtPtx4874R1923); // PTX L6635
	r_LaneIndexAtPtx6639 = uint32_t((threadIdx.x & 31u));							// PTX L6639
	r_PackedHalf2AtPtx6642R1990 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4874R1925,
										  r_MmaAccumulatorHalf2WordAtPtx4874R1925); // PTX L6642
	r_LaneIndexAtPtx6646 = uint32_t((threadIdx.x & 31u));							// PTX L6646
	r_PackedHalf2AtPtx6649R1993 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4881R1927,
										  r_MmaAccumulatorHalf2WordAtPtx4881R1927); // PTX L6649
	r_LaneIndexAtPtx6653 = uint32_t((threadIdx.x & 31u));							// PTX L6653
	r_PackedHalf2AtPtx6656R1996 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4881R1929,
										  r_MmaAccumulatorHalf2WordAtPtx4881R1929); // PTX L6656
	r_LaneIndexAtPtx6660 = uint32_t((threadIdx.x & 31u));							// PTX L6660
	r_PackedHalf2AtPtx6663R1988 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4888R1931,
										  r_MmaAccumulatorHalf2WordAtPtx4888R1931); // PTX L6663
	r_LaneIndexAtPtx6667 = uint32_t((threadIdx.x & 31u));							// PTX L6667
	r_PackedHalf2AtPtx6670R1991 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4888R1933,
										  r_MmaAccumulatorHalf2WordAtPtx4888R1933); // PTX L6670
	r_LaneIndexAtPtx6674 = uint32_t((threadIdx.x & 31u));							// PTX L6674
	r_PackedHalf2AtPtx6677R1994 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4895R1935,
										  r_MmaAccumulatorHalf2WordAtPtx4895R1935); // PTX L6677
	r_LaneIndexAtPtx6681 = uint32_t((threadIdx.x & 31u));							// PTX L6681
	r_PackedHalf2AtPtx6684R1997 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4895R1937,
										  r_MmaAccumulatorHalf2WordAtPtx4895R1937); // PTX L6684
	r_LaneIndexAtPtx6688 = uint32_t((threadIdx.x & 31u));							// PTX L6688
	r_PackedHalf2AtPtx6691R1999 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4958R1939,
										  r_MmaAccumulatorHalf2WordAtPtx4958R1939); // PTX L6691
	r_LaneIndexAtPtx6695 = uint32_t((threadIdx.x & 31u));							// PTX L6695
	r_PackedHalf2AtPtx6698R2002 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4958R1941,
										  r_MmaAccumulatorHalf2WordAtPtx4958R1941); // PTX L6698
	r_LaneIndexAtPtx6702 = uint32_t((threadIdx.x & 31u));							// PTX L6702
	r_PackedHalf2AtPtx6705R2005 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4965R1943,
										  r_MmaAccumulatorHalf2WordAtPtx4965R1943); // PTX L6705
	r_LaneIndexAtPtx6709 = uint32_t((threadIdx.x & 31u));							// PTX L6709
	r_PackedHalf2AtPtx6712R2008 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4965R1945,
										  r_MmaAccumulatorHalf2WordAtPtx4965R1945); // PTX L6712
	r_LaneIndexAtPtx6716 = uint32_t((threadIdx.x & 31u));							// PTX L6716
	r_PackedHalf2AtPtx6719R2000 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4972R1947,
										  r_MmaAccumulatorHalf2WordAtPtx4972R1947); // PTX L6719
	r_LaneIndexAtPtx6723 = uint32_t((threadIdx.x & 31u));							// PTX L6723
	r_PackedHalf2AtPtx6726R2003 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4972R1949,
										  r_MmaAccumulatorHalf2WordAtPtx4972R1949); // PTX L6726
	r_LaneIndexAtPtx6730 = uint32_t((threadIdx.x & 31u));							// PTX L6730
	r_PackedHalf2AtPtx6733R2006 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4979R1951,
										  r_MmaAccumulatorHalf2WordAtPtx4979R1951); // PTX L6733
	r_LaneIndexAtPtx6737 = uint32_t((threadIdx.x & 31u));							// PTX L6737
	r_PackedHalf2AtPtx6740R2009 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx4979R1953,
										  r_MmaAccumulatorHalf2WordAtPtx4979R1953); // PTX L6740
	r_LaneIndexAtPtx6744 = uint32_t((threadIdx.x & 31u));							// PTX L6744
	r_PackedHalf2AtPtx6747R2011 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5042R1955,
										  r_MmaAccumulatorHalf2WordAtPtx5042R1955); // PTX L6747
	r_LaneIndexAtPtx6751 = uint32_t((threadIdx.x & 31u));							// PTX L6751
	r_PackedHalf2AtPtx6754R2014 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5042R1957,
										  r_MmaAccumulatorHalf2WordAtPtx5042R1957); // PTX L6754
	r_LaneIndexAtPtx6758 = uint32_t((threadIdx.x & 31u));							// PTX L6758
	r_PackedHalf2AtPtx6761R2017 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5049R1959,
										  r_MmaAccumulatorHalf2WordAtPtx5049R1959); // PTX L6761
	r_LaneIndexAtPtx6765 = uint32_t((threadIdx.x & 31u));							// PTX L6765
	r_PackedHalf2AtPtx6768R2020 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5049R1961,
										  r_MmaAccumulatorHalf2WordAtPtx5049R1961); // PTX L6768
	r_LaneIndexAtPtx6772 = uint32_t((threadIdx.x & 31u));							// PTX L6772
	r_PackedHalf2AtPtx6775R2012 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5056R1963,
										  r_MmaAccumulatorHalf2WordAtPtx5056R1963); // PTX L6775
	r_LaneIndexAtPtx6779 = uint32_t((threadIdx.x & 31u));							// PTX L6779
	r_PackedHalf2AtPtx6782R2015 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5056R1965,
										  r_MmaAccumulatorHalf2WordAtPtx5056R1965); // PTX L6782
	r_LaneIndexAtPtx6786 = uint32_t((threadIdx.x & 31u));							// PTX L6786
	r_PackedHalf2AtPtx6789R2018 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5063R1967,
										  r_MmaAccumulatorHalf2WordAtPtx5063R1967); // PTX L6789
	r_LaneIndexAtPtx6793 = uint32_t((threadIdx.x & 31u));							// PTX L6793
	r_PackedHalf2AtPtx6796R2021 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5063R1969,
										  r_MmaAccumulatorHalf2WordAtPtx5063R1969); // PTX L6796
	r_LaneIndexAtPtx6800 = uint32_t((threadIdx.x & 31u));							// PTX L6800
	r_PackedHalf2AtPtx6803R2023 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5126R1971,
										  r_MmaAccumulatorHalf2WordAtPtx5126R1971); // PTX L6803
	r_LaneIndexAtPtx6807 = uint32_t((threadIdx.x & 31u));							// PTX L6807
	r_PackedHalf2AtPtx6810R2026 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5126R1973,
										  r_MmaAccumulatorHalf2WordAtPtx5126R1973); // PTX L6810
	r_LaneIndexAtPtx6814 = uint32_t((threadIdx.x & 31u));							// PTX L6814
	r_PackedHalf2AtPtx6817R2029 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5133R1975,
										  r_MmaAccumulatorHalf2WordAtPtx5133R1975); // PTX L6817
	r_LaneIndexAtPtx6821 = uint32_t((threadIdx.x & 31u));							// PTX L6821
	r_PackedHalf2AtPtx6824R2032 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5133R1977,
										  r_MmaAccumulatorHalf2WordAtPtx5133R1977); // PTX L6824
	r_LaneIndexAtPtx6828 = uint32_t((threadIdx.x & 31u));							// PTX L6828
	r_PackedHalf2AtPtx6831R2024 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5140R1979,
										  r_MmaAccumulatorHalf2WordAtPtx5140R1979); // PTX L6831
	r_LaneIndexAtPtx6835 = uint32_t((threadIdx.x & 31u));							// PTX L6835
	r_PackedHalf2AtPtx6838R2027 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5140R1981,
										  r_MmaAccumulatorHalf2WordAtPtx5140R1981); // PTX L6838
	r_LaneIndexAtPtx6842 = uint32_t((threadIdx.x & 31u));							// PTX L6842
	r_PackedHalf2AtPtx6845R2030 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5147R1983,
										  r_MmaAccumulatorHalf2WordAtPtx5147R1983); // PTX L6845
	r_LaneIndexAtPtx6849 = uint32_t((threadIdx.x & 31u));							// PTX L6849
	r_PackedHalf2AtPtx6852R2033 = HalfMul(r_MmaAccumulatorHalf2WordAtPtx5147R1985,
										  r_MmaAccumulatorHalf2WordAtPtx5147R1985); // PTX L6852
	r_LaneIndexAtPtx6856 = uint32_t((threadIdx.x & 31u));							// PTX L6856
	r_PackedHalf2AtPtx6859R2035 =
		HalfAdd(r_PackedHalf2AtPtx6635R1987, r_PackedHalf2AtPtx6663R1988); // PTX L6859
	r_LaneIndexAtPtx6863 = uint32_t((threadIdx.x & 31u));				   // PTX L6863
	r_PackedHalf2AtPtx6866R2037 =
		HalfAdd(r_PackedHalf2AtPtx6642R1990, r_PackedHalf2AtPtx6670R1991); // PTX L6866
	r_LaneIndexAtPtx6870 = uint32_t((threadIdx.x & 31u));				   // PTX L6870
	r_PackedHalf2AtPtx6873R2034 =
		HalfAdd(r_PackedHalf2AtPtx6649R1993, r_PackedHalf2AtPtx6677R1994); // PTX L6873
	r_LaneIndexAtPtx6877 = uint32_t((threadIdx.x & 31u));				   // PTX L6877
	r_PackedHalf2AtPtx6880R2036 =
		HalfAdd(r_PackedHalf2AtPtx6656R1996, r_PackedHalf2AtPtx6684R1997); // PTX L6880
	r_LaneIndexAtPtx6884 = uint32_t((threadIdx.x & 31u));				   // PTX L6884
	r_PackedHalf2AtPtx6887R2051 =
		HalfAdd(r_PackedHalf2AtPtx6691R1999, r_PackedHalf2AtPtx6719R2000); // PTX L6887
	r_LaneIndexAtPtx6891 = uint32_t((threadIdx.x & 31u));				   // PTX L6891
	r_PackedHalf2AtPtx6894R2053 =
		HalfAdd(r_PackedHalf2AtPtx6698R2002, r_PackedHalf2AtPtx6726R2003); // PTX L6894
	r_LaneIndexAtPtx6898 = uint32_t((threadIdx.x & 31u));				   // PTX L6898
	r_PackedHalf2AtPtx6901R2050 =
		HalfAdd(r_PackedHalf2AtPtx6705R2005, r_PackedHalf2AtPtx6733R2006); // PTX L6901
	r_LaneIndexAtPtx6905 = uint32_t((threadIdx.x & 31u));				   // PTX L6905
	r_PackedHalf2AtPtx6908R2052 =
		HalfAdd(r_PackedHalf2AtPtx6712R2008, r_PackedHalf2AtPtx6740R2009); // PTX L6908
	r_LaneIndexAtPtx6912 = uint32_t((threadIdx.x & 31u));				   // PTX L6912
	r_PackedHalf2AtPtx6915R2067 =
		HalfAdd(r_PackedHalf2AtPtx6747R2011, r_PackedHalf2AtPtx6775R2012); // PTX L6915
	r_LaneIndexAtPtx6919 = uint32_t((threadIdx.x & 31u));				   // PTX L6919
	r_PackedHalf2AtPtx6922R2069 =
		HalfAdd(r_PackedHalf2AtPtx6754R2014, r_PackedHalf2AtPtx6782R2015); // PTX L6922
	r_LaneIndexAtPtx6926 = uint32_t((threadIdx.x & 31u));				   // PTX L6926
	r_PackedHalf2AtPtx6929R2066 =
		HalfAdd(r_PackedHalf2AtPtx6761R2017, r_PackedHalf2AtPtx6789R2018); // PTX L6929
	r_LaneIndexAtPtx6933 = uint32_t((threadIdx.x & 31u));				   // PTX L6933
	r_PackedHalf2AtPtx6936R2068 =
		HalfAdd(r_PackedHalf2AtPtx6768R2020, r_PackedHalf2AtPtx6796R2021); // PTX L6936
	r_LaneIndexAtPtx6940 = uint32_t((threadIdx.x & 31u));				   // PTX L6940
	r_PackedHalf2AtPtx6943R2083 =
		HalfAdd(r_PackedHalf2AtPtx6803R2023, r_PackedHalf2AtPtx6831R2024); // PTX L6943
	r_LaneIndexAtPtx6947 = uint32_t((threadIdx.x & 31u));				   // PTX L6947
	r_PackedHalf2AtPtx6950R2085 =
		HalfAdd(r_PackedHalf2AtPtx6810R2026, r_PackedHalf2AtPtx6838R2027); // PTX L6950
	r_LaneIndexAtPtx6954 = uint32_t((threadIdx.x & 31u));				   // PTX L6954
	r_PackedHalf2AtPtx6957R2082 =
		HalfAdd(r_PackedHalf2AtPtx6817R2029, r_PackedHalf2AtPtx6845R2030); // PTX L6957
	r_LaneIndexAtPtx6961 = uint32_t((threadIdx.x & 31u));				   // PTX L6961
	r_PackedHalf2AtPtx6964R2084 =
		HalfAdd(r_PackedHalf2AtPtx6824R2032, r_PackedHalf2AtPtx6852R2033); // PTX L6964
	r_PackedHalf2AtPtx6968R2038 =
		HalfAdd(r_PackedHalf2AtPtx6873R2034, r_PackedHalf2AtPtx6859R2035); // PTX L6968
	r_PackedHalf2AtPtx6972R2044 =
		HalfAdd(r_PackedHalf2AtPtx6880R2036, r_PackedHalf2AtPtx6866R2037); // PTX L6972
	r_PackedHalf2AtPtx6976R2039 = ShuffleBfly(r_PackedHalf2AtPtx6968R2038, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L6976
	r_PackedHalf2AtPtx6980R2040 =
		HalfAdd(r_PackedHalf2AtPtx6968R2038, r_PackedHalf2AtPtx6976R2039); // PTX L6980
	r_PackedHalf2AtPtx6984R2041 = ShuffleBfly(r_PackedHalf2AtPtx6980R2040, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L6984
	r_PtxRegister2042 = HalfAdd(r_PackedHalf2AtPtx6980R2040, r_PackedHalf2AtPtx6984R2041); // PTX L6988
	r_PtxU16Register386 = uint16_t(r_PtxRegister2042);
	r_PtxU16Register387 = uint16_t(r_PtxRegister2042 >> 16);							   // PTX L6991
	r_PackedHalf2AtPtx6992R2043 = JoinHalfwords(r_PtxU16Register387, r_PtxU16Register386); // PTX L6992
	r_PackedHalf2AtPtx6994R2099 = HalfAdd(r_PtxRegister2042, r_PackedHalf2AtPtx6992R2043); // PTX L6994
	r_PackedHalf2AtPtx6998R2045 = ShuffleBfly(r_PackedHalf2AtPtx6972R2044, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L6998
	r_PackedHalf2AtPtx7002R2046 =
		HalfAdd(r_PackedHalf2AtPtx6972R2044, r_PackedHalf2AtPtx6998R2045); // PTX L7002
	r_PackedHalf2AtPtx7006R2047 = ShuffleBfly(r_PackedHalf2AtPtx7002R2046, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L7006
	r_PtxRegister2048 = HalfAdd(r_PackedHalf2AtPtx7002R2046, r_PackedHalf2AtPtx7006R2047); // PTX L7010
	r_PtxU16Register388 = uint16_t(r_PtxRegister2048);
	r_PtxU16Register389 = uint16_t(r_PtxRegister2048 >> 16);							   // PTX L7013
	r_PackedHalf2AtPtx7014R2049 = JoinHalfwords(r_PtxU16Register389, r_PtxU16Register388); // PTX L7014
	r_PackedHalf2AtPtx7016R2101 = HalfAdd(r_PtxRegister2048, r_PackedHalf2AtPtx7014R2049); // PTX L7016
	r_PackedHalf2AtPtx7020R2054 =
		HalfAdd(r_PackedHalf2AtPtx6901R2050, r_PackedHalf2AtPtx6887R2051); // PTX L7020
	r_PackedHalf2AtPtx7024R2060 =
		HalfAdd(r_PackedHalf2AtPtx6908R2052, r_PackedHalf2AtPtx6894R2053); // PTX L7024
	r_PackedHalf2AtPtx7028R2055 = ShuffleBfly(r_PackedHalf2AtPtx7020R2054, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L7028
	r_PackedHalf2AtPtx7032R2056 =
		HalfAdd(r_PackedHalf2AtPtx7020R2054, r_PackedHalf2AtPtx7028R2055); // PTX L7032
	r_PackedHalf2AtPtx7036R2057 = ShuffleBfly(r_PackedHalf2AtPtx7032R2056, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L7036
	r_PtxRegister2058 = HalfAdd(r_PackedHalf2AtPtx7032R2056, r_PackedHalf2AtPtx7036R2057); // PTX L7040
	r_PtxU16Register390 = uint16_t(r_PtxRegister2058);
	r_PtxU16Register391 = uint16_t(r_PtxRegister2058 >> 16);							   // PTX L7043
	r_PackedHalf2AtPtx7044R2059 = JoinHalfwords(r_PtxU16Register391, r_PtxU16Register390); // PTX L7044
	r_PackedHalf2AtPtx7046R2109 = HalfAdd(r_PtxRegister2058, r_PackedHalf2AtPtx7044R2059); // PTX L7046
	r_PackedHalf2AtPtx7050R2061 = ShuffleBfly(r_PackedHalf2AtPtx7024R2060, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L7050
	r_PackedHalf2AtPtx7054R2062 =
		HalfAdd(r_PackedHalf2AtPtx7024R2060, r_PackedHalf2AtPtx7050R2061); // PTX L7054
	r_PackedHalf2AtPtx7058R2063 = ShuffleBfly(r_PackedHalf2AtPtx7054R2062, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L7058
	r_PtxRegister2064 = HalfAdd(r_PackedHalf2AtPtx7054R2062, r_PackedHalf2AtPtx7058R2063); // PTX L7062
	r_PtxU16Register392 = uint16_t(r_PtxRegister2064);
	r_PtxU16Register393 = uint16_t(r_PtxRegister2064 >> 16);							   // PTX L7065
	r_PackedHalf2AtPtx7066R2065 = JoinHalfwords(r_PtxU16Register393, r_PtxU16Register392); // PTX L7066
	r_PackedHalf2AtPtx7068R2111 = HalfAdd(r_PtxRegister2064, r_PackedHalf2AtPtx7066R2065); // PTX L7068
	r_PackedHalf2AtPtx7072R2070 =
		HalfAdd(r_PackedHalf2AtPtx6929R2066, r_PackedHalf2AtPtx6915R2067); // PTX L7072
	r_PackedHalf2AtPtx7076R2076 =
		HalfAdd(r_PackedHalf2AtPtx6936R2068, r_PackedHalf2AtPtx6922R2069); // PTX L7076
	r_PackedHalf2AtPtx7080R2071 = ShuffleBfly(r_PackedHalf2AtPtx7072R2070, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L7080
	r_PackedHalf2AtPtx7084R2072 =
		HalfAdd(r_PackedHalf2AtPtx7072R2070, r_PackedHalf2AtPtx7080R2071); // PTX L7084
	r_PackedHalf2AtPtx7088R2073 = ShuffleBfly(r_PackedHalf2AtPtx7084R2072, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L7088
	r_PtxRegister2074 = HalfAdd(r_PackedHalf2AtPtx7084R2072, r_PackedHalf2AtPtx7088R2073); // PTX L7092
	r_PtxU16Register394 = uint16_t(r_PtxRegister2074);
	r_PtxU16Register395 = uint16_t(r_PtxRegister2074 >> 16);							   // PTX L7095
	r_PackedHalf2AtPtx7096R2075 = JoinHalfwords(r_PtxU16Register395, r_PtxU16Register394); // PTX L7096
	r_PackedHalf2AtPtx7098R2119 = HalfAdd(r_PtxRegister2074, r_PackedHalf2AtPtx7096R2075); // PTX L7098
	r_PackedHalf2AtPtx7102R2077 = ShuffleBfly(r_PackedHalf2AtPtx7076R2076, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L7102
	r_PackedHalf2AtPtx7106R2078 =
		HalfAdd(r_PackedHalf2AtPtx7076R2076, r_PackedHalf2AtPtx7102R2077); // PTX L7106
	r_PackedHalf2AtPtx7110R2079 = ShuffleBfly(r_PackedHalf2AtPtx7106R2078, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L7110
	r_PtxRegister2080 = HalfAdd(r_PackedHalf2AtPtx7106R2078, r_PackedHalf2AtPtx7110R2079); // PTX L7114
	r_PtxU16Register396 = uint16_t(r_PtxRegister2080);
	r_PtxU16Register397 = uint16_t(r_PtxRegister2080 >> 16);							   // PTX L7117
	r_PackedHalf2AtPtx7118R2081 = JoinHalfwords(r_PtxU16Register397, r_PtxU16Register396); // PTX L7118
	r_PackedHalf2AtPtx7120R2121 = HalfAdd(r_PtxRegister2080, r_PackedHalf2AtPtx7118R2081); // PTX L7120
	r_PackedHalf2AtPtx7124R2086 =
		HalfAdd(r_PackedHalf2AtPtx6957R2082, r_PackedHalf2AtPtx6943R2083); // PTX L7124
	r_PackedHalf2AtPtx7128R2092 =
		HalfAdd(r_PackedHalf2AtPtx6964R2084, r_PackedHalf2AtPtx6950R2085); // PTX L7128
	r_PackedHalf2AtPtx7132R2087 = ShuffleBfly(r_PackedHalf2AtPtx7124R2086, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L7132
	r_PackedHalf2AtPtx7136R2088 =
		HalfAdd(r_PackedHalf2AtPtx7124R2086, r_PackedHalf2AtPtx7132R2087); // PTX L7136
	r_PackedHalf2AtPtx7140R2089 = ShuffleBfly(r_PackedHalf2AtPtx7136R2088, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L7140
	r_PtxRegister2090 = HalfAdd(r_PackedHalf2AtPtx7136R2088, r_PackedHalf2AtPtx7140R2089); // PTX L7144
	r_PtxU16Register398 = uint16_t(r_PtxRegister2090);
	r_PtxU16Register399 = uint16_t(r_PtxRegister2090 >> 16);							   // PTX L7147
	r_PackedHalf2AtPtx7148R2091 = JoinHalfwords(r_PtxU16Register399, r_PtxU16Register398); // PTX L7148
	r_PackedHalf2AtPtx7150R2129 = HalfAdd(r_PtxRegister2090, r_PackedHalf2AtPtx7148R2091); // PTX L7150
	r_PackedHalf2AtPtx7154R2093 = ShuffleBfly(r_PackedHalf2AtPtx7128R2092, r_PtxRegister1639,
											  r_PtxRegister1640, r_PtxRegister1641); // PTX L7154
	r_PackedHalf2AtPtx7158R2094 =
		HalfAdd(r_PackedHalf2AtPtx7128R2092, r_PackedHalf2AtPtx7154R2093); // PTX L7158
	r_PackedHalf2AtPtx7162R2095 = ShuffleBfly(r_PackedHalf2AtPtx7158R2094, r_PtxRegister1644,
											  r_PtxRegister1640, r_PtxRegister1641);	   // PTX L7162
	r_PtxRegister2096 = HalfAdd(r_PackedHalf2AtPtx7158R2094, r_PackedHalf2AtPtx7162R2095); // PTX L7166
	r_PtxU16Register400 = uint16_t(r_PtxRegister2096);
	r_PtxU16Register401 = uint16_t(r_PtxRegister2096 >> 16);							   // PTX L7169
	r_PackedHalf2AtPtx7170R2097 = JoinHalfwords(r_PtxU16Register401, r_PtxU16Register400); // PTX L7170
	r_PackedHalf2AtPtx7172R2131 = HalfAdd(r_PtxRegister2096, r_PackedHalf2AtPtx7170R2097); // PTX L7172
	r_LaneIndexAtPtx7176 = uint32_t((threadIdx.x & 31u));								   // PTX L7176
	r_PackedHalf2AtPtx7179R2139 =
		HalfMax(r_PackedHalf2AtPtx6994R2099, r_PackedHalf2AtPtx5740R1705); // PTX L7179
	r_LaneIndexAtPtx7183 = uint32_t((threadIdx.x & 31u));				   // PTX L7183
	r_PackedHalf2AtPtx7186R2141 =
		HalfMax(r_PackedHalf2AtPtx7016R2101, r_PackedHalf2AtPtx5740R1705); // PTX L7186
	r_LaneIndexAtPtx7190 = uint32_t((threadIdx.x & 31u));				   // PTX L7190
	r_LaneIndexAtPtx7193 = uint32_t((threadIdx.x & 31u));				   // PTX L7193
	r_LaneIndexAtPtx7196 = uint32_t((threadIdx.x & 31u));				   // PTX L7196
	r_LaneIndexAtPtx7199 = uint32_t((threadIdx.x & 31u));				   // PTX L7199
	r_LaneIndexAtPtx7202 = uint32_t((threadIdx.x & 31u));				   // PTX L7202
	r_LaneIndexAtPtx7205 = uint32_t((threadIdx.x & 31u));				   // PTX L7205
	r_LaneIndexAtPtx7208 = uint32_t((threadIdx.x & 31u));				   // PTX L7208
	r_PackedHalf2AtPtx7211R2149 =
		HalfMax(r_PackedHalf2AtPtx7046R2109, r_PackedHalf2AtPtx5740R1705); // PTX L7211
	r_LaneIndexAtPtx7215 = uint32_t((threadIdx.x & 31u));				   // PTX L7215
	r_PackedHalf2AtPtx7218R2151 =
		HalfMax(r_PackedHalf2AtPtx7068R2111, r_PackedHalf2AtPtx5740R1705); // PTX L7218
	r_LaneIndexAtPtx7222 = uint32_t((threadIdx.x & 31u));				   // PTX L7222
	r_LaneIndexAtPtx7225 = uint32_t((threadIdx.x & 31u));				   // PTX L7225
	r_LaneIndexAtPtx7228 = uint32_t((threadIdx.x & 31u));				   // PTX L7228
	r_LaneIndexAtPtx7231 = uint32_t((threadIdx.x & 31u));				   // PTX L7231
	r_LaneIndexAtPtx7234 = uint32_t((threadIdx.x & 31u));				   // PTX L7234
	r_LaneIndexAtPtx7237 = uint32_t((threadIdx.x & 31u));				   // PTX L7237
	r_LaneIndexAtPtx7240 = uint32_t((threadIdx.x & 31u));				   // PTX L7240
	r_PackedHalf2AtPtx7243R2159 =
		HalfMax(r_PackedHalf2AtPtx7098R2119, r_PackedHalf2AtPtx5740R1705); // PTX L7243
	r_LaneIndexAtPtx7247 = uint32_t((threadIdx.x & 31u));				   // PTX L7247
	r_PackedHalf2AtPtx7250R2161 =
		HalfMax(r_PackedHalf2AtPtx7120R2121, r_PackedHalf2AtPtx5740R1705); // PTX L7250
	r_LaneIndexAtPtx7254 = uint32_t((threadIdx.x & 31u));				   // PTX L7254
	r_LaneIndexAtPtx7257 = uint32_t((threadIdx.x & 31u));				   // PTX L7257
	r_LaneIndexAtPtx7260 = uint32_t((threadIdx.x & 31u));				   // PTX L7260
	r_LaneIndexAtPtx7263 = uint32_t((threadIdx.x & 31u));				   // PTX L7263
	r_LaneIndexAtPtx7266 = uint32_t((threadIdx.x & 31u));				   // PTX L7266
	r_LaneIndexAtPtx7269 = uint32_t((threadIdx.x & 31u));				   // PTX L7269
	r_LaneIndexAtPtx7272 = uint32_t((threadIdx.x & 31u));				   // PTX L7272
	r_PackedHalf2AtPtx7275R2169 =
		HalfMax(r_PackedHalf2AtPtx7150R2129, r_PackedHalf2AtPtx5740R1705); // PTX L7275
	r_LaneIndexAtPtx7279 = uint32_t((threadIdx.x & 31u));				   // PTX L7279
	r_PackedHalf2AtPtx7282R2171 =
		HalfMax(r_PackedHalf2AtPtx7172R2131, r_PackedHalf2AtPtx5740R1705); // PTX L7282
	r_LaneIndexAtPtx7286 = uint32_t((threadIdx.x & 31u));				   // PTX L7286
	r_LaneIndexAtPtx7289 = uint32_t((threadIdx.x & 31u));				   // PTX L7289
	r_LaneIndexAtPtx7292 = uint32_t((threadIdx.x & 31u));				   // PTX L7292
	r_LaneIndexAtPtx7295 = uint32_t((threadIdx.x & 31u));				   // PTX L7295
	r_LaneIndexAtPtx7298 = uint32_t((threadIdx.x & 31u));				   // PTX L7298
	r_LaneIndexAtPtx7301 = uint32_t((threadIdx.x & 31u));				   // PTX L7301
	r_LaneIndexAtPtx7304 = uint32_t((threadIdx.x & 31u));				   // PTX L7304
	r_PackedHalf2AtPtx7307R2179 = RsqrtHalf2(r_PackedHalf2AtPtx7179R2139); // PTX L7307
	r_LaneIndexAtPtx7320 = uint32_t((threadIdx.x & 31u));				   // PTX L7320
	r_PackedHalf2AtPtx7323R2181 = RsqrtHalf2(r_PackedHalf2AtPtx7186R2141); // PTX L7323
	r_LaneIndexAtPtx7336 = uint32_t((threadIdx.x & 31u));				   // PTX L7336
	r_LaneIndexAtPtx7339 = uint32_t((threadIdx.x & 31u));				   // PTX L7339
	r_LaneIndexAtPtx7342 = uint32_t((threadIdx.x & 31u));				   // PTX L7342
	r_LaneIndexAtPtx7345 = uint32_t((threadIdx.x & 31u));				   // PTX L7345
	r_LaneIndexAtPtx7348 = uint32_t((threadIdx.x & 31u));				   // PTX L7348
	r_LaneIndexAtPtx7351 = uint32_t((threadIdx.x & 31u));				   // PTX L7351
	r_LaneIndexAtPtx7354 = uint32_t((threadIdx.x & 31u));				   // PTX L7354
	r_PackedHalf2AtPtx7357R2189 = RsqrtHalf2(r_PackedHalf2AtPtx7211R2149); // PTX L7357
	r_LaneIndexAtPtx7370 = uint32_t((threadIdx.x & 31u));				   // PTX L7370
	r_PackedHalf2AtPtx7373R2191 = RsqrtHalf2(r_PackedHalf2AtPtx7218R2151); // PTX L7373
	r_LaneIndexAtPtx7386 = uint32_t((threadIdx.x & 31u));				   // PTX L7386
	r_LaneIndexAtPtx7389 = uint32_t((threadIdx.x & 31u));				   // PTX L7389
	r_LaneIndexAtPtx7392 = uint32_t((threadIdx.x & 31u));				   // PTX L7392
	r_LaneIndexAtPtx7395 = uint32_t((threadIdx.x & 31u));				   // PTX L7395
	r_LaneIndexAtPtx7398 = uint32_t((threadIdx.x & 31u));				   // PTX L7398
	r_LaneIndexAtPtx7401 = uint32_t((threadIdx.x & 31u));				   // PTX L7401
	r_LaneIndexAtPtx7404 = uint32_t((threadIdx.x & 31u));				   // PTX L7404
	r_PackedHalf2AtPtx7407R2199 = RsqrtHalf2(r_PackedHalf2AtPtx7243R2159); // PTX L7407
	r_LaneIndexAtPtx7420 = uint32_t((threadIdx.x & 31u));				   // PTX L7420
	r_PackedHalf2AtPtx7423R2201 = RsqrtHalf2(r_PackedHalf2AtPtx7250R2161); // PTX L7423
	r_LaneIndexAtPtx7436 = uint32_t((threadIdx.x & 31u));				   // PTX L7436
	r_LaneIndexAtPtx7439 = uint32_t((threadIdx.x & 31u));				   // PTX L7439
	r_LaneIndexAtPtx7442 = uint32_t((threadIdx.x & 31u));				   // PTX L7442
	r_LaneIndexAtPtx7445 = uint32_t((threadIdx.x & 31u));				   // PTX L7445
	r_LaneIndexAtPtx7448 = uint32_t((threadIdx.x & 31u));				   // PTX L7448
	r_LaneIndexAtPtx7451 = uint32_t((threadIdx.x & 31u));				   // PTX L7451
	r_LaneIndexAtPtx7454 = uint32_t((threadIdx.x & 31u));				   // PTX L7454
	r_PackedHalf2AtPtx7457R2209 = RsqrtHalf2(r_PackedHalf2AtPtx7275R2169); // PTX L7457
	r_LaneIndexAtPtx7470 = uint32_t((threadIdx.x & 31u));				   // PTX L7470
	r_PackedHalf2AtPtx7473R2211 = RsqrtHalf2(r_PackedHalf2AtPtx7282R2171); // PTX L7473
	r_LaneIndexAtPtx7486 = uint32_t((threadIdx.x & 31u));				   // PTX L7486
	r_LaneIndexAtPtx7489 = uint32_t((threadIdx.x & 31u));				   // PTX L7489
	r_LaneIndexAtPtx7492 = uint32_t((threadIdx.x & 31u));				   // PTX L7492
	r_LaneIndexAtPtx7495 = uint32_t((threadIdx.x & 31u));				   // PTX L7495
	r_LaneIndexAtPtx7498 = uint32_t((threadIdx.x & 31u));				   // PTX L7498
	r_LaneIndexAtPtx7501 = uint32_t((threadIdx.x & 31u));				   // PTX L7501
	r_LaneIndexAtPtx7504 = uint32_t((threadIdx.x & 31u));				   // PTX L7504
	r_PackedHalf2AtPtx7507R2218 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4874R1923, r_PackedHalf2AtPtx7307R2179); // PTX L7507
	r_LaneIndexAtPtx7511 = uint32_t((threadIdx.x & 31u));							   // PTX L7511
	r_PackedHalf2AtPtx7514R2222 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4874R1925, r_PackedHalf2AtPtx7323R2181); // PTX L7514
	r_LaneIndexAtPtx7518 = uint32_t((threadIdx.x & 31u));							   // PTX L7518
	r_PackedHalf2AtPtx7521R2219 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4881R1927, r_PackedHalf2AtPtx7307R2179); // PTX L7521
	r_LaneIndexAtPtx7525 = uint32_t((threadIdx.x & 31u));							   // PTX L7525
	r_PackedHalf2AtPtx7528R2223 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4881R1929, r_PackedHalf2AtPtx7323R2181); // PTX L7528
	r_LaneIndexAtPtx7532 = uint32_t((threadIdx.x & 31u));							   // PTX L7532
	r_PackedHalf2AtPtx7535R2220 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4888R1931, r_PackedHalf2AtPtx7307R2179); // PTX L7535
	r_LaneIndexAtPtx7539 = uint32_t((threadIdx.x & 31u));							   // PTX L7539
	r_PackedHalf2AtPtx7542R2224 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4888R1933, r_PackedHalf2AtPtx7323R2181); // PTX L7542
	r_LaneIndexAtPtx7546 = uint32_t((threadIdx.x & 31u));							   // PTX L7546
	r_PackedHalf2AtPtx7549R2221 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4895R1935, r_PackedHalf2AtPtx7307R2179); // PTX L7549
	r_LaneIndexAtPtx7553 = uint32_t((threadIdx.x & 31u));							   // PTX L7553
	r_PackedHalf2AtPtx7556R2225 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4895R1937, r_PackedHalf2AtPtx7323R2181); // PTX L7556
	r_LaneIndexAtPtx7560 = uint32_t((threadIdx.x & 31u));							   // PTX L7560
	r_PackedHalf2AtPtx7563R2226 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4958R1939, r_PackedHalf2AtPtx7357R2189); // PTX L7563
	r_LaneIndexAtPtx7567 = uint32_t((threadIdx.x & 31u));							   // PTX L7567
	r_PackedHalf2AtPtx7570R2230 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4958R1941, r_PackedHalf2AtPtx7373R2191); // PTX L7570
	r_LaneIndexAtPtx7574 = uint32_t((threadIdx.x & 31u));							   // PTX L7574
	r_PackedHalf2AtPtx7577R2227 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4965R1943, r_PackedHalf2AtPtx7357R2189); // PTX L7577
	r_LaneIndexAtPtx7581 = uint32_t((threadIdx.x & 31u));							   // PTX L7581
	r_PackedHalf2AtPtx7584R2231 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4965R1945, r_PackedHalf2AtPtx7373R2191); // PTX L7584
	r_LaneIndexAtPtx7588 = uint32_t((threadIdx.x & 31u));							   // PTX L7588
	r_PackedHalf2AtPtx7591R2228 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4972R1947, r_PackedHalf2AtPtx7357R2189); // PTX L7591
	r_LaneIndexAtPtx7595 = uint32_t((threadIdx.x & 31u));							   // PTX L7595
	r_PackedHalf2AtPtx7598R2232 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4972R1949, r_PackedHalf2AtPtx7373R2191); // PTX L7598
	r_LaneIndexAtPtx7602 = uint32_t((threadIdx.x & 31u));							   // PTX L7602
	r_PackedHalf2AtPtx7605R2229 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4979R1951, r_PackedHalf2AtPtx7357R2189); // PTX L7605
	r_LaneIndexAtPtx7609 = uint32_t((threadIdx.x & 31u));							   // PTX L7609
	r_PackedHalf2AtPtx7612R2233 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx4979R1953, r_PackedHalf2AtPtx7373R2191); // PTX L7612
	r_LaneIndexAtPtx7616 = uint32_t((threadIdx.x & 31u));							   // PTX L7616
	r_PackedHalf2AtPtx7619R2234 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5042R1955, r_PackedHalf2AtPtx7407R2199); // PTX L7619
	r_LaneIndexAtPtx7623 = uint32_t((threadIdx.x & 31u));							   // PTX L7623
	r_PackedHalf2AtPtx7626R2238 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5042R1957, r_PackedHalf2AtPtx7423R2201); // PTX L7626
	r_LaneIndexAtPtx7630 = uint32_t((threadIdx.x & 31u));							   // PTX L7630
	r_PackedHalf2AtPtx7633R2235 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5049R1959, r_PackedHalf2AtPtx7407R2199); // PTX L7633
	r_LaneIndexAtPtx7637 = uint32_t((threadIdx.x & 31u));							   // PTX L7637
	r_PackedHalf2AtPtx7640R2239 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5049R1961, r_PackedHalf2AtPtx7423R2201); // PTX L7640
	r_LaneIndexAtPtx7644 = uint32_t((threadIdx.x & 31u));							   // PTX L7644
	r_PackedHalf2AtPtx7647R2236 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5056R1963, r_PackedHalf2AtPtx7407R2199); // PTX L7647
	r_LaneIndexAtPtx7651 = uint32_t((threadIdx.x & 31u));							   // PTX L7651
	r_PackedHalf2AtPtx7654R2240 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5056R1965, r_PackedHalf2AtPtx7423R2201); // PTX L7654
	r_LaneIndexAtPtx7658 = uint32_t((threadIdx.x & 31u));							   // PTX L7658
	r_PackedHalf2AtPtx7661R2237 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5063R1967, r_PackedHalf2AtPtx7407R2199); // PTX L7661
	r_LaneIndexAtPtx7665 = uint32_t((threadIdx.x & 31u));							   // PTX L7665
	r_PackedHalf2AtPtx7668R2241 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5063R1969, r_PackedHalf2AtPtx7423R2201); // PTX L7668
	r_LaneIndexAtPtx7672 = uint32_t((threadIdx.x & 31u));							   // PTX L7672
	r_PackedHalf2AtPtx7675R2242 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5126R1971, r_PackedHalf2AtPtx7457R2209); // PTX L7675
	r_LaneIndexAtPtx7679 = uint32_t((threadIdx.x & 31u));							   // PTX L7679
	r_PackedHalf2AtPtx7682R2246 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5126R1973, r_PackedHalf2AtPtx7473R2211); // PTX L7682
	r_LaneIndexAtPtx7686 = uint32_t((threadIdx.x & 31u));							   // PTX L7686
	r_PackedHalf2AtPtx7689R2243 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5133R1975, r_PackedHalf2AtPtx7457R2209); // PTX L7689
	r_LaneIndexAtPtx7693 = uint32_t((threadIdx.x & 31u));							   // PTX L7693
	r_PackedHalf2AtPtx7696R2247 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5133R1977, r_PackedHalf2AtPtx7473R2211); // PTX L7696
	r_LaneIndexAtPtx7700 = uint32_t((threadIdx.x & 31u));							   // PTX L7700
	r_PackedHalf2AtPtx7703R2244 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5140R1979, r_PackedHalf2AtPtx7457R2209); // PTX L7703
	r_LaneIndexAtPtx7707 = uint32_t((threadIdx.x & 31u));							   // PTX L7707
	r_PackedHalf2AtPtx7710R2248 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5140R1981, r_PackedHalf2AtPtx7473R2211); // PTX L7710
	r_LaneIndexAtPtx7714 = uint32_t((threadIdx.x & 31u));							   // PTX L7714
	r_PackedHalf2AtPtx7717R2245 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5147R1983, r_PackedHalf2AtPtx7457R2209); // PTX L7717
	r_LaneIndexAtPtx7721 = uint32_t((threadIdx.x & 31u));							   // PTX L7721
	r_PackedHalf2AtPtx7724R2249 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx5147R1985, r_PackedHalf2AtPtx7473R2211); // PTX L7724
	r_ConvertedE4PairAtPtx7728Rs225 = PublishE4(r_PackedHalf2AtPtx7507R2218);		   // PTX L7728
	r_ConvertedE4PairAtPtx7731Rs226 = PublishE4(r_PackedHalf2AtPtx7521R2219);		   // PTX L7731
	r_MmaBE4x4WordAtPtx7733R2322 = JoinConvertedE4(r_ConvertedE4PairAtPtx7728Rs225,
												   r_ConvertedE4PairAtPtx7731Rs226); // PTX L7733
	r_ConvertedE4PairAtPtx7735Rs227 = PublishE4(r_PackedHalf2AtPtx7535R2220);		 // PTX L7735
	r_ConvertedE4PairAtPtx7738Rs228 = PublishE4(r_PackedHalf2AtPtx7549R2221);		 // PTX L7738
	r_MmaBE4x4WordAtPtx7740R2323 = JoinConvertedE4(r_ConvertedE4PairAtPtx7735Rs227,
												   r_ConvertedE4PairAtPtx7738Rs228); // PTX L7740
	r_ConvertedE4PairAtPtx7742Rs229 = PublishE4(r_PackedHalf2AtPtx7514R2222);		 // PTX L7742
	r_ConvertedE4PairAtPtx7745Rs230 = PublishE4(r_PackedHalf2AtPtx7528R2223);		 // PTX L7745
	r_MmaBE4x4WordAtPtx7747R2330 = JoinConvertedE4(r_ConvertedE4PairAtPtx7742Rs229,
												   r_ConvertedE4PairAtPtx7745Rs230); // PTX L7747
	r_ConvertedE4PairAtPtx7749Rs231 = PublishE4(r_PackedHalf2AtPtx7542R2224);		 // PTX L7749
	r_ConvertedE4PairAtPtx7752Rs232 = PublishE4(r_PackedHalf2AtPtx7556R2225);		 // PTX L7752
	r_MmaBE4x4WordAtPtx7754R2331 = JoinConvertedE4(r_ConvertedE4PairAtPtx7749Rs231,
												   r_ConvertedE4PairAtPtx7752Rs232); // PTX L7754
	r_ConvertedE4PairAtPtx7756Rs233 = PublishE4(r_PackedHalf2AtPtx7563R2226);		 // PTX L7756
	r_ConvertedE4PairAtPtx7759Rs234 = PublishE4(r_PackedHalf2AtPtx7577R2227);		 // PTX L7759
	r_MmaBE4x4WordAtPtx7761R2334 = JoinConvertedE4(r_ConvertedE4PairAtPtx7756Rs233,
												   r_ConvertedE4PairAtPtx7759Rs234); // PTX L7761
	r_ConvertedE4PairAtPtx7763Rs235 = PublishE4(r_PackedHalf2AtPtx7591R2228);		 // PTX L7763
	r_ConvertedE4PairAtPtx7766Rs236 = PublishE4(r_PackedHalf2AtPtx7605R2229);		 // PTX L7766
	r_MmaBE4x4WordAtPtx7768R2335 = JoinConvertedE4(r_ConvertedE4PairAtPtx7763Rs235,
												   r_ConvertedE4PairAtPtx7766Rs236); // PTX L7768
	r_ConvertedE4PairAtPtx7770Rs237 = PublishE4(r_PackedHalf2AtPtx7570R2230);		 // PTX L7770
	r_ConvertedE4PairAtPtx7773Rs238 = PublishE4(r_PackedHalf2AtPtx7584R2231);		 // PTX L7773
	r_MmaBE4x4WordAtPtx7775R2338 = JoinConvertedE4(r_ConvertedE4PairAtPtx7770Rs237,
												   r_ConvertedE4PairAtPtx7773Rs238); // PTX L7775
	r_ConvertedE4PairAtPtx7777Rs239 = PublishE4(r_PackedHalf2AtPtx7598R2232);		 // PTX L7777
	r_ConvertedE4PairAtPtx7780Rs240 = PublishE4(r_PackedHalf2AtPtx7612R2233);		 // PTX L7780
	r_MmaBE4x4WordAtPtx7782R2339 = JoinConvertedE4(r_ConvertedE4PairAtPtx7777Rs239,
												   r_ConvertedE4PairAtPtx7780Rs240); // PTX L7782
	r_ConvertedE4PairAtPtx7784Rs241 = PublishE4(r_PackedHalf2AtPtx7619R2234);		 // PTX L7784
	r_ConvertedE4PairAtPtx7787Rs242 = PublishE4(r_PackedHalf2AtPtx7633R2235);		 // PTX L7787
	r_MmaBE4x4WordAtPtx7789R2342 = JoinConvertedE4(r_ConvertedE4PairAtPtx7784Rs241,
												   r_ConvertedE4PairAtPtx7787Rs242); // PTX L7789
	r_ConvertedE4PairAtPtx7791Rs243 = PublishE4(r_PackedHalf2AtPtx7647R2236);		 // PTX L7791
	r_ConvertedE4PairAtPtx7794Rs244 = PublishE4(r_PackedHalf2AtPtx7661R2237);		 // PTX L7794
	r_MmaBE4x4WordAtPtx7796R2343 = JoinConvertedE4(r_ConvertedE4PairAtPtx7791Rs243,
												   r_ConvertedE4PairAtPtx7794Rs244); // PTX L7796
	r_ConvertedE4PairAtPtx7798Rs245 = PublishE4(r_PackedHalf2AtPtx7626R2238);		 // PTX L7798
	r_ConvertedE4PairAtPtx7801Rs246 = PublishE4(r_PackedHalf2AtPtx7640R2239);		 // PTX L7801
	r_MmaBE4x4WordAtPtx7803R2346 = JoinConvertedE4(r_ConvertedE4PairAtPtx7798Rs245,
												   r_ConvertedE4PairAtPtx7801Rs246); // PTX L7803
	r_ConvertedE4PairAtPtx7805Rs247 = PublishE4(r_PackedHalf2AtPtx7654R2240);		 // PTX L7805
	r_ConvertedE4PairAtPtx7808Rs248 = PublishE4(r_PackedHalf2AtPtx7668R2241);		 // PTX L7808
	r_MmaBE4x4WordAtPtx7810R2347 = JoinConvertedE4(r_ConvertedE4PairAtPtx7805Rs247,
												   r_ConvertedE4PairAtPtx7808Rs248); // PTX L7810
	r_ConvertedE4PairAtPtx7812Rs249 = PublishE4(r_PackedHalf2AtPtx7675R2242);		 // PTX L7812
	r_ConvertedE4PairAtPtx7815Rs250 = PublishE4(r_PackedHalf2AtPtx7689R2243);		 // PTX L7815
	r_MmaBE4x4WordAtPtx7817R2350 = JoinConvertedE4(r_ConvertedE4PairAtPtx7812Rs249,
												   r_ConvertedE4PairAtPtx7815Rs250); // PTX L7817
	r_ConvertedE4PairAtPtx7819Rs251 = PublishE4(r_PackedHalf2AtPtx7703R2244);		 // PTX L7819
	r_ConvertedE4PairAtPtx7822Rs252 = PublishE4(r_PackedHalf2AtPtx7717R2245);		 // PTX L7822
	r_MmaBE4x4WordAtPtx7824R2351 = JoinConvertedE4(r_ConvertedE4PairAtPtx7819Rs251,
												   r_ConvertedE4PairAtPtx7822Rs252); // PTX L7824
	r_ConvertedE4PairAtPtx7826Rs253 = PublishE4(r_PackedHalf2AtPtx7682R2246);		 // PTX L7826
	r_ConvertedE4PairAtPtx7829Rs254 = PublishE4(r_PackedHalf2AtPtx7696R2247);		 // PTX L7829
	r_MmaBE4x4WordAtPtx7831R2354 = JoinConvertedE4(r_ConvertedE4PairAtPtx7826Rs253,
												   r_ConvertedE4PairAtPtx7829Rs254); // PTX L7831
	r_ConvertedE4PairAtPtx7833Rs255 = PublishE4(r_PackedHalf2AtPtx7710R2248);		 // PTX L7833
	r_ConvertedE4PairAtPtx7836Rs256 = PublishE4(r_PackedHalf2AtPtx7724R2249);		 // PTX L7836
	r_MmaBE4x4WordAtPtx7838R2355 = JoinConvertedE4(r_ConvertedE4PairAtPtx7833Rs255,
												   r_ConvertedE4PairAtPtx7836Rs256); // PTX L7838
	r_PtxRegister2282 = TransposeM8n8(r_PtxRegister2250);							 // PTX L7840
	r_PtxRegister2283 = TransposeM8n8(r_PtxRegister2251);							 // PTX L7843
	r_PtxRegister2286 = TransposeM8n8(r_PtxRegister2252);							 // PTX L7846
	r_PtxRegister2287 = TransposeM8n8(r_PtxRegister2253);							 // PTX L7849
	r_PtxRegister2290 = TransposeM8n8(r_PtxRegister2254);							 // PTX L7852
	r_PtxRegister2291 = TransposeM8n8(r_PtxRegister2255);							 // PTX L7855
	r_PtxRegister2294 = TransposeM8n8(r_PtxRegister2256);							 // PTX L7858
	r_PtxRegister2295 = TransposeM8n8(r_PtxRegister2257);							 // PTX L7861
	r_PtxRegister2284 = TransposeM8n8(r_PtxRegister2258);							 // PTX L7864
	r_PtxRegister2285 = TransposeM8n8(r_PtxRegister2259);							 // PTX L7867
	r_PtxRegister2288 = TransposeM8n8(r_PtxRegister2260);							 // PTX L7870
	r_PtxRegister2289 = TransposeM8n8(r_PtxRegister2261);							 // PTX L7873
	r_PtxRegister2292 = TransposeM8n8(r_PtxRegister2262);							 // PTX L7876
	r_PtxRegister2293 = TransposeM8n8(r_PtxRegister2263);							 // PTX L7879
	r_PtxRegister2296 = TransposeM8n8(r_PtxRegister2264);							 // PTX L7882
	r_PtxRegister2297 = TransposeM8n8(r_PtxRegister2265);							 // PTX L7885
	r_PtxRegister2298 = TransposeM8n8(r_PtxRegister2266);							 // PTX L7888
	r_PtxRegister2299 = TransposeM8n8(r_PtxRegister2267);							 // PTX L7891
	r_PtxRegister2302 = TransposeM8n8(r_PtxRegister2268);							 // PTX L7894
	r_PtxRegister2303 = TransposeM8n8(r_PtxRegister2269);							 // PTX L7897
	r_PtxRegister2306 = TransposeM8n8(r_PtxRegister2270);							 // PTX L7900
	r_PtxRegister2307 = TransposeM8n8(r_PtxRegister2271);							 // PTX L7903
	r_PtxRegister2310 = TransposeM8n8(r_PtxRegister2272);							 // PTX L7906
	r_PtxRegister2311 = TransposeM8n8(r_PtxRegister2273);							 // PTX L7909
	r_PtxRegister2300 = TransposeM8n8(r_PtxRegister2274);							 // PTX L7912
	r_PtxRegister2301 = TransposeM8n8(r_PtxRegister2275);							 // PTX L7915
	r_PtxRegister2304 = TransposeM8n8(r_PtxRegister2276);							 // PTX L7918
	r_PtxRegister2305 = TransposeM8n8(r_PtxRegister2277);							 // PTX L7921
	r_PtxRegister2308 = TransposeM8n8(r_PtxRegister2278);							 // PTX L7924
	r_PtxRegister2309 = TransposeM8n8(r_PtxRegister2279);							 // PTX L7927
	r_PtxRegister2312 = TransposeM8n8(r_PtxRegister2280);							 // PTX L7930
	r_PtxRegister2313 = TransposeM8n8(r_PtxRegister2281);							 // PTX L7933
	r_ConvertedE4PairAtPtx7936Rs257 = PublishE4(r_PtxRegister2282);					 // PTX L7936
	r_ConvertedE4PairAtPtx7939Rs258 = PublishE4(r_PtxRegister2283);					 // PTX L7939
	r_MmaBE4x4WordAtPtx7941R2723 = JoinConvertedE4(r_ConvertedE4PairAtPtx7936Rs257,
												   r_ConvertedE4PairAtPtx7939Rs258); // PTX L7941
	r_ConvertedE4PairAtPtx7943Rs259 = PublishE4(r_PtxRegister2284);					 // PTX L7943
	r_ConvertedE4PairAtPtx7946Rs260 = PublishE4(r_PtxRegister2285);					 // PTX L7946
	r_MmaBE4x4WordAtPtx7948R2724 = JoinConvertedE4(r_ConvertedE4PairAtPtx7943Rs259,
												   r_ConvertedE4PairAtPtx7946Rs260); // PTX L7948
	r_ConvertedE4PairAtPtx7950Rs261 = PublishE4(r_PtxRegister2286);					 // PTX L7950
	r_ConvertedE4PairAtPtx7953Rs262 = PublishE4(r_PtxRegister2287);					 // PTX L7953
	r_MmaBE4x4WordAtPtx7955R2729 = JoinConvertedE4(r_ConvertedE4PairAtPtx7950Rs261,
												   r_ConvertedE4PairAtPtx7953Rs262); // PTX L7955
	r_ConvertedE4PairAtPtx7957Rs263 = PublishE4(r_PtxRegister2288);					 // PTX L7957
	r_ConvertedE4PairAtPtx7960Rs264 = PublishE4(r_PtxRegister2289);					 // PTX L7960
	r_MmaBE4x4WordAtPtx7962R2730 = JoinConvertedE4(r_ConvertedE4PairAtPtx7957Rs263,
												   r_ConvertedE4PairAtPtx7960Rs264); // PTX L7962
	r_ConvertedE4PairAtPtx7964Rs265 = PublishE4(r_PtxRegister2290);					 // PTX L7964
	r_ConvertedE4PairAtPtx7967Rs266 = PublishE4(r_PtxRegister2291);					 // PTX L7967
	r_MmaBE4x4WordAtPtx7969R2743 = JoinConvertedE4(r_ConvertedE4PairAtPtx7964Rs265,
												   r_ConvertedE4PairAtPtx7967Rs266); // PTX L7969
	r_ConvertedE4PairAtPtx7971Rs267 = PublishE4(r_PtxRegister2292);					 // PTX L7971
	r_ConvertedE4PairAtPtx7974Rs268 = PublishE4(r_PtxRegister2293);					 // PTX L7974
	r_MmaBE4x4WordAtPtx7976R2744 = JoinConvertedE4(r_ConvertedE4PairAtPtx7971Rs267,
												   r_ConvertedE4PairAtPtx7974Rs268); // PTX L7976
	r_ConvertedE4PairAtPtx7978Rs269 = PublishE4(r_PtxRegister2294);					 // PTX L7978
	r_ConvertedE4PairAtPtx7981Rs270 = PublishE4(r_PtxRegister2295);					 // PTX L7981
	r_MmaBE4x4WordAtPtx7983R2745 = JoinConvertedE4(r_ConvertedE4PairAtPtx7978Rs269,
												   r_ConvertedE4PairAtPtx7981Rs270); // PTX L7983
	r_ConvertedE4PairAtPtx7985Rs271 = PublishE4(r_PtxRegister2296);					 // PTX L7985
	r_ConvertedE4PairAtPtx7988Rs272 = PublishE4(r_PtxRegister2297);					 // PTX L7988
	r_MmaBE4x4WordAtPtx7990R2746 = JoinConvertedE4(r_ConvertedE4PairAtPtx7985Rs271,
												   r_ConvertedE4PairAtPtx7988Rs272); // PTX L7990
	r_ConvertedE4PairAtPtx7992Rs273 = PublishE4(r_PtxRegister2298);					 // PTX L7992
	r_ConvertedE4PairAtPtx7995Rs274 = PublishE4(r_PtxRegister2299);					 // PTX L7995
	r_MmaBE4x4WordAtPtx7997R2731 = JoinConvertedE4(r_ConvertedE4PairAtPtx7992Rs273,
												   r_ConvertedE4PairAtPtx7995Rs274); // PTX L7997
	r_ConvertedE4PairAtPtx7999Rs275 = PublishE4(r_PtxRegister2300);					 // PTX L7999
	r_ConvertedE4PairAtPtx8002Rs276 = PublishE4(r_PtxRegister2301);					 // PTX L8002
	r_MmaBE4x4WordAtPtx8004R2732 = JoinConvertedE4(r_ConvertedE4PairAtPtx7999Rs275,
												   r_ConvertedE4PairAtPtx8002Rs276); // PTX L8004
	r_ConvertedE4PairAtPtx8006Rs277 = PublishE4(r_PtxRegister2302);					 // PTX L8006
	r_ConvertedE4PairAtPtx8009Rs278 = PublishE4(r_PtxRegister2303);					 // PTX L8009
	r_MmaBE4x4WordAtPtx8011R2739 = JoinConvertedE4(r_ConvertedE4PairAtPtx8006Rs277,
												   r_ConvertedE4PairAtPtx8009Rs278); // PTX L8011
	r_ConvertedE4PairAtPtx8013Rs279 = PublishE4(r_PtxRegister2304);					 // PTX L8013
	r_ConvertedE4PairAtPtx8016Rs280 = PublishE4(r_PtxRegister2305);					 // PTX L8016
	r_MmaBE4x4WordAtPtx8018R2740 = JoinConvertedE4(r_ConvertedE4PairAtPtx8013Rs279,
												   r_ConvertedE4PairAtPtx8016Rs280); // PTX L8018
	r_ConvertedE4PairAtPtx8020Rs281 = PublishE4(r_PtxRegister2306);					 // PTX L8020
	r_ConvertedE4PairAtPtx8023Rs282 = PublishE4(r_PtxRegister2307);					 // PTX L8023
	r_MmaBE4x4WordAtPtx8025R2747 = JoinConvertedE4(r_ConvertedE4PairAtPtx8020Rs281,
												   r_ConvertedE4PairAtPtx8023Rs282); // PTX L8025
	r_ConvertedE4PairAtPtx8027Rs283 = PublishE4(r_PtxRegister2308);					 // PTX L8027
	r_ConvertedE4PairAtPtx8030Rs284 = PublishE4(r_PtxRegister2309);					 // PTX L8030
	r_MmaBE4x4WordAtPtx8032R2748 = JoinConvertedE4(r_ConvertedE4PairAtPtx8027Rs283,
												   r_ConvertedE4PairAtPtx8030Rs284); // PTX L8032
	r_ConvertedE4PairAtPtx8034Rs285 = PublishE4(r_PtxRegister2310);					 // PTX L8034
	r_ConvertedE4PairAtPtx8037Rs286 = PublishE4(r_PtxRegister2311);					 // PTX L8037
	r_MmaBE4x4WordAtPtx8039R2751 = JoinConvertedE4(r_ConvertedE4PairAtPtx8034Rs285,
												   r_ConvertedE4PairAtPtx8037Rs286); // PTX L8039
	r_ConvertedE4PairAtPtx8041Rs287 = PublishE4(r_PtxRegister2312);					 // PTX L8041
	r_ConvertedE4PairAtPtx8044Rs288 = PublishE4(r_PtxRegister2313);					 // PTX L8044
	r_MmaBE4x4WordAtPtx8046R2752 = JoinConvertedE4(r_ConvertedE4PairAtPtx8041Rs287,
												   r_ConvertedE4PairAtPtx8044Rs288); // PTX L8046

	// Attention phase; retain native two-M16 scheduling and Half denominator trees
	__syncthreads();																			  // PTX L8047
	r_PtxRegister15 = ShiftLeft(uint32_t(r_ThreadYAtPtx4287), uint32_t(5));						  // PTX L8048
	r_PtxU64Register235 = uint64_t(uint32_t(r_PtxRegister2968)) * uint64_t(uint32_t(4));		  // PTX L8049
	g_RecordByteAddressAtPtx8050 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register235); // PTX L8050
	r_LaneIndexAtPtx8052 = uint32_t((threadIdx.x & 31u));										  // PTX L8052
	r_PtxU64Register236 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx8052)) * int64_t(int32_t(16))); // PTX L8054
	g_RecordByteAddressAtPtx8055 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register236);				 // PTX L8055
	g_RecordByteAddressAtPtx8056 = uint64_t(g_RecordByteAddressAtPtx8055) + uint64_t(41120); // PTX L8056
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx8056));
		r_MmaAccumulatorHalf2WordAtPtx8058R2324 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx8058R2325 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx8058R2332 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx8058R2333 = r_Value.w;
	} // PTX L8058
	r_LaneIndexAtPtx8061 = uint32_t((threadIdx.x & 31u)); // PTX L8061
	r_PtxU64Register238 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx8061)) * int64_t(int32_t(16))); // PTX L8063
	g_RecordByteAddressAtPtx8064 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register238);				 // PTX L8064
	g_RecordByteAddressAtPtx8065 = uint64_t(g_RecordByteAddressAtPtx8064) + uint64_t(41632); // PTX L8065
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx8065));
		r_MmaAccumulatorHalf2WordAtPtx8067R2336 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx8067R2337 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx8067R2340 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx8067R2341 = r_Value.w;
	} // PTX L8067
	r_LaneIndexAtPtx8070 = uint32_t((threadIdx.x & 31u)); // PTX L8070
	r_PtxU64Register240 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx8070)) * int64_t(int32_t(16))); // PTX L8072
	g_RecordByteAddressAtPtx8073 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register240);				 // PTX L8073
	g_RecordByteAddressAtPtx8074 = uint64_t(g_RecordByteAddressAtPtx8073) + uint64_t(42144); // PTX L8074
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx8074));
		r_MmaAccumulatorHalf2WordAtPtx8076R2344 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx8076R2345 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx8076R2348 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx8076R2349 = r_Value.w;
	} // PTX L8076
	r_LaneIndexAtPtx8079 = uint32_t((threadIdx.x & 31u)); // PTX L8079
	r_PtxU64Register242 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx8079)) * int64_t(int32_t(16))); // PTX L8081
	g_RecordByteAddressAtPtx8082 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register242);				 // PTX L8082
	g_RecordByteAddressAtPtx8083 = uint64_t(g_RecordByteAddressAtPtx8082) + uint64_t(42656); // PTX L8083
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx8083));
		r_MmaAccumulatorHalf2WordAtPtx8085R2352 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx8085R2353 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx8085R2356 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx8085R2357 = r_Value.w;
	} // PTX L8085
	r_LaneIndexAtPtx8088 = uint32_t((threadIdx.x & 31u)); // PTX L8088
	r_PtxU64Register244 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx8088)) * int64_t(int32_t(16))); // PTX L8090
	g_RecordByteAddressAtPtx8091 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register244);				 // PTX L8091
	g_RecordByteAddressAtPtx8092 = uint64_t(g_RecordByteAddressAtPtx8091) + uint64_t(43168); // PTX L8092
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx8092));
		r_MmaAccumulatorHalf2WordAtPtx8094R2358 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx8094R2359 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx8094R2364 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx8094R2365 = r_Value.w;
	} // PTX L8094
	r_LaneIndexAtPtx8097 = uint32_t((threadIdx.x & 31u)); // PTX L8097
	r_PtxU64Register246 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx8097)) * int64_t(int32_t(16))); // PTX L8099
	g_RecordByteAddressAtPtx8100 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register246);				 // PTX L8100
	g_RecordByteAddressAtPtx8101 = uint64_t(g_RecordByteAddressAtPtx8100) + uint64_t(43680); // PTX L8101
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx8101));
		r_MmaAccumulatorHalf2WordAtPtx8103R2366 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx8103R2367 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx8103R2368 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx8103R2369 = r_Value.w;
	} // PTX L8103
	r_LaneIndexAtPtx8106 = uint32_t((threadIdx.x & 31u)); // PTX L8106
	r_PtxU64Register248 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx8106)) * int64_t(int32_t(16))); // PTX L8108
	g_RecordByteAddressAtPtx8109 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register248);				 // PTX L8109
	g_RecordByteAddressAtPtx8110 = uint64_t(g_RecordByteAddressAtPtx8109) + uint64_t(44192); // PTX L8110
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx8110));
		r_MmaAccumulatorHalf2WordAtPtx8112R2370 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx8112R2371 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx8112R2372 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx8112R2373 = r_Value.w;
	} // PTX L8112
	r_LaneIndexAtPtx8115 = uint32_t((threadIdx.x & 31u)); // PTX L8115
	r_PtxU64Register250 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx8115)) * int64_t(int32_t(16))); // PTX L8117
	g_RecordByteAddressAtPtx8118 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register250);				 // PTX L8118
	g_RecordByteAddressAtPtx8119 = uint64_t(g_RecordByteAddressAtPtx8118) + uint64_t(44704); // PTX L8119
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx8119));
		r_MmaAccumulatorHalf2WordAtPtx8121R2374 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx8121R2375 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx8121R2376 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx8121R2377 = r_Value.w;
	} // PTX L8121
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8124R2383, r_MmaAccumulatorHalf2WordAtPtx8124R2388,
		  r_MmaAE4x4WordAtPtx6533R2326, r_MmaAE4x4WordAtPtx6540R2327, r_MmaAE4x4WordAtPtx6547R2328,
		  r_MmaAE4x4WordAtPtx6554R2329, r_MmaBE4x4WordAtPtx7733R2322, r_MmaBE4x4WordAtPtx7740R2323,
		  r_MmaAccumulatorHalf2WordAtPtx8058R2324,
		  r_MmaAccumulatorHalf2WordAtPtx8058R2325); // PTX L8124
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8131R2393, r_MmaAccumulatorHalf2WordAtPtx8131R2398,
		  r_MmaAE4x4WordAtPtx6533R2326, r_MmaAE4x4WordAtPtx6540R2327, r_MmaAE4x4WordAtPtx6547R2328,
		  r_MmaAE4x4WordAtPtx6554R2329, r_MmaBE4x4WordAtPtx7747R2330, r_MmaBE4x4WordAtPtx7754R2331,
		  r_MmaAccumulatorHalf2WordAtPtx8058R2332,
		  r_MmaAccumulatorHalf2WordAtPtx8058R2333); // PTX L8131
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8138R2403, r_MmaAccumulatorHalf2WordAtPtx8138R2408,
		  r_MmaAE4x4WordAtPtx6533R2326, r_MmaAE4x4WordAtPtx6540R2327, r_MmaAE4x4WordAtPtx6547R2328,
		  r_MmaAE4x4WordAtPtx6554R2329, r_MmaBE4x4WordAtPtx7761R2334, r_MmaBE4x4WordAtPtx7768R2335,
		  r_MmaAccumulatorHalf2WordAtPtx8067R2336,
		  r_MmaAccumulatorHalf2WordAtPtx8067R2337); // PTX L8138
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8145R2413, r_MmaAccumulatorHalf2WordAtPtx8145R2418,
		  r_MmaAE4x4WordAtPtx6533R2326, r_MmaAE4x4WordAtPtx6540R2327, r_MmaAE4x4WordAtPtx6547R2328,
		  r_MmaAE4x4WordAtPtx6554R2329, r_MmaBE4x4WordAtPtx7775R2338, r_MmaBE4x4WordAtPtx7782R2339,
		  r_MmaAccumulatorHalf2WordAtPtx8067R2340,
		  r_MmaAccumulatorHalf2WordAtPtx8067R2341); // PTX L8145
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8152R2423, r_MmaAccumulatorHalf2WordAtPtx8152R2428,
		  r_MmaAE4x4WordAtPtx6533R2326, r_MmaAE4x4WordAtPtx6540R2327, r_MmaAE4x4WordAtPtx6547R2328,
		  r_MmaAE4x4WordAtPtx6554R2329, r_MmaBE4x4WordAtPtx7789R2342, r_MmaBE4x4WordAtPtx7796R2343,
		  r_MmaAccumulatorHalf2WordAtPtx8076R2344,
		  r_MmaAccumulatorHalf2WordAtPtx8076R2345); // PTX L8152
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8159R2433, r_MmaAccumulatorHalf2WordAtPtx8159R2438,
		  r_MmaAE4x4WordAtPtx6533R2326, r_MmaAE4x4WordAtPtx6540R2327, r_MmaAE4x4WordAtPtx6547R2328,
		  r_MmaAE4x4WordAtPtx6554R2329, r_MmaBE4x4WordAtPtx7803R2346, r_MmaBE4x4WordAtPtx7810R2347,
		  r_MmaAccumulatorHalf2WordAtPtx8076R2348,
		  r_MmaAccumulatorHalf2WordAtPtx8076R2349); // PTX L8159
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8166R2443, r_MmaAccumulatorHalf2WordAtPtx8166R2448,
		  r_MmaAE4x4WordAtPtx6533R2326, r_MmaAE4x4WordAtPtx6540R2327, r_MmaAE4x4WordAtPtx6547R2328,
		  r_MmaAE4x4WordAtPtx6554R2329, r_MmaBE4x4WordAtPtx7817R2350, r_MmaBE4x4WordAtPtx7824R2351,
		  r_MmaAccumulatorHalf2WordAtPtx8085R2352,
		  r_MmaAccumulatorHalf2WordAtPtx8085R2353); // PTX L8166
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8173R2453, r_MmaAccumulatorHalf2WordAtPtx8173R2458,
		  r_MmaAE4x4WordAtPtx6533R2326, r_MmaAE4x4WordAtPtx6540R2327, r_MmaAE4x4WordAtPtx6547R2328,
		  r_MmaAE4x4WordAtPtx6554R2329, r_MmaBE4x4WordAtPtx7831R2354, r_MmaBE4x4WordAtPtx7838R2355,
		  r_MmaAccumulatorHalf2WordAtPtx8085R2356,
		  r_MmaAccumulatorHalf2WordAtPtx8085R2357); // PTX L8173
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8180R2463, r_MmaAccumulatorHalf2WordAtPtx8180R2468,
		  r_MmaAE4x4WordAtPtx6561R2360, r_MmaAE4x4WordAtPtx6568R2361, r_MmaAE4x4WordAtPtx6575R2362,
		  r_MmaAE4x4WordAtPtx6582R2363, r_MmaBE4x4WordAtPtx7733R2322, r_MmaBE4x4WordAtPtx7740R2323,
		  r_MmaAccumulatorHalf2WordAtPtx8094R2358,
		  r_MmaAccumulatorHalf2WordAtPtx8094R2359); // PTX L8180
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8187R2473, r_MmaAccumulatorHalf2WordAtPtx8187R2478,
		  r_MmaAE4x4WordAtPtx6561R2360, r_MmaAE4x4WordAtPtx6568R2361, r_MmaAE4x4WordAtPtx6575R2362,
		  r_MmaAE4x4WordAtPtx6582R2363, r_MmaBE4x4WordAtPtx7747R2330, r_MmaBE4x4WordAtPtx7754R2331,
		  r_MmaAccumulatorHalf2WordAtPtx8094R2364,
		  r_MmaAccumulatorHalf2WordAtPtx8094R2365); // PTX L8187
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8194R2483, r_MmaAccumulatorHalf2WordAtPtx8194R2488,
		  r_MmaAE4x4WordAtPtx6561R2360, r_MmaAE4x4WordAtPtx6568R2361, r_MmaAE4x4WordAtPtx6575R2362,
		  r_MmaAE4x4WordAtPtx6582R2363, r_MmaBE4x4WordAtPtx7761R2334, r_MmaBE4x4WordAtPtx7768R2335,
		  r_MmaAccumulatorHalf2WordAtPtx8103R2366,
		  r_MmaAccumulatorHalf2WordAtPtx8103R2367); // PTX L8194
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8201R2493, r_MmaAccumulatorHalf2WordAtPtx8201R2498,
		  r_MmaAE4x4WordAtPtx6561R2360, r_MmaAE4x4WordAtPtx6568R2361, r_MmaAE4x4WordAtPtx6575R2362,
		  r_MmaAE4x4WordAtPtx6582R2363, r_MmaBE4x4WordAtPtx7775R2338, r_MmaBE4x4WordAtPtx7782R2339,
		  r_MmaAccumulatorHalf2WordAtPtx8103R2368,
		  r_MmaAccumulatorHalf2WordAtPtx8103R2369); // PTX L8201
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8208R2503, r_MmaAccumulatorHalf2WordAtPtx8208R2508,
		  r_MmaAE4x4WordAtPtx6561R2360, r_MmaAE4x4WordAtPtx6568R2361, r_MmaAE4x4WordAtPtx6575R2362,
		  r_MmaAE4x4WordAtPtx6582R2363, r_MmaBE4x4WordAtPtx7789R2342, r_MmaBE4x4WordAtPtx7796R2343,
		  r_MmaAccumulatorHalf2WordAtPtx8112R2370,
		  r_MmaAccumulatorHalf2WordAtPtx8112R2371); // PTX L8208
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8215R2513, r_MmaAccumulatorHalf2WordAtPtx8215R2518,
		  r_MmaAE4x4WordAtPtx6561R2360, r_MmaAE4x4WordAtPtx6568R2361, r_MmaAE4x4WordAtPtx6575R2362,
		  r_MmaAE4x4WordAtPtx6582R2363, r_MmaBE4x4WordAtPtx7803R2346, r_MmaBE4x4WordAtPtx7810R2347,
		  r_MmaAccumulatorHalf2WordAtPtx8112R2372,
		  r_MmaAccumulatorHalf2WordAtPtx8112R2373); // PTX L8215
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8222R2523, r_MmaAccumulatorHalf2WordAtPtx8222R2528,
		  r_MmaAE4x4WordAtPtx6561R2360, r_MmaAE4x4WordAtPtx6568R2361, r_MmaAE4x4WordAtPtx6575R2362,
		  r_MmaAE4x4WordAtPtx6582R2363, r_MmaBE4x4WordAtPtx7817R2350, r_MmaBE4x4WordAtPtx7824R2351,
		  r_MmaAccumulatorHalf2WordAtPtx8121R2374,
		  r_MmaAccumulatorHalf2WordAtPtx8121R2375); // PTX L8222
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx8229R2533, r_MmaAccumulatorHalf2WordAtPtx8229R2538,
		  r_MmaAE4x4WordAtPtx6561R2360, r_MmaAE4x4WordAtPtx6568R2361, r_MmaAE4x4WordAtPtx6575R2362,
		  r_MmaAE4x4WordAtPtx6582R2363, r_MmaBE4x4WordAtPtx7831R2354, r_MmaBE4x4WordAtPtx7838R2355,
		  r_MmaAccumulatorHalf2WordAtPtx8121R2376,
		  r_MmaAccumulatorHalf2WordAtPtx8121R2377);						   // PTX L8229
	r_LaneIndexAtPtx8236 = uint32_t((threadIdx.x & 31u));				   // PTX L8236
	r_Float32BitsAtPtx8238R2379 = uint32_t(1027077105);					   // PTX L8238
	r_PackedHalf2AtPtx8240R16 = FloatToHalf2(r_Float32BitsAtPtx8238R2379); // PTX L8240
	r_Float32BitsAtPtx8245R2380 = uint32_t(1067877303);					   // PTX L8245
	r_PackedHalf2AtPtx8247R17 = FloatToHalf2(r_Float32BitsAtPtx8245R2380); // PTX L8247
	r_Float32BitsAtPtx8252R2381 = uint32_t(1065615360);					   // PTX L8252
	r_PackedHalf2AtPtx8254R18 = FloatToHalf2(r_Float32BitsAtPtx8252R2381); // PTX L8254
	r_Float32BitsAtPtx8259R2382 = uint32_t(1070129152);					   // PTX L8259
	r_PackedHalf2AtPtx8261R19 = FloatToHalf2(r_Float32BitsAtPtx8259R2382); // PTX L8261
	r_PackedHalf2AtPtx8267R2384 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8124R2383, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8267
	r_PackedHalf2AtPtx8271R2386 =
		HalfMax(r_PackedHalf2AtPtx8267R2384, r_PackedHalf2AtPtx8254R18);				 // PTX L8271
	r_PtxRegister2385 = HalfMin(r_PackedHalf2AtPtx8271R2386, r_PackedHalf2AtPtx8261R19); // PTX L8275
	r_PtxRegister2995 = ShiftLeft(uint32_t(r_PtxRegister2385), uint32_t(5));			 // PTX L8278
	r_PtxRegister2596 = uint32_t(r_PtxRegister2995) + uint32_t(2146992128);				 // PTX L8279
	r_LaneIndexAtPtx8281 = uint32_t((threadIdx.x & 31u));								 // PTX L8281
	r_PackedHalf2AtPtx8284R2389 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8124R2388, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8284
	r_PackedHalf2AtPtx8288R2391 =
		HalfMax(r_PackedHalf2AtPtx8284R2389, r_PackedHalf2AtPtx8254R18);				 // PTX L8288
	r_PtxRegister2390 = HalfMin(r_PackedHalf2AtPtx8288R2391, r_PackedHalf2AtPtx8261R19); // PTX L8292
	r_PtxRegister2996 = ShiftLeft(uint32_t(r_PtxRegister2390), uint32_t(5));			 // PTX L8295
	r_PtxRegister2599 = uint32_t(r_PtxRegister2996) + uint32_t(2146992128);				 // PTX L8296
	r_LaneIndexAtPtx8298 = uint32_t((threadIdx.x & 31u));								 // PTX L8298
	r_PackedHalf2AtPtx8301R2394 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8131R2393, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8301
	r_PackedHalf2AtPtx8305R2396 =
		HalfMax(r_PackedHalf2AtPtx8301R2394, r_PackedHalf2AtPtx8254R18);				 // PTX L8305
	r_PtxRegister2395 = HalfMin(r_PackedHalf2AtPtx8305R2396, r_PackedHalf2AtPtx8261R19); // PTX L8309
	r_PtxRegister2997 = ShiftLeft(uint32_t(r_PtxRegister2395), uint32_t(5));			 // PTX L8312
	r_PtxRegister2602 = uint32_t(r_PtxRegister2997) + uint32_t(2146992128);				 // PTX L8313
	r_LaneIndexAtPtx8315 = uint32_t((threadIdx.x & 31u));								 // PTX L8315
	r_PackedHalf2AtPtx8318R2399 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8131R2398, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8318
	r_PackedHalf2AtPtx8322R2401 =
		HalfMax(r_PackedHalf2AtPtx8318R2399, r_PackedHalf2AtPtx8254R18);				 // PTX L8322
	r_PtxRegister2400 = HalfMin(r_PackedHalf2AtPtx8322R2401, r_PackedHalf2AtPtx8261R19); // PTX L8326
	r_PtxRegister2998 = ShiftLeft(uint32_t(r_PtxRegister2400), uint32_t(5));			 // PTX L8329
	r_PtxRegister2605 = uint32_t(r_PtxRegister2998) + uint32_t(2146992128);				 // PTX L8330
	r_LaneIndexAtPtx8332 = uint32_t((threadIdx.x & 31u));								 // PTX L8332
	r_PackedHalf2AtPtx8335R2404 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8138R2403, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8335
	r_PackedHalf2AtPtx8339R2406 =
		HalfMax(r_PackedHalf2AtPtx8335R2404, r_PackedHalf2AtPtx8254R18);				 // PTX L8339
	r_PtxRegister2405 = HalfMin(r_PackedHalf2AtPtx8339R2406, r_PackedHalf2AtPtx8261R19); // PTX L8343
	r_PtxRegister2999 = ShiftLeft(uint32_t(r_PtxRegister2405), uint32_t(5));			 // PTX L8346
	r_PtxRegister2608 = uint32_t(r_PtxRegister2999) + uint32_t(2146992128);				 // PTX L8347
	r_LaneIndexAtPtx8349 = uint32_t((threadIdx.x & 31u));								 // PTX L8349
	r_PackedHalf2AtPtx8352R2409 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8138R2408, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8352
	r_PackedHalf2AtPtx8356R2411 =
		HalfMax(r_PackedHalf2AtPtx8352R2409, r_PackedHalf2AtPtx8254R18);				 // PTX L8356
	r_PtxRegister2410 = HalfMin(r_PackedHalf2AtPtx8356R2411, r_PackedHalf2AtPtx8261R19); // PTX L8360
	r_PtxRegister3000 = ShiftLeft(uint32_t(r_PtxRegister2410), uint32_t(5));			 // PTX L8363
	r_PtxRegister2611 = uint32_t(r_PtxRegister3000) + uint32_t(2146992128);				 // PTX L8364
	r_LaneIndexAtPtx8366 = uint32_t((threadIdx.x & 31u));								 // PTX L8366
	r_PackedHalf2AtPtx8369R2414 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8145R2413, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8369
	r_PackedHalf2AtPtx8373R2416 =
		HalfMax(r_PackedHalf2AtPtx8369R2414, r_PackedHalf2AtPtx8254R18);				 // PTX L8373
	r_PtxRegister2415 = HalfMin(r_PackedHalf2AtPtx8373R2416, r_PackedHalf2AtPtx8261R19); // PTX L8377
	r_PtxRegister3001 = ShiftLeft(uint32_t(r_PtxRegister2415), uint32_t(5));			 // PTX L8380
	r_PtxRegister2614 = uint32_t(r_PtxRegister3001) + uint32_t(2146992128);				 // PTX L8381
	r_LaneIndexAtPtx8383 = uint32_t((threadIdx.x & 31u));								 // PTX L8383
	r_PackedHalf2AtPtx8386R2419 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8145R2418, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8386
	r_PackedHalf2AtPtx8390R2421 =
		HalfMax(r_PackedHalf2AtPtx8386R2419, r_PackedHalf2AtPtx8254R18);				 // PTX L8390
	r_PtxRegister2420 = HalfMin(r_PackedHalf2AtPtx8390R2421, r_PackedHalf2AtPtx8261R19); // PTX L8394
	r_PtxRegister3002 = ShiftLeft(uint32_t(r_PtxRegister2420), uint32_t(5));			 // PTX L8397
	r_PtxRegister2617 = uint32_t(r_PtxRegister3002) + uint32_t(2146992128);				 // PTX L8398
	r_LaneIndexAtPtx8400 = uint32_t((threadIdx.x & 31u));								 // PTX L8400
	r_PackedHalf2AtPtx8403R2424 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8152R2423, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8403
	r_PackedHalf2AtPtx8407R2426 =
		HalfMax(r_PackedHalf2AtPtx8403R2424, r_PackedHalf2AtPtx8254R18);				 // PTX L8407
	r_PtxRegister2425 = HalfMin(r_PackedHalf2AtPtx8407R2426, r_PackedHalf2AtPtx8261R19); // PTX L8411
	r_PtxRegister3003 = ShiftLeft(uint32_t(r_PtxRegister2425), uint32_t(5));			 // PTX L8414
	r_PtxRegister2620 = uint32_t(r_PtxRegister3003) + uint32_t(2146992128);				 // PTX L8415
	r_LaneIndexAtPtx8417 = uint32_t((threadIdx.x & 31u));								 // PTX L8417
	r_PackedHalf2AtPtx8420R2429 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8152R2428, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8420
	r_PackedHalf2AtPtx8424R2431 =
		HalfMax(r_PackedHalf2AtPtx8420R2429, r_PackedHalf2AtPtx8254R18);				 // PTX L8424
	r_PtxRegister2430 = HalfMin(r_PackedHalf2AtPtx8424R2431, r_PackedHalf2AtPtx8261R19); // PTX L8428
	r_PtxRegister3004 = ShiftLeft(uint32_t(r_PtxRegister2430), uint32_t(5));			 // PTX L8431
	r_PtxRegister2623 = uint32_t(r_PtxRegister3004) + uint32_t(2146992128);				 // PTX L8432
	r_LaneIndexAtPtx8434 = uint32_t((threadIdx.x & 31u));								 // PTX L8434
	r_PackedHalf2AtPtx8437R2434 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8159R2433, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8437
	r_PackedHalf2AtPtx8441R2436 =
		HalfMax(r_PackedHalf2AtPtx8437R2434, r_PackedHalf2AtPtx8254R18);				 // PTX L8441
	r_PtxRegister2435 = HalfMin(r_PackedHalf2AtPtx8441R2436, r_PackedHalf2AtPtx8261R19); // PTX L8445
	r_PtxRegister3005 = ShiftLeft(uint32_t(r_PtxRegister2435), uint32_t(5));			 // PTX L8448
	r_PtxRegister2626 = uint32_t(r_PtxRegister3005) + uint32_t(2146992128);				 // PTX L8449
	r_LaneIndexAtPtx8451 = uint32_t((threadIdx.x & 31u));								 // PTX L8451
	r_PackedHalf2AtPtx8454R2439 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8159R2438, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8454
	r_PackedHalf2AtPtx8458R2441 =
		HalfMax(r_PackedHalf2AtPtx8454R2439, r_PackedHalf2AtPtx8254R18);				 // PTX L8458
	r_PtxRegister2440 = HalfMin(r_PackedHalf2AtPtx8458R2441, r_PackedHalf2AtPtx8261R19); // PTX L8462
	r_PtxRegister3006 = ShiftLeft(uint32_t(r_PtxRegister2440), uint32_t(5));			 // PTX L8465
	r_PtxRegister2629 = uint32_t(r_PtxRegister3006) + uint32_t(2146992128);				 // PTX L8466
	r_LaneIndexAtPtx8468 = uint32_t((threadIdx.x & 31u));								 // PTX L8468
	r_PackedHalf2AtPtx8471R2444 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8166R2443, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8471
	r_PackedHalf2AtPtx8475R2446 =
		HalfMax(r_PackedHalf2AtPtx8471R2444, r_PackedHalf2AtPtx8254R18);				 // PTX L8475
	r_PtxRegister2445 = HalfMin(r_PackedHalf2AtPtx8475R2446, r_PackedHalf2AtPtx8261R19); // PTX L8479
	r_PtxRegister3007 = ShiftLeft(uint32_t(r_PtxRegister2445), uint32_t(5));			 // PTX L8482
	r_PtxRegister2632 = uint32_t(r_PtxRegister3007) + uint32_t(2146992128);				 // PTX L8483
	r_LaneIndexAtPtx8485 = uint32_t((threadIdx.x & 31u));								 // PTX L8485
	r_PackedHalf2AtPtx8488R2449 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8166R2448, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8488
	r_PackedHalf2AtPtx8492R2451 =
		HalfMax(r_PackedHalf2AtPtx8488R2449, r_PackedHalf2AtPtx8254R18);				 // PTX L8492
	r_PtxRegister2450 = HalfMin(r_PackedHalf2AtPtx8492R2451, r_PackedHalf2AtPtx8261R19); // PTX L8496
	r_PtxRegister3008 = ShiftLeft(uint32_t(r_PtxRegister2450), uint32_t(5));			 // PTX L8499
	r_PtxRegister2635 = uint32_t(r_PtxRegister3008) + uint32_t(2146992128);				 // PTX L8500
	r_LaneIndexAtPtx8502 = uint32_t((threadIdx.x & 31u));								 // PTX L8502
	r_PackedHalf2AtPtx8505R2454 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8173R2453, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8505
	r_PackedHalf2AtPtx8509R2456 =
		HalfMax(r_PackedHalf2AtPtx8505R2454, r_PackedHalf2AtPtx8254R18);				 // PTX L8509
	r_PtxRegister2455 = HalfMin(r_PackedHalf2AtPtx8509R2456, r_PackedHalf2AtPtx8261R19); // PTX L8513
	r_PtxRegister3009 = ShiftLeft(uint32_t(r_PtxRegister2455), uint32_t(5));			 // PTX L8516
	r_PtxRegister2638 = uint32_t(r_PtxRegister3009) + uint32_t(2146992128);				 // PTX L8517
	r_LaneIndexAtPtx8519 = uint32_t((threadIdx.x & 31u));								 // PTX L8519
	r_PackedHalf2AtPtx8522R2459 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8173R2458, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8522
	r_PackedHalf2AtPtx8526R2461 =
		HalfMax(r_PackedHalf2AtPtx8522R2459, r_PackedHalf2AtPtx8254R18);				 // PTX L8526
	r_PtxRegister2460 = HalfMin(r_PackedHalf2AtPtx8526R2461, r_PackedHalf2AtPtx8261R19); // PTX L8530
	r_PtxRegister3010 = ShiftLeft(uint32_t(r_PtxRegister2460), uint32_t(5));			 // PTX L8533
	r_PtxRegister2641 = uint32_t(r_PtxRegister3010) + uint32_t(2146992128);				 // PTX L8534
	r_LaneIndexAtPtx8536 = uint32_t((threadIdx.x & 31u));								 // PTX L8536
	r_PackedHalf2AtPtx8539R2464 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8180R2463, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8539
	r_PackedHalf2AtPtx8543R2466 =
		HalfMax(r_PackedHalf2AtPtx8539R2464, r_PackedHalf2AtPtx8254R18);				 // PTX L8543
	r_PtxRegister2465 = HalfMin(r_PackedHalf2AtPtx8543R2466, r_PackedHalf2AtPtx8261R19); // PTX L8547
	r_PtxRegister3011 = ShiftLeft(uint32_t(r_PtxRegister2465), uint32_t(5));			 // PTX L8550
	r_PtxRegister2644 = uint32_t(r_PtxRegister3011) + uint32_t(2146992128);				 // PTX L8551
	r_LaneIndexAtPtx8553 = uint32_t((threadIdx.x & 31u));								 // PTX L8553
	r_PackedHalf2AtPtx8556R2469 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8180R2468, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8556
	r_PackedHalf2AtPtx8560R2471 =
		HalfMax(r_PackedHalf2AtPtx8556R2469, r_PackedHalf2AtPtx8254R18);				 // PTX L8560
	r_PtxRegister2470 = HalfMin(r_PackedHalf2AtPtx8560R2471, r_PackedHalf2AtPtx8261R19); // PTX L8564
	r_PtxRegister3012 = ShiftLeft(uint32_t(r_PtxRegister2470), uint32_t(5));			 // PTX L8567
	r_PtxRegister2647 = uint32_t(r_PtxRegister3012) + uint32_t(2146992128);				 // PTX L8568
	r_LaneIndexAtPtx8570 = uint32_t((threadIdx.x & 31u));								 // PTX L8570
	r_PackedHalf2AtPtx8573R2474 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8187R2473, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8573
	r_PackedHalf2AtPtx8577R2476 =
		HalfMax(r_PackedHalf2AtPtx8573R2474, r_PackedHalf2AtPtx8254R18);				 // PTX L8577
	r_PtxRegister2475 = HalfMin(r_PackedHalf2AtPtx8577R2476, r_PackedHalf2AtPtx8261R19); // PTX L8581
	r_PtxRegister3013 = ShiftLeft(uint32_t(r_PtxRegister2475), uint32_t(5));			 // PTX L8584
	r_PtxRegister2650 = uint32_t(r_PtxRegister3013) + uint32_t(2146992128);				 // PTX L8585
	r_LaneIndexAtPtx8587 = uint32_t((threadIdx.x & 31u));								 // PTX L8587
	r_PackedHalf2AtPtx8590R2479 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8187R2478, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8590
	r_PackedHalf2AtPtx8594R2481 =
		HalfMax(r_PackedHalf2AtPtx8590R2479, r_PackedHalf2AtPtx8254R18);				 // PTX L8594
	r_PtxRegister2480 = HalfMin(r_PackedHalf2AtPtx8594R2481, r_PackedHalf2AtPtx8261R19); // PTX L8598
	r_PtxRegister3014 = ShiftLeft(uint32_t(r_PtxRegister2480), uint32_t(5));			 // PTX L8601
	r_PtxRegister2653 = uint32_t(r_PtxRegister3014) + uint32_t(2146992128);				 // PTX L8602
	r_LaneIndexAtPtx8604 = uint32_t((threadIdx.x & 31u));								 // PTX L8604
	r_PackedHalf2AtPtx8607R2484 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8194R2483, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8607
	r_PackedHalf2AtPtx8611R2486 =
		HalfMax(r_PackedHalf2AtPtx8607R2484, r_PackedHalf2AtPtx8254R18);				 // PTX L8611
	r_PtxRegister2485 = HalfMin(r_PackedHalf2AtPtx8611R2486, r_PackedHalf2AtPtx8261R19); // PTX L8615
	r_PtxRegister3015 = ShiftLeft(uint32_t(r_PtxRegister2485), uint32_t(5));			 // PTX L8618
	r_PtxRegister2656 = uint32_t(r_PtxRegister3015) + uint32_t(2146992128);				 // PTX L8619
	r_LaneIndexAtPtx8621 = uint32_t((threadIdx.x & 31u));								 // PTX L8621
	r_PackedHalf2AtPtx8624R2489 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8194R2488, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8624
	r_PackedHalf2AtPtx8628R2491 =
		HalfMax(r_PackedHalf2AtPtx8624R2489, r_PackedHalf2AtPtx8254R18);				 // PTX L8628
	r_PtxRegister2490 = HalfMin(r_PackedHalf2AtPtx8628R2491, r_PackedHalf2AtPtx8261R19); // PTX L8632
	r_PtxRegister3016 = ShiftLeft(uint32_t(r_PtxRegister2490), uint32_t(5));			 // PTX L8635
	r_PtxRegister2659 = uint32_t(r_PtxRegister3016) + uint32_t(2146992128);				 // PTX L8636
	r_LaneIndexAtPtx8638 = uint32_t((threadIdx.x & 31u));								 // PTX L8638
	r_PackedHalf2AtPtx8641R2494 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8201R2493, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8641
	r_PackedHalf2AtPtx8645R2496 =
		HalfMax(r_PackedHalf2AtPtx8641R2494, r_PackedHalf2AtPtx8254R18);				 // PTX L8645
	r_PtxRegister2495 = HalfMin(r_PackedHalf2AtPtx8645R2496, r_PackedHalf2AtPtx8261R19); // PTX L8649
	r_PtxRegister3017 = ShiftLeft(uint32_t(r_PtxRegister2495), uint32_t(5));			 // PTX L8652
	r_PtxRegister2662 = uint32_t(r_PtxRegister3017) + uint32_t(2146992128);				 // PTX L8653
	r_LaneIndexAtPtx8655 = uint32_t((threadIdx.x & 31u));								 // PTX L8655
	r_PackedHalf2AtPtx8658R2499 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8201R2498, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8658
	r_PackedHalf2AtPtx8662R2501 =
		HalfMax(r_PackedHalf2AtPtx8658R2499, r_PackedHalf2AtPtx8254R18);				 // PTX L8662
	r_PtxRegister2500 = HalfMin(r_PackedHalf2AtPtx8662R2501, r_PackedHalf2AtPtx8261R19); // PTX L8666
	r_PtxRegister3018 = ShiftLeft(uint32_t(r_PtxRegister2500), uint32_t(5));			 // PTX L8669
	r_PtxRegister2665 = uint32_t(r_PtxRegister3018) + uint32_t(2146992128);				 // PTX L8670
	r_LaneIndexAtPtx8672 = uint32_t((threadIdx.x & 31u));								 // PTX L8672
	r_PackedHalf2AtPtx8675R2504 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8208R2503, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8675
	r_PackedHalf2AtPtx8679R2506 =
		HalfMax(r_PackedHalf2AtPtx8675R2504, r_PackedHalf2AtPtx8254R18);				 // PTX L8679
	r_PtxRegister2505 = HalfMin(r_PackedHalf2AtPtx8679R2506, r_PackedHalf2AtPtx8261R19); // PTX L8683
	r_PtxRegister3019 = ShiftLeft(uint32_t(r_PtxRegister2505), uint32_t(5));			 // PTX L8686
	r_PtxRegister2668 = uint32_t(r_PtxRegister3019) + uint32_t(2146992128);				 // PTX L8687
	r_LaneIndexAtPtx8689 = uint32_t((threadIdx.x & 31u));								 // PTX L8689
	r_PackedHalf2AtPtx8692R2509 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8208R2508, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8692
	r_PackedHalf2AtPtx8696R2511 =
		HalfMax(r_PackedHalf2AtPtx8692R2509, r_PackedHalf2AtPtx8254R18);				 // PTX L8696
	r_PtxRegister2510 = HalfMin(r_PackedHalf2AtPtx8696R2511, r_PackedHalf2AtPtx8261R19); // PTX L8700
	r_PtxRegister3020 = ShiftLeft(uint32_t(r_PtxRegister2510), uint32_t(5));			 // PTX L8703
	r_PtxRegister2671 = uint32_t(r_PtxRegister3020) + uint32_t(2146992128);				 // PTX L8704
	r_LaneIndexAtPtx8706 = uint32_t((threadIdx.x & 31u));								 // PTX L8706
	r_PackedHalf2AtPtx8709R2514 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8215R2513, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8709
	r_PackedHalf2AtPtx8713R2516 =
		HalfMax(r_PackedHalf2AtPtx8709R2514, r_PackedHalf2AtPtx8254R18);				 // PTX L8713
	r_PtxRegister2515 = HalfMin(r_PackedHalf2AtPtx8713R2516, r_PackedHalf2AtPtx8261R19); // PTX L8717
	r_PtxRegister3021 = ShiftLeft(uint32_t(r_PtxRegister2515), uint32_t(5));			 // PTX L8720
	r_PtxRegister2674 = uint32_t(r_PtxRegister3021) + uint32_t(2146992128);				 // PTX L8721
	r_LaneIndexAtPtx8723 = uint32_t((threadIdx.x & 31u));								 // PTX L8723
	r_PackedHalf2AtPtx8726R2519 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8215R2518, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8726
	r_PackedHalf2AtPtx8730R2521 =
		HalfMax(r_PackedHalf2AtPtx8726R2519, r_PackedHalf2AtPtx8254R18);				 // PTX L8730
	r_PtxRegister2520 = HalfMin(r_PackedHalf2AtPtx8730R2521, r_PackedHalf2AtPtx8261R19); // PTX L8734
	r_PtxRegister3022 = ShiftLeft(uint32_t(r_PtxRegister2520), uint32_t(5));			 // PTX L8737
	r_PtxRegister2677 = uint32_t(r_PtxRegister3022) + uint32_t(2146992128);				 // PTX L8738
	r_LaneIndexAtPtx8740 = uint32_t((threadIdx.x & 31u));								 // PTX L8740
	r_PackedHalf2AtPtx8743R2524 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8222R2523, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8743
	r_PackedHalf2AtPtx8747R2526 =
		HalfMax(r_PackedHalf2AtPtx8743R2524, r_PackedHalf2AtPtx8254R18);				 // PTX L8747
	r_PtxRegister2525 = HalfMin(r_PackedHalf2AtPtx8747R2526, r_PackedHalf2AtPtx8261R19); // PTX L8751
	r_PtxRegister3023 = ShiftLeft(uint32_t(r_PtxRegister2525), uint32_t(5));			 // PTX L8754
	r_PtxRegister2680 = uint32_t(r_PtxRegister3023) + uint32_t(2146992128);				 // PTX L8755
	r_LaneIndexAtPtx8757 = uint32_t((threadIdx.x & 31u));								 // PTX L8757
	r_PackedHalf2AtPtx8760R2529 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8222R2528, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8760
	r_PackedHalf2AtPtx8764R2531 =
		HalfMax(r_PackedHalf2AtPtx8760R2529, r_PackedHalf2AtPtx8254R18);				 // PTX L8764
	r_PtxRegister2530 = HalfMin(r_PackedHalf2AtPtx8764R2531, r_PackedHalf2AtPtx8261R19); // PTX L8768
	r_PtxRegister3024 = ShiftLeft(uint32_t(r_PtxRegister2530), uint32_t(5));			 // PTX L8771
	r_PtxRegister2683 = uint32_t(r_PtxRegister3024) + uint32_t(2146992128);				 // PTX L8772
	r_LaneIndexAtPtx8774 = uint32_t((threadIdx.x & 31u));								 // PTX L8774
	r_PackedHalf2AtPtx8777R2534 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8229R2533, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8777
	r_PackedHalf2AtPtx8781R2536 =
		HalfMax(r_PackedHalf2AtPtx8777R2534, r_PackedHalf2AtPtx8254R18);				 // PTX L8781
	r_PtxRegister2535 = HalfMin(r_PackedHalf2AtPtx8781R2536, r_PackedHalf2AtPtx8261R19); // PTX L8785
	r_PtxRegister3025 = ShiftLeft(uint32_t(r_PtxRegister2535), uint32_t(5));			 // PTX L8788
	r_PtxRegister2686 = uint32_t(r_PtxRegister3025) + uint32_t(2146992128);				 // PTX L8789
	r_LaneIndexAtPtx8791 = uint32_t((threadIdx.x & 31u));								 // PTX L8791
	r_PackedHalf2AtPtx8794R2539 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx8229R2538, r_PackedHalf2AtPtx8240R16,
										  r_PackedHalf2AtPtx8247R17); // PTX L8794
	r_PackedHalf2AtPtx8798R2541 =
		HalfMax(r_PackedHalf2AtPtx8794R2539, r_PackedHalf2AtPtx8254R18);				 // PTX L8798
	r_PtxRegister2540 = HalfMin(r_PackedHalf2AtPtx8798R2541, r_PackedHalf2AtPtx8261R19); // PTX L8802
	r_PtxRegister3026 = ShiftLeft(uint32_t(r_PtxRegister2540), uint32_t(5));			 // PTX L8805
	r_PtxRegister2689 = uint32_t(r_PtxRegister3026) + uint32_t(2146992128);				 // PTX L8806
	r_LaneIndexAtPtx8808 = uint32_t((threadIdx.x & 31u));								 // PTX L8808
	r_PackedHalf2AtPtx8811R2543 = HalfAdd(r_PtxRegister2596, r_PtxRegister2602);		 // PTX L8811
	r_PackedHalf2AtPtx8815R2544 = HalfAdd(r_PtxRegister2608, r_PtxRegister2614);		 // PTX L8815
	r_PackedHalf2AtPtx8819R2545 =
		HalfAdd(r_PackedHalf2AtPtx8811R2543, r_PackedHalf2AtPtx8815R2544);		 // PTX L8819
	r_PackedHalf2AtPtx8823R2546 = HalfAdd(r_PtxRegister2620, r_PtxRegister2626); // PTX L8823
	r_PackedHalf2AtPtx8827R2548 =
		HalfAdd(r_PackedHalf2AtPtx8819R2545, r_PackedHalf2AtPtx8823R2546);				   // PTX L8827
	r_PackedHalf2AtPtx8831R2549 = HalfAdd(r_PtxRegister2632, r_PtxRegister2638);		   // PTX L8831
	r_PtxRegister2547 = HalfAdd(r_PackedHalf2AtPtx8827R2548, r_PackedHalf2AtPtx8831R2549); // PTX L8835
	r_PackedHalf2AtPtx8839R2550 = HalfAdd(r_PtxRegister2599, r_PtxRegister2605);		   // PTX L8839
	r_PackedHalf2AtPtx8843R2551 = HalfAdd(r_PtxRegister2611, r_PtxRegister2617);		   // PTX L8843
	r_PackedHalf2AtPtx8847R2552 =
		HalfAdd(r_PackedHalf2AtPtx8839R2550, r_PackedHalf2AtPtx8843R2551);		 // PTX L8847
	r_PackedHalf2AtPtx8851R2553 = HalfAdd(r_PtxRegister2623, r_PtxRegister2629); // PTX L8851
	r_PackedHalf2AtPtx8855R2555 =
		HalfAdd(r_PackedHalf2AtPtx8847R2552, r_PackedHalf2AtPtx8851R2553);				   // PTX L8855
	r_PackedHalf2AtPtx8859R2556 = HalfAdd(r_PtxRegister2635, r_PtxRegister2641);		   // PTX L8859
	r_PtxRegister2554 = HalfAdd(r_PackedHalf2AtPtx8855R2555, r_PackedHalf2AtPtx8859R2556); // PTX L8863
	r_PackedHalf2AtPtx8867R2557 = HalfAdd(r_PtxRegister2644, r_PtxRegister2650);		   // PTX L8867
	r_PackedHalf2AtPtx8871R2558 = HalfAdd(r_PtxRegister2656, r_PtxRegister2662);		   // PTX L8871
	r_PackedHalf2AtPtx8875R2559 =
		HalfAdd(r_PackedHalf2AtPtx8867R2557, r_PackedHalf2AtPtx8871R2558);		 // PTX L8875
	r_PackedHalf2AtPtx8879R2560 = HalfAdd(r_PtxRegister2668, r_PtxRegister2674); // PTX L8879
	r_PackedHalf2AtPtx8883R2562 =
		HalfAdd(r_PackedHalf2AtPtx8875R2559, r_PackedHalf2AtPtx8879R2560);				   // PTX L8883
	r_PackedHalf2AtPtx8887R2563 = HalfAdd(r_PtxRegister2680, r_PtxRegister2686);		   // PTX L8887
	r_PtxRegister2561 = HalfAdd(r_PackedHalf2AtPtx8883R2562, r_PackedHalf2AtPtx8887R2563); // PTX L8891
	r_PackedHalf2AtPtx8895R2564 = HalfAdd(r_PtxRegister2647, r_PtxRegister2653);		   // PTX L8895
	r_PackedHalf2AtPtx8899R2565 = HalfAdd(r_PtxRegister2659, r_PtxRegister2665);		   // PTX L8899
	r_PackedHalf2AtPtx8903R2566 =
		HalfAdd(r_PackedHalf2AtPtx8895R2564, r_PackedHalf2AtPtx8899R2565);		 // PTX L8903
	r_PackedHalf2AtPtx8907R2567 = HalfAdd(r_PtxRegister2671, r_PtxRegister2677); // PTX L8907
	r_PackedHalf2AtPtx8911R2569 =
		HalfAdd(r_PackedHalf2AtPtx8903R2566, r_PackedHalf2AtPtx8907R2567);				   // PTX L8911
	r_PackedHalf2AtPtx8915R2570 = HalfAdd(r_PtxRegister2683, r_PtxRegister2689);		   // PTX L8915
	r_PtxRegister2568 = HalfAdd(r_PackedHalf2AtPtx8911R2569, r_PackedHalf2AtPtx8915R2570); // PTX L8919
	r_PtxU16Register402 = uint16_t(r_LaneIndexAtPtx8808);								   // PTX L8922
	r_PtxRegister3027 = r_LaneIndexAtPtx8808 & 1;										   // PTX L8923
	r_bPtxPredicate39 = uint32_t(r_PtxRegister3027) != uint32_t(0);						   // PTX L8924
	r_PtxRegister3028 = r_bPtxPredicate39 ? r_PtxRegister2554 : r_PtxRegister2547;		   // PTX L8925
	r_PtxRegister3029 = r_bPtxPredicate39 ? r_PtxRegister2547 : r_PtxRegister2554;		   // PTX L8926
	r_PtxRegister3030 = r_bPtxPredicate39 ? r_PtxRegister2568 : r_PtxRegister2561;		   // PTX L8927
	r_PtxRegister3031 = r_bPtxPredicate39 ? r_PtxRegister2561 : r_PtxRegister2568;		   // PTX L8928
	r_PtxU16Register403 = r_PtxU16Register402 & 2;										   // PTX L8929
	r_bPtxPredicate40 = uint16_t(r_PtxU16Register403) == uint16_t(0);					   // PTX L8930
	r_PtxRegister3032 = r_bPtxPredicate40 ? r_PtxRegister3028 : r_PtxRegister3030;		   // PTX L8931
	r_PtxRegister3033 = r_bPtxPredicate40 ? r_PtxRegister3030 : r_PtxRegister3028;		   // PTX L8932
	r_PtxRegister3034 = r_bPtxPredicate40 ? r_PtxRegister3029 : r_PtxRegister3031;		   // PTX L8933
	r_PtxRegister3035 = r_bPtxPredicate40 ? r_PtxRegister3031 : r_PtxRegister3029;		   // PTX L8934
	r_PtxRegister3036 = ShiftLeft(uint32_t(r_LaneIndexAtPtx8808), uint32_t(2));			   // PTX L8935
	r_PtxRegister3037 = r_PtxRegister3036 & 28;											   // PTX L8936
	r_PtxRegister3038 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx8808), uint32_t(3));	   // PTX L8937
	r_PtxRegister3039 = uint32_t(r_PtxRegister3037) + uint32_t(r_PtxRegister3038);		   // PTX L8938
	r_PtxRegister3040 =
		ShuffleIdxPredicate(r_bPtxPredicate41, r_PtxRegister3032, r_PtxRegister3039, 31, -1); // PTX L8939
	r_PtxRegister3041 = r_PtxRegister3039 ^ 1;												  // PTX L8940
	r_PtxRegister3042 =
		ShuffleIdxPredicate(r_bPtxPredicate42, r_PtxRegister3034, r_PtxRegister3041, 31, -1); // PTX L8941
	r_PtxRegister3043 = r_PtxRegister3039 ^ 2;												  // PTX L8942
	r_PtxRegister3044 =
		ShuffleIdxPredicate(r_bPtxPredicate43, r_PtxRegister3033, r_PtxRegister3043, 31, -1); // PTX L8943
	r_PtxRegister3045 = r_PtxRegister3039 ^ 3;												  // PTX L8944
	r_PtxRegister3046 =
		ShuffleIdxPredicate(r_bPtxPredicate44, r_PtxRegister3035, r_PtxRegister3045, 31, -1); // PTX L8945
	r_PtxU16Register404 = r_PtxU16Register402 & 8;											  // PTX L8946
	r_bPtxPredicate45 = uint16_t(r_PtxU16Register404) == uint16_t(0);						  // PTX L8947
	r_PtxRegister3047 = r_bPtxPredicate45 ? r_PtxRegister3040 : r_PtxRegister3042;			  // PTX L8948
	r_PtxRegister3048 = r_bPtxPredicate45 ? r_PtxRegister3042 : r_PtxRegister3040;			  // PTX L8949
	r_PtxRegister3049 = r_bPtxPredicate45 ? r_PtxRegister3044 : r_PtxRegister3046;			  // PTX L8950
	r_PtxRegister3050 = r_bPtxPredicate45 ? r_PtxRegister3046 : r_PtxRegister3044;			  // PTX L8951
	r_PtxU16Register405 = r_PtxU16Register402 & 16;											  // PTX L8952
	r_bPtxPredicate46 = uint16_t(r_PtxU16Register405) == uint16_t(0);						  // PTX L8953
	r_PtxRegister2571 = r_bPtxPredicate46 ? r_PtxRegister3047 : r_PtxRegister3049;			  // PTX L8954
	r_PtxRegister2574 = r_bPtxPredicate46 ? r_PtxRegister3049 : r_PtxRegister3047;			  // PTX L8955
	r_PtxRegister2572 = r_bPtxPredicate46 ? r_PtxRegister3048 : r_PtxRegister3050;			  // PTX L8956
	r_PtxRegister2577 = r_bPtxPredicate46 ? r_PtxRegister3050 : r_PtxRegister3048;			  // PTX L8957
	r_PackedHalf2AtPtx8959R2573 = HalfAdd(r_PtxRegister2571, r_PtxRegister2572);			  // PTX L8959
	r_PackedHalf2AtPtx8963R2576 = HalfAdd(r_PackedHalf2AtPtx8959R2573, r_PtxRegister2574);	  // PTX L8963
	r_PtxRegister2575 = HalfAdd(r_PackedHalf2AtPtx8963R2576, r_PtxRegister2577);			  // PTX L8967
	r_PtxU16Register406 = uint16_t(r_PtxRegister2575);
	r_PtxU16Register407 = uint16_t(r_PtxRegister2575 >> 16);									 // PTX L8970
	r_PackedHalf2AtPtx8971R2579 = JoinHalfwords(r_PtxU16Register406, r_PtxU16Register406);		 // PTX L8971
	r_PackedHalf2AtPtx8972R2580 = JoinHalfwords(r_PtxU16Register407, r_PtxU16Register407);		 // PTX L8972
	r_PtxRegister2578 = HalfAdd(r_PackedHalf2AtPtx8971R2579, r_PackedHalf2AtPtx8972R2580);		 // PTX L8974
	r_PtxRegister2582 = __byte_perm(r_PtxRegister2578, r_PtxRegister2578, 0x5410U);				 // PTX L8977
	r_PtxU16Register289 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1702))); // PTX L8979
	r_PackedHalf2AtPtx8982R2583 = JoinHalfwords(r_PtxU16Register289, r_PtxU16Register289);		 // PTX L8982
	r_LaneIndexAtPtx8984 = uint32_t((threadIdx.x & 31u));										 // PTX L8984
	r_PackedHalf2AtPtx8987R2586 = HalfMax(r_PtxRegister2582, r_PackedHalf2AtPtx8982R2583);		 // PTX L8987
	r_LaneIndexAtPtx8991 = uint32_t((threadIdx.x & 31u));										 // PTX L8991
	r_PtxRegister2585 = RcpHalf2(r_PackedHalf2AtPtx8987R2586);									 // PTX L8994
	r_LaneIndexAtPtx9007 = uint32_t((threadIdx.x & 31u));										 // PTX L9007
	r_PtxRegister3051 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9007), uint32_t(31));			 // PTX L9009
	r_PtxRegister3052 = ShiftRight(uint32_t(r_PtxRegister3051), uint32_t(30));					 // PTX L9010
	r_PtxRegister3053 = uint32_t(r_LaneIndexAtPtx9007) + uint32_t(r_PtxRegister3052);			 // PTX L9011
	r_PtxRegister3054 = ShiftRightSigned(int32_t(r_PtxRegister3053), uint32_t(2));				 // PTX L9012
	r_PtxRegister3055 = ShiftRightSigned(int32_t(r_PtxRegister3053), uint32_t(31));				 // PTX L9013
	r_PtxRegister3056 = ShiftRight(uint32_t(r_PtxRegister3055), uint32_t(27));					 // PTX L9014
	r_PtxRegister3057 = uint32_t(r_PtxRegister3054) + uint32_t(r_PtxRegister3056);				 // PTX L9015
	r_PtxRegister3058 = r_PtxRegister3057 & -32;												 // PTX L9016
	r_PtxRegister3059 = uint32_t(r_PtxRegister3054) - uint32_t(r_PtxRegister3058);				 // PTX L9017
	r_PtxRegister3060 =
		ShuffleIdxPredicate(r_bPtxPredicate47, r_PtxRegister2585, r_PtxRegister3059, 31, -1); // PTX L9018
	r_PtxRegister2597 = __byte_perm(r_PtxRegister3060, r_PtxRegister3060, 0x5410U);			  // PTX L9019
	r_PtxRegister3061 = uint32_t(r_PtxRegister3054) + uint32_t(8);							  // PTX L9020
	r_PtxRegister3062 = ShiftRightSigned(int32_t(r_PtxRegister3061), uint32_t(31));			  // PTX L9021
	r_PtxRegister3063 = ShiftRight(uint32_t(r_PtxRegister3062), uint32_t(27));				  // PTX L9022
	r_PtxRegister3064 = uint32_t(r_PtxRegister3061) + uint32_t(r_PtxRegister3063);			  // PTX L9023
	r_PtxRegister3065 = r_PtxRegister3064 & -32;											  // PTX L9024
	r_PtxRegister3066 = uint32_t(r_PtxRegister3061) - uint32_t(r_PtxRegister3065);			  // PTX L9025
	r_PtxRegister3067 =
		ShuffleIdxPredicate(r_bPtxPredicate48, r_PtxRegister2585, r_PtxRegister3066, 31, -1); // PTX L9026
	r_PtxRegister2600 = __byte_perm(r_PtxRegister3067, r_PtxRegister3067, 0x5410U);			  // PTX L9027
	r_PtxRegister3068 =
		ShuffleIdxPredicate(r_bPtxPredicate49, r_PtxRegister2585, r_PtxRegister3059, 31, -1); // PTX L9028
	r_PtxRegister2603 = __byte_perm(r_PtxRegister3068, r_PtxRegister3068, 0x5410U);			  // PTX L9029
	r_PtxRegister3069 =
		ShuffleIdxPredicate(r_bPtxPredicate50, r_PtxRegister2585, r_PtxRegister3066, 31, -1); // PTX L9030
	r_PtxRegister2606 = __byte_perm(r_PtxRegister3069, r_PtxRegister3069, 0x5410U);			  // PTX L9031
	r_LaneIndexAtPtx9033 = uint32_t((threadIdx.x & 31u));									  // PTX L9033
	r_PtxRegister3070 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9033), uint32_t(31));		  // PTX L9035
	r_PtxRegister3071 = ShiftRight(uint32_t(r_PtxRegister3070), uint32_t(30));				  // PTX L9036
	r_PtxRegister3072 = uint32_t(r_LaneIndexAtPtx9033) + uint32_t(r_PtxRegister3071);		  // PTX L9037
	r_PtxRegister3073 = ShiftRightSigned(int32_t(r_PtxRegister3072), uint32_t(2));			  // PTX L9038
	r_PtxRegister3074 = ShiftRightSigned(int32_t(r_PtxRegister3072), uint32_t(31));			  // PTX L9039
	r_PtxRegister3075 = ShiftRight(uint32_t(r_PtxRegister3074), uint32_t(27));				  // PTX L9040
	r_PtxRegister3076 = uint32_t(r_PtxRegister3073) + uint32_t(r_PtxRegister3075);			  // PTX L9041
	r_PtxRegister3077 = r_PtxRegister3076 & -32;											  // PTX L9042
	r_PtxRegister3078 = uint32_t(r_PtxRegister3073) - uint32_t(r_PtxRegister3077);			  // PTX L9043
	r_PtxRegister3079 =
		ShuffleIdxPredicate(r_bPtxPredicate51, r_PtxRegister2585, r_PtxRegister3078, 31, -1); // PTX L9044
	r_PtxRegister2609 = __byte_perm(r_PtxRegister3079, r_PtxRegister3079, 0x5410U);			  // PTX L9045
	r_PtxRegister3080 = uint32_t(r_PtxRegister3073) + uint32_t(8);							  // PTX L9046
	r_PtxRegister3081 = ShiftRightSigned(int32_t(r_PtxRegister3080), uint32_t(31));			  // PTX L9047
	r_PtxRegister3082 = ShiftRight(uint32_t(r_PtxRegister3081), uint32_t(27));				  // PTX L9048
	r_PtxRegister3083 = uint32_t(r_PtxRegister3080) + uint32_t(r_PtxRegister3082);			  // PTX L9049
	r_PtxRegister3084 = r_PtxRegister3083 & -32;											  // PTX L9050
	r_PtxRegister3085 = uint32_t(r_PtxRegister3080) - uint32_t(r_PtxRegister3084);			  // PTX L9051
	r_PtxRegister3086 =
		ShuffleIdxPredicate(r_bPtxPredicate52, r_PtxRegister2585, r_PtxRegister3085, 31, -1); // PTX L9052
	r_PtxRegister2612 = __byte_perm(r_PtxRegister3086, r_PtxRegister3086, 0x5410U);			  // PTX L9053
	r_PtxRegister3087 =
		ShuffleIdxPredicate(r_bPtxPredicate53, r_PtxRegister2585, r_PtxRegister3078, 31, -1); // PTX L9054
	r_PtxRegister2615 = __byte_perm(r_PtxRegister3087, r_PtxRegister3087, 0x5410U);			  // PTX L9055
	r_PtxRegister3088 =
		ShuffleIdxPredicate(r_bPtxPredicate54, r_PtxRegister2585, r_PtxRegister3085, 31, -1); // PTX L9056
	r_PtxRegister2618 = __byte_perm(r_PtxRegister3088, r_PtxRegister3088, 0x5410U);			  // PTX L9057
	r_LaneIndexAtPtx9059 = uint32_t((threadIdx.x & 31u));									  // PTX L9059
	r_PtxRegister3089 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9059), uint32_t(31));		  // PTX L9061
	r_PtxRegister3090 = ShiftRight(uint32_t(r_PtxRegister3089), uint32_t(30));				  // PTX L9062
	r_PtxRegister3091 = uint32_t(r_LaneIndexAtPtx9059) + uint32_t(r_PtxRegister3090);		  // PTX L9063
	r_PtxRegister3092 = ShiftRightSigned(int32_t(r_PtxRegister3091), uint32_t(2));			  // PTX L9064
	r_PtxRegister3093 = ShiftRightSigned(int32_t(r_PtxRegister3091), uint32_t(31));			  // PTX L9065
	r_PtxRegister3094 = ShiftRight(uint32_t(r_PtxRegister3093), uint32_t(27));				  // PTX L9066
	r_PtxRegister3095 = uint32_t(r_PtxRegister3092) + uint32_t(r_PtxRegister3094);			  // PTX L9067
	r_PtxRegister3096 = r_PtxRegister3095 & -32;											  // PTX L9068
	r_PtxRegister3097 = uint32_t(r_PtxRegister3092) - uint32_t(r_PtxRegister3096);			  // PTX L9069
	r_PtxRegister3098 =
		ShuffleIdxPredicate(r_bPtxPredicate55, r_PtxRegister2585, r_PtxRegister3097, 31, -1); // PTX L9070
	r_PtxRegister2621 = __byte_perm(r_PtxRegister3098, r_PtxRegister3098, 0x5410U);			  // PTX L9071
	r_PtxRegister3099 = uint32_t(r_PtxRegister3092) + uint32_t(8);							  // PTX L9072
	r_PtxRegister3100 = ShiftRightSigned(int32_t(r_PtxRegister3099), uint32_t(31));			  // PTX L9073
	r_PtxRegister3101 = ShiftRight(uint32_t(r_PtxRegister3100), uint32_t(27));				  // PTX L9074
	r_PtxRegister3102 = uint32_t(r_PtxRegister3099) + uint32_t(r_PtxRegister3101);			  // PTX L9075
	r_PtxRegister3103 = r_PtxRegister3102 & -32;											  // PTX L9076
	r_PtxRegister3104 = uint32_t(r_PtxRegister3099) - uint32_t(r_PtxRegister3103);			  // PTX L9077
	r_PtxRegister3105 =
		ShuffleIdxPredicate(r_bPtxPredicate56, r_PtxRegister2585, r_PtxRegister3104, 31, -1); // PTX L9078
	r_PtxRegister2624 = __byte_perm(r_PtxRegister3105, r_PtxRegister3105, 0x5410U);			  // PTX L9079
	r_PtxRegister3106 =
		ShuffleIdxPredicate(r_bPtxPredicate57, r_PtxRegister2585, r_PtxRegister3097, 31, -1); // PTX L9080
	r_PtxRegister2627 = __byte_perm(r_PtxRegister3106, r_PtxRegister3106, 0x5410U);			  // PTX L9081
	r_PtxRegister3107 =
		ShuffleIdxPredicate(r_bPtxPredicate58, r_PtxRegister2585, r_PtxRegister3104, 31, -1); // PTX L9082
	r_PtxRegister2630 = __byte_perm(r_PtxRegister3107, r_PtxRegister3107, 0x5410U);			  // PTX L9083
	r_LaneIndexAtPtx9085 = uint32_t((threadIdx.x & 31u));									  // PTX L9085
	r_PtxRegister3108 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9085), uint32_t(31));		  // PTX L9087
	r_PtxRegister3109 = ShiftRight(uint32_t(r_PtxRegister3108), uint32_t(30));				  // PTX L9088
	r_PtxRegister3110 = uint32_t(r_LaneIndexAtPtx9085) + uint32_t(r_PtxRegister3109);		  // PTX L9089
	r_PtxRegister3111 = ShiftRightSigned(int32_t(r_PtxRegister3110), uint32_t(2));			  // PTX L9090
	r_PtxRegister3112 = ShiftRightSigned(int32_t(r_PtxRegister3110), uint32_t(31));			  // PTX L9091
	r_PtxRegister3113 = ShiftRight(uint32_t(r_PtxRegister3112), uint32_t(27));				  // PTX L9092
	r_PtxRegister3114 = uint32_t(r_PtxRegister3111) + uint32_t(r_PtxRegister3113);			  // PTX L9093
	r_PtxRegister3115 = r_PtxRegister3114 & -32;											  // PTX L9094
	r_PtxRegister3116 = uint32_t(r_PtxRegister3111) - uint32_t(r_PtxRegister3115);			  // PTX L9095
	r_PtxRegister3117 =
		ShuffleIdxPredicate(r_bPtxPredicate59, r_PtxRegister2585, r_PtxRegister3116, 31, -1); // PTX L9096
	r_PtxRegister2633 = __byte_perm(r_PtxRegister3117, r_PtxRegister3117, 0x5410U);			  // PTX L9097
	r_PtxRegister3118 = uint32_t(r_PtxRegister3111) + uint32_t(8);							  // PTX L9098
	r_PtxRegister3119 = ShiftRightSigned(int32_t(r_PtxRegister3118), uint32_t(31));			  // PTX L9099
	r_PtxRegister3120 = ShiftRight(uint32_t(r_PtxRegister3119), uint32_t(27));				  // PTX L9100
	r_PtxRegister3121 = uint32_t(r_PtxRegister3118) + uint32_t(r_PtxRegister3120);			  // PTX L9101
	r_PtxRegister3122 = r_PtxRegister3121 & -32;											  // PTX L9102
	r_PtxRegister3123 = uint32_t(r_PtxRegister3118) - uint32_t(r_PtxRegister3122);			  // PTX L9103
	r_PtxRegister3124 =
		ShuffleIdxPredicate(r_bPtxPredicate60, r_PtxRegister2585, r_PtxRegister3123, 31, -1); // PTX L9104
	r_PtxRegister2636 = __byte_perm(r_PtxRegister3124, r_PtxRegister3124, 0x5410U);			  // PTX L9105
	r_PtxRegister3125 =
		ShuffleIdxPredicate(r_bPtxPredicate61, r_PtxRegister2585, r_PtxRegister3116, 31, -1); // PTX L9106
	r_PtxRegister2639 = __byte_perm(r_PtxRegister3125, r_PtxRegister3125, 0x5410U);			  // PTX L9107
	r_PtxRegister3126 =
		ShuffleIdxPredicate(r_bPtxPredicate62, r_PtxRegister2585, r_PtxRegister3123, 31, -1); // PTX L9108
	r_PtxRegister2642 = __byte_perm(r_PtxRegister3126, r_PtxRegister3126, 0x5410U);			  // PTX L9109
	r_LaneIndexAtPtx9111 = uint32_t((threadIdx.x & 31u));									  // PTX L9111
	r_PtxRegister3127 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9111), uint32_t(31));		  // PTX L9113
	r_PtxRegister3128 = ShiftRight(uint32_t(r_PtxRegister3127), uint32_t(30));				  // PTX L9114
	r_PtxRegister3129 = uint32_t(r_LaneIndexAtPtx9111) + uint32_t(r_PtxRegister3128);		  // PTX L9115
	r_PtxRegister3130 = ShiftRightSigned(int32_t(r_PtxRegister3129), uint32_t(2));			  // PTX L9116
	r_PtxRegister3131 = uint32_t(r_PtxRegister3130) + uint32_t(16);							  // PTX L9117
	r_PtxRegister3132 = ShiftRightSigned(int32_t(r_PtxRegister3131), uint32_t(31));			  // PTX L9118
	r_PtxRegister3133 = ShiftRight(uint32_t(r_PtxRegister3132), uint32_t(27));				  // PTX L9119
	r_PtxRegister3134 = uint32_t(r_PtxRegister3131) + uint32_t(r_PtxRegister3133);			  // PTX L9120
	r_PtxRegister3135 = r_PtxRegister3134 & -32;											  // PTX L9121
	r_PtxRegister3136 = uint32_t(r_PtxRegister3131) - uint32_t(r_PtxRegister3135);			  // PTX L9122
	r_PtxRegister3137 =
		ShuffleIdxPredicate(r_bPtxPredicate63, r_PtxRegister2585, r_PtxRegister3136, 31, -1); // PTX L9123
	r_PtxRegister2645 = __byte_perm(r_PtxRegister3137, r_PtxRegister3137, 0x5410U);			  // PTX L9124
	r_PtxRegister3138 = uint32_t(r_PtxRegister3130) + uint32_t(24);							  // PTX L9125
	r_PtxRegister3139 = ShiftRightSigned(int32_t(r_PtxRegister3138), uint32_t(31));			  // PTX L9126
	r_PtxRegister3140 = ShiftRight(uint32_t(r_PtxRegister3139), uint32_t(27));				  // PTX L9127
	r_PtxRegister3141 = uint32_t(r_PtxRegister3138) + uint32_t(r_PtxRegister3140);			  // PTX L9128
	r_PtxRegister3142 = r_PtxRegister3141 & -32;											  // PTX L9129
	r_PtxRegister3143 = uint32_t(r_PtxRegister3138) - uint32_t(r_PtxRegister3142);			  // PTX L9130
	r_PtxRegister3144 =
		ShuffleIdxPredicate(r_bPtxPredicate64, r_PtxRegister2585, r_PtxRegister3143, 31, -1); // PTX L9131
	r_PtxRegister2648 = __byte_perm(r_PtxRegister3144, r_PtxRegister3144, 0x5410U);			  // PTX L9132
	r_PtxRegister3145 =
		ShuffleIdxPredicate(r_bPtxPredicate65, r_PtxRegister2585, r_PtxRegister3136, 31, -1); // PTX L9133
	r_PtxRegister2651 = __byte_perm(r_PtxRegister3145, r_PtxRegister3145, 0x5410U);			  // PTX L9134
	r_PtxRegister3146 =
		ShuffleIdxPredicate(r_bPtxPredicate66, r_PtxRegister2585, r_PtxRegister3143, 31, -1); // PTX L9135
	r_PtxRegister2654 = __byte_perm(r_PtxRegister3146, r_PtxRegister3146, 0x5410U);			  // PTX L9136
	r_LaneIndexAtPtx9138 = uint32_t((threadIdx.x & 31u));									  // PTX L9138
	r_PtxRegister3147 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9138), uint32_t(31));		  // PTX L9140
	r_PtxRegister3148 = ShiftRight(uint32_t(r_PtxRegister3147), uint32_t(30));				  // PTX L9141
	r_PtxRegister3149 = uint32_t(r_LaneIndexAtPtx9138) + uint32_t(r_PtxRegister3148);		  // PTX L9142
	r_PtxRegister3150 = ShiftRightSigned(int32_t(r_PtxRegister3149), uint32_t(2));			  // PTX L9143
	r_PtxRegister3151 = uint32_t(r_PtxRegister3150) + uint32_t(16);							  // PTX L9144
	r_PtxRegister3152 = ShiftRightSigned(int32_t(r_PtxRegister3151), uint32_t(31));			  // PTX L9145
	r_PtxRegister3153 = ShiftRight(uint32_t(r_PtxRegister3152), uint32_t(27));				  // PTX L9146
	r_PtxRegister3154 = uint32_t(r_PtxRegister3151) + uint32_t(r_PtxRegister3153);			  // PTX L9147
	r_PtxRegister3155 = r_PtxRegister3154 & -32;											  // PTX L9148
	r_PtxRegister3156 = uint32_t(r_PtxRegister3151) - uint32_t(r_PtxRegister3155);			  // PTX L9149
	r_PtxRegister3157 =
		ShuffleIdxPredicate(r_bPtxPredicate67, r_PtxRegister2585, r_PtxRegister3156, 31, -1); // PTX L9150
	r_PtxRegister2657 = __byte_perm(r_PtxRegister3157, r_PtxRegister3157, 0x5410U);			  // PTX L9151
	r_PtxRegister3158 = uint32_t(r_PtxRegister3150) + uint32_t(24);							  // PTX L9152
	r_PtxRegister3159 = ShiftRightSigned(int32_t(r_PtxRegister3158), uint32_t(31));			  // PTX L9153
	r_PtxRegister3160 = ShiftRight(uint32_t(r_PtxRegister3159), uint32_t(27));				  // PTX L9154
	r_PtxRegister3161 = uint32_t(r_PtxRegister3158) + uint32_t(r_PtxRegister3160);			  // PTX L9155
	r_PtxRegister3162 = r_PtxRegister3161 & -32;											  // PTX L9156
	r_PtxRegister3163 = uint32_t(r_PtxRegister3158) - uint32_t(r_PtxRegister3162);			  // PTX L9157
	r_PtxRegister3164 =
		ShuffleIdxPredicate(r_bPtxPredicate68, r_PtxRegister2585, r_PtxRegister3163, 31, -1); // PTX L9158
	r_PtxRegister2660 = __byte_perm(r_PtxRegister3164, r_PtxRegister3164, 0x5410U);			  // PTX L9159
	r_PtxRegister3165 =
		ShuffleIdxPredicate(r_bPtxPredicate69, r_PtxRegister2585, r_PtxRegister3156, 31, -1); // PTX L9160
	r_PtxRegister2663 = __byte_perm(r_PtxRegister3165, r_PtxRegister3165, 0x5410U);			  // PTX L9161
	r_PtxRegister3166 =
		ShuffleIdxPredicate(r_bPtxPredicate70, r_PtxRegister2585, r_PtxRegister3163, 31, -1); // PTX L9162
	r_PtxRegister2666 = __byte_perm(r_PtxRegister3166, r_PtxRegister3166, 0x5410U);			  // PTX L9163
	r_LaneIndexAtPtx9165 = uint32_t((threadIdx.x & 31u));									  // PTX L9165
	r_PtxRegister3167 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9165), uint32_t(31));		  // PTX L9167
	r_PtxRegister3168 = ShiftRight(uint32_t(r_PtxRegister3167), uint32_t(30));				  // PTX L9168
	r_PtxRegister3169 = uint32_t(r_LaneIndexAtPtx9165) + uint32_t(r_PtxRegister3168);		  // PTX L9169
	r_PtxRegister3170 = ShiftRightSigned(int32_t(r_PtxRegister3169), uint32_t(2));			  // PTX L9170
	r_PtxRegister3171 = uint32_t(r_PtxRegister3170) + uint32_t(16);							  // PTX L9171
	r_PtxRegister3172 = ShiftRightSigned(int32_t(r_PtxRegister3171), uint32_t(31));			  // PTX L9172
	r_PtxRegister3173 = ShiftRight(uint32_t(r_PtxRegister3172), uint32_t(27));				  // PTX L9173
	r_PtxRegister3174 = uint32_t(r_PtxRegister3171) + uint32_t(r_PtxRegister3173);			  // PTX L9174
	r_PtxRegister3175 = r_PtxRegister3174 & -32;											  // PTX L9175
	r_PtxRegister3176 = uint32_t(r_PtxRegister3171) - uint32_t(r_PtxRegister3175);			  // PTX L9176
	r_PtxRegister3177 =
		ShuffleIdxPredicate(r_bPtxPredicate71, r_PtxRegister2585, r_PtxRegister3176, 31, -1); // PTX L9177
	r_PtxRegister2669 = __byte_perm(r_PtxRegister3177, r_PtxRegister3177, 0x5410U);			  // PTX L9178
	r_PtxRegister3178 = uint32_t(r_PtxRegister3170) + uint32_t(24);							  // PTX L9179
	r_PtxRegister3179 = ShiftRightSigned(int32_t(r_PtxRegister3178), uint32_t(31));			  // PTX L9180
	r_PtxRegister3180 = ShiftRight(uint32_t(r_PtxRegister3179), uint32_t(27));				  // PTX L9181
	r_PtxRegister3181 = uint32_t(r_PtxRegister3178) + uint32_t(r_PtxRegister3180);			  // PTX L9182
	r_PtxRegister3182 = r_PtxRegister3181 & -32;											  // PTX L9183
	r_PtxRegister3183 = uint32_t(r_PtxRegister3178) - uint32_t(r_PtxRegister3182);			  // PTX L9184
	r_PtxRegister3184 =
		ShuffleIdxPredicate(r_bPtxPredicate72, r_PtxRegister2585, r_PtxRegister3183, 31, -1); // PTX L9185
	r_PtxRegister2672 = __byte_perm(r_PtxRegister3184, r_PtxRegister3184, 0x5410U);			  // PTX L9186
	r_PtxRegister3185 =
		ShuffleIdxPredicate(r_bPtxPredicate73, r_PtxRegister2585, r_PtxRegister3176, 31, -1); // PTX L9187
	r_PtxRegister2675 = __byte_perm(r_PtxRegister3185, r_PtxRegister3185, 0x5410U);			  // PTX L9188
	r_PtxRegister3186 =
		ShuffleIdxPredicate(r_bPtxPredicate74, r_PtxRegister2585, r_PtxRegister3183, 31, -1); // PTX L9189
	r_PtxRegister2678 = __byte_perm(r_PtxRegister3186, r_PtxRegister3186, 0x5410U);			  // PTX L9190
	r_LaneIndexAtPtx9192 = uint32_t((threadIdx.x & 31u));									  // PTX L9192
	r_PtxRegister3187 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9192), uint32_t(31));		  // PTX L9194
	r_PtxRegister3188 = ShiftRight(uint32_t(r_PtxRegister3187), uint32_t(30));				  // PTX L9195
	r_PtxRegister3189 = uint32_t(r_LaneIndexAtPtx9192) + uint32_t(r_PtxRegister3188);		  // PTX L9196
	r_PtxRegister3190 = ShiftRightSigned(int32_t(r_PtxRegister3189), uint32_t(2));			  // PTX L9197
	r_PtxRegister3191 = uint32_t(r_PtxRegister3190) + uint32_t(16);							  // PTX L9198
	r_PtxRegister3192 = ShiftRightSigned(int32_t(r_PtxRegister3191), uint32_t(31));			  // PTX L9199
	r_PtxRegister3193 = ShiftRight(uint32_t(r_PtxRegister3192), uint32_t(27));				  // PTX L9200
	r_PtxRegister3194 = uint32_t(r_PtxRegister3191) + uint32_t(r_PtxRegister3193);			  // PTX L9201
	r_PtxRegister3195 = r_PtxRegister3194 & -32;											  // PTX L9202
	r_PtxRegister3196 = uint32_t(r_PtxRegister3191) - uint32_t(r_PtxRegister3195);			  // PTX L9203
	r_PtxRegister3197 =
		ShuffleIdxPredicate(r_bPtxPredicate75, r_PtxRegister2585, r_PtxRegister3196, 31, -1); // PTX L9204
	r_PtxRegister2681 = __byte_perm(r_PtxRegister3197, r_PtxRegister3197, 0x5410U);			  // PTX L9205
	r_PtxRegister3198 = uint32_t(r_PtxRegister3190) + uint32_t(24);							  // PTX L9206
	r_PtxRegister3199 = ShiftRightSigned(int32_t(r_PtxRegister3198), uint32_t(31));			  // PTX L9207
	r_PtxRegister3200 = ShiftRight(uint32_t(r_PtxRegister3199), uint32_t(27));				  // PTX L9208
	r_PtxRegister3201 = uint32_t(r_PtxRegister3198) + uint32_t(r_PtxRegister3200);			  // PTX L9209
	r_PtxRegister3202 = r_PtxRegister3201 & -32;											  // PTX L9210
	r_PtxRegister3203 = uint32_t(r_PtxRegister3198) - uint32_t(r_PtxRegister3202);			  // PTX L9211
	r_PtxRegister3204 =
		ShuffleIdxPredicate(r_bPtxPredicate76, r_PtxRegister2585, r_PtxRegister3203, 31, -1); // PTX L9212
	r_PtxRegister2684 = __byte_perm(r_PtxRegister3204, r_PtxRegister3204, 0x5410U);			  // PTX L9213
	r_PtxRegister3205 =
		ShuffleIdxPredicate(r_bPtxPredicate77, r_PtxRegister2585, r_PtxRegister3196, 31, -1); // PTX L9214
	r_PtxRegister2687 = __byte_perm(r_PtxRegister3205, r_PtxRegister3205, 0x5410U);			  // PTX L9215
	r_PtxRegister3206 =
		ShuffleIdxPredicate(r_bPtxPredicate78, r_PtxRegister2585, r_PtxRegister3203, 31, -1); // PTX L9216
	r_PtxRegister2690 = __byte_perm(r_PtxRegister3206, r_PtxRegister3206, 0x5410U);			  // PTX L9217
	r_LaneIndexAtPtx9219 = uint32_t((threadIdx.x & 31u));									  // PTX L9219
	r_PackedHalf2AtPtx9222R2691 = HalfMul(r_PtxRegister2596, r_PtxRegister2597);			  // PTX L9222
	r_LaneIndexAtPtx9226 = uint32_t((threadIdx.x & 31u));									  // PTX L9226
	r_PackedHalf2AtPtx9229R2693 = HalfMul(r_PtxRegister2599, r_PtxRegister2600);			  // PTX L9229
	r_LaneIndexAtPtx9233 = uint32_t((threadIdx.x & 31u));									  // PTX L9233
	r_PackedHalf2AtPtx9236R2692 = HalfMul(r_PtxRegister2602, r_PtxRegister2603);			  // PTX L9236
	r_LaneIndexAtPtx9240 = uint32_t((threadIdx.x & 31u));									  // PTX L9240
	r_PackedHalf2AtPtx9243R2694 = HalfMul(r_PtxRegister2605, r_PtxRegister2606);			  // PTX L9243
	r_LaneIndexAtPtx9247 = uint32_t((threadIdx.x & 31u));									  // PTX L9247
	r_PackedHalf2AtPtx9250R2695 = HalfMul(r_PtxRegister2608, r_PtxRegister2609);			  // PTX L9250
	r_LaneIndexAtPtx9254 = uint32_t((threadIdx.x & 31u));									  // PTX L9254
	r_PackedHalf2AtPtx9257R2697 = HalfMul(r_PtxRegister2611, r_PtxRegister2612);			  // PTX L9257
	r_LaneIndexAtPtx9261 = uint32_t((threadIdx.x & 31u));									  // PTX L9261
	r_PackedHalf2AtPtx9264R2696 = HalfMul(r_PtxRegister2614, r_PtxRegister2615);			  // PTX L9264
	r_LaneIndexAtPtx9268 = uint32_t((threadIdx.x & 31u));									  // PTX L9268
	r_PackedHalf2AtPtx9271R2698 = HalfMul(r_PtxRegister2617, r_PtxRegister2618);			  // PTX L9271
	r_LaneIndexAtPtx9275 = uint32_t((threadIdx.x & 31u));									  // PTX L9275
	r_PackedHalf2AtPtx9278R2699 = HalfMul(r_PtxRegister2620, r_PtxRegister2621);			  // PTX L9278
	r_LaneIndexAtPtx9282 = uint32_t((threadIdx.x & 31u));									  // PTX L9282
	r_PackedHalf2AtPtx9285R2701 = HalfMul(r_PtxRegister2623, r_PtxRegister2624);			  // PTX L9285
	r_LaneIndexAtPtx9289 = uint32_t((threadIdx.x & 31u));									  // PTX L9289
	r_PackedHalf2AtPtx9292R2700 = HalfMul(r_PtxRegister2626, r_PtxRegister2627);			  // PTX L9292
	r_LaneIndexAtPtx9296 = uint32_t((threadIdx.x & 31u));									  // PTX L9296
	r_PackedHalf2AtPtx9299R2702 = HalfMul(r_PtxRegister2629, r_PtxRegister2630);			  // PTX L9299
	r_LaneIndexAtPtx9303 = uint32_t((threadIdx.x & 31u));									  // PTX L9303
	r_PackedHalf2AtPtx9306R2703 = HalfMul(r_PtxRegister2632, r_PtxRegister2633);			  // PTX L9306
	r_LaneIndexAtPtx9310 = uint32_t((threadIdx.x & 31u));									  // PTX L9310
	r_PackedHalf2AtPtx9313R2705 = HalfMul(r_PtxRegister2635, r_PtxRegister2636);			  // PTX L9313
	r_LaneIndexAtPtx9317 = uint32_t((threadIdx.x & 31u));									  // PTX L9317
	r_PackedHalf2AtPtx9320R2704 = HalfMul(r_PtxRegister2638, r_PtxRegister2639);			  // PTX L9320
	r_LaneIndexAtPtx9324 = uint32_t((threadIdx.x & 31u));									  // PTX L9324
	r_PackedHalf2AtPtx9327R2706 = HalfMul(r_PtxRegister2641, r_PtxRegister2642);			  // PTX L9327
	r_LaneIndexAtPtx9331 = uint32_t((threadIdx.x & 31u));									  // PTX L9331
	r_PackedHalf2AtPtx9334R2707 = HalfMul(r_PtxRegister2644, r_PtxRegister2645);			  // PTX L9334
	r_LaneIndexAtPtx9338 = uint32_t((threadIdx.x & 31u));									  // PTX L9338
	r_PackedHalf2AtPtx9341R2709 = HalfMul(r_PtxRegister2647, r_PtxRegister2648);			  // PTX L9341
	r_LaneIndexAtPtx9345 = uint32_t((threadIdx.x & 31u));									  // PTX L9345
	r_PackedHalf2AtPtx9348R2708 = HalfMul(r_PtxRegister2650, r_PtxRegister2651);			  // PTX L9348
	r_LaneIndexAtPtx9352 = uint32_t((threadIdx.x & 31u));									  // PTX L9352
	r_PackedHalf2AtPtx9355R2710 = HalfMul(r_PtxRegister2653, r_PtxRegister2654);			  // PTX L9355
	r_LaneIndexAtPtx9359 = uint32_t((threadIdx.x & 31u));									  // PTX L9359
	r_PackedHalf2AtPtx9362R2711 = HalfMul(r_PtxRegister2656, r_PtxRegister2657);			  // PTX L9362
	r_LaneIndexAtPtx9366 = uint32_t((threadIdx.x & 31u));									  // PTX L9366
	r_PackedHalf2AtPtx9369R2713 = HalfMul(r_PtxRegister2659, r_PtxRegister2660);			  // PTX L9369
	r_LaneIndexAtPtx9373 = uint32_t((threadIdx.x & 31u));									  // PTX L9373
	r_PackedHalf2AtPtx9376R2712 = HalfMul(r_PtxRegister2662, r_PtxRegister2663);			  // PTX L9376
	r_LaneIndexAtPtx9380 = uint32_t((threadIdx.x & 31u));									  // PTX L9380
	r_PackedHalf2AtPtx9383R2714 = HalfMul(r_PtxRegister2665, r_PtxRegister2666);			  // PTX L9383
	r_LaneIndexAtPtx9387 = uint32_t((threadIdx.x & 31u));									  // PTX L9387
	r_PackedHalf2AtPtx9390R2715 = HalfMul(r_PtxRegister2668, r_PtxRegister2669);			  // PTX L9390
	r_LaneIndexAtPtx9394 = uint32_t((threadIdx.x & 31u));									  // PTX L9394
	r_PackedHalf2AtPtx9397R2717 = HalfMul(r_PtxRegister2671, r_PtxRegister2672);			  // PTX L9397
	r_LaneIndexAtPtx9401 = uint32_t((threadIdx.x & 31u));									  // PTX L9401
	r_PackedHalf2AtPtx9404R2716 = HalfMul(r_PtxRegister2674, r_PtxRegister2675);			  // PTX L9404
	r_LaneIndexAtPtx9408 = uint32_t((threadIdx.x & 31u));									  // PTX L9408
	r_PackedHalf2AtPtx9411R2718 = HalfMul(r_PtxRegister2677, r_PtxRegister2678);			  // PTX L9411
	r_LaneIndexAtPtx9415 = uint32_t((threadIdx.x & 31u));									  // PTX L9415
	r_PackedHalf2AtPtx9418R2719 = HalfMul(r_PtxRegister2680, r_PtxRegister2681);			  // PTX L9418
	r_LaneIndexAtPtx9422 = uint32_t((threadIdx.x & 31u));									  // PTX L9422
	r_PackedHalf2AtPtx9425R2721 = HalfMul(r_PtxRegister2683, r_PtxRegister2684);			  // PTX L9425
	r_LaneIndexAtPtx9429 = uint32_t((threadIdx.x & 31u));									  // PTX L9429
	r_PackedHalf2AtPtx9432R2720 = HalfMul(r_PtxRegister2686, r_PtxRegister2687);			  // PTX L9432
	r_LaneIndexAtPtx9436 = uint32_t((threadIdx.x & 31u));									  // PTX L9436
	r_PackedHalf2AtPtx9439R2722 = HalfMul(r_PtxRegister2689, r_PtxRegister2690);			  // PTX L9439
	r_ConvertedE4PairAtPtx9443Rs290 = PublishE4(r_PackedHalf2AtPtx9222R2691);				  // PTX L9443
	r_ConvertedE4PairAtPtx9446Rs291 = PublishE4(r_PackedHalf2AtPtx9236R2692);				  // PTX L9446
	r_MmaAE4x4WordAtPtx9448R2725 = JoinConvertedE4(r_ConvertedE4PairAtPtx9443Rs290,
												   r_ConvertedE4PairAtPtx9446Rs291); // PTX L9448
	r_ConvertedE4PairAtPtx9450Rs292 = PublishE4(r_PackedHalf2AtPtx9229R2693);		 // PTX L9450
	r_ConvertedE4PairAtPtx9453Rs293 = PublishE4(r_PackedHalf2AtPtx9243R2694);		 // PTX L9453
	r_MmaAE4x4WordAtPtx9455R2726 = JoinConvertedE4(r_ConvertedE4PairAtPtx9450Rs292,
												   r_ConvertedE4PairAtPtx9453Rs293); // PTX L9455
	r_ConvertedE4PairAtPtx9457Rs294 = PublishE4(r_PackedHalf2AtPtx9250R2695);		 // PTX L9457
	r_ConvertedE4PairAtPtx9460Rs295 = PublishE4(r_PackedHalf2AtPtx9264R2696);		 // PTX L9460
	r_MmaAE4x4WordAtPtx9462R2727 = JoinConvertedE4(r_ConvertedE4PairAtPtx9457Rs294,
												   r_ConvertedE4PairAtPtx9460Rs295); // PTX L9462
	r_ConvertedE4PairAtPtx9464Rs296 = PublishE4(r_PackedHalf2AtPtx9257R2697);		 // PTX L9464
	r_ConvertedE4PairAtPtx9467Rs297 = PublishE4(r_PackedHalf2AtPtx9271R2698);		 // PTX L9467
	r_MmaAE4x4WordAtPtx9469R2728 = JoinConvertedE4(r_ConvertedE4PairAtPtx9464Rs296,
												   r_ConvertedE4PairAtPtx9467Rs297); // PTX L9469
	r_ConvertedE4PairAtPtx9471Rs298 = PublishE4(r_PackedHalf2AtPtx9278R2699);		 // PTX L9471
	r_ConvertedE4PairAtPtx9474Rs299 = PublishE4(r_PackedHalf2AtPtx9292R2700);		 // PTX L9474
	r_MmaAE4x4WordAtPtx9476R2735 = JoinConvertedE4(r_ConvertedE4PairAtPtx9471Rs298,
												   r_ConvertedE4PairAtPtx9474Rs299); // PTX L9476
	r_ConvertedE4PairAtPtx9478Rs300 = PublishE4(r_PackedHalf2AtPtx9285R2701);		 // PTX L9478
	r_ConvertedE4PairAtPtx9481Rs301 = PublishE4(r_PackedHalf2AtPtx9299R2702);		 // PTX L9481
	r_MmaAE4x4WordAtPtx9483R2736 = JoinConvertedE4(r_ConvertedE4PairAtPtx9478Rs300,
												   r_ConvertedE4PairAtPtx9481Rs301); // PTX L9483
	r_ConvertedE4PairAtPtx9485Rs302 = PublishE4(r_PackedHalf2AtPtx9306R2703);		 // PTX L9485
	r_ConvertedE4PairAtPtx9488Rs303 = PublishE4(r_PackedHalf2AtPtx9320R2704);		 // PTX L9488
	r_MmaAE4x4WordAtPtx9490R2737 = JoinConvertedE4(r_ConvertedE4PairAtPtx9485Rs302,
												   r_ConvertedE4PairAtPtx9488Rs303); // PTX L9490
	r_ConvertedE4PairAtPtx9492Rs304 = PublishE4(r_PackedHalf2AtPtx9313R2705);		 // PTX L9492
	r_ConvertedE4PairAtPtx9495Rs305 = PublishE4(r_PackedHalf2AtPtx9327R2706);		 // PTX L9495
	r_MmaAE4x4WordAtPtx9497R2738 = JoinConvertedE4(r_ConvertedE4PairAtPtx9492Rs304,
												   r_ConvertedE4PairAtPtx9495Rs305); // PTX L9497
	r_ConvertedE4PairAtPtx9499Rs306 = PublishE4(r_PackedHalf2AtPtx9334R2707);		 // PTX L9499
	r_ConvertedE4PairAtPtx9502Rs307 = PublishE4(r_PackedHalf2AtPtx9348R2708);		 // PTX L9502
	r_MmaAE4x4WordAtPtx9504R2755 = JoinConvertedE4(r_ConvertedE4PairAtPtx9499Rs306,
												   r_ConvertedE4PairAtPtx9502Rs307); // PTX L9504
	r_ConvertedE4PairAtPtx9506Rs308 = PublishE4(r_PackedHalf2AtPtx9341R2709);		 // PTX L9506
	r_ConvertedE4PairAtPtx9509Rs309 = PublishE4(r_PackedHalf2AtPtx9355R2710);		 // PTX L9509
	r_MmaAE4x4WordAtPtx9511R2756 = JoinConvertedE4(r_ConvertedE4PairAtPtx9506Rs308,
												   r_ConvertedE4PairAtPtx9509Rs309); // PTX L9511
	r_ConvertedE4PairAtPtx9513Rs310 = PublishE4(r_PackedHalf2AtPtx9362R2711);		 // PTX L9513
	r_ConvertedE4PairAtPtx9516Rs311 = PublishE4(r_PackedHalf2AtPtx9376R2712);		 // PTX L9516
	r_MmaAE4x4WordAtPtx9518R2757 = JoinConvertedE4(r_ConvertedE4PairAtPtx9513Rs310,
												   r_ConvertedE4PairAtPtx9516Rs311); // PTX L9518
	r_ConvertedE4PairAtPtx9520Rs312 = PublishE4(r_PackedHalf2AtPtx9369R2713);		 // PTX L9520
	r_ConvertedE4PairAtPtx9523Rs313 = PublishE4(r_PackedHalf2AtPtx9383R2714);		 // PTX L9523
	r_MmaAE4x4WordAtPtx9525R2758 = JoinConvertedE4(r_ConvertedE4PairAtPtx9520Rs312,
												   r_ConvertedE4PairAtPtx9523Rs313); // PTX L9525
	r_ConvertedE4PairAtPtx9527Rs314 = PublishE4(r_PackedHalf2AtPtx9390R2715);		 // PTX L9527
	r_ConvertedE4PairAtPtx9530Rs315 = PublishE4(r_PackedHalf2AtPtx9404R2716);		 // PTX L9530
	r_MmaAE4x4WordAtPtx9532R2761 = JoinConvertedE4(r_ConvertedE4PairAtPtx9527Rs314,
												   r_ConvertedE4PairAtPtx9530Rs315); // PTX L9532
	r_ConvertedE4PairAtPtx9534Rs316 = PublishE4(r_PackedHalf2AtPtx9397R2717);		 // PTX L9534
	r_ConvertedE4PairAtPtx9537Rs317 = PublishE4(r_PackedHalf2AtPtx9411R2718);		 // PTX L9537
	r_MmaAE4x4WordAtPtx9539R2762 = JoinConvertedE4(r_ConvertedE4PairAtPtx9534Rs316,
												   r_ConvertedE4PairAtPtx9537Rs317); // PTX L9539
	r_ConvertedE4PairAtPtx9541Rs318 = PublishE4(r_PackedHalf2AtPtx9418R2719);		 // PTX L9541
	r_ConvertedE4PairAtPtx9544Rs319 = PublishE4(r_PackedHalf2AtPtx9432R2720);		 // PTX L9544
	r_MmaAE4x4WordAtPtx9546R2763 = JoinConvertedE4(r_ConvertedE4PairAtPtx9541Rs318,
												   r_ConvertedE4PairAtPtx9544Rs319); // PTX L9546
	r_ConvertedE4PairAtPtx9548Rs320 = PublishE4(r_PackedHalf2AtPtx9425R2721);		 // PTX L9548
	r_ConvertedE4PairAtPtx9551Rs321 = PublishE4(r_PackedHalf2AtPtx9439R2722);		 // PTX L9551
	r_MmaAE4x4WordAtPtx9553R2764 = JoinConvertedE4(r_ConvertedE4PairAtPtx9548Rs320,
												   r_ConvertedE4PairAtPtx9551Rs321); // PTX L9553
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9555R2733, r_MmaAccumulatorHalf2WordAtPtx9555R2734,
		  r_MmaAE4x4WordAtPtx9448R2725, r_MmaAE4x4WordAtPtx9455R2726, r_MmaAE4x4WordAtPtx9462R2727,
		  r_MmaAE4x4WordAtPtx9469R2728, r_MmaBE4x4WordAtPtx7941R2723, r_MmaBE4x4WordAtPtx7948R2724,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L9555
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9562R2741, r_MmaAccumulatorHalf2WordAtPtx9562R2742,
		  r_MmaAE4x4WordAtPtx9448R2725, r_MmaAE4x4WordAtPtx9455R2726, r_MmaAE4x4WordAtPtx9462R2727,
		  r_MmaAE4x4WordAtPtx9469R2728, r_MmaBE4x4WordAtPtx7955R2729, r_MmaBE4x4WordAtPtx7962R2730,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L9562
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9569R2848, r_MmaAccumulatorHalf2WordAtPtx9569R2850,
		  r_MmaAE4x4WordAtPtx9476R2735, r_MmaAE4x4WordAtPtx9483R2736, r_MmaAE4x4WordAtPtx9490R2737,
		  r_MmaAE4x4WordAtPtx9497R2738, r_MmaBE4x4WordAtPtx7997R2731, r_MmaBE4x4WordAtPtx8004R2732,
		  r_MmaAccumulatorHalf2WordAtPtx9555R2733,
		  r_MmaAccumulatorHalf2WordAtPtx9555R2734); // PTX L9569
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9576R2849, r_MmaAccumulatorHalf2WordAtPtx9576R2851,
		  r_MmaAE4x4WordAtPtx9476R2735, r_MmaAE4x4WordAtPtx9483R2736, r_MmaAE4x4WordAtPtx9490R2737,
		  r_MmaAE4x4WordAtPtx9497R2738, r_MmaBE4x4WordAtPtx8011R2739, r_MmaBE4x4WordAtPtx8018R2740,
		  r_MmaAccumulatorHalf2WordAtPtx9562R2741,
		  r_MmaAccumulatorHalf2WordAtPtx9562R2742); // PTX L9576
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9583R2749, r_MmaAccumulatorHalf2WordAtPtx9583R2750,
		  r_MmaAE4x4WordAtPtx9448R2725, r_MmaAE4x4WordAtPtx9455R2726, r_MmaAE4x4WordAtPtx9462R2727,
		  r_MmaAE4x4WordAtPtx9469R2728, r_MmaBE4x4WordAtPtx7969R2743, r_MmaBE4x4WordAtPtx7976R2744,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L9583
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9590R2753, r_MmaAccumulatorHalf2WordAtPtx9590R2754,
		  r_MmaAE4x4WordAtPtx9448R2725, r_MmaAE4x4WordAtPtx9455R2726, r_MmaAE4x4WordAtPtx9462R2727,
		  r_MmaAE4x4WordAtPtx9469R2728, r_MmaBE4x4WordAtPtx7983R2745, r_MmaBE4x4WordAtPtx7990R2746,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L9590
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9597R2852, r_MmaAccumulatorHalf2WordAtPtx9597R2854,
		  r_MmaAE4x4WordAtPtx9476R2735, r_MmaAE4x4WordAtPtx9483R2736, r_MmaAE4x4WordAtPtx9490R2737,
		  r_MmaAE4x4WordAtPtx9497R2738, r_MmaBE4x4WordAtPtx8025R2747, r_MmaBE4x4WordAtPtx8032R2748,
		  r_MmaAccumulatorHalf2WordAtPtx9583R2749,
		  r_MmaAccumulatorHalf2WordAtPtx9583R2750); // PTX L9597
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9604R2853, r_MmaAccumulatorHalf2WordAtPtx9604R2855,
		  r_MmaAE4x4WordAtPtx9476R2735, r_MmaAE4x4WordAtPtx9483R2736, r_MmaAE4x4WordAtPtx9490R2737,
		  r_MmaAE4x4WordAtPtx9497R2738, r_MmaBE4x4WordAtPtx8039R2751, r_MmaBE4x4WordAtPtx8046R2752,
		  r_MmaAccumulatorHalf2WordAtPtx9590R2753,
		  r_MmaAccumulatorHalf2WordAtPtx9590R2754); // PTX L9604
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9611R2759, r_MmaAccumulatorHalf2WordAtPtx9611R2760,
		  r_MmaAE4x4WordAtPtx9504R2755, r_MmaAE4x4WordAtPtx9511R2756, r_MmaAE4x4WordAtPtx9518R2757,
		  r_MmaAE4x4WordAtPtx9525R2758, r_MmaBE4x4WordAtPtx7941R2723, r_MmaBE4x4WordAtPtx7948R2724,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L9611
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9618R2765, r_MmaAccumulatorHalf2WordAtPtx9618R2766,
		  r_MmaAE4x4WordAtPtx9504R2755, r_MmaAE4x4WordAtPtx9511R2756, r_MmaAE4x4WordAtPtx9518R2757,
		  r_MmaAE4x4WordAtPtx9525R2758, r_MmaBE4x4WordAtPtx7955R2729, r_MmaBE4x4WordAtPtx7962R2730,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L9618
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9625R2856, r_MmaAccumulatorHalf2WordAtPtx9625R2858,
		  r_MmaAE4x4WordAtPtx9532R2761, r_MmaAE4x4WordAtPtx9539R2762, r_MmaAE4x4WordAtPtx9546R2763,
		  r_MmaAE4x4WordAtPtx9553R2764, r_MmaBE4x4WordAtPtx7997R2731, r_MmaBE4x4WordAtPtx8004R2732,
		  r_MmaAccumulatorHalf2WordAtPtx9611R2759,
		  r_MmaAccumulatorHalf2WordAtPtx9611R2760); // PTX L9625
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9632R2857, r_MmaAccumulatorHalf2WordAtPtx9632R2859,
		  r_MmaAE4x4WordAtPtx9532R2761, r_MmaAE4x4WordAtPtx9539R2762, r_MmaAE4x4WordAtPtx9546R2763,
		  r_MmaAE4x4WordAtPtx9553R2764, r_MmaBE4x4WordAtPtx8011R2739, r_MmaBE4x4WordAtPtx8018R2740,
		  r_MmaAccumulatorHalf2WordAtPtx9618R2765,
		  r_MmaAccumulatorHalf2WordAtPtx9618R2766); // PTX L9632
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9639R2768, r_MmaAccumulatorHalf2WordAtPtx9639R2769,
		  r_MmaAE4x4WordAtPtx9504R2755, r_MmaAE4x4WordAtPtx9511R2756, r_MmaAE4x4WordAtPtx9518R2757,
		  r_MmaAE4x4WordAtPtx9525R2758, r_MmaBE4x4WordAtPtx7969R2743, r_MmaBE4x4WordAtPtx7976R2744,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L9639
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9646R2770, r_MmaAccumulatorHalf2WordAtPtx9646R2771,
		  r_MmaAE4x4WordAtPtx9504R2755, r_MmaAE4x4WordAtPtx9511R2756, r_MmaAE4x4WordAtPtx9518R2757,
		  r_MmaAE4x4WordAtPtx9525R2758, r_MmaBE4x4WordAtPtx7983R2745, r_MmaBE4x4WordAtPtx7990R2746,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L9646
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9653R2860, r_MmaAccumulatorHalf2WordAtPtx9653R2862,
		  r_MmaAE4x4WordAtPtx9532R2761, r_MmaAE4x4WordAtPtx9539R2762, r_MmaAE4x4WordAtPtx9546R2763,
		  r_MmaAE4x4WordAtPtx9553R2764, r_MmaBE4x4WordAtPtx8025R2747, r_MmaBE4x4WordAtPtx8032R2748,
		  r_MmaAccumulatorHalf2WordAtPtx9639R2768,
		  r_MmaAccumulatorHalf2WordAtPtx9639R2769); // PTX L9653
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx9660R2861, r_MmaAccumulatorHalf2WordAtPtx9660R2863,
		  r_MmaAE4x4WordAtPtx9532R2761, r_MmaAE4x4WordAtPtx9539R2762, r_MmaAE4x4WordAtPtx9546R2763,
		  r_MmaAE4x4WordAtPtx9553R2764, r_MmaBE4x4WordAtPtx8039R2751, r_MmaBE4x4WordAtPtx8046R2752,
		  r_MmaAccumulatorHalf2WordAtPtx9646R2770,
		  r_MmaAccumulatorHalf2WordAtPtx9646R2771);								 // PTX L9660
	r_LaneIndexAtPtx9667 = uint32_t((threadIdx.x & 31u));						 // PTX L9667
	r_PtxRegister3207 = ShiftLeft(uint32_t(r_ThreadYAtPtx4287), uint32_t(9));	 // PTX L9669
	r_PtxRegister20 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister3207); // PTX L9670
	r_PtxRegister3208 = ShiftLeft(uint32_t(r_LaneIndexAtPtx9667), uint32_t(4));	 // PTX L9671
	r_PtxRegister2777 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister3208); // PTX L9672
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2777));
		r_PtxRegister2773 = r_Value.x;
		r_PtxRegister2774 = r_Value.y;
		r_PtxRegister2775 = r_Value.z;
		r_PtxRegister2776 = r_Value.w;
	} // PTX L9674
	r_LaneIndexAtPtx9677 = uint32_t((threadIdx.x & 31u));						 // PTX L9677
	r_PtxRegister3209 = ShiftLeft(uint32_t(r_LaneIndexAtPtx9677), uint32_t(4));	 // PTX L9679
	r_PtxRegister3210 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister3209); // PTX L9680
	r_PtxRegister2783 = uint32_t(r_PtxRegister3210) + uint32_t(1024);			 // PTX L9681
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2783));
		r_PtxRegister2779 = r_Value.x;
		r_PtxRegister2780 = r_Value.y;
		r_PtxRegister2781 = r_Value.z;
		r_PtxRegister2782 = r_Value.w;
	} // PTX L9683
	r_PtxU16Register322 = uint16_t(r_PtxRegister2773);
	r_PtxU16Register323 = uint16_t(r_PtxRegister2773 >> 16);	 // PTX L9685
	r_PackedHalf2AtPtx9687R2801 = DecodeE4(r_PtxU16Register322); // PTX L9687
	r_PackedHalf2AtPtx9690R2807 = DecodeE4(r_PtxU16Register323); // PTX L9690
	r_PtxU16Register324 = uint16_t(r_PtxRegister2774);
	r_PtxU16Register325 = uint16_t(r_PtxRegister2774 >> 16);	 // PTX L9692
	r_PackedHalf2AtPtx9694R2804 = DecodeE4(r_PtxU16Register324); // PTX L9694
	r_PackedHalf2AtPtx9697R2810 = DecodeE4(r_PtxU16Register325); // PTX L9697
	r_PtxU16Register326 = uint16_t(r_PtxRegister2775);
	r_PtxU16Register327 = uint16_t(r_PtxRegister2775 >> 16);	 // PTX L9699
	r_PackedHalf2AtPtx9701R2813 = DecodeE4(r_PtxU16Register326); // PTX L9701
	r_PackedHalf2AtPtx9704R2819 = DecodeE4(r_PtxU16Register327); // PTX L9704
	r_PtxU16Register328 = uint16_t(r_PtxRegister2776);
	r_PtxU16Register329 = uint16_t(r_PtxRegister2776 >> 16);	 // PTX L9706
	r_PackedHalf2AtPtx9708R2816 = DecodeE4(r_PtxU16Register328); // PTX L9708
	r_PackedHalf2AtPtx9711R2822 = DecodeE4(r_PtxU16Register329); // PTX L9711
	r_PtxU16Register330 = uint16_t(r_PtxRegister2779);
	r_PtxU16Register331 = uint16_t(r_PtxRegister2779 >> 16);	 // PTX L9713
	r_PackedHalf2AtPtx9715R2825 = DecodeE4(r_PtxU16Register330); // PTX L9715
	r_PackedHalf2AtPtx9718R2831 = DecodeE4(r_PtxU16Register331); // PTX L9718
	r_PtxU16Register332 = uint16_t(r_PtxRegister2780);
	r_PtxU16Register333 = uint16_t(r_PtxRegister2780 >> 16);	 // PTX L9720
	r_PackedHalf2AtPtx9722R2828 = DecodeE4(r_PtxU16Register332); // PTX L9722
	r_PackedHalf2AtPtx9725R2834 = DecodeE4(r_PtxU16Register333); // PTX L9725
	r_PtxU16Register334 = uint16_t(r_PtxRegister2781);
	r_PtxU16Register335 = uint16_t(r_PtxRegister2781 >> 16);	 // PTX L9727
	r_PackedHalf2AtPtx9729R2837 = DecodeE4(r_PtxU16Register334); // PTX L9729
	r_PackedHalf2AtPtx9732R2843 = DecodeE4(r_PtxU16Register335); // PTX L9732
	r_PtxU16Register336 = uint16_t(r_PtxRegister2782);
	r_PtxU16Register337 = uint16_t(r_PtxRegister2782 >> 16);								   // PTX L9734
	r_PackedHalf2AtPtx9736R2840 = DecodeE4(r_PtxU16Register336);							   // PTX L9736
	r_PackedHalf2AtPtx9739R2846 = DecodeE4(r_PtxU16Register337);							   // PTX L9739
	r_LaneIndexAtPtx9742 = uint32_t((threadIdx.x & 31u));									   // PTX L9742
	r_PtxRegister3211 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9742), uint32_t(31));		   // PTX L9744
	r_PtxRegister3212 = ShiftRight(uint32_t(r_PtxRegister3211), uint32_t(30));				   // PTX L9745
	r_PtxRegister3213 = uint32_t(r_LaneIndexAtPtx9742) + uint32_t(r_PtxRegister3212);		   // PTX L9746
	r_PtxRegister3214 = r_PtxRegister3213 & 2147483644;										   // PTX L9747
	r_PtxRegister3215 = uint32_t(r_LaneIndexAtPtx9742) - uint32_t(r_PtxRegister3214);		   // PTX L9748
	r_PtxRegister3216 = ShiftLeft(uint32_t(r_PtxRegister3215), uint32_t(1));				   // PTX L9749
	r_PtxRegister3217 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister3216);			   // PTX L9750
	r_PtxRegister3218 = ShiftRightSigned(int32_t(r_PtxRegister3217), uint32_t(1));			   // PTX L9751
	r_PtxU64Register252 = uint64_t(int64_t(int32_t(r_PtxRegister3218)) * int64_t(int32_t(4))); // PTX L9752
	g_RecordByteAddressAtPtx9753 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register252); // PTX L9753
	r_PtxRegister2802 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9753 + 61616ull);		   // PTX L9754
	r_LaneIndexAtPtx9756 = uint32_t((threadIdx.x & 31u));									   // PTX L9756
	r_PtxRegister3219 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9756), uint32_t(31));		   // PTX L9758
	r_PtxRegister3220 = ShiftRight(uint32_t(r_PtxRegister3219), uint32_t(30));				   // PTX L9759
	r_PtxRegister3221 = uint32_t(r_LaneIndexAtPtx9756) + uint32_t(r_PtxRegister3220);		   // PTX L9760
	r_PtxRegister3222 = r_PtxRegister3221 & 2147483644;										   // PTX L9761
	r_PtxRegister3223 = uint32_t(r_LaneIndexAtPtx9756) - uint32_t(r_PtxRegister3222);		   // PTX L9762
	r_PtxRegister3224 = ShiftLeft(uint32_t(r_PtxRegister3223), uint32_t(1));				   // PTX L9763
	r_PtxRegister3225 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister3224);			   // PTX L9764
	r_PtxRegister3226 = ShiftRightSigned(int32_t(r_PtxRegister3225), uint32_t(1));			   // PTX L9765
	r_PtxU64Register254 = uint64_t(int64_t(int32_t(r_PtxRegister3226)) * int64_t(int32_t(4))); // PTX L9766
	g_RecordByteAddressAtPtx9767 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register254); // PTX L9767
	r_PtxRegister2805 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9767 + 61616ull);	 // PTX L9768
	r_LaneIndexAtPtx9770 = uint32_t((threadIdx.x & 31u));								 // PTX L9770
	r_PtxRegister3227 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9770), uint32_t(31));	 // PTX L9772
	r_PtxRegister3228 = ShiftRight(uint32_t(r_PtxRegister3227), uint32_t(30));			 // PTX L9773
	r_PtxRegister3229 = uint32_t(r_LaneIndexAtPtx9770) + uint32_t(r_PtxRegister3228);	 // PTX L9774
	r_PtxRegister3230 = r_PtxRegister3229 & -4;											 // PTX L9775
	r_PtxRegister3231 = uint32_t(r_LaneIndexAtPtx9770) - uint32_t(r_PtxRegister3230);	 // PTX L9776
	r_PtxRegister3232 = ShiftRight(uint32_t(r_PtxRegister15), uint32_t(1));				 // PTX L9777
	r_PtxRegister21 = r_PtxRegister3232 | 4;											 // PTX L9778
	r_PtxRegister3233 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister3231);		 // PTX L9779
	r_PtxU64Register256 = uint64_t(uint32_t(r_PtxRegister3233)) * uint64_t(uint32_t(4)); // PTX L9780
	g_RecordByteAddressAtPtx9781 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register256); // PTX L9781
	r_PtxRegister2808 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9781 + 61616ull);	 // PTX L9782
	r_LaneIndexAtPtx9784 = uint32_t((threadIdx.x & 31u));								 // PTX L9784
	r_PtxRegister3234 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9784), uint32_t(31));	 // PTX L9786
	r_PtxRegister3235 = ShiftRight(uint32_t(r_PtxRegister3234), uint32_t(30));			 // PTX L9787
	r_PtxRegister3236 = uint32_t(r_LaneIndexAtPtx9784) + uint32_t(r_PtxRegister3235);	 // PTX L9788
	r_PtxRegister3237 = r_PtxRegister3236 & -4;											 // PTX L9789
	r_PtxRegister3238 = uint32_t(r_LaneIndexAtPtx9784) - uint32_t(r_PtxRegister3237);	 // PTX L9790
	r_PtxRegister3239 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister3238);		 // PTX L9791
	r_PtxU64Register258 = uint64_t(uint32_t(r_PtxRegister3239)) * uint64_t(uint32_t(4)); // PTX L9792
	g_RecordByteAddressAtPtx9793 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register258); // PTX L9793
	r_PtxRegister2811 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9793 + 61616ull);	 // PTX L9794
	r_LaneIndexAtPtx9796 = uint32_t((threadIdx.x & 31u));								 // PTX L9796
	r_PtxRegister3240 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9796), uint32_t(31));	 // PTX L9798
	r_PtxRegister3241 = ShiftRight(uint32_t(r_PtxRegister3240), uint32_t(30));			 // PTX L9799
	r_PtxRegister3242 = uint32_t(r_LaneIndexAtPtx9796) + uint32_t(r_PtxRegister3241);	 // PTX L9800
	r_PtxRegister3243 = r_PtxRegister3242 & -4;											 // PTX L9801
	r_PtxRegister3244 = uint32_t(r_LaneIndexAtPtx9796) - uint32_t(r_PtxRegister3243);	 // PTX L9802
	r_PtxRegister22 = r_PtxRegister3232 | 8;											 // PTX L9803
	r_PtxRegister3245 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister3244);		 // PTX L9804
	r_PtxU64Register260 = uint64_t(uint32_t(r_PtxRegister3245)) * uint64_t(uint32_t(4)); // PTX L9805
	g_RecordByteAddressAtPtx9806 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register260); // PTX L9806
	r_PtxRegister2814 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9806 + 61616ull);	 // PTX L9807
	r_LaneIndexAtPtx9809 = uint32_t((threadIdx.x & 31u));								 // PTX L9809
	r_PtxRegister3246 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9809), uint32_t(31));	 // PTX L9811
	r_PtxRegister3247 = ShiftRight(uint32_t(r_PtxRegister3246), uint32_t(30));			 // PTX L9812
	r_PtxRegister3248 = uint32_t(r_LaneIndexAtPtx9809) + uint32_t(r_PtxRegister3247);	 // PTX L9813
	r_PtxRegister3249 = r_PtxRegister3248 & -4;											 // PTX L9814
	r_PtxRegister3250 = uint32_t(r_LaneIndexAtPtx9809) - uint32_t(r_PtxRegister3249);	 // PTX L9815
	r_PtxRegister3251 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister3250);		 // PTX L9816
	r_PtxU64Register262 = uint64_t(uint32_t(r_PtxRegister3251)) * uint64_t(uint32_t(4)); // PTX L9817
	g_RecordByteAddressAtPtx9818 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register262); // PTX L9818
	r_PtxRegister2817 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9818 + 61616ull);	 // PTX L9819
	r_LaneIndexAtPtx9821 = uint32_t((threadIdx.x & 31u));								 // PTX L9821
	r_PtxRegister3252 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9821), uint32_t(31));	 // PTX L9823
	r_PtxRegister3253 = ShiftRight(uint32_t(r_PtxRegister3252), uint32_t(30));			 // PTX L9824
	r_PtxRegister3254 = uint32_t(r_LaneIndexAtPtx9821) + uint32_t(r_PtxRegister3253);	 // PTX L9825
	r_PtxRegister3255 = r_PtxRegister3254 & -4;											 // PTX L9826
	r_PtxRegister3256 = uint32_t(r_LaneIndexAtPtx9821) - uint32_t(r_PtxRegister3255);	 // PTX L9827
	r_PtxRegister23 = r_PtxRegister3232 | 12;											 // PTX L9828
	r_PtxRegister3257 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister3256);		 // PTX L9829
	r_PtxU64Register264 = uint64_t(uint32_t(r_PtxRegister3257)) * uint64_t(uint32_t(4)); // PTX L9830
	g_RecordByteAddressAtPtx9831 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register264); // PTX L9831
	r_PtxRegister2820 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9831 + 61616ull);	 // PTX L9832
	r_LaneIndexAtPtx9834 = uint32_t((threadIdx.x & 31u));								 // PTX L9834
	r_PtxRegister3258 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9834), uint32_t(31));	 // PTX L9836
	r_PtxRegister3259 = ShiftRight(uint32_t(r_PtxRegister3258), uint32_t(30));			 // PTX L9837
	r_PtxRegister3260 = uint32_t(r_LaneIndexAtPtx9834) + uint32_t(r_PtxRegister3259);	 // PTX L9838
	r_PtxRegister3261 = r_PtxRegister3260 & -4;											 // PTX L9839
	r_PtxRegister3262 = uint32_t(r_LaneIndexAtPtx9834) - uint32_t(r_PtxRegister3261);	 // PTX L9840
	r_PtxRegister3263 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister3262);		 // PTX L9841
	r_PtxU64Register266 = uint64_t(uint32_t(r_PtxRegister3263)) * uint64_t(uint32_t(4)); // PTX L9842
	g_RecordByteAddressAtPtx9843 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register266); // PTX L9843
	r_PtxRegister2823 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9843 + 61616ull);		   // PTX L9844
	r_LaneIndexAtPtx9846 = uint32_t((threadIdx.x & 31u));									   // PTX L9846
	r_PtxRegister3264 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9846), uint32_t(31));		   // PTX L9848
	r_PtxRegister3265 = ShiftRight(uint32_t(r_PtxRegister3264), uint32_t(30));				   // PTX L9849
	r_PtxRegister3266 = uint32_t(r_LaneIndexAtPtx9846) + uint32_t(r_PtxRegister3265);		   // PTX L9850
	r_PtxRegister3267 = r_PtxRegister3266 & 2147483644;										   // PTX L9851
	r_PtxRegister3268 = uint32_t(r_LaneIndexAtPtx9846) - uint32_t(r_PtxRegister3267);		   // PTX L9852
	r_PtxRegister3269 = ShiftLeft(uint32_t(r_PtxRegister3268), uint32_t(1));				   // PTX L9853
	r_PtxRegister3270 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister3269);			   // PTX L9854
	r_PtxRegister3271 = ShiftRightSigned(int32_t(r_PtxRegister3270), uint32_t(1));			   // PTX L9855
	r_PtxU64Register268 = uint64_t(int64_t(int32_t(r_PtxRegister3271)) * int64_t(int32_t(4))); // PTX L9856
	g_RecordByteAddressAtPtx9857 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register268); // PTX L9857
	r_PtxRegister2826 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9857 + 61616ull);		   // PTX L9858
	r_LaneIndexAtPtx9860 = uint32_t((threadIdx.x & 31u));									   // PTX L9860
	r_PtxRegister3272 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9860), uint32_t(31));		   // PTX L9862
	r_PtxRegister3273 = ShiftRight(uint32_t(r_PtxRegister3272), uint32_t(30));				   // PTX L9863
	r_PtxRegister3274 = uint32_t(r_LaneIndexAtPtx9860) + uint32_t(r_PtxRegister3273);		   // PTX L9864
	r_PtxRegister3275 = r_PtxRegister3274 & 2147483644;										   // PTX L9865
	r_PtxRegister3276 = uint32_t(r_LaneIndexAtPtx9860) - uint32_t(r_PtxRegister3275);		   // PTX L9866
	r_PtxRegister3277 = ShiftLeft(uint32_t(r_PtxRegister3276), uint32_t(1));				   // PTX L9867
	r_PtxRegister3278 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister3277);			   // PTX L9868
	r_PtxRegister3279 = ShiftRightSigned(int32_t(r_PtxRegister3278), uint32_t(1));			   // PTX L9869
	r_PtxU64Register270 = uint64_t(int64_t(int32_t(r_PtxRegister3279)) * int64_t(int32_t(4))); // PTX L9870
	g_RecordByteAddressAtPtx9871 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register270); // PTX L9871
	r_PtxRegister2829 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9871 + 61616ull);	 // PTX L9872
	r_LaneIndexAtPtx9874 = uint32_t((threadIdx.x & 31u));								 // PTX L9874
	r_PtxRegister3280 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9874), uint32_t(31));	 // PTX L9876
	r_PtxRegister3281 = ShiftRight(uint32_t(r_PtxRegister3280), uint32_t(30));			 // PTX L9877
	r_PtxRegister3282 = uint32_t(r_LaneIndexAtPtx9874) + uint32_t(r_PtxRegister3281);	 // PTX L9878
	r_PtxRegister3283 = r_PtxRegister3282 & -4;											 // PTX L9879
	r_PtxRegister3284 = uint32_t(r_LaneIndexAtPtx9874) - uint32_t(r_PtxRegister3283);	 // PTX L9880
	r_PtxRegister3285 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister3284);		 // PTX L9881
	r_PtxU64Register272 = uint64_t(uint32_t(r_PtxRegister3285)) * uint64_t(uint32_t(4)); // PTX L9882
	g_RecordByteAddressAtPtx9883 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register272); // PTX L9883
	r_PtxRegister2832 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9883 + 61616ull);	 // PTX L9884
	r_LaneIndexAtPtx9886 = uint32_t((threadIdx.x & 31u));								 // PTX L9886
	r_PtxRegister3286 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9886), uint32_t(31));	 // PTX L9888
	r_PtxRegister3287 = ShiftRight(uint32_t(r_PtxRegister3286), uint32_t(30));			 // PTX L9889
	r_PtxRegister3288 = uint32_t(r_LaneIndexAtPtx9886) + uint32_t(r_PtxRegister3287);	 // PTX L9890
	r_PtxRegister3289 = r_PtxRegister3288 & -4;											 // PTX L9891
	r_PtxRegister3290 = uint32_t(r_LaneIndexAtPtx9886) - uint32_t(r_PtxRegister3289);	 // PTX L9892
	r_PtxRegister3291 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister3290);		 // PTX L9893
	r_PtxU64Register274 = uint64_t(uint32_t(r_PtxRegister3291)) * uint64_t(uint32_t(4)); // PTX L9894
	g_RecordByteAddressAtPtx9895 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register274); // PTX L9895
	r_PtxRegister2835 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9895 + 61616ull);	 // PTX L9896
	r_LaneIndexAtPtx9898 = uint32_t((threadIdx.x & 31u));								 // PTX L9898
	r_PtxRegister3292 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9898), uint32_t(31));	 // PTX L9900
	r_PtxRegister3293 = ShiftRight(uint32_t(r_PtxRegister3292), uint32_t(30));			 // PTX L9901
	r_PtxRegister3294 = uint32_t(r_LaneIndexAtPtx9898) + uint32_t(r_PtxRegister3293);	 // PTX L9902
	r_PtxRegister3295 = r_PtxRegister3294 & -4;											 // PTX L9903
	r_PtxRegister3296 = uint32_t(r_LaneIndexAtPtx9898) - uint32_t(r_PtxRegister3295);	 // PTX L9904
	r_PtxRegister3297 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister3296);		 // PTX L9905
	r_PtxU64Register276 = uint64_t(uint32_t(r_PtxRegister3297)) * uint64_t(uint32_t(4)); // PTX L9906
	g_RecordByteAddressAtPtx9907 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register276); // PTX L9907
	r_PtxRegister2838 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9907 + 61616ull);	 // PTX L9908
	r_LaneIndexAtPtx9910 = uint32_t((threadIdx.x & 31u));								 // PTX L9910
	r_PtxRegister3298 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9910), uint32_t(31));	 // PTX L9912
	r_PtxRegister3299 = ShiftRight(uint32_t(r_PtxRegister3298), uint32_t(30));			 // PTX L9913
	r_PtxRegister3300 = uint32_t(r_LaneIndexAtPtx9910) + uint32_t(r_PtxRegister3299);	 // PTX L9914
	r_PtxRegister3301 = r_PtxRegister3300 & -4;											 // PTX L9915
	r_PtxRegister3302 = uint32_t(r_LaneIndexAtPtx9910) - uint32_t(r_PtxRegister3301);	 // PTX L9916
	r_PtxRegister3303 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister3302);		 // PTX L9917
	r_PtxU64Register278 = uint64_t(uint32_t(r_PtxRegister3303)) * uint64_t(uint32_t(4)); // PTX L9918
	g_RecordByteAddressAtPtx9919 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register278); // PTX L9919
	r_PtxRegister2841 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9919 + 61616ull);	 // PTX L9920
	r_LaneIndexAtPtx9922 = uint32_t((threadIdx.x & 31u));								 // PTX L9922
	r_PtxRegister3304 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9922), uint32_t(31));	 // PTX L9924
	r_PtxRegister3305 = ShiftRight(uint32_t(r_PtxRegister3304), uint32_t(30));			 // PTX L9925
	r_PtxRegister3306 = uint32_t(r_LaneIndexAtPtx9922) + uint32_t(r_PtxRegister3305);	 // PTX L9926
	r_PtxRegister3307 = r_PtxRegister3306 & -4;											 // PTX L9927
	r_PtxRegister3308 = uint32_t(r_LaneIndexAtPtx9922) - uint32_t(r_PtxRegister3307);	 // PTX L9928
	r_PtxRegister3309 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister3308);		 // PTX L9929
	r_PtxU64Register280 = uint64_t(uint32_t(r_PtxRegister3309)) * uint64_t(uint32_t(4)); // PTX L9930
	g_RecordByteAddressAtPtx9931 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register280); // PTX L9931
	r_PtxRegister2844 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9931 + 61616ull);	 // PTX L9932
	r_LaneIndexAtPtx9934 = uint32_t((threadIdx.x & 31u));								 // PTX L9934
	r_PtxRegister3310 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx9934), uint32_t(31));	 // PTX L9936
	r_PtxRegister3311 = ShiftRight(uint32_t(r_PtxRegister3310), uint32_t(30));			 // PTX L9937
	r_PtxRegister3312 = uint32_t(r_LaneIndexAtPtx9934) + uint32_t(r_PtxRegister3311);	 // PTX L9938
	r_PtxRegister3313 = r_PtxRegister3312 & -4;											 // PTX L9939
	r_PtxRegister3314 = uint32_t(r_LaneIndexAtPtx9934) - uint32_t(r_PtxRegister3313);	 // PTX L9940
	r_PtxRegister3315 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister3314);		 // PTX L9941
	r_PtxU64Register282 = uint64_t(uint32_t(r_PtxRegister3315)) * uint64_t(uint32_t(4)); // PTX L9942
	g_RecordByteAddressAtPtx9943 =
		uint64_t(g_RecordByteAddressAtPtx5181) + uint64_t(r_PtxU64Register282); // PTX L9943
	r_PtxRegister2847 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx9943 + 61616ull);		// PTX L9944
	r_LaneIndexAtPtx9946 = uint32_t((threadIdx.x & 31u));									// PTX L9946
	r_PackedHalf2AtPtx9949R2888 = HalfMul(r_PackedHalf2AtPtx9687R2801, r_PtxRegister2802);	// PTX L9949
	r_LaneIndexAtPtx9953 = uint32_t((threadIdx.x & 31u));									// PTX L9953
	r_PackedHalf2AtPtx9956R2889 = HalfMul(r_PackedHalf2AtPtx9694R2804, r_PtxRegister2805);	// PTX L9956
	r_LaneIndexAtPtx9960 = uint32_t((threadIdx.x & 31u));									// PTX L9960
	r_PackedHalf2AtPtx9963R2892 = HalfMul(r_PackedHalf2AtPtx9690R2807, r_PtxRegister2808);	// PTX L9963
	r_LaneIndexAtPtx9967 = uint32_t((threadIdx.x & 31u));									// PTX L9967
	r_PackedHalf2AtPtx9970R2893 = HalfMul(r_PackedHalf2AtPtx9697R2810, r_PtxRegister2811);	// PTX L9970
	r_LaneIndexAtPtx9974 = uint32_t((threadIdx.x & 31u));									// PTX L9974
	r_PackedHalf2AtPtx9977R2896 = HalfMul(r_PackedHalf2AtPtx9701R2813, r_PtxRegister2814);	// PTX L9977
	r_LaneIndexAtPtx9981 = uint32_t((threadIdx.x & 31u));									// PTX L9981
	r_PackedHalf2AtPtx9984R2897 = HalfMul(r_PackedHalf2AtPtx9708R2816, r_PtxRegister2817);	// PTX L9984
	r_LaneIndexAtPtx9988 = uint32_t((threadIdx.x & 31u));									// PTX L9988
	r_PackedHalf2AtPtx9991R2900 = HalfMul(r_PackedHalf2AtPtx9704R2819, r_PtxRegister2820);	// PTX L9991
	r_LaneIndexAtPtx9995 = uint32_t((threadIdx.x & 31u));									// PTX L9995
	r_PackedHalf2AtPtx9998R2901 = HalfMul(r_PackedHalf2AtPtx9711R2822, r_PtxRegister2823);	// PTX L9998
	r_LaneIndexAtPtx10002 = uint32_t((threadIdx.x & 31u));									// PTX L10002
	r_PackedHalf2AtPtx10005R2906 = HalfMul(r_PackedHalf2AtPtx9715R2825, r_PtxRegister2826); // PTX L10005
	r_LaneIndexAtPtx10009 = uint32_t((threadIdx.x & 31u));									// PTX L10009
	r_PackedHalf2AtPtx10012R2907 = HalfMul(r_PackedHalf2AtPtx9722R2828, r_PtxRegister2829); // PTX L10012
	r_LaneIndexAtPtx10016 = uint32_t((threadIdx.x & 31u));									// PTX L10016
	r_PackedHalf2AtPtx10019R2908 = HalfMul(r_PackedHalf2AtPtx9718R2831, r_PtxRegister2832); // PTX L10019
	r_LaneIndexAtPtx10023 = uint32_t((threadIdx.x & 31u));									// PTX L10023
	r_PackedHalf2AtPtx10026R2909 = HalfMul(r_PackedHalf2AtPtx9725R2834, r_PtxRegister2835); // PTX L10026
	r_LaneIndexAtPtx10030 = uint32_t((threadIdx.x & 31u));									// PTX L10030
	r_PackedHalf2AtPtx10033R2910 = HalfMul(r_PackedHalf2AtPtx9729R2837, r_PtxRegister2838); // PTX L10033
	r_LaneIndexAtPtx10037 = uint32_t((threadIdx.x & 31u));									// PTX L10037
	r_PackedHalf2AtPtx10040R2911 = HalfMul(r_PackedHalf2AtPtx9736R2840, r_PtxRegister2841); // PTX L10040
	r_LaneIndexAtPtx10044 = uint32_t((threadIdx.x & 31u));									// PTX L10044
	r_PackedHalf2AtPtx10047R2912 = HalfMul(r_PackedHalf2AtPtx9732R2843, r_PtxRegister2844); // PTX L10047
	r_LaneIndexAtPtx10051 = uint32_t((threadIdx.x & 31u));									// PTX L10051
	r_PackedHalf2AtPtx10054R2913 = HalfMul(r_PackedHalf2AtPtx9739R2846, r_PtxRegister2847); // PTX L10054
	r_ConvertedE4PairAtPtx10058Rs338 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9569R2848);	// PTX L10058
	r_ConvertedE4PairAtPtx10061Rs339 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9576R2849);	// PTX L10061
	r_PackedE4WordAtPtx10063R2866 = JoinConvertedE4(r_ConvertedE4PairAtPtx10058Rs338,
													r_ConvertedE4PairAtPtx10061Rs339);	   // PTX L10063
	r_ConvertedE4PairAtPtx10065Rs340 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9569R2850); // PTX L10065
	r_ConvertedE4PairAtPtx10068Rs341 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9576R2851); // PTX L10068
	r_PackedE4WordAtPtx10070R2867 = JoinConvertedE4(r_ConvertedE4PairAtPtx10065Rs340,
													r_ConvertedE4PairAtPtx10068Rs341);	   // PTX L10070
	r_ConvertedE4PairAtPtx10072Rs342 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9597R2852); // PTX L10072
	r_ConvertedE4PairAtPtx10075Rs343 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9604R2853); // PTX L10075
	r_PackedE4WordAtPtx10077R2868 = JoinConvertedE4(r_ConvertedE4PairAtPtx10072Rs342,
													r_ConvertedE4PairAtPtx10075Rs343);	   // PTX L10077
	r_ConvertedE4PairAtPtx10079Rs344 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9597R2854); // PTX L10079
	r_ConvertedE4PairAtPtx10082Rs345 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9604R2855); // PTX L10082
	r_PackedE4WordAtPtx10084R2869 = JoinConvertedE4(r_ConvertedE4PairAtPtx10079Rs344,
													r_ConvertedE4PairAtPtx10082Rs345);	   // PTX L10084
	r_ConvertedE4PairAtPtx10086Rs346 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9625R2856); // PTX L10086
	r_ConvertedE4PairAtPtx10089Rs347 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9632R2857); // PTX L10089
	r_PackedE4WordAtPtx10091R2872 = JoinConvertedE4(r_ConvertedE4PairAtPtx10086Rs346,
													r_ConvertedE4PairAtPtx10089Rs347);	   // PTX L10091
	r_ConvertedE4PairAtPtx10093Rs348 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9625R2858); // PTX L10093
	r_ConvertedE4PairAtPtx10096Rs349 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9632R2859); // PTX L10096
	r_PackedE4WordAtPtx10098R2873 = JoinConvertedE4(r_ConvertedE4PairAtPtx10093Rs348,
													r_ConvertedE4PairAtPtx10096Rs349);	   // PTX L10098
	r_ConvertedE4PairAtPtx10100Rs350 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9653R2860); // PTX L10100
	r_ConvertedE4PairAtPtx10103Rs351 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9660R2861); // PTX L10103
	r_PackedE4WordAtPtx10105R2874 = JoinConvertedE4(r_ConvertedE4PairAtPtx10100Rs350,
													r_ConvertedE4PairAtPtx10103Rs351);	   // PTX L10105
	r_ConvertedE4PairAtPtx10107Rs352 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9653R2862); // PTX L10107
	r_ConvertedE4PairAtPtx10110Rs353 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx9660R2863); // PTX L10110
	r_PackedE4WordAtPtx10112R2875 = JoinConvertedE4(r_ConvertedE4PairAtPtx10107Rs352,
													r_ConvertedE4PairAtPtx10110Rs353); // PTX L10112
	r_LaneIndexAtPtx10114 = uint32_t((threadIdx.x & 31u));							   // PTX L10114
	r_PtxRegister3316 = ShiftLeft(uint32_t(r_LaneIndexAtPtx10114), uint32_t(4));	   // PTX L10116
	r_PtxRegister2865 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister3316);	   // PTX L10117
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2865)) =
		make_uint4(r_PackedE4WordAtPtx10063R2866, r_PackedE4WordAtPtx10070R2867,
				   r_PackedE4WordAtPtx10077R2868, r_PackedE4WordAtPtx10084R2869); // PTX L10119
	r_LaneIndexAtPtx10122 = uint32_t((threadIdx.x & 31u));						  // PTX L10122
	r_PtxRegister3317 = ShiftLeft(uint32_t(r_LaneIndexAtPtx10122), uint32_t(4));  // PTX L10124
	r_PtxRegister3318 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister3317);  // PTX L10125
	r_PtxRegister2871 = uint32_t(r_PtxRegister3318) + uint32_t(1024);			  // PTX L10126
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2871)) =
		make_uint4(r_PackedE4WordAtPtx10091R2872, r_PackedE4WordAtPtx10098R2873,
				   r_PackedE4WordAtPtx10105R2874, r_PackedE4WordAtPtx10112R2875); // PTX L10128

	// Attention publication / final projection for first spatial half
	__syncthreads();																	 // PTX L10130
	r_PtxRegister3319 = ShiftLeft(uint32_t(r_ThreadYAtPtx4287), uint32_t(8));			 // PTX L10131
	r_PtxU64Register284 = uint64_t(uint32_t(r_PtxRegister3319)) * uint64_t(uint32_t(4)); // PTX L10132
	g_RecordByteAddressAtPtx10133 =
		uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register284); // PTX L10133
	r_LaneIndexAtPtx10135 = uint32_t((threadIdx.x & 31u));			   // PTX L10135
	r_PtxU64Register285 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10135)) * int64_t(int32_t(16))); // PTX L10137
	g_RecordByteAddressAtPtx10138 =
		uint64_t(g_RecordByteAddressAtPtx10133) + uint64_t(r_PtxU64Register285);			   // PTX L10138
	g_RecordByteAddressAtPtx10139 = uint64_t(g_RecordByteAddressAtPtx10138) + uint64_t(57520); // PTX L10139
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10139));
		r_MmaBE4x4WordAtPtx10141R2886 = r_Value.x;
		r_MmaBE4x4WordAtPtx10141R2887 = r_Value.y;
		r_MmaBE4x4WordAtPtx10141R2890 = r_Value.z;
		r_MmaBE4x4WordAtPtx10141R2891 = r_Value.w;
	} // PTX L10141
	r_LaneIndexAtPtx10144 = uint32_t((threadIdx.x & 31u)); // PTX L10144
	r_PtxU64Register287 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10144)) * int64_t(int32_t(16))); // PTX L10146
	g_RecordByteAddressAtPtx10147 =
		uint64_t(g_RecordByteAddressAtPtx10133) + uint64_t(r_PtxU64Register287);			   // PTX L10147
	g_RecordByteAddressAtPtx10148 = uint64_t(g_RecordByteAddressAtPtx10147) + uint64_t(58032); // PTX L10148
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10148));
		r_MmaBE4x4WordAtPtx10150R2894 = r_Value.x;
		r_MmaBE4x4WordAtPtx10150R2895 = r_Value.y;
		r_MmaBE4x4WordAtPtx10150R2898 = r_Value.z;
		r_MmaBE4x4WordAtPtx10150R2899 = r_Value.w;
	} // PTX L10150
	r_LaneIndexAtPtx10153 = uint32_t((threadIdx.x & 31u));						   // PTX L10153
	r_PtxRegister3320 = ShiftLeft(uint32_t(r_LaneIndexAtPtx10153), uint32_t(4));   // PTX L10155
	r_PtxRegister2879 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister3320); // PTX L10156
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2879));
		r_MmaAE4x4WordAtPtx10158R2882 = r_Value.x;
		r_MmaAE4x4WordAtPtx10158R2883 = r_Value.y;
		r_MmaAE4x4WordAtPtx10158R2884 = r_Value.z;
		r_MmaAE4x4WordAtPtx10158R2885 = r_Value.w;
	} // PTX L10158
	r_LaneIndexAtPtx10161 = uint32_t((threadIdx.x & 31u));						   // PTX L10161
	r_PtxRegister3321 = ShiftLeft(uint32_t(r_LaneIndexAtPtx10161), uint32_t(4));   // PTX L10163
	r_PtxRegister3322 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister3321); // PTX L10164
	r_PtxRegister2881 = uint32_t(r_PtxRegister3322) + uint32_t(1024);			   // PTX L10165
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2881));
		r_MmaAE4x4WordAtPtx10167R2902 = r_Value.x;
		r_MmaAE4x4WordAtPtx10167R2903 = r_Value.y;
		r_MmaAE4x4WordAtPtx10167R2904 = r_Value.z;
		r_MmaAE4x4WordAtPtx10167R2905 = r_Value.w;
	} // PTX L10167
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10170R2926, r_MmaAccumulatorHalf2WordAtPtx10170R2927,
		  r_MmaAE4x4WordAtPtx10158R2882, r_MmaAE4x4WordAtPtx10158R2883, r_MmaAE4x4WordAtPtx10158R2884,
		  r_MmaAE4x4WordAtPtx10158R2885, r_MmaBE4x4WordAtPtx10141R2886, r_MmaBE4x4WordAtPtx10141R2887,
		  r_PackedHalf2AtPtx9949R2888, r_PackedHalf2AtPtx9956R2889); // PTX L10170
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10177R2930, r_MmaAccumulatorHalf2WordAtPtx10177R2931,
		  r_MmaAE4x4WordAtPtx10158R2882, r_MmaAE4x4WordAtPtx10158R2883, r_MmaAE4x4WordAtPtx10158R2884,
		  r_MmaAE4x4WordAtPtx10158R2885, r_MmaBE4x4WordAtPtx10141R2890, r_MmaBE4x4WordAtPtx10141R2891,
		  r_PackedHalf2AtPtx9963R2892, r_PackedHalf2AtPtx9970R2893); // PTX L10177
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10184R2934, r_MmaAccumulatorHalf2WordAtPtx10184R2935,
		  r_MmaAE4x4WordAtPtx10158R2882, r_MmaAE4x4WordAtPtx10158R2883, r_MmaAE4x4WordAtPtx10158R2884,
		  r_MmaAE4x4WordAtPtx10158R2885, r_MmaBE4x4WordAtPtx10150R2894, r_MmaBE4x4WordAtPtx10150R2895,
		  r_PackedHalf2AtPtx9977R2896, r_PackedHalf2AtPtx9984R2897); // PTX L10184
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10191R2938, r_MmaAccumulatorHalf2WordAtPtx10191R2939,
		  r_MmaAE4x4WordAtPtx10158R2882, r_MmaAE4x4WordAtPtx10158R2883, r_MmaAE4x4WordAtPtx10158R2884,
		  r_MmaAE4x4WordAtPtx10158R2885, r_MmaBE4x4WordAtPtx10150R2898, r_MmaBE4x4WordAtPtx10150R2899,
		  r_PackedHalf2AtPtx9991R2900, r_PackedHalf2AtPtx9998R2901); // PTX L10191
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10198R2944, r_MmaAccumulatorHalf2WordAtPtx10198R2945,
		  r_MmaAE4x4WordAtPtx10167R2902, r_MmaAE4x4WordAtPtx10167R2903, r_MmaAE4x4WordAtPtx10167R2904,
		  r_MmaAE4x4WordAtPtx10167R2905, r_MmaBE4x4WordAtPtx10141R2886, r_MmaBE4x4WordAtPtx10141R2887,
		  r_PackedHalf2AtPtx10005R2906, r_PackedHalf2AtPtx10012R2907); // PTX L10198
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10205R2946, r_MmaAccumulatorHalf2WordAtPtx10205R2947,
		  r_MmaAE4x4WordAtPtx10167R2902, r_MmaAE4x4WordAtPtx10167R2903, r_MmaAE4x4WordAtPtx10167R2904,
		  r_MmaAE4x4WordAtPtx10167R2905, r_MmaBE4x4WordAtPtx10141R2890, r_MmaBE4x4WordAtPtx10141R2891,
		  r_PackedHalf2AtPtx10019R2908, r_PackedHalf2AtPtx10026R2909); // PTX L10205
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10212R2948, r_MmaAccumulatorHalf2WordAtPtx10212R2949,
		  r_MmaAE4x4WordAtPtx10167R2902, r_MmaAE4x4WordAtPtx10167R2903, r_MmaAE4x4WordAtPtx10167R2904,
		  r_MmaAE4x4WordAtPtx10167R2905, r_MmaBE4x4WordAtPtx10150R2894, r_MmaBE4x4WordAtPtx10150R2895,
		  r_PackedHalf2AtPtx10033R2910, r_PackedHalf2AtPtx10040R2911); // PTX L10212
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10219R2950, r_MmaAccumulatorHalf2WordAtPtx10219R2951,
		  r_MmaAE4x4WordAtPtx10167R2902, r_MmaAE4x4WordAtPtx10167R2903, r_MmaAE4x4WordAtPtx10167R2904,
		  r_MmaAE4x4WordAtPtx10167R2905, r_MmaBE4x4WordAtPtx10150R2898, r_MmaBE4x4WordAtPtx10150R2899,
		  r_PackedHalf2AtPtx10047R2912, r_PackedHalf2AtPtx10054R2913); // PTX L10219
	r_LaneIndexAtPtx10226 = uint32_t((threadIdx.x & 31u));			   // PTX L10226
	r_PtxU64Register289 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10226)) * int64_t(int32_t(16))); // PTX L10228
	g_RecordByteAddressAtPtx10229 =
		uint64_t(g_RecordByteAddressAtPtx10133) + uint64_t(r_PtxU64Register289);			   // PTX L10229
	g_RecordByteAddressAtPtx10230 = uint64_t(g_RecordByteAddressAtPtx10229) + uint64_t(59568); // PTX L10230
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10230));
		r_MmaBE4x4WordAtPtx10232R2924 = r_Value.x;
		r_MmaBE4x4WordAtPtx10232R2925 = r_Value.y;
		r_MmaBE4x4WordAtPtx10232R2928 = r_Value.z;
		r_MmaBE4x4WordAtPtx10232R2929 = r_Value.w;
	} // PTX L10232
	r_LaneIndexAtPtx10235 = uint32_t((threadIdx.x & 31u)); // PTX L10235
	r_PtxU64Register291 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10235)) * int64_t(int32_t(16))); // PTX L10237
	g_RecordByteAddressAtPtx10238 =
		uint64_t(g_RecordByteAddressAtPtx10133) + uint64_t(r_PtxU64Register291);			   // PTX L10238
	g_RecordByteAddressAtPtx10239 = uint64_t(g_RecordByteAddressAtPtx10238) + uint64_t(60080); // PTX L10239
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10239));
		r_MmaBE4x4WordAtPtx10241R2932 = r_Value.x;
		r_MmaBE4x4WordAtPtx10241R2933 = r_Value.y;
		r_MmaBE4x4WordAtPtx10241R2936 = r_Value.z;
		r_MmaBE4x4WordAtPtx10241R2937 = r_Value.w;
	} // PTX L10241
	r_LaneIndexAtPtx10244 = uint32_t((threadIdx.x & 31u));						   // PTX L10244
	r_PtxRegister3323 = ShiftLeft(uint32_t(r_LaneIndexAtPtx10244), uint32_t(4));   // PTX L10246
	r_PtxRegister3324 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister3323); // PTX L10247
	r_PtxRegister2917 = uint32_t(r_PtxRegister3324) + uint32_t(512);			   // PTX L10248
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2917));
		r_MmaAE4x4WordAtPtx10250R2920 = r_Value.x;
		r_MmaAE4x4WordAtPtx10250R2921 = r_Value.y;
		r_MmaAE4x4WordAtPtx10250R2922 = r_Value.z;
		r_MmaAE4x4WordAtPtx10250R2923 = r_Value.w;
	} // PTX L10250
	r_LaneIndexAtPtx10253 = uint32_t((threadIdx.x & 31u));						   // PTX L10253
	r_PtxRegister3325 = ShiftLeft(uint32_t(r_LaneIndexAtPtx10253), uint32_t(4));   // PTX L10255
	r_PtxRegister3326 = uint32_t(r_PtxRegister2969) + uint32_t(r_PtxRegister3325); // PTX L10256
	r_PtxRegister2919 = uint32_t(r_PtxRegister3326) + uint32_t(1536);			   // PTX L10257
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2919));
		r_MmaAE4x4WordAtPtx10259R2940 = r_Value.x;
		r_MmaAE4x4WordAtPtx10259R2941 = r_Value.y;
		r_MmaAE4x4WordAtPtx10259R2942 = r_Value.z;
		r_MmaAE4x4WordAtPtx10259R2943 = r_Value.w;
	} // PTX L10259
	MmaE4(r_PtxRegister2952, r_PtxRegister2954, r_MmaAE4x4WordAtPtx10250R2920, r_MmaAE4x4WordAtPtx10250R2921,
		  r_MmaAE4x4WordAtPtx10250R2922, r_MmaAE4x4WordAtPtx10250R2923, r_MmaBE4x4WordAtPtx10232R2924,
		  r_MmaBE4x4WordAtPtx10232R2925, r_MmaAccumulatorHalf2WordAtPtx10170R2926,
		  r_MmaAccumulatorHalf2WordAtPtx10170R2927); // PTX L10262
	MmaE4(r_PtxRegister2953, r_PtxRegister2955, r_MmaAE4x4WordAtPtx10250R2920, r_MmaAE4x4WordAtPtx10250R2921,
		  r_MmaAE4x4WordAtPtx10250R2922, r_MmaAE4x4WordAtPtx10250R2923, r_MmaBE4x4WordAtPtx10232R2928,
		  r_MmaBE4x4WordAtPtx10232R2929, r_MmaAccumulatorHalf2WordAtPtx10177R2930,
		  r_MmaAccumulatorHalf2WordAtPtx10177R2931); // PTX L10269
	MmaE4(r_PtxRegister2956, r_PtxRegister2958, r_MmaAE4x4WordAtPtx10250R2920, r_MmaAE4x4WordAtPtx10250R2921,
		  r_MmaAE4x4WordAtPtx10250R2922, r_MmaAE4x4WordAtPtx10250R2923, r_MmaBE4x4WordAtPtx10241R2932,
		  r_MmaBE4x4WordAtPtx10241R2933, r_MmaAccumulatorHalf2WordAtPtx10184R2934,
		  r_MmaAccumulatorHalf2WordAtPtx10184R2935); // PTX L10276
	MmaE4(r_PtxRegister2957, r_PtxRegister2959, r_MmaAE4x4WordAtPtx10250R2920, r_MmaAE4x4WordAtPtx10250R2921,
		  r_MmaAE4x4WordAtPtx10250R2922, r_MmaAE4x4WordAtPtx10250R2923, r_MmaBE4x4WordAtPtx10241R2936,
		  r_MmaBE4x4WordAtPtx10241R2937, r_MmaAccumulatorHalf2WordAtPtx10191R2938,
		  r_MmaAccumulatorHalf2WordAtPtx10191R2939); // PTX L10283
	MmaE4(r_PtxRegister2960, r_PtxRegister2962, r_MmaAE4x4WordAtPtx10259R2940, r_MmaAE4x4WordAtPtx10259R2941,
		  r_MmaAE4x4WordAtPtx10259R2942, r_MmaAE4x4WordAtPtx10259R2943, r_MmaBE4x4WordAtPtx10232R2924,
		  r_MmaBE4x4WordAtPtx10232R2925, r_MmaAccumulatorHalf2WordAtPtx10198R2944,
		  r_MmaAccumulatorHalf2WordAtPtx10198R2945); // PTX L10290
	MmaE4(r_PtxRegister2961, r_PtxRegister2963, r_MmaAE4x4WordAtPtx10259R2940, r_MmaAE4x4WordAtPtx10259R2941,
		  r_MmaAE4x4WordAtPtx10259R2942, r_MmaAE4x4WordAtPtx10259R2943, r_MmaBE4x4WordAtPtx10232R2928,
		  r_MmaBE4x4WordAtPtx10232R2929, r_MmaAccumulatorHalf2WordAtPtx10205R2946,
		  r_MmaAccumulatorHalf2WordAtPtx10205R2947); // PTX L10297
	MmaE4(r_PtxRegister2964, r_PtxRegister2966, r_MmaAE4x4WordAtPtx10259R2940, r_MmaAE4x4WordAtPtx10259R2941,
		  r_MmaAE4x4WordAtPtx10259R2942, r_MmaAE4x4WordAtPtx10259R2943, r_MmaBE4x4WordAtPtx10241R2932,
		  r_MmaBE4x4WordAtPtx10241R2933, r_MmaAccumulatorHalf2WordAtPtx10212R2948,
		  r_MmaAccumulatorHalf2WordAtPtx10212R2949); // PTX L10304
	MmaE4(r_PtxRegister2965, r_PtxRegister2967, r_MmaAE4x4WordAtPtx10259R2940, r_MmaAE4x4WordAtPtx10259R2941,
		  r_MmaAE4x4WordAtPtx10259R2942, r_MmaAE4x4WordAtPtx10259R2943, r_MmaBE4x4WordAtPtx10241R2936,
		  r_MmaBE4x4WordAtPtx10241R2937, r_MmaAccumulatorHalf2WordAtPtx10219R2950,
		  r_MmaAccumulatorHalf2WordAtPtx10219R2951);						 // PTX L10311
	r_ConvertedE4PairAtPtx10318Rs354 = PublishE4(r_PtxRegister2952);		 // PTX L10318
	r_ConvertedE4PairAtPtx10321Rs355 = PublishE4(r_PtxRegister2953);		 // PTX L10321
	r_ConvertedE4PairAtPtx10324Rs356 = PublishE4(r_PtxRegister2954);		 // PTX L10324
	r_ConvertedE4PairAtPtx10327Rs357 = PublishE4(r_PtxRegister2955);		 // PTX L10327
	r_ConvertedE4PairAtPtx10330Rs358 = PublishE4(r_PtxRegister2956);		 // PTX L10330
	r_ConvertedE4PairAtPtx10333Rs359 = PublishE4(r_PtxRegister2957);		 // PTX L10333
	r_ConvertedE4PairAtPtx10336Rs360 = PublishE4(r_PtxRegister2958);		 // PTX L10336
	r_ConvertedE4PairAtPtx10339Rs361 = PublishE4(r_PtxRegister2959);		 // PTX L10339
	r_ConvertedE4PairAtPtx10342Rs362 = PublishE4(r_PtxRegister2960);		 // PTX L10342
	r_ConvertedE4PairAtPtx10345Rs363 = PublishE4(r_PtxRegister2961);		 // PTX L10345
	r_ConvertedE4PairAtPtx10348Rs364 = PublishE4(r_PtxRegister2962);		 // PTX L10348
	r_ConvertedE4PairAtPtx10351Rs365 = PublishE4(r_PtxRegister2963);		 // PTX L10351
	r_ConvertedE4PairAtPtx10354Rs366 = PublishE4(r_PtxRegister2964);		 // PTX L10354
	r_ConvertedE4PairAtPtx10357Rs367 = PublishE4(r_PtxRegister2965);		 // PTX L10357
	r_ConvertedE4PairAtPtx10360Rs368 = PublishE4(r_PtxRegister2966);		 // PTX L10360
	r_ConvertedE4PairAtPtx10363Rs369 = PublishE4(r_PtxRegister2967);		 // PTX L10363
	r_CtaYAtPtx10365 = uint32_t(blockIdx.y);								 // PTX L10365
	r_PtxRegister3328 = ShiftLeft(uint32_t(r_CtaYAtPtx10365), uint32_t(3));	 // PTX L10366
	r_PtxRegister24 = uint32_t(r_OriginYBits) + uint32_t(r_PtxRegister3328); // PTX L10367
	r_bPtxPredicate79 = int32_t(r_PtxRegister24) > int32_t(-4);				 // PTX L10368
	r_bPtxPredicate80 = int32_t(r_PtxRegister2) < int32_t(r_HeightDiv4Bits); // PTX L10369
	r_bPtxPredicate4 = r_bPtxPredicate79 & r_bPtxPredicate80;				 // PTX L10370
	r_bPtxPredicate81 = r_bPtxPredicate4 & r_bPtxPredicate1;				 // PTX L10371
	r_PtxRegister3329 =
		uint32_t(r_PtxRegister2) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister3);	   // PTX L10372
	r_PtxRegister25 = ShiftLeft(uint32_t(r_ThreadYAtPtx4287), uint32_t(7));					   // PTX L10373
	r_PtxRegister3330 = ShiftLeft(uint32_t(r_PtxRegister3329), uint32_t(8));				   // PTX L10374
	r_PtxRegister3331 = uint32_t(r_PtxRegister3330) + uint32_t(r_PtxRegister25);			   // PTX L10375
	r_PtxU64Register293 = uint64_t(int64_t(int32_t(r_PtxRegister3331)) * int64_t(int32_t(4))); // PTX L10376
	g_OutputByteAddressAtPtx10377 =
		uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register293); // PTX L10377
	r_bPtxPredicate82 = !r_bPtxPredicate81;							   // PTX L10378
	if (r_bPtxPredicate82)
	{
		goto L__BB11_24;
	} // PTX L10379
	r_PackedE4WordAtPtx10380R3336 = JoinConvertedE4(r_ConvertedE4PairAtPtx10336Rs360,
													r_ConvertedE4PairAtPtx10339Rs361); // PTX L10380
	r_PackedE4WordAtPtx10381R3335 = JoinConvertedE4(r_ConvertedE4PairAtPtx10330Rs358,
													r_ConvertedE4PairAtPtx10333Rs359); // PTX L10381
	r_PackedE4WordAtPtx10382R3334 = JoinConvertedE4(r_ConvertedE4PairAtPtx10324Rs356,
													r_ConvertedE4PairAtPtx10327Rs357); // PTX L10382
	r_PackedE4WordAtPtx10383R3333 = JoinConvertedE4(r_ConvertedE4PairAtPtx10318Rs354,
													r_ConvertedE4PairAtPtx10321Rs355); // PTX L10383
	r_LaneIndexAtPtx10385 = uint32_t((threadIdx.x & 31u));							   // PTX L10385
	r_PtxU64Register295 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10385)) * int64_t(int32_t(16))); // PTX L10387
	g_OutputByteAddressAtPtx10388 =
		uint64_t(g_OutputByteAddressAtPtx10377) + uint64_t(r_PtxU64Register295); // PTX L10388
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx10388,
					make_uint4(r_PackedE4WordAtPtx10383R3333, r_PackedE4WordAtPtx10382R3334,
							   r_PackedE4WordAtPtx10381R3335,
							   r_PackedE4WordAtPtx10380R3336)); // PTX L10390
L__BB11_24:														// PTX L10392
	r_bPtxPredicate83 = r_bPtxPredicate4 & r_bPtxPredicate2;	// PTX L10393
	r_bPtxPredicate84 = !r_bPtxPredicate83;						// PTX L10394
	if (r_bPtxPredicate84)
	{
		goto L__BB11_26;
	} // PTX L10395
	r_LaneIndexAtPtx10397 = uint32_t((threadIdx.x & 31u)); // PTX L10397
	r_PtxU64Register297 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10397)) * int64_t(int32_t(16))); // PTX L10399
	g_OutputByteAddressAtPtx10400 =
		uint64_t(g_OutputByteAddressAtPtx10377) + uint64_t(r_PtxU64Register297);			  // PTX L10400
	g_OutputByteAddressAtPtx10401 = uint64_t(g_OutputByteAddressAtPtx10400) + uint64_t(1024); // PTX L10401
	r_PackedE4WordAtPtx10402R3341 = JoinConvertedE4(r_ConvertedE4PairAtPtx10360Rs368,
													r_ConvertedE4PairAtPtx10363Rs369); // PTX L10402
	r_PackedE4WordAtPtx10403R3340 = JoinConvertedE4(r_ConvertedE4PairAtPtx10354Rs366,
													r_ConvertedE4PairAtPtx10357Rs367); // PTX L10403
	r_PackedE4WordAtPtx10404R3339 = JoinConvertedE4(r_ConvertedE4PairAtPtx10348Rs364,
													r_ConvertedE4PairAtPtx10351Rs365); // PTX L10404
	r_PackedE4WordAtPtx10405R3338 = JoinConvertedE4(r_ConvertedE4PairAtPtx10342Rs362,
													r_ConvertedE4PairAtPtx10345Rs363); // PTX L10405
	StoreNoAllocate(g_OutputByteAddressAtPtx10401,
					make_uint4(r_PackedE4WordAtPtx10405R3338, r_PackedE4WordAtPtx10404R3339,
							   r_PackedE4WordAtPtx10403R3340,
							   r_PackedE4WordAtPtx10402R3341)); // PTX L10407
L__BB11_26:														// PTX L10409
	r_MmaAE4x4WordAtPtx10410R3352 = JoinConvertedE4(r_ConvertedE4PairAtPtx6584Rs209,
													r_ConvertedE4PairAtPtx6587Rs210); // PTX L10410
	r_MmaAE4x4WordAtPtx10411R3353 = JoinConvertedE4(r_ConvertedE4PairAtPtx6590Rs211,
													r_ConvertedE4PairAtPtx6593Rs212); // PTX L10411
	r_MmaAE4x4WordAtPtx10412R3354 = JoinConvertedE4(r_ConvertedE4PairAtPtx6596Rs213,
													r_ConvertedE4PairAtPtx6599Rs214); // PTX L10412
	r_MmaAE4x4WordAtPtx10413R3355 = JoinConvertedE4(r_ConvertedE4PairAtPtx6602Rs215,
													r_ConvertedE4PairAtPtx6605Rs216); // PTX L10413
	r_MmaAE4x4WordAtPtx10414R3372 = JoinConvertedE4(r_ConvertedE4PairAtPtx6608Rs217,
													r_ConvertedE4PairAtPtx6611Rs218); // PTX L10414
	r_MmaAE4x4WordAtPtx10415R3373 = JoinConvertedE4(r_ConvertedE4PairAtPtx6614Rs219,
													r_ConvertedE4PairAtPtx6617Rs220); // PTX L10415
	r_MmaAE4x4WordAtPtx10416R3374 = JoinConvertedE4(r_ConvertedE4PairAtPtx6620Rs221,
													r_ConvertedE4PairAtPtx6623Rs222); // PTX L10416
	r_MmaAE4x4WordAtPtx10417R3375 = JoinConvertedE4(r_ConvertedE4PairAtPtx6626Rs223,
													r_ConvertedE4PairAtPtx6629Rs224); // PTX L10417

	// Second spatial half attention and final projection
	__syncthreads();									   // PTX L10418
	r_LaneIndexAtPtx10420 = uint32_t((threadIdx.x & 31u)); // PTX L10420
	r_PtxU64Register311 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10420)) * int64_t(int32_t(16))); // PTX L10422
	g_RecordByteAddressAtPtx10423 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register311);				   // PTX L10423
	g_RecordByteAddressAtPtx10424 = uint64_t(g_RecordByteAddressAtPtx10423) + uint64_t(45216); // PTX L10424
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10424));
		r_MmaAccumulatorHalf2WordAtPtx10426R3350 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx10426R3351 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx10426R3356 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx10426R3357 = r_Value.w;
	} // PTX L10426
	r_LaneIndexAtPtx10429 = uint32_t((threadIdx.x & 31u)); // PTX L10429
	r_PtxU64Register313 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10429)) * int64_t(int32_t(16))); // PTX L10431
	g_RecordByteAddressAtPtx10432 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register313);				   // PTX L10432
	g_RecordByteAddressAtPtx10433 = uint64_t(g_RecordByteAddressAtPtx10432) + uint64_t(45728); // PTX L10433
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10433));
		r_MmaAccumulatorHalf2WordAtPtx10435R3358 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx10435R3359 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx10435R3360 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx10435R3361 = r_Value.w;
	} // PTX L10435
	r_LaneIndexAtPtx10438 = uint32_t((threadIdx.x & 31u)); // PTX L10438
	r_PtxU64Register315 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10438)) * int64_t(int32_t(16))); // PTX L10440
	g_RecordByteAddressAtPtx10441 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register315);				   // PTX L10441
	g_RecordByteAddressAtPtx10442 = uint64_t(g_RecordByteAddressAtPtx10441) + uint64_t(46240); // PTX L10442
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10442));
		r_MmaAccumulatorHalf2WordAtPtx10444R3362 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx10444R3363 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx10444R3364 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx10444R3365 = r_Value.w;
	} // PTX L10444
	r_LaneIndexAtPtx10447 = uint32_t((threadIdx.x & 31u)); // PTX L10447
	r_PtxU64Register317 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10447)) * int64_t(int32_t(16))); // PTX L10449
	g_RecordByteAddressAtPtx10450 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register317);				   // PTX L10450
	g_RecordByteAddressAtPtx10451 = uint64_t(g_RecordByteAddressAtPtx10450) + uint64_t(46752); // PTX L10451
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10451));
		r_MmaAccumulatorHalf2WordAtPtx10453R3366 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx10453R3367 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx10453R3368 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx10453R3369 = r_Value.w;
	} // PTX L10453
	r_LaneIndexAtPtx10456 = uint32_t((threadIdx.x & 31u)); // PTX L10456
	r_PtxU64Register319 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10456)) * int64_t(int32_t(16))); // PTX L10458
	g_RecordByteAddressAtPtx10459 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register319);				   // PTX L10459
	g_RecordByteAddressAtPtx10460 = uint64_t(g_RecordByteAddressAtPtx10459) + uint64_t(47264); // PTX L10460
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10460));
		r_MmaAccumulatorHalf2WordAtPtx10462R3370 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx10462R3371 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx10462R3376 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx10462R3377 = r_Value.w;
	} // PTX L10462
	r_LaneIndexAtPtx10465 = uint32_t((threadIdx.x & 31u)); // PTX L10465
	r_PtxU64Register321 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10465)) * int64_t(int32_t(16))); // PTX L10467
	g_RecordByteAddressAtPtx10468 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register321);				   // PTX L10468
	g_RecordByteAddressAtPtx10469 = uint64_t(g_RecordByteAddressAtPtx10468) + uint64_t(47776); // PTX L10469
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10469));
		r_MmaAccumulatorHalf2WordAtPtx10471R3378 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx10471R3379 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx10471R3380 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx10471R3381 = r_Value.w;
	} // PTX L10471
	r_LaneIndexAtPtx10474 = uint32_t((threadIdx.x & 31u)); // PTX L10474
	r_PtxU64Register323 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10474)) * int64_t(int32_t(16))); // PTX L10476
	g_RecordByteAddressAtPtx10477 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register323);				   // PTX L10477
	g_RecordByteAddressAtPtx10478 = uint64_t(g_RecordByteAddressAtPtx10477) + uint64_t(48288); // PTX L10478
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10478));
		r_MmaAccumulatorHalf2WordAtPtx10480R3382 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx10480R3383 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx10480R3384 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx10480R3385 = r_Value.w;
	} // PTX L10480
	r_LaneIndexAtPtx10483 = uint32_t((threadIdx.x & 31u)); // PTX L10483
	r_PtxU64Register325 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx10483)) * int64_t(int32_t(16))); // PTX L10485
	g_RecordByteAddressAtPtx10486 =
		uint64_t(g_RecordByteAddressAtPtx8050) + uint64_t(r_PtxU64Register325);				   // PTX L10486
	g_RecordByteAddressAtPtx10487 = uint64_t(g_RecordByteAddressAtPtx10486) + uint64_t(48800); // PTX L10487
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx10487));
		r_MmaAccumulatorHalf2WordAtPtx10489R3386 = r_Value.x;
		r_MmaAccumulatorHalf2WordAtPtx10489R3387 = r_Value.y;
		r_MmaAccumulatorHalf2WordAtPtx10489R3388 = r_Value.z;
		r_MmaAccumulatorHalf2WordAtPtx10489R3389 = r_Value.w;
	} // PTX L10489
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10492R3391, r_MmaAccumulatorHalf2WordAtPtx10492R3396,
		  r_MmaAE4x4WordAtPtx10410R3352, r_MmaAE4x4WordAtPtx10411R3353, r_MmaAE4x4WordAtPtx10412R3354,
		  r_MmaAE4x4WordAtPtx10413R3355, r_MmaBE4x4WordAtPtx7733R2322, r_MmaBE4x4WordAtPtx7740R2323,
		  r_MmaAccumulatorHalf2WordAtPtx10426R3350,
		  r_MmaAccumulatorHalf2WordAtPtx10426R3351); // PTX L10492
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10499R3401, r_MmaAccumulatorHalf2WordAtPtx10499R3406,
		  r_MmaAE4x4WordAtPtx10410R3352, r_MmaAE4x4WordAtPtx10411R3353, r_MmaAE4x4WordAtPtx10412R3354,
		  r_MmaAE4x4WordAtPtx10413R3355, r_MmaBE4x4WordAtPtx7747R2330, r_MmaBE4x4WordAtPtx7754R2331,
		  r_MmaAccumulatorHalf2WordAtPtx10426R3356,
		  r_MmaAccumulatorHalf2WordAtPtx10426R3357); // PTX L10499
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10506R3411, r_MmaAccumulatorHalf2WordAtPtx10506R3416,
		  r_MmaAE4x4WordAtPtx10410R3352, r_MmaAE4x4WordAtPtx10411R3353, r_MmaAE4x4WordAtPtx10412R3354,
		  r_MmaAE4x4WordAtPtx10413R3355, r_MmaBE4x4WordAtPtx7761R2334, r_MmaBE4x4WordAtPtx7768R2335,
		  r_MmaAccumulatorHalf2WordAtPtx10435R3358,
		  r_MmaAccumulatorHalf2WordAtPtx10435R3359); // PTX L10506
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10513R3421, r_MmaAccumulatorHalf2WordAtPtx10513R3426,
		  r_MmaAE4x4WordAtPtx10410R3352, r_MmaAE4x4WordAtPtx10411R3353, r_MmaAE4x4WordAtPtx10412R3354,
		  r_MmaAE4x4WordAtPtx10413R3355, r_MmaBE4x4WordAtPtx7775R2338, r_MmaBE4x4WordAtPtx7782R2339,
		  r_MmaAccumulatorHalf2WordAtPtx10435R3360,
		  r_MmaAccumulatorHalf2WordAtPtx10435R3361); // PTX L10513
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10520R3431, r_MmaAccumulatorHalf2WordAtPtx10520R3436,
		  r_MmaAE4x4WordAtPtx10410R3352, r_MmaAE4x4WordAtPtx10411R3353, r_MmaAE4x4WordAtPtx10412R3354,
		  r_MmaAE4x4WordAtPtx10413R3355, r_MmaBE4x4WordAtPtx7789R2342, r_MmaBE4x4WordAtPtx7796R2343,
		  r_MmaAccumulatorHalf2WordAtPtx10444R3362,
		  r_MmaAccumulatorHalf2WordAtPtx10444R3363); // PTX L10520
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10527R3441, r_MmaAccumulatorHalf2WordAtPtx10527R3446,
		  r_MmaAE4x4WordAtPtx10410R3352, r_MmaAE4x4WordAtPtx10411R3353, r_MmaAE4x4WordAtPtx10412R3354,
		  r_MmaAE4x4WordAtPtx10413R3355, r_MmaBE4x4WordAtPtx7803R2346, r_MmaBE4x4WordAtPtx7810R2347,
		  r_MmaAccumulatorHalf2WordAtPtx10444R3364,
		  r_MmaAccumulatorHalf2WordAtPtx10444R3365); // PTX L10527
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10534R3451, r_MmaAccumulatorHalf2WordAtPtx10534R3456,
		  r_MmaAE4x4WordAtPtx10410R3352, r_MmaAE4x4WordAtPtx10411R3353, r_MmaAE4x4WordAtPtx10412R3354,
		  r_MmaAE4x4WordAtPtx10413R3355, r_MmaBE4x4WordAtPtx7817R2350, r_MmaBE4x4WordAtPtx7824R2351,
		  r_MmaAccumulatorHalf2WordAtPtx10453R3366,
		  r_MmaAccumulatorHalf2WordAtPtx10453R3367); // PTX L10534
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10541R3461, r_MmaAccumulatorHalf2WordAtPtx10541R3466,
		  r_MmaAE4x4WordAtPtx10410R3352, r_MmaAE4x4WordAtPtx10411R3353, r_MmaAE4x4WordAtPtx10412R3354,
		  r_MmaAE4x4WordAtPtx10413R3355, r_MmaBE4x4WordAtPtx7831R2354, r_MmaBE4x4WordAtPtx7838R2355,
		  r_MmaAccumulatorHalf2WordAtPtx10453R3368,
		  r_MmaAccumulatorHalf2WordAtPtx10453R3369); // PTX L10541
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10548R3471, r_MmaAccumulatorHalf2WordAtPtx10548R3476,
		  r_MmaAE4x4WordAtPtx10414R3372, r_MmaAE4x4WordAtPtx10415R3373, r_MmaAE4x4WordAtPtx10416R3374,
		  r_MmaAE4x4WordAtPtx10417R3375, r_MmaBE4x4WordAtPtx7733R2322, r_MmaBE4x4WordAtPtx7740R2323,
		  r_MmaAccumulatorHalf2WordAtPtx10462R3370,
		  r_MmaAccumulatorHalf2WordAtPtx10462R3371); // PTX L10548
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10555R3481, r_MmaAccumulatorHalf2WordAtPtx10555R3486,
		  r_MmaAE4x4WordAtPtx10414R3372, r_MmaAE4x4WordAtPtx10415R3373, r_MmaAE4x4WordAtPtx10416R3374,
		  r_MmaAE4x4WordAtPtx10417R3375, r_MmaBE4x4WordAtPtx7747R2330, r_MmaBE4x4WordAtPtx7754R2331,
		  r_MmaAccumulatorHalf2WordAtPtx10462R3376,
		  r_MmaAccumulatorHalf2WordAtPtx10462R3377); // PTX L10555
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10562R3491, r_MmaAccumulatorHalf2WordAtPtx10562R3496,
		  r_MmaAE4x4WordAtPtx10414R3372, r_MmaAE4x4WordAtPtx10415R3373, r_MmaAE4x4WordAtPtx10416R3374,
		  r_MmaAE4x4WordAtPtx10417R3375, r_MmaBE4x4WordAtPtx7761R2334, r_MmaBE4x4WordAtPtx7768R2335,
		  r_MmaAccumulatorHalf2WordAtPtx10471R3378,
		  r_MmaAccumulatorHalf2WordAtPtx10471R3379); // PTX L10562
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10569R3501, r_MmaAccumulatorHalf2WordAtPtx10569R3506,
		  r_MmaAE4x4WordAtPtx10414R3372, r_MmaAE4x4WordAtPtx10415R3373, r_MmaAE4x4WordAtPtx10416R3374,
		  r_MmaAE4x4WordAtPtx10417R3375, r_MmaBE4x4WordAtPtx7775R2338, r_MmaBE4x4WordAtPtx7782R2339,
		  r_MmaAccumulatorHalf2WordAtPtx10471R3380,
		  r_MmaAccumulatorHalf2WordAtPtx10471R3381); // PTX L10569
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10576R3511, r_MmaAccumulatorHalf2WordAtPtx10576R3516,
		  r_MmaAE4x4WordAtPtx10414R3372, r_MmaAE4x4WordAtPtx10415R3373, r_MmaAE4x4WordAtPtx10416R3374,
		  r_MmaAE4x4WordAtPtx10417R3375, r_MmaBE4x4WordAtPtx7789R2342, r_MmaBE4x4WordAtPtx7796R2343,
		  r_MmaAccumulatorHalf2WordAtPtx10480R3382,
		  r_MmaAccumulatorHalf2WordAtPtx10480R3383); // PTX L10576
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10583R3521, r_MmaAccumulatorHalf2WordAtPtx10583R3526,
		  r_MmaAE4x4WordAtPtx10414R3372, r_MmaAE4x4WordAtPtx10415R3373, r_MmaAE4x4WordAtPtx10416R3374,
		  r_MmaAE4x4WordAtPtx10417R3375, r_MmaBE4x4WordAtPtx7803R2346, r_MmaBE4x4WordAtPtx7810R2347,
		  r_MmaAccumulatorHalf2WordAtPtx10480R3384,
		  r_MmaAccumulatorHalf2WordAtPtx10480R3385); // PTX L10583
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10590R3531, r_MmaAccumulatorHalf2WordAtPtx10590R3536,
		  r_MmaAE4x4WordAtPtx10414R3372, r_MmaAE4x4WordAtPtx10415R3373, r_MmaAE4x4WordAtPtx10416R3374,
		  r_MmaAE4x4WordAtPtx10417R3375, r_MmaBE4x4WordAtPtx7817R2350, r_MmaBE4x4WordAtPtx7824R2351,
		  r_MmaAccumulatorHalf2WordAtPtx10489R3386,
		  r_MmaAccumulatorHalf2WordAtPtx10489R3387); // PTX L10590
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx10597R3541, r_MmaAccumulatorHalf2WordAtPtx10597R3546,
		  r_MmaAE4x4WordAtPtx10414R3372, r_MmaAE4x4WordAtPtx10415R3373, r_MmaAE4x4WordAtPtx10416R3374,
		  r_MmaAE4x4WordAtPtx10417R3375, r_MmaBE4x4WordAtPtx7831R2354, r_MmaBE4x4WordAtPtx7838R2355,
		  r_MmaAccumulatorHalf2WordAtPtx10489R3388,
		  r_MmaAccumulatorHalf2WordAtPtx10489R3389);	   // PTX L10597
	r_LaneIndexAtPtx10604 = uint32_t((threadIdx.x & 31u)); // PTX L10604
	r_PackedHalf2AtPtx10607R3392 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10492R3391, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10607
	r_PackedHalf2AtPtx10611R3394 =
		HalfMax(r_PackedHalf2AtPtx10607R3392, r_PackedHalf2AtPtx8254R18);				  // PTX L10611
	r_PtxRegister3393 = HalfMin(r_PackedHalf2AtPtx10611R3394, r_PackedHalf2AtPtx8261R19); // PTX L10615
	r_PtxRegister3958 = ShiftLeft(uint32_t(r_PtxRegister3393), uint32_t(5));			  // PTX L10618
	r_PtxRegister3603 = uint32_t(r_PtxRegister3958) + uint32_t(2146992128);				  // PTX L10619
	r_LaneIndexAtPtx10621 = uint32_t((threadIdx.x & 31u));								  // PTX L10621
	r_PackedHalf2AtPtx10624R3397 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10492R3396, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10624
	r_PackedHalf2AtPtx10628R3399 =
		HalfMax(r_PackedHalf2AtPtx10624R3397, r_PackedHalf2AtPtx8254R18);				  // PTX L10628
	r_PtxRegister3398 = HalfMin(r_PackedHalf2AtPtx10628R3399, r_PackedHalf2AtPtx8261R19); // PTX L10632
	r_PtxRegister3959 = ShiftLeft(uint32_t(r_PtxRegister3398), uint32_t(5));			  // PTX L10635
	r_PtxRegister3606 = uint32_t(r_PtxRegister3959) + uint32_t(2146992128);				  // PTX L10636
	r_LaneIndexAtPtx10638 = uint32_t((threadIdx.x & 31u));								  // PTX L10638
	r_PackedHalf2AtPtx10641R3402 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10499R3401, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10641
	r_PackedHalf2AtPtx10645R3404 =
		HalfMax(r_PackedHalf2AtPtx10641R3402, r_PackedHalf2AtPtx8254R18);				  // PTX L10645
	r_PtxRegister3403 = HalfMin(r_PackedHalf2AtPtx10645R3404, r_PackedHalf2AtPtx8261R19); // PTX L10649
	r_PtxRegister3960 = ShiftLeft(uint32_t(r_PtxRegister3403), uint32_t(5));			  // PTX L10652
	r_PtxRegister3609 = uint32_t(r_PtxRegister3960) + uint32_t(2146992128);				  // PTX L10653
	r_LaneIndexAtPtx10655 = uint32_t((threadIdx.x & 31u));								  // PTX L10655
	r_PackedHalf2AtPtx10658R3407 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10499R3406, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10658
	r_PackedHalf2AtPtx10662R3409 =
		HalfMax(r_PackedHalf2AtPtx10658R3407, r_PackedHalf2AtPtx8254R18);				  // PTX L10662
	r_PtxRegister3408 = HalfMin(r_PackedHalf2AtPtx10662R3409, r_PackedHalf2AtPtx8261R19); // PTX L10666
	r_PtxRegister3961 = ShiftLeft(uint32_t(r_PtxRegister3408), uint32_t(5));			  // PTX L10669
	r_PtxRegister3612 = uint32_t(r_PtxRegister3961) + uint32_t(2146992128);				  // PTX L10670
	r_LaneIndexAtPtx10672 = uint32_t((threadIdx.x & 31u));								  // PTX L10672
	r_PackedHalf2AtPtx10675R3412 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10506R3411, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10675
	r_PackedHalf2AtPtx10679R3414 =
		HalfMax(r_PackedHalf2AtPtx10675R3412, r_PackedHalf2AtPtx8254R18);				  // PTX L10679
	r_PtxRegister3413 = HalfMin(r_PackedHalf2AtPtx10679R3414, r_PackedHalf2AtPtx8261R19); // PTX L10683
	r_PtxRegister3962 = ShiftLeft(uint32_t(r_PtxRegister3413), uint32_t(5));			  // PTX L10686
	r_PtxRegister3615 = uint32_t(r_PtxRegister3962) + uint32_t(2146992128);				  // PTX L10687
	r_LaneIndexAtPtx10689 = uint32_t((threadIdx.x & 31u));								  // PTX L10689
	r_PackedHalf2AtPtx10692R3417 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10506R3416, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10692
	r_PackedHalf2AtPtx10696R3419 =
		HalfMax(r_PackedHalf2AtPtx10692R3417, r_PackedHalf2AtPtx8254R18);				  // PTX L10696
	r_PtxRegister3418 = HalfMin(r_PackedHalf2AtPtx10696R3419, r_PackedHalf2AtPtx8261R19); // PTX L10700
	r_PtxRegister3963 = ShiftLeft(uint32_t(r_PtxRegister3418), uint32_t(5));			  // PTX L10703
	r_PtxRegister3618 = uint32_t(r_PtxRegister3963) + uint32_t(2146992128);				  // PTX L10704
	r_LaneIndexAtPtx10706 = uint32_t((threadIdx.x & 31u));								  // PTX L10706
	r_PackedHalf2AtPtx10709R3422 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10513R3421, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10709
	r_PackedHalf2AtPtx10713R3424 =
		HalfMax(r_PackedHalf2AtPtx10709R3422, r_PackedHalf2AtPtx8254R18);				  // PTX L10713
	r_PtxRegister3423 = HalfMin(r_PackedHalf2AtPtx10713R3424, r_PackedHalf2AtPtx8261R19); // PTX L10717
	r_PtxRegister3964 = ShiftLeft(uint32_t(r_PtxRegister3423), uint32_t(5));			  // PTX L10720
	r_PtxRegister3621 = uint32_t(r_PtxRegister3964) + uint32_t(2146992128);				  // PTX L10721
	r_LaneIndexAtPtx10723 = uint32_t((threadIdx.x & 31u));								  // PTX L10723
	r_PackedHalf2AtPtx10726R3427 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10513R3426, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10726
	r_PackedHalf2AtPtx10730R3429 =
		HalfMax(r_PackedHalf2AtPtx10726R3427, r_PackedHalf2AtPtx8254R18);				  // PTX L10730
	r_PtxRegister3428 = HalfMin(r_PackedHalf2AtPtx10730R3429, r_PackedHalf2AtPtx8261R19); // PTX L10734
	r_PtxRegister3965 = ShiftLeft(uint32_t(r_PtxRegister3428), uint32_t(5));			  // PTX L10737
	r_PtxRegister3624 = uint32_t(r_PtxRegister3965) + uint32_t(2146992128);				  // PTX L10738
	r_LaneIndexAtPtx10740 = uint32_t((threadIdx.x & 31u));								  // PTX L10740
	r_PackedHalf2AtPtx10743R3432 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10520R3431, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10743
	r_PackedHalf2AtPtx10747R3434 =
		HalfMax(r_PackedHalf2AtPtx10743R3432, r_PackedHalf2AtPtx8254R18);				  // PTX L10747
	r_PtxRegister3433 = HalfMin(r_PackedHalf2AtPtx10747R3434, r_PackedHalf2AtPtx8261R19); // PTX L10751
	r_PtxRegister3966 = ShiftLeft(uint32_t(r_PtxRegister3433), uint32_t(5));			  // PTX L10754
	r_PtxRegister3627 = uint32_t(r_PtxRegister3966) + uint32_t(2146992128);				  // PTX L10755
	r_LaneIndexAtPtx10757 = uint32_t((threadIdx.x & 31u));								  // PTX L10757
	r_PackedHalf2AtPtx10760R3437 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10520R3436, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10760
	r_PackedHalf2AtPtx10764R3439 =
		HalfMax(r_PackedHalf2AtPtx10760R3437, r_PackedHalf2AtPtx8254R18);				  // PTX L10764
	r_PtxRegister3438 = HalfMin(r_PackedHalf2AtPtx10764R3439, r_PackedHalf2AtPtx8261R19); // PTX L10768
	r_PtxRegister3967 = ShiftLeft(uint32_t(r_PtxRegister3438), uint32_t(5));			  // PTX L10771
	r_PtxRegister3630 = uint32_t(r_PtxRegister3967) + uint32_t(2146992128);				  // PTX L10772
	r_LaneIndexAtPtx10774 = uint32_t((threadIdx.x & 31u));								  // PTX L10774
	r_PackedHalf2AtPtx10777R3442 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10527R3441, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10777
	r_PackedHalf2AtPtx10781R3444 =
		HalfMax(r_PackedHalf2AtPtx10777R3442, r_PackedHalf2AtPtx8254R18);				  // PTX L10781
	r_PtxRegister3443 = HalfMin(r_PackedHalf2AtPtx10781R3444, r_PackedHalf2AtPtx8261R19); // PTX L10785
	r_PtxRegister3968 = ShiftLeft(uint32_t(r_PtxRegister3443), uint32_t(5));			  // PTX L10788
	r_PtxRegister3633 = uint32_t(r_PtxRegister3968) + uint32_t(2146992128);				  // PTX L10789
	r_LaneIndexAtPtx10791 = uint32_t((threadIdx.x & 31u));								  // PTX L10791
	r_PackedHalf2AtPtx10794R3447 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10527R3446, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10794
	r_PackedHalf2AtPtx10798R3449 =
		HalfMax(r_PackedHalf2AtPtx10794R3447, r_PackedHalf2AtPtx8254R18);				  // PTX L10798
	r_PtxRegister3448 = HalfMin(r_PackedHalf2AtPtx10798R3449, r_PackedHalf2AtPtx8261R19); // PTX L10802
	r_PtxRegister3969 = ShiftLeft(uint32_t(r_PtxRegister3448), uint32_t(5));			  // PTX L10805
	r_PtxRegister3636 = uint32_t(r_PtxRegister3969) + uint32_t(2146992128);				  // PTX L10806
	r_LaneIndexAtPtx10808 = uint32_t((threadIdx.x & 31u));								  // PTX L10808
	r_PackedHalf2AtPtx10811R3452 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10534R3451, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10811
	r_PackedHalf2AtPtx10815R3454 =
		HalfMax(r_PackedHalf2AtPtx10811R3452, r_PackedHalf2AtPtx8254R18);				  // PTX L10815
	r_PtxRegister3453 = HalfMin(r_PackedHalf2AtPtx10815R3454, r_PackedHalf2AtPtx8261R19); // PTX L10819
	r_PtxRegister3970 = ShiftLeft(uint32_t(r_PtxRegister3453), uint32_t(5));			  // PTX L10822
	r_PtxRegister3639 = uint32_t(r_PtxRegister3970) + uint32_t(2146992128);				  // PTX L10823
	r_LaneIndexAtPtx10825 = uint32_t((threadIdx.x & 31u));								  // PTX L10825
	r_PackedHalf2AtPtx10828R3457 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10534R3456, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10828
	r_PackedHalf2AtPtx10832R3459 =
		HalfMax(r_PackedHalf2AtPtx10828R3457, r_PackedHalf2AtPtx8254R18);				  // PTX L10832
	r_PtxRegister3458 = HalfMin(r_PackedHalf2AtPtx10832R3459, r_PackedHalf2AtPtx8261R19); // PTX L10836
	r_PtxRegister3971 = ShiftLeft(uint32_t(r_PtxRegister3458), uint32_t(5));			  // PTX L10839
	r_PtxRegister3642 = uint32_t(r_PtxRegister3971) + uint32_t(2146992128);				  // PTX L10840
	r_LaneIndexAtPtx10842 = uint32_t((threadIdx.x & 31u));								  // PTX L10842
	r_PackedHalf2AtPtx10845R3462 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10541R3461, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10845
	r_PackedHalf2AtPtx10849R3464 =
		HalfMax(r_PackedHalf2AtPtx10845R3462, r_PackedHalf2AtPtx8254R18);				  // PTX L10849
	r_PtxRegister3463 = HalfMin(r_PackedHalf2AtPtx10849R3464, r_PackedHalf2AtPtx8261R19); // PTX L10853
	r_PtxRegister3972 = ShiftLeft(uint32_t(r_PtxRegister3463), uint32_t(5));			  // PTX L10856
	r_PtxRegister3645 = uint32_t(r_PtxRegister3972) + uint32_t(2146992128);				  // PTX L10857
	r_LaneIndexAtPtx10859 = uint32_t((threadIdx.x & 31u));								  // PTX L10859
	r_PackedHalf2AtPtx10862R3467 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10541R3466, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10862
	r_PackedHalf2AtPtx10866R3469 =
		HalfMax(r_PackedHalf2AtPtx10862R3467, r_PackedHalf2AtPtx8254R18);				  // PTX L10866
	r_PtxRegister3468 = HalfMin(r_PackedHalf2AtPtx10866R3469, r_PackedHalf2AtPtx8261R19); // PTX L10870
	r_PtxRegister3973 = ShiftLeft(uint32_t(r_PtxRegister3468), uint32_t(5));			  // PTX L10873
	r_PtxRegister3648 = uint32_t(r_PtxRegister3973) + uint32_t(2146992128);				  // PTX L10874
	r_LaneIndexAtPtx10876 = uint32_t((threadIdx.x & 31u));								  // PTX L10876
	r_PackedHalf2AtPtx10879R3472 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10548R3471, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10879
	r_PackedHalf2AtPtx10883R3474 =
		HalfMax(r_PackedHalf2AtPtx10879R3472, r_PackedHalf2AtPtx8254R18);				  // PTX L10883
	r_PtxRegister3473 = HalfMin(r_PackedHalf2AtPtx10883R3474, r_PackedHalf2AtPtx8261R19); // PTX L10887
	r_PtxRegister3974 = ShiftLeft(uint32_t(r_PtxRegister3473), uint32_t(5));			  // PTX L10890
	r_PtxRegister3651 = uint32_t(r_PtxRegister3974) + uint32_t(2146992128);				  // PTX L10891
	r_LaneIndexAtPtx10893 = uint32_t((threadIdx.x & 31u));								  // PTX L10893
	r_PackedHalf2AtPtx10896R3477 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10548R3476, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10896
	r_PackedHalf2AtPtx10900R3479 =
		HalfMax(r_PackedHalf2AtPtx10896R3477, r_PackedHalf2AtPtx8254R18);				  // PTX L10900
	r_PtxRegister3478 = HalfMin(r_PackedHalf2AtPtx10900R3479, r_PackedHalf2AtPtx8261R19); // PTX L10904
	r_PtxRegister3975 = ShiftLeft(uint32_t(r_PtxRegister3478), uint32_t(5));			  // PTX L10907
	r_PtxRegister3654 = uint32_t(r_PtxRegister3975) + uint32_t(2146992128);				  // PTX L10908
	r_LaneIndexAtPtx10910 = uint32_t((threadIdx.x & 31u));								  // PTX L10910
	r_PackedHalf2AtPtx10913R3482 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10555R3481, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10913
	r_PackedHalf2AtPtx10917R3484 =
		HalfMax(r_PackedHalf2AtPtx10913R3482, r_PackedHalf2AtPtx8254R18);				  // PTX L10917
	r_PtxRegister3483 = HalfMin(r_PackedHalf2AtPtx10917R3484, r_PackedHalf2AtPtx8261R19); // PTX L10921
	r_PtxRegister3976 = ShiftLeft(uint32_t(r_PtxRegister3483), uint32_t(5));			  // PTX L10924
	r_PtxRegister3657 = uint32_t(r_PtxRegister3976) + uint32_t(2146992128);				  // PTX L10925
	r_LaneIndexAtPtx10927 = uint32_t((threadIdx.x & 31u));								  // PTX L10927
	r_PackedHalf2AtPtx10930R3487 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10555R3486, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10930
	r_PackedHalf2AtPtx10934R3489 =
		HalfMax(r_PackedHalf2AtPtx10930R3487, r_PackedHalf2AtPtx8254R18);				  // PTX L10934
	r_PtxRegister3488 = HalfMin(r_PackedHalf2AtPtx10934R3489, r_PackedHalf2AtPtx8261R19); // PTX L10938
	r_PtxRegister3977 = ShiftLeft(uint32_t(r_PtxRegister3488), uint32_t(5));			  // PTX L10941
	r_PtxRegister3660 = uint32_t(r_PtxRegister3977) + uint32_t(2146992128);				  // PTX L10942
	r_LaneIndexAtPtx10944 = uint32_t((threadIdx.x & 31u));								  // PTX L10944
	r_PackedHalf2AtPtx10947R3492 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10562R3491, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10947
	r_PackedHalf2AtPtx10951R3494 =
		HalfMax(r_PackedHalf2AtPtx10947R3492, r_PackedHalf2AtPtx8254R18);				  // PTX L10951
	r_PtxRegister3493 = HalfMin(r_PackedHalf2AtPtx10951R3494, r_PackedHalf2AtPtx8261R19); // PTX L10955
	r_PtxRegister3978 = ShiftLeft(uint32_t(r_PtxRegister3493), uint32_t(5));			  // PTX L10958
	r_PtxRegister3663 = uint32_t(r_PtxRegister3978) + uint32_t(2146992128);				  // PTX L10959
	r_LaneIndexAtPtx10961 = uint32_t((threadIdx.x & 31u));								  // PTX L10961
	r_PackedHalf2AtPtx10964R3497 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10562R3496, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10964
	r_PackedHalf2AtPtx10968R3499 =
		HalfMax(r_PackedHalf2AtPtx10964R3497, r_PackedHalf2AtPtx8254R18);				  // PTX L10968
	r_PtxRegister3498 = HalfMin(r_PackedHalf2AtPtx10968R3499, r_PackedHalf2AtPtx8261R19); // PTX L10972
	r_PtxRegister3979 = ShiftLeft(uint32_t(r_PtxRegister3498), uint32_t(5));			  // PTX L10975
	r_PtxRegister3666 = uint32_t(r_PtxRegister3979) + uint32_t(2146992128);				  // PTX L10976
	r_LaneIndexAtPtx10978 = uint32_t((threadIdx.x & 31u));								  // PTX L10978
	r_PackedHalf2AtPtx10981R3502 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10569R3501, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10981
	r_PackedHalf2AtPtx10985R3504 =
		HalfMax(r_PackedHalf2AtPtx10981R3502, r_PackedHalf2AtPtx8254R18);				  // PTX L10985
	r_PtxRegister3503 = HalfMin(r_PackedHalf2AtPtx10985R3504, r_PackedHalf2AtPtx8261R19); // PTX L10989
	r_PtxRegister3980 = ShiftLeft(uint32_t(r_PtxRegister3503), uint32_t(5));			  // PTX L10992
	r_PtxRegister3669 = uint32_t(r_PtxRegister3980) + uint32_t(2146992128);				  // PTX L10993
	r_LaneIndexAtPtx10995 = uint32_t((threadIdx.x & 31u));								  // PTX L10995
	r_PackedHalf2AtPtx10998R3507 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10569R3506, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L10998
	r_PackedHalf2AtPtx11002R3509 =
		HalfMax(r_PackedHalf2AtPtx10998R3507, r_PackedHalf2AtPtx8254R18);				  // PTX L11002
	r_PtxRegister3508 = HalfMin(r_PackedHalf2AtPtx11002R3509, r_PackedHalf2AtPtx8261R19); // PTX L11006
	r_PtxRegister3981 = ShiftLeft(uint32_t(r_PtxRegister3508), uint32_t(5));			  // PTX L11009
	r_PtxRegister3672 = uint32_t(r_PtxRegister3981) + uint32_t(2146992128);				  // PTX L11010
	r_LaneIndexAtPtx11012 = uint32_t((threadIdx.x & 31u));								  // PTX L11012
	r_PackedHalf2AtPtx11015R3512 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10576R3511, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L11015
	r_PackedHalf2AtPtx11019R3514 =
		HalfMax(r_PackedHalf2AtPtx11015R3512, r_PackedHalf2AtPtx8254R18);				  // PTX L11019
	r_PtxRegister3513 = HalfMin(r_PackedHalf2AtPtx11019R3514, r_PackedHalf2AtPtx8261R19); // PTX L11023
	r_PtxRegister3982 = ShiftLeft(uint32_t(r_PtxRegister3513), uint32_t(5));			  // PTX L11026
	r_PtxRegister3675 = uint32_t(r_PtxRegister3982) + uint32_t(2146992128);				  // PTX L11027
	r_LaneIndexAtPtx11029 = uint32_t((threadIdx.x & 31u));								  // PTX L11029
	r_PackedHalf2AtPtx11032R3517 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10576R3516, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L11032
	r_PackedHalf2AtPtx11036R3519 =
		HalfMax(r_PackedHalf2AtPtx11032R3517, r_PackedHalf2AtPtx8254R18);				  // PTX L11036
	r_PtxRegister3518 = HalfMin(r_PackedHalf2AtPtx11036R3519, r_PackedHalf2AtPtx8261R19); // PTX L11040
	r_PtxRegister3983 = ShiftLeft(uint32_t(r_PtxRegister3518), uint32_t(5));			  // PTX L11043
	r_PtxRegister3678 = uint32_t(r_PtxRegister3983) + uint32_t(2146992128);				  // PTX L11044
	r_LaneIndexAtPtx11046 = uint32_t((threadIdx.x & 31u));								  // PTX L11046
	r_PackedHalf2AtPtx11049R3522 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10583R3521, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L11049
	r_PackedHalf2AtPtx11053R3524 =
		HalfMax(r_PackedHalf2AtPtx11049R3522, r_PackedHalf2AtPtx8254R18);				  // PTX L11053
	r_PtxRegister3523 = HalfMin(r_PackedHalf2AtPtx11053R3524, r_PackedHalf2AtPtx8261R19); // PTX L11057
	r_PtxRegister3984 = ShiftLeft(uint32_t(r_PtxRegister3523), uint32_t(5));			  // PTX L11060
	r_PtxRegister3681 = uint32_t(r_PtxRegister3984) + uint32_t(2146992128);				  // PTX L11061
	r_LaneIndexAtPtx11063 = uint32_t((threadIdx.x & 31u));								  // PTX L11063
	r_PackedHalf2AtPtx11066R3527 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10583R3526, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L11066
	r_PackedHalf2AtPtx11070R3529 =
		HalfMax(r_PackedHalf2AtPtx11066R3527, r_PackedHalf2AtPtx8254R18);				  // PTX L11070
	r_PtxRegister3528 = HalfMin(r_PackedHalf2AtPtx11070R3529, r_PackedHalf2AtPtx8261R19); // PTX L11074
	r_PtxRegister3985 = ShiftLeft(uint32_t(r_PtxRegister3528), uint32_t(5));			  // PTX L11077
	r_PtxRegister3684 = uint32_t(r_PtxRegister3985) + uint32_t(2146992128);				  // PTX L11078
	r_LaneIndexAtPtx11080 = uint32_t((threadIdx.x & 31u));								  // PTX L11080
	r_PackedHalf2AtPtx11083R3532 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10590R3531, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L11083
	r_PackedHalf2AtPtx11087R3534 =
		HalfMax(r_PackedHalf2AtPtx11083R3532, r_PackedHalf2AtPtx8254R18);				  // PTX L11087
	r_PtxRegister3533 = HalfMin(r_PackedHalf2AtPtx11087R3534, r_PackedHalf2AtPtx8261R19); // PTX L11091
	r_PtxRegister3986 = ShiftLeft(uint32_t(r_PtxRegister3533), uint32_t(5));			  // PTX L11094
	r_PtxRegister3687 = uint32_t(r_PtxRegister3986) + uint32_t(2146992128);				  // PTX L11095
	r_LaneIndexAtPtx11097 = uint32_t((threadIdx.x & 31u));								  // PTX L11097
	r_PackedHalf2AtPtx11100R3537 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10590R3536, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L11100
	r_PackedHalf2AtPtx11104R3539 =
		HalfMax(r_PackedHalf2AtPtx11100R3537, r_PackedHalf2AtPtx8254R18);				  // PTX L11104
	r_PtxRegister3538 = HalfMin(r_PackedHalf2AtPtx11104R3539, r_PackedHalf2AtPtx8261R19); // PTX L11108
	r_PtxRegister3987 = ShiftLeft(uint32_t(r_PtxRegister3538), uint32_t(5));			  // PTX L11111
	r_PtxRegister3690 = uint32_t(r_PtxRegister3987) + uint32_t(2146992128);				  // PTX L11112
	r_LaneIndexAtPtx11114 = uint32_t((threadIdx.x & 31u));								  // PTX L11114
	r_PackedHalf2AtPtx11117R3542 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10597R3541, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L11117
	r_PackedHalf2AtPtx11121R3544 =
		HalfMax(r_PackedHalf2AtPtx11117R3542, r_PackedHalf2AtPtx8254R18);				  // PTX L11121
	r_PtxRegister3543 = HalfMin(r_PackedHalf2AtPtx11121R3544, r_PackedHalf2AtPtx8261R19); // PTX L11125
	r_PtxRegister3988 = ShiftLeft(uint32_t(r_PtxRegister3543), uint32_t(5));			  // PTX L11128
	r_PtxRegister3693 = uint32_t(r_PtxRegister3988) + uint32_t(2146992128);				  // PTX L11129
	r_LaneIndexAtPtx11131 = uint32_t((threadIdx.x & 31u));								  // PTX L11131
	r_PackedHalf2AtPtx11134R3547 =
		HalfFma(r_MmaAccumulatorHalf2WordAtPtx10597R3546, r_PackedHalf2AtPtx8240R16,
				r_PackedHalf2AtPtx8247R17); // PTX L11134
	r_PackedHalf2AtPtx11138R3549 =
		HalfMax(r_PackedHalf2AtPtx11134R3547, r_PackedHalf2AtPtx8254R18);				  // PTX L11138
	r_PtxRegister3548 = HalfMin(r_PackedHalf2AtPtx11138R3549, r_PackedHalf2AtPtx8261R19); // PTX L11142
	r_PtxRegister3989 = ShiftLeft(uint32_t(r_PtxRegister3548), uint32_t(5));			  // PTX L11145
	r_PtxRegister3696 = uint32_t(r_PtxRegister3989) + uint32_t(2146992128);				  // PTX L11146
	r_LaneIndexAtPtx11148 = uint32_t((threadIdx.x & 31u));								  // PTX L11148
	r_PackedHalf2AtPtx11151R3551 = HalfAdd(r_PtxRegister3603, r_PtxRegister3609);		  // PTX L11151
	r_PackedHalf2AtPtx11155R3552 = HalfAdd(r_PtxRegister3615, r_PtxRegister3621);		  // PTX L11155
	r_PackedHalf2AtPtx11159R3553 =
		HalfAdd(r_PackedHalf2AtPtx11151R3551, r_PackedHalf2AtPtx11155R3552);	  // PTX L11159
	r_PackedHalf2AtPtx11163R3554 = HalfAdd(r_PtxRegister3627, r_PtxRegister3633); // PTX L11163
	r_PackedHalf2AtPtx11167R3556 =
		HalfAdd(r_PackedHalf2AtPtx11159R3553, r_PackedHalf2AtPtx11163R3554);				 // PTX L11167
	r_PackedHalf2AtPtx11171R3557 = HalfAdd(r_PtxRegister3639, r_PtxRegister3645);			 // PTX L11171
	r_PtxRegister3555 = HalfAdd(r_PackedHalf2AtPtx11167R3556, r_PackedHalf2AtPtx11171R3557); // PTX L11175
	r_PackedHalf2AtPtx11179R3558 = HalfAdd(r_PtxRegister3606, r_PtxRegister3612);			 // PTX L11179
	r_PackedHalf2AtPtx11183R3559 = HalfAdd(r_PtxRegister3618, r_PtxRegister3624);			 // PTX L11183
	r_PackedHalf2AtPtx11187R3560 =
		HalfAdd(r_PackedHalf2AtPtx11179R3558, r_PackedHalf2AtPtx11183R3559);	  // PTX L11187
	r_PackedHalf2AtPtx11191R3561 = HalfAdd(r_PtxRegister3630, r_PtxRegister3636); // PTX L11191
	r_PackedHalf2AtPtx11195R3563 =
		HalfAdd(r_PackedHalf2AtPtx11187R3560, r_PackedHalf2AtPtx11191R3561);				 // PTX L11195
	r_PackedHalf2AtPtx11199R3564 = HalfAdd(r_PtxRegister3642, r_PtxRegister3648);			 // PTX L11199
	r_PtxRegister3562 = HalfAdd(r_PackedHalf2AtPtx11195R3563, r_PackedHalf2AtPtx11199R3564); // PTX L11203
	r_PackedHalf2AtPtx11207R3565 = HalfAdd(r_PtxRegister3651, r_PtxRegister3657);			 // PTX L11207
	r_PackedHalf2AtPtx11211R3566 = HalfAdd(r_PtxRegister3663, r_PtxRegister3669);			 // PTX L11211
	r_PackedHalf2AtPtx11215R3567 =
		HalfAdd(r_PackedHalf2AtPtx11207R3565, r_PackedHalf2AtPtx11211R3566);	  // PTX L11215
	r_PackedHalf2AtPtx11219R3568 = HalfAdd(r_PtxRegister3675, r_PtxRegister3681); // PTX L11219
	r_PackedHalf2AtPtx11223R3570 =
		HalfAdd(r_PackedHalf2AtPtx11215R3567, r_PackedHalf2AtPtx11219R3568);				 // PTX L11223
	r_PackedHalf2AtPtx11227R3571 = HalfAdd(r_PtxRegister3687, r_PtxRegister3693);			 // PTX L11227
	r_PtxRegister3569 = HalfAdd(r_PackedHalf2AtPtx11223R3570, r_PackedHalf2AtPtx11227R3571); // PTX L11231
	r_PackedHalf2AtPtx11235R3572 = HalfAdd(r_PtxRegister3654, r_PtxRegister3660);			 // PTX L11235
	r_PackedHalf2AtPtx11239R3573 = HalfAdd(r_PtxRegister3666, r_PtxRegister3672);			 // PTX L11239
	r_PackedHalf2AtPtx11243R3574 =
		HalfAdd(r_PackedHalf2AtPtx11235R3572, r_PackedHalf2AtPtx11239R3573);	  // PTX L11243
	r_PackedHalf2AtPtx11247R3575 = HalfAdd(r_PtxRegister3678, r_PtxRegister3684); // PTX L11247
	r_PackedHalf2AtPtx11251R3577 =
		HalfAdd(r_PackedHalf2AtPtx11243R3574, r_PackedHalf2AtPtx11247R3575);				 // PTX L11251
	r_PackedHalf2AtPtx11255R3578 = HalfAdd(r_PtxRegister3690, r_PtxRegister3696);			 // PTX L11255
	r_PtxRegister3576 = HalfAdd(r_PackedHalf2AtPtx11251R3577, r_PackedHalf2AtPtx11255R3578); // PTX L11259
	r_PtxU16Register488 = uint16_t(r_LaneIndexAtPtx11148);									 // PTX L11262
	r_PtxRegister3990 = r_LaneIndexAtPtx11148 & 1;											 // PTX L11263
	r_bPtxPredicate85 = uint32_t(r_PtxRegister3990) != uint32_t(0);							 // PTX L11264
	r_PtxRegister3991 = r_bPtxPredicate85 ? r_PtxRegister3562 : r_PtxRegister3555;			 // PTX L11265
	r_PtxRegister3992 = r_bPtxPredicate85 ? r_PtxRegister3555 : r_PtxRegister3562;			 // PTX L11266
	r_PtxRegister3993 = r_bPtxPredicate85 ? r_PtxRegister3576 : r_PtxRegister3569;			 // PTX L11267
	r_PtxRegister3994 = r_bPtxPredicate85 ? r_PtxRegister3569 : r_PtxRegister3576;			 // PTX L11268
	r_PtxU16Register489 = r_PtxU16Register488 & 2;											 // PTX L11269
	r_bPtxPredicate86 = uint16_t(r_PtxU16Register489) == uint16_t(0);						 // PTX L11270
	r_PtxRegister3995 = r_bPtxPredicate86 ? r_PtxRegister3991 : r_PtxRegister3993;			 // PTX L11271
	r_PtxRegister3996 = r_bPtxPredicate86 ? r_PtxRegister3993 : r_PtxRegister3991;			 // PTX L11272
	r_PtxRegister3997 = r_bPtxPredicate86 ? r_PtxRegister3992 : r_PtxRegister3994;			 // PTX L11273
	r_PtxRegister3998 = r_bPtxPredicate86 ? r_PtxRegister3994 : r_PtxRegister3992;			 // PTX L11274
	r_PtxRegister3999 = ShiftLeft(uint32_t(r_LaneIndexAtPtx11148), uint32_t(2));			 // PTX L11275
	r_PtxRegister4000 = r_PtxRegister3999 & 28;												 // PTX L11276
	r_PtxRegister4001 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx11148), uint32_t(3));		 // PTX L11277
	r_PtxRegister4002 = uint32_t(r_PtxRegister4000) + uint32_t(r_PtxRegister4001);			 // PTX L11278
	r_PtxRegister4003 =
		ShuffleIdxPredicate(r_bPtxPredicate87, r_PtxRegister3995, r_PtxRegister4002, 31, -1); // PTX L11279
	r_PtxRegister4004 = r_PtxRegister4002 ^ 1;												  // PTX L11280
	r_PtxRegister4005 =
		ShuffleIdxPredicate(r_bPtxPredicate88, r_PtxRegister3997, r_PtxRegister4004, 31, -1); // PTX L11281
	r_PtxRegister4006 = r_PtxRegister4002 ^ 2;												  // PTX L11282
	r_PtxRegister4007 =
		ShuffleIdxPredicate(r_bPtxPredicate89, r_PtxRegister3996, r_PtxRegister4006, 31, -1); // PTX L11283
	r_PtxRegister4008 = r_PtxRegister4002 ^ 3;												  // PTX L11284
	r_PtxRegister4009 =
		ShuffleIdxPredicate(r_bPtxPredicate90, r_PtxRegister3998, r_PtxRegister4008, 31, -1); // PTX L11285
	r_PtxU16Register490 = r_PtxU16Register488 & 8;											  // PTX L11286
	r_bPtxPredicate91 = uint16_t(r_PtxU16Register490) == uint16_t(0);						  // PTX L11287
	r_PtxRegister4010 = r_bPtxPredicate91 ? r_PtxRegister4003 : r_PtxRegister4005;			  // PTX L11288
	r_PtxRegister4011 = r_bPtxPredicate91 ? r_PtxRegister4005 : r_PtxRegister4003;			  // PTX L11289
	r_PtxRegister4012 = r_bPtxPredicate91 ? r_PtxRegister4007 : r_PtxRegister4009;			  // PTX L11290
	r_PtxRegister4013 = r_bPtxPredicate91 ? r_PtxRegister4009 : r_PtxRegister4007;			  // PTX L11291
	r_PtxU16Register491 = r_PtxU16Register488 & 16;											  // PTX L11292
	r_bPtxPredicate92 = uint16_t(r_PtxU16Register491) == uint16_t(0);						  // PTX L11293
	r_PtxRegister3579 = r_bPtxPredicate92 ? r_PtxRegister4010 : r_PtxRegister4012;			  // PTX L11294
	r_PtxRegister3582 = r_bPtxPredicate92 ? r_PtxRegister4012 : r_PtxRegister4010;			  // PTX L11295
	r_PtxRegister3580 = r_bPtxPredicate92 ? r_PtxRegister4011 : r_PtxRegister4013;			  // PTX L11296
	r_PtxRegister3585 = r_bPtxPredicate92 ? r_PtxRegister4013 : r_PtxRegister4011;			  // PTX L11297
	r_PackedHalf2AtPtx11299R3581 = HalfAdd(r_PtxRegister3579, r_PtxRegister3580);			  // PTX L11299
	r_PackedHalf2AtPtx11303R3584 = HalfAdd(r_PackedHalf2AtPtx11299R3581, r_PtxRegister3582);  // PTX L11303
	r_PtxRegister3583 = HalfAdd(r_PackedHalf2AtPtx11303R3584, r_PtxRegister3585);			  // PTX L11307
	r_PtxU16Register492 = uint16_t(r_PtxRegister3583);
	r_PtxU16Register493 = uint16_t(r_PtxRegister3583 >> 16);								 // PTX L11310
	r_PackedHalf2AtPtx11311R3587 = JoinHalfwords(r_PtxU16Register492, r_PtxU16Register492);	 // PTX L11311
	r_PackedHalf2AtPtx11312R3588 = JoinHalfwords(r_PtxU16Register493, r_PtxU16Register493);	 // PTX L11312
	r_PtxRegister3586 = HalfAdd(r_PackedHalf2AtPtx11311R3587, r_PackedHalf2AtPtx11312R3588); // PTX L11314
	r_PtxRegister3590 = __byte_perm(r_PtxRegister3586, r_PtxRegister3586, 0x5410U);			 // PTX L11317
	r_LaneIndexAtPtx11319 = uint32_t((threadIdx.x & 31u));									 // PTX L11319
	r_PackedHalf2AtPtx11322R3593 = HalfMax(r_PtxRegister3590, r_PackedHalf2AtPtx8982R2583);	 // PTX L11322
	r_LaneIndexAtPtx11326 = uint32_t((threadIdx.x & 31u));									 // PTX L11326
	r_PtxRegister3592 = RcpHalf2(r_PackedHalf2AtPtx11322R3593);								 // PTX L11329
	r_LaneIndexAtPtx11342 = uint32_t((threadIdx.x & 31u));									 // PTX L11342
	r_PtxRegister4014 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx11342), uint32_t(31));		 // PTX L11344
	r_PtxRegister4015 = ShiftRight(uint32_t(r_PtxRegister4014), uint32_t(30));				 // PTX L11345
	r_PtxRegister4016 = uint32_t(r_LaneIndexAtPtx11342) + uint32_t(r_PtxRegister4015);		 // PTX L11346
	r_PtxRegister4017 = ShiftRightSigned(int32_t(r_PtxRegister4016), uint32_t(2));			 // PTX L11347
	r_PtxRegister4018 = ShiftRightSigned(int32_t(r_PtxRegister4016), uint32_t(31));			 // PTX L11348
	r_PtxRegister4019 = ShiftRight(uint32_t(r_PtxRegister4018), uint32_t(27));				 // PTX L11349
	r_PtxRegister4020 = uint32_t(r_PtxRegister4017) + uint32_t(r_PtxRegister4019);			 // PTX L11350
	r_PtxRegister4021 = r_PtxRegister4020 & -32;											 // PTX L11351
	r_PtxRegister4022 = uint32_t(r_PtxRegister4017) - uint32_t(r_PtxRegister4021);			 // PTX L11352
	r_PtxRegister4023 =
		ShuffleIdxPredicate(r_bPtxPredicate93, r_PtxRegister3592, r_PtxRegister4022, 31, -1); // PTX L11353
	r_PtxRegister3604 = __byte_perm(r_PtxRegister4023, r_PtxRegister4023, 0x5410U);			  // PTX L11354
	r_PtxRegister4024 = uint32_t(r_PtxRegister4017) + uint32_t(8);							  // PTX L11355
	r_PtxRegister4025 = ShiftRightSigned(int32_t(r_PtxRegister4024), uint32_t(31));			  // PTX L11356
	r_PtxRegister4026 = ShiftRight(uint32_t(r_PtxRegister4025), uint32_t(27));				  // PTX L11357
	r_PtxRegister4027 = uint32_t(r_PtxRegister4024) + uint32_t(r_PtxRegister4026);			  // PTX L11358
	r_PtxRegister4028 = r_PtxRegister4027 & -32;											  // PTX L11359
	r_PtxRegister4029 = uint32_t(r_PtxRegister4024) - uint32_t(r_PtxRegister4028);			  // PTX L11360
	r_PtxRegister4030 =
		ShuffleIdxPredicate(r_bPtxPredicate94, r_PtxRegister3592, r_PtxRegister4029, 31, -1); // PTX L11361
	r_PtxRegister3607 = __byte_perm(r_PtxRegister4030, r_PtxRegister4030, 0x5410U);			  // PTX L11362
	r_PtxRegister4031 =
		ShuffleIdxPredicate(r_bPtxPredicate95, r_PtxRegister3592, r_PtxRegister4022, 31, -1); // PTX L11363
	r_PtxRegister3610 = __byte_perm(r_PtxRegister4031, r_PtxRegister4031, 0x5410U);			  // PTX L11364
	r_PtxRegister4032 =
		ShuffleIdxPredicate(r_bPtxPredicate96, r_PtxRegister3592, r_PtxRegister4029, 31, -1); // PTX L11365
	r_PtxRegister3613 = __byte_perm(r_PtxRegister4032, r_PtxRegister4032, 0x5410U);			  // PTX L11366
	r_LaneIndexAtPtx11368 = uint32_t((threadIdx.x & 31u));									  // PTX L11368
	r_PtxRegister4033 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx11368), uint32_t(31));		  // PTX L11370
	r_PtxRegister4034 = ShiftRight(uint32_t(r_PtxRegister4033), uint32_t(30));				  // PTX L11371
	r_PtxRegister4035 = uint32_t(r_LaneIndexAtPtx11368) + uint32_t(r_PtxRegister4034);		  // PTX L11372
	r_PtxRegister4036 = ShiftRightSigned(int32_t(r_PtxRegister4035), uint32_t(2));			  // PTX L11373
	r_PtxRegister4037 = ShiftRightSigned(int32_t(r_PtxRegister4035), uint32_t(31));			  // PTX L11374
	r_PtxRegister4038 = ShiftRight(uint32_t(r_PtxRegister4037), uint32_t(27));				  // PTX L11375
	r_PtxRegister4039 = uint32_t(r_PtxRegister4036) + uint32_t(r_PtxRegister4038);			  // PTX L11376
	r_PtxRegister4040 = r_PtxRegister4039 & -32;											  // PTX L11377
	r_PtxRegister4041 = uint32_t(r_PtxRegister4036) - uint32_t(r_PtxRegister4040);			  // PTX L11378
	r_PtxRegister4042 =
		ShuffleIdxPredicate(r_bPtxPredicate97, r_PtxRegister3592, r_PtxRegister4041, 31, -1); // PTX L11379
	r_PtxRegister3616 = __byte_perm(r_PtxRegister4042, r_PtxRegister4042, 0x5410U);			  // PTX L11380
	r_PtxRegister4043 = uint32_t(r_PtxRegister4036) + uint32_t(8);							  // PTX L11381
	r_PtxRegister4044 = ShiftRightSigned(int32_t(r_PtxRegister4043), uint32_t(31));			  // PTX L11382
	r_PtxRegister4045 = ShiftRight(uint32_t(r_PtxRegister4044), uint32_t(27));				  // PTX L11383
	r_PtxRegister4046 = uint32_t(r_PtxRegister4043) + uint32_t(r_PtxRegister4045);			  // PTX L11384
	r_PtxRegister4047 = r_PtxRegister4046 & -32;											  // PTX L11385
	r_PtxRegister4048 = uint32_t(r_PtxRegister4043) - uint32_t(r_PtxRegister4047);			  // PTX L11386
	r_PtxRegister4049 =
		ShuffleIdxPredicate(r_bPtxPredicate98, r_PtxRegister3592, r_PtxRegister4048, 31, -1); // PTX L11387
	r_PtxRegister3619 = __byte_perm(r_PtxRegister4049, r_PtxRegister4049, 0x5410U);			  // PTX L11388
	r_PtxRegister4050 =
		ShuffleIdxPredicate(r_bPtxPredicate99, r_PtxRegister3592, r_PtxRegister4041, 31, -1); // PTX L11389
	r_PtxRegister3622 = __byte_perm(r_PtxRegister4050, r_PtxRegister4050, 0x5410U);			  // PTX L11390
	r_PtxRegister4051 =
		ShuffleIdxPredicate(r_bPtxPredicate100, r_PtxRegister3592, r_PtxRegister4048, 31, -1); // PTX L11391
	r_PtxRegister3625 = __byte_perm(r_PtxRegister4051, r_PtxRegister4051, 0x5410U);			   // PTX L11392
	r_LaneIndexAtPtx11394 = uint32_t((threadIdx.x & 31u));									   // PTX L11394
	r_PtxRegister4052 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx11394), uint32_t(31));		   // PTX L11396
	r_PtxRegister4053 = ShiftRight(uint32_t(r_PtxRegister4052), uint32_t(30));				   // PTX L11397
	r_PtxRegister4054 = uint32_t(r_LaneIndexAtPtx11394) + uint32_t(r_PtxRegister4053);		   // PTX L11398
	r_PtxRegister4055 = ShiftRightSigned(int32_t(r_PtxRegister4054), uint32_t(2));			   // PTX L11399
	r_PtxRegister4056 = ShiftRightSigned(int32_t(r_PtxRegister4054), uint32_t(31));			   // PTX L11400
	r_PtxRegister4057 = ShiftRight(uint32_t(r_PtxRegister4056), uint32_t(27));				   // PTX L11401
	r_PtxRegister4058 = uint32_t(r_PtxRegister4055) + uint32_t(r_PtxRegister4057);			   // PTX L11402
	r_PtxRegister4059 = r_PtxRegister4058 & -32;											   // PTX L11403
	r_PtxRegister4060 = uint32_t(r_PtxRegister4055) - uint32_t(r_PtxRegister4059);			   // PTX L11404
	r_PtxRegister4061 =
		ShuffleIdxPredicate(r_bPtxPredicate101, r_PtxRegister3592, r_PtxRegister4060, 31, -1); // PTX L11405
	r_PtxRegister3628 = __byte_perm(r_PtxRegister4061, r_PtxRegister4061, 0x5410U);			   // PTX L11406
	r_PtxRegister4062 = uint32_t(r_PtxRegister4055) + uint32_t(8);							   // PTX L11407
	r_PtxRegister4063 = ShiftRightSigned(int32_t(r_PtxRegister4062), uint32_t(31));			   // PTX L11408
	r_PtxRegister4064 = ShiftRight(uint32_t(r_PtxRegister4063), uint32_t(27));				   // PTX L11409
	r_PtxRegister4065 = uint32_t(r_PtxRegister4062) + uint32_t(r_PtxRegister4064);			   // PTX L11410
	r_PtxRegister4066 = r_PtxRegister4065 & -32;											   // PTX L11411
	r_PtxRegister4067 = uint32_t(r_PtxRegister4062) - uint32_t(r_PtxRegister4066);			   // PTX L11412
	r_PtxRegister4068 =
		ShuffleIdxPredicate(r_bPtxPredicate102, r_PtxRegister3592, r_PtxRegister4067, 31, -1); // PTX L11413
	r_PtxRegister3631 = __byte_perm(r_PtxRegister4068, r_PtxRegister4068, 0x5410U);			   // PTX L11414
	r_PtxRegister4069 =
		ShuffleIdxPredicate(r_bPtxPredicate103, r_PtxRegister3592, r_PtxRegister4060, 31, -1); // PTX L11415
	r_PtxRegister3634 = __byte_perm(r_PtxRegister4069, r_PtxRegister4069, 0x5410U);			   // PTX L11416
	r_PtxRegister4070 =
		ShuffleIdxPredicate(r_bPtxPredicate104, r_PtxRegister3592, r_PtxRegister4067, 31, -1); // PTX L11417
	r_PtxRegister3637 = __byte_perm(r_PtxRegister4070, r_PtxRegister4070, 0x5410U);			   // PTX L11418
	r_LaneIndexAtPtx11420 = uint32_t((threadIdx.x & 31u));									   // PTX L11420
	r_PtxRegister4071 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx11420), uint32_t(31));		   // PTX L11422
	r_PtxRegister4072 = ShiftRight(uint32_t(r_PtxRegister4071), uint32_t(30));				   // PTX L11423
	r_PtxRegister4073 = uint32_t(r_LaneIndexAtPtx11420) + uint32_t(r_PtxRegister4072);		   // PTX L11424
	r_PtxRegister4074 = ShiftRightSigned(int32_t(r_PtxRegister4073), uint32_t(2));			   // PTX L11425
	r_PtxRegister4075 = ShiftRightSigned(int32_t(r_PtxRegister4073), uint32_t(31));			   // PTX L11426
	r_PtxRegister4076 = ShiftRight(uint32_t(r_PtxRegister4075), uint32_t(27));				   // PTX L11427
	r_PtxRegister4077 = uint32_t(r_PtxRegister4074) + uint32_t(r_PtxRegister4076);			   // PTX L11428
	r_PtxRegister4078 = r_PtxRegister4077 & -32;											   // PTX L11429
	r_PtxRegister4079 = uint32_t(r_PtxRegister4074) - uint32_t(r_PtxRegister4078);			   // PTX L11430
	r_PtxRegister4080 =
		ShuffleIdxPredicate(r_bPtxPredicate105, r_PtxRegister3592, r_PtxRegister4079, 31, -1); // PTX L11431
	r_PtxRegister3640 = __byte_perm(r_PtxRegister4080, r_PtxRegister4080, 0x5410U);			   // PTX L11432
	r_PtxRegister4081 = uint32_t(r_PtxRegister4074) + uint32_t(8);							   // PTX L11433
	r_PtxRegister4082 = ShiftRightSigned(int32_t(r_PtxRegister4081), uint32_t(31));			   // PTX L11434
	r_PtxRegister4083 = ShiftRight(uint32_t(r_PtxRegister4082), uint32_t(27));				   // PTX L11435
	r_PtxRegister4084 = uint32_t(r_PtxRegister4081) + uint32_t(r_PtxRegister4083);			   // PTX L11436
	r_PtxRegister4085 = r_PtxRegister4084 & -32;											   // PTX L11437
	r_PtxRegister4086 = uint32_t(r_PtxRegister4081) - uint32_t(r_PtxRegister4085);			   // PTX L11438
	r_PtxRegister4087 =
		ShuffleIdxPredicate(r_bPtxPredicate106, r_PtxRegister3592, r_PtxRegister4086, 31, -1); // PTX L11439
	r_PtxRegister3643 = __byte_perm(r_PtxRegister4087, r_PtxRegister4087, 0x5410U);			   // PTX L11440
	r_PtxRegister4088 =
		ShuffleIdxPredicate(r_bPtxPredicate107, r_PtxRegister3592, r_PtxRegister4079, 31, -1); // PTX L11441
	r_PtxRegister3646 = __byte_perm(r_PtxRegister4088, r_PtxRegister4088, 0x5410U);			   // PTX L11442
	r_PtxRegister4089 =
		ShuffleIdxPredicate(r_bPtxPredicate108, r_PtxRegister3592, r_PtxRegister4086, 31, -1); // PTX L11443
	r_PtxRegister3649 = __byte_perm(r_PtxRegister4089, r_PtxRegister4089, 0x5410U);			   // PTX L11444
	r_LaneIndexAtPtx11446 = uint32_t((threadIdx.x & 31u));									   // PTX L11446
	r_PtxRegister4090 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx11446), uint32_t(31));		   // PTX L11448
	r_PtxRegister4091 = ShiftRight(uint32_t(r_PtxRegister4090), uint32_t(30));				   // PTX L11449
	r_PtxRegister4092 = uint32_t(r_LaneIndexAtPtx11446) + uint32_t(r_PtxRegister4091);		   // PTX L11450
	r_PtxRegister4093 = ShiftRightSigned(int32_t(r_PtxRegister4092), uint32_t(2));			   // PTX L11451
	r_PtxRegister4094 = uint32_t(r_PtxRegister4093) + uint32_t(16);							   // PTX L11452
	r_PtxRegister4095 = ShiftRightSigned(int32_t(r_PtxRegister4094), uint32_t(31));			   // PTX L11453
	r_PtxRegister4096 = ShiftRight(uint32_t(r_PtxRegister4095), uint32_t(27));				   // PTX L11454
	r_PtxRegister4097 = uint32_t(r_PtxRegister4094) + uint32_t(r_PtxRegister4096);			   // PTX L11455
	r_PtxRegister4098 = r_PtxRegister4097 & -32;											   // PTX L11456
	r_PtxRegister4099 = uint32_t(r_PtxRegister4094) - uint32_t(r_PtxRegister4098);			   // PTX L11457
	r_PtxRegister4100 =
		ShuffleIdxPredicate(r_bPtxPredicate109, r_PtxRegister3592, r_PtxRegister4099, 31, -1); // PTX L11458
	r_PtxRegister3652 = __byte_perm(r_PtxRegister4100, r_PtxRegister4100, 0x5410U);			   // PTX L11459
	r_PtxRegister4101 = uint32_t(r_PtxRegister4093) + uint32_t(24);							   // PTX L11460
	r_PtxRegister4102 = ShiftRightSigned(int32_t(r_PtxRegister4101), uint32_t(31));			   // PTX L11461
	r_PtxRegister4103 = ShiftRight(uint32_t(r_PtxRegister4102), uint32_t(27));				   // PTX L11462
	r_PtxRegister4104 = uint32_t(r_PtxRegister4101) + uint32_t(r_PtxRegister4103);			   // PTX L11463
	r_PtxRegister4105 = r_PtxRegister4104 & -32;											   // PTX L11464
	r_PtxRegister4106 = uint32_t(r_PtxRegister4101) - uint32_t(r_PtxRegister4105);			   // PTX L11465
	r_PtxRegister4107 =
		ShuffleIdxPredicate(r_bPtxPredicate110, r_PtxRegister3592, r_PtxRegister4106, 31, -1); // PTX L11466
	r_PtxRegister3655 = __byte_perm(r_PtxRegister4107, r_PtxRegister4107, 0x5410U);			   // PTX L11467
	r_PtxRegister4108 =
		ShuffleIdxPredicate(r_bPtxPredicate111, r_PtxRegister3592, r_PtxRegister4099, 31, -1); // PTX L11468
	r_PtxRegister3658 = __byte_perm(r_PtxRegister4108, r_PtxRegister4108, 0x5410U);			   // PTX L11469
	r_PtxRegister4109 =
		ShuffleIdxPredicate(r_bPtxPredicate112, r_PtxRegister3592, r_PtxRegister4106, 31, -1); // PTX L11470
	r_PtxRegister3661 = __byte_perm(r_PtxRegister4109, r_PtxRegister4109, 0x5410U);			   // PTX L11471
	r_LaneIndexAtPtx11473 = uint32_t((threadIdx.x & 31u));									   // PTX L11473
	r_PtxRegister4110 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx11473), uint32_t(31));		   // PTX L11475
	r_PtxRegister4111 = ShiftRight(uint32_t(r_PtxRegister4110), uint32_t(30));				   // PTX L11476
	r_PtxRegister4112 = uint32_t(r_LaneIndexAtPtx11473) + uint32_t(r_PtxRegister4111);		   // PTX L11477
	r_PtxRegister4113 = ShiftRightSigned(int32_t(r_PtxRegister4112), uint32_t(2));			   // PTX L11478
	r_PtxRegister4114 = uint32_t(r_PtxRegister4113) + uint32_t(16);							   // PTX L11479
	r_PtxRegister4115 = ShiftRightSigned(int32_t(r_PtxRegister4114), uint32_t(31));			   // PTX L11480
	r_PtxRegister4116 = ShiftRight(uint32_t(r_PtxRegister4115), uint32_t(27));				   // PTX L11481
	r_PtxRegister4117 = uint32_t(r_PtxRegister4114) + uint32_t(r_PtxRegister4116);			   // PTX L11482
	r_PtxRegister4118 = r_PtxRegister4117 & -32;											   // PTX L11483
	r_PtxRegister4119 = uint32_t(r_PtxRegister4114) - uint32_t(r_PtxRegister4118);			   // PTX L11484
	r_PtxRegister4120 =
		ShuffleIdxPredicate(r_bPtxPredicate113, r_PtxRegister3592, r_PtxRegister4119, 31, -1); // PTX L11485
	r_PtxRegister3664 = __byte_perm(r_PtxRegister4120, r_PtxRegister4120, 0x5410U);			   // PTX L11486
	r_PtxRegister4121 = uint32_t(r_PtxRegister4113) + uint32_t(24);							   // PTX L11487
	r_PtxRegister4122 = ShiftRightSigned(int32_t(r_PtxRegister4121), uint32_t(31));			   // PTX L11488
	r_PtxRegister4123 = ShiftRight(uint32_t(r_PtxRegister4122), uint32_t(27));				   // PTX L11489
	r_PtxRegister4124 = uint32_t(r_PtxRegister4121) + uint32_t(r_PtxRegister4123);			   // PTX L11490
	r_PtxRegister4125 = r_PtxRegister4124 & -32;											   // PTX L11491
	r_PtxRegister4126 = uint32_t(r_PtxRegister4121) - uint32_t(r_PtxRegister4125);			   // PTX L11492
	r_PtxRegister4127 =
		ShuffleIdxPredicate(r_bPtxPredicate114, r_PtxRegister3592, r_PtxRegister4126, 31, -1); // PTX L11493
	r_PtxRegister3667 = __byte_perm(r_PtxRegister4127, r_PtxRegister4127, 0x5410U);			   // PTX L11494
	r_PtxRegister4128 =
		ShuffleIdxPredicate(r_bPtxPredicate115, r_PtxRegister3592, r_PtxRegister4119, 31, -1); // PTX L11495
	r_PtxRegister3670 = __byte_perm(r_PtxRegister4128, r_PtxRegister4128, 0x5410U);			   // PTX L11496
	r_PtxRegister4129 =
		ShuffleIdxPredicate(r_bPtxPredicate116, r_PtxRegister3592, r_PtxRegister4126, 31, -1); // PTX L11497
	r_PtxRegister3673 = __byte_perm(r_PtxRegister4129, r_PtxRegister4129, 0x5410U);			   // PTX L11498
	r_LaneIndexAtPtx11500 = uint32_t((threadIdx.x & 31u));									   // PTX L11500
	r_PtxRegister4130 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx11500), uint32_t(31));		   // PTX L11502
	r_PtxRegister4131 = ShiftRight(uint32_t(r_PtxRegister4130), uint32_t(30));				   // PTX L11503
	r_PtxRegister4132 = uint32_t(r_LaneIndexAtPtx11500) + uint32_t(r_PtxRegister4131);		   // PTX L11504
	r_PtxRegister4133 = ShiftRightSigned(int32_t(r_PtxRegister4132), uint32_t(2));			   // PTX L11505
	r_PtxRegister4134 = uint32_t(r_PtxRegister4133) + uint32_t(16);							   // PTX L11506
	r_PtxRegister4135 = ShiftRightSigned(int32_t(r_PtxRegister4134), uint32_t(31));			   // PTX L11507
	r_PtxRegister4136 = ShiftRight(uint32_t(r_PtxRegister4135), uint32_t(27));				   // PTX L11508
	r_PtxRegister4137 = uint32_t(r_PtxRegister4134) + uint32_t(r_PtxRegister4136);			   // PTX L11509
	r_PtxRegister4138 = r_PtxRegister4137 & -32;											   // PTX L11510
	r_PtxRegister4139 = uint32_t(r_PtxRegister4134) - uint32_t(r_PtxRegister4138);			   // PTX L11511
	r_PtxRegister4140 =
		ShuffleIdxPredicate(r_bPtxPredicate117, r_PtxRegister3592, r_PtxRegister4139, 31, -1); // PTX L11512
	r_PtxRegister3676 = __byte_perm(r_PtxRegister4140, r_PtxRegister4140, 0x5410U);			   // PTX L11513
	r_PtxRegister4141 = uint32_t(r_PtxRegister4133) + uint32_t(24);							   // PTX L11514
	r_PtxRegister4142 = ShiftRightSigned(int32_t(r_PtxRegister4141), uint32_t(31));			   // PTX L11515
	r_PtxRegister4143 = ShiftRight(uint32_t(r_PtxRegister4142), uint32_t(27));				   // PTX L11516
	r_PtxRegister4144 = uint32_t(r_PtxRegister4141) + uint32_t(r_PtxRegister4143);			   // PTX L11517
	r_PtxRegister4145 = r_PtxRegister4144 & -32;											   // PTX L11518
	r_PtxRegister4146 = uint32_t(r_PtxRegister4141) - uint32_t(r_PtxRegister4145);			   // PTX L11519
	r_PtxRegister4147 =
		ShuffleIdxPredicate(r_bPtxPredicate118, r_PtxRegister3592, r_PtxRegister4146, 31, -1); // PTX L11520
	r_PtxRegister3679 = __byte_perm(r_PtxRegister4147, r_PtxRegister4147, 0x5410U);			   // PTX L11521
	r_PtxRegister4148 =
		ShuffleIdxPredicate(r_bPtxPredicate119, r_PtxRegister3592, r_PtxRegister4139, 31, -1); // PTX L11522
	r_PtxRegister3682 = __byte_perm(r_PtxRegister4148, r_PtxRegister4148, 0x5410U);			   // PTX L11523
	r_PtxRegister4149 =
		ShuffleIdxPredicate(r_bPtxPredicate120, r_PtxRegister3592, r_PtxRegister4146, 31, -1); // PTX L11524
	r_PtxRegister3685 = __byte_perm(r_PtxRegister4149, r_PtxRegister4149, 0x5410U);			   // PTX L11525
	r_LaneIndexAtPtx11527 = uint32_t((threadIdx.x & 31u));									   // PTX L11527
	r_PtxRegister4150 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx11527), uint32_t(31));		   // PTX L11529
	r_PtxRegister4151 = ShiftRight(uint32_t(r_PtxRegister4150), uint32_t(30));				   // PTX L11530
	r_PtxRegister4152 = uint32_t(r_LaneIndexAtPtx11527) + uint32_t(r_PtxRegister4151);		   // PTX L11531
	r_PtxRegister4153 = ShiftRightSigned(int32_t(r_PtxRegister4152), uint32_t(2));			   // PTX L11532
	r_PtxRegister4154 = uint32_t(r_PtxRegister4153) + uint32_t(16);							   // PTX L11533
	r_PtxRegister4155 = ShiftRightSigned(int32_t(r_PtxRegister4154), uint32_t(31));			   // PTX L11534
	r_PtxRegister4156 = ShiftRight(uint32_t(r_PtxRegister4155), uint32_t(27));				   // PTX L11535
	r_PtxRegister4157 = uint32_t(r_PtxRegister4154) + uint32_t(r_PtxRegister4156);			   // PTX L11536
	r_PtxRegister4158 = r_PtxRegister4157 & -32;											   // PTX L11537
	r_PtxRegister4159 = uint32_t(r_PtxRegister4154) - uint32_t(r_PtxRegister4158);			   // PTX L11538
	r_PtxRegister4160 =
		ShuffleIdxPredicate(r_bPtxPredicate121, r_PtxRegister3592, r_PtxRegister4159, 31, -1); // PTX L11539
	r_PtxRegister3688 = __byte_perm(r_PtxRegister4160, r_PtxRegister4160, 0x5410U);			   // PTX L11540
	r_PtxRegister4161 = uint32_t(r_PtxRegister4153) + uint32_t(24);							   // PTX L11541
	r_PtxRegister4162 = ShiftRightSigned(int32_t(r_PtxRegister4161), uint32_t(31));			   // PTX L11542
	r_PtxRegister4163 = ShiftRight(uint32_t(r_PtxRegister4162), uint32_t(27));				   // PTX L11543
	r_PtxRegister4164 = uint32_t(r_PtxRegister4161) + uint32_t(r_PtxRegister4163);			   // PTX L11544
	r_PtxRegister4165 = r_PtxRegister4164 & -32;											   // PTX L11545
	r_PtxRegister4166 = uint32_t(r_PtxRegister4161) - uint32_t(r_PtxRegister4165);			   // PTX L11546
	r_PtxRegister4167 =
		ShuffleIdxPredicate(r_bPtxPredicate122, r_PtxRegister3592, r_PtxRegister4166, 31, -1); // PTX L11547
	r_PtxRegister3691 = __byte_perm(r_PtxRegister4167, r_PtxRegister4167, 0x5410U);			   // PTX L11548
	r_PtxRegister4168 =
		ShuffleIdxPredicate(r_bPtxPredicate123, r_PtxRegister3592, r_PtxRegister4159, 31, -1); // PTX L11549
	r_PtxRegister3694 = __byte_perm(r_PtxRegister4168, r_PtxRegister4168, 0x5410U);			   // PTX L11550
	r_PtxRegister4169 =
		ShuffleIdxPredicate(r_bPtxPredicate124, r_PtxRegister3592, r_PtxRegister4166, 31, -1); // PTX L11551
	r_PtxRegister3697 = __byte_perm(r_PtxRegister4169, r_PtxRegister4169, 0x5410U);			   // PTX L11552
	r_LaneIndexAtPtx11554 = uint32_t((threadIdx.x & 31u));									   // PTX L11554
	r_PackedHalf2AtPtx11557R3698 = HalfMul(r_PtxRegister3603, r_PtxRegister3604);			   // PTX L11557
	r_LaneIndexAtPtx11561 = uint32_t((threadIdx.x & 31u));									   // PTX L11561
	r_PackedHalf2AtPtx11564R3700 = HalfMul(r_PtxRegister3606, r_PtxRegister3607);			   // PTX L11564
	r_LaneIndexAtPtx11568 = uint32_t((threadIdx.x & 31u));									   // PTX L11568
	r_PackedHalf2AtPtx11571R3699 = HalfMul(r_PtxRegister3609, r_PtxRegister3610);			   // PTX L11571
	r_LaneIndexAtPtx11575 = uint32_t((threadIdx.x & 31u));									   // PTX L11575
	r_PackedHalf2AtPtx11578R3701 = HalfMul(r_PtxRegister3612, r_PtxRegister3613);			   // PTX L11578
	r_LaneIndexAtPtx11582 = uint32_t((threadIdx.x & 31u));									   // PTX L11582
	r_PackedHalf2AtPtx11585R3702 = HalfMul(r_PtxRegister3615, r_PtxRegister3616);			   // PTX L11585
	r_LaneIndexAtPtx11589 = uint32_t((threadIdx.x & 31u));									   // PTX L11589
	r_PackedHalf2AtPtx11592R3704 = HalfMul(r_PtxRegister3618, r_PtxRegister3619);			   // PTX L11592
	r_LaneIndexAtPtx11596 = uint32_t((threadIdx.x & 31u));									   // PTX L11596
	r_PackedHalf2AtPtx11599R3703 = HalfMul(r_PtxRegister3621, r_PtxRegister3622);			   // PTX L11599
	r_LaneIndexAtPtx11603 = uint32_t((threadIdx.x & 31u));									   // PTX L11603
	r_PackedHalf2AtPtx11606R3705 = HalfMul(r_PtxRegister3624, r_PtxRegister3625);			   // PTX L11606
	r_LaneIndexAtPtx11610 = uint32_t((threadIdx.x & 31u));									   // PTX L11610
	r_PackedHalf2AtPtx11613R3706 = HalfMul(r_PtxRegister3627, r_PtxRegister3628);			   // PTX L11613
	r_LaneIndexAtPtx11617 = uint32_t((threadIdx.x & 31u));									   // PTX L11617
	r_PackedHalf2AtPtx11620R3708 = HalfMul(r_PtxRegister3630, r_PtxRegister3631);			   // PTX L11620
	r_LaneIndexAtPtx11624 = uint32_t((threadIdx.x & 31u));									   // PTX L11624
	r_PackedHalf2AtPtx11627R3707 = HalfMul(r_PtxRegister3633, r_PtxRegister3634);			   // PTX L11627
	r_LaneIndexAtPtx11631 = uint32_t((threadIdx.x & 31u));									   // PTX L11631
	r_PackedHalf2AtPtx11634R3709 = HalfMul(r_PtxRegister3636, r_PtxRegister3637);			   // PTX L11634
	r_LaneIndexAtPtx11638 = uint32_t((threadIdx.x & 31u));									   // PTX L11638
	r_PackedHalf2AtPtx11641R3710 = HalfMul(r_PtxRegister3639, r_PtxRegister3640);			   // PTX L11641
	r_LaneIndexAtPtx11645 = uint32_t((threadIdx.x & 31u));									   // PTX L11645
	r_PackedHalf2AtPtx11648R3712 = HalfMul(r_PtxRegister3642, r_PtxRegister3643);			   // PTX L11648
	r_LaneIndexAtPtx11652 = uint32_t((threadIdx.x & 31u));									   // PTX L11652
	r_PackedHalf2AtPtx11655R3711 = HalfMul(r_PtxRegister3645, r_PtxRegister3646);			   // PTX L11655
	r_LaneIndexAtPtx11659 = uint32_t((threadIdx.x & 31u));									   // PTX L11659
	r_PackedHalf2AtPtx11662R3713 = HalfMul(r_PtxRegister3648, r_PtxRegister3649);			   // PTX L11662
	r_LaneIndexAtPtx11666 = uint32_t((threadIdx.x & 31u));									   // PTX L11666
	r_PackedHalf2AtPtx11669R3714 = HalfMul(r_PtxRegister3651, r_PtxRegister3652);			   // PTX L11669
	r_LaneIndexAtPtx11673 = uint32_t((threadIdx.x & 31u));									   // PTX L11673
	r_PackedHalf2AtPtx11676R3716 = HalfMul(r_PtxRegister3654, r_PtxRegister3655);			   // PTX L11676
	r_LaneIndexAtPtx11680 = uint32_t((threadIdx.x & 31u));									   // PTX L11680
	r_PackedHalf2AtPtx11683R3715 = HalfMul(r_PtxRegister3657, r_PtxRegister3658);			   // PTX L11683
	r_LaneIndexAtPtx11687 = uint32_t((threadIdx.x & 31u));									   // PTX L11687
	r_PackedHalf2AtPtx11690R3717 = HalfMul(r_PtxRegister3660, r_PtxRegister3661);			   // PTX L11690
	r_LaneIndexAtPtx11694 = uint32_t((threadIdx.x & 31u));									   // PTX L11694
	r_PackedHalf2AtPtx11697R3718 = HalfMul(r_PtxRegister3663, r_PtxRegister3664);			   // PTX L11697
	r_LaneIndexAtPtx11701 = uint32_t((threadIdx.x & 31u));									   // PTX L11701
	r_PackedHalf2AtPtx11704R3720 = HalfMul(r_PtxRegister3666, r_PtxRegister3667);			   // PTX L11704
	r_LaneIndexAtPtx11708 = uint32_t((threadIdx.x & 31u));									   // PTX L11708
	r_PackedHalf2AtPtx11711R3719 = HalfMul(r_PtxRegister3669, r_PtxRegister3670);			   // PTX L11711
	r_LaneIndexAtPtx11715 = uint32_t((threadIdx.x & 31u));									   // PTX L11715
	r_PackedHalf2AtPtx11718R3721 = HalfMul(r_PtxRegister3672, r_PtxRegister3673);			   // PTX L11718
	r_LaneIndexAtPtx11722 = uint32_t((threadIdx.x & 31u));									   // PTX L11722
	r_PackedHalf2AtPtx11725R3722 = HalfMul(r_PtxRegister3675, r_PtxRegister3676);			   // PTX L11725
	r_LaneIndexAtPtx11729 = uint32_t((threadIdx.x & 31u));									   // PTX L11729
	r_PackedHalf2AtPtx11732R3724 = HalfMul(r_PtxRegister3678, r_PtxRegister3679);			   // PTX L11732
	r_LaneIndexAtPtx11736 = uint32_t((threadIdx.x & 31u));									   // PTX L11736
	r_PackedHalf2AtPtx11739R3723 = HalfMul(r_PtxRegister3681, r_PtxRegister3682);			   // PTX L11739
	r_LaneIndexAtPtx11743 = uint32_t((threadIdx.x & 31u));									   // PTX L11743
	r_PackedHalf2AtPtx11746R3725 = HalfMul(r_PtxRegister3684, r_PtxRegister3685);			   // PTX L11746
	r_LaneIndexAtPtx11750 = uint32_t((threadIdx.x & 31u));									   // PTX L11750
	r_PackedHalf2AtPtx11753R3726 = HalfMul(r_PtxRegister3687, r_PtxRegister3688);			   // PTX L11753
	r_LaneIndexAtPtx11757 = uint32_t((threadIdx.x & 31u));									   // PTX L11757
	r_PackedHalf2AtPtx11760R3728 = HalfMul(r_PtxRegister3690, r_PtxRegister3691);			   // PTX L11760
	r_LaneIndexAtPtx11764 = uint32_t((threadIdx.x & 31u));									   // PTX L11764
	r_PackedHalf2AtPtx11767R3727 = HalfMul(r_PtxRegister3693, r_PtxRegister3694);			   // PTX L11767
	r_LaneIndexAtPtx11771 = uint32_t((threadIdx.x & 31u));									   // PTX L11771
	r_PackedHalf2AtPtx11774R3729 = HalfMul(r_PtxRegister3696, r_PtxRegister3697);			   // PTX L11774
	r_ConvertedE4PairAtPtx11778Rs408 = PublishE4(r_PackedHalf2AtPtx11557R3698);				   // PTX L11778
	r_ConvertedE4PairAtPtx11781Rs409 = PublishE4(r_PackedHalf2AtPtx11571R3699);				   // PTX L11781
	r_MmaAE4x4WordAtPtx11783R3730 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11778Rs408, r_ConvertedE4PairAtPtx11781Rs409); // PTX L11783
	r_ConvertedE4PairAtPtx11785Rs410 = PublishE4(r_PackedHalf2AtPtx11564R3700);				 // PTX L11785
	r_ConvertedE4PairAtPtx11788Rs411 = PublishE4(r_PackedHalf2AtPtx11578R3701);				 // PTX L11788
	r_MmaAE4x4WordAtPtx11790R3731 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11785Rs410, r_ConvertedE4PairAtPtx11788Rs411); // PTX L11790
	r_ConvertedE4PairAtPtx11792Rs412 = PublishE4(r_PackedHalf2AtPtx11585R3702);				 // PTX L11792
	r_ConvertedE4PairAtPtx11795Rs413 = PublishE4(r_PackedHalf2AtPtx11599R3703);				 // PTX L11795
	r_MmaAE4x4WordAtPtx11797R3732 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11792Rs412, r_ConvertedE4PairAtPtx11795Rs413); // PTX L11797
	r_ConvertedE4PairAtPtx11799Rs414 = PublishE4(r_PackedHalf2AtPtx11592R3704);				 // PTX L11799
	r_ConvertedE4PairAtPtx11802Rs415 = PublishE4(r_PackedHalf2AtPtx11606R3705);				 // PTX L11802
	r_MmaAE4x4WordAtPtx11804R3733 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11799Rs414, r_ConvertedE4PairAtPtx11802Rs415); // PTX L11804
	r_ConvertedE4PairAtPtx11806Rs416 = PublishE4(r_PackedHalf2AtPtx11613R3706);				 // PTX L11806
	r_ConvertedE4PairAtPtx11809Rs417 = PublishE4(r_PackedHalf2AtPtx11627R3707);				 // PTX L11809
	r_MmaAE4x4WordAtPtx11811R3736 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11806Rs416, r_ConvertedE4PairAtPtx11809Rs417); // PTX L11811
	r_ConvertedE4PairAtPtx11813Rs418 = PublishE4(r_PackedHalf2AtPtx11620R3708);				 // PTX L11813
	r_ConvertedE4PairAtPtx11816Rs419 = PublishE4(r_PackedHalf2AtPtx11634R3709);				 // PTX L11816
	r_MmaAE4x4WordAtPtx11818R3737 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11813Rs418, r_ConvertedE4PairAtPtx11816Rs419); // PTX L11818
	r_ConvertedE4PairAtPtx11820Rs420 = PublishE4(r_PackedHalf2AtPtx11641R3710);				 // PTX L11820
	r_ConvertedE4PairAtPtx11823Rs421 = PublishE4(r_PackedHalf2AtPtx11655R3711);				 // PTX L11823
	r_MmaAE4x4WordAtPtx11825R3738 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11820Rs420, r_ConvertedE4PairAtPtx11823Rs421); // PTX L11825
	r_ConvertedE4PairAtPtx11827Rs422 = PublishE4(r_PackedHalf2AtPtx11648R3712);				 // PTX L11827
	r_ConvertedE4PairAtPtx11830Rs423 = PublishE4(r_PackedHalf2AtPtx11662R3713);				 // PTX L11830
	r_MmaAE4x4WordAtPtx11832R3739 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11827Rs422, r_ConvertedE4PairAtPtx11830Rs423); // PTX L11832
	r_ConvertedE4PairAtPtx11834Rs424 = PublishE4(r_PackedHalf2AtPtx11669R3714);				 // PTX L11834
	r_ConvertedE4PairAtPtx11837Rs425 = PublishE4(r_PackedHalf2AtPtx11683R3715);				 // PTX L11837
	r_MmaAE4x4WordAtPtx11839R3746 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11834Rs424, r_ConvertedE4PairAtPtx11837Rs425); // PTX L11839
	r_ConvertedE4PairAtPtx11841Rs426 = PublishE4(r_PackedHalf2AtPtx11676R3716);				 // PTX L11841
	r_ConvertedE4PairAtPtx11844Rs427 = PublishE4(r_PackedHalf2AtPtx11690R3717);				 // PTX L11844
	r_MmaAE4x4WordAtPtx11846R3747 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11841Rs426, r_ConvertedE4PairAtPtx11844Rs427); // PTX L11846
	r_ConvertedE4PairAtPtx11848Rs428 = PublishE4(r_PackedHalf2AtPtx11697R3718);				 // PTX L11848
	r_ConvertedE4PairAtPtx11851Rs429 = PublishE4(r_PackedHalf2AtPtx11711R3719);				 // PTX L11851
	r_MmaAE4x4WordAtPtx11853R3748 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11848Rs428, r_ConvertedE4PairAtPtx11851Rs429); // PTX L11853
	r_ConvertedE4PairAtPtx11855Rs430 = PublishE4(r_PackedHalf2AtPtx11704R3720);				 // PTX L11855
	r_ConvertedE4PairAtPtx11858Rs431 = PublishE4(r_PackedHalf2AtPtx11718R3721);				 // PTX L11858
	r_MmaAE4x4WordAtPtx11860R3749 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11855Rs430, r_ConvertedE4PairAtPtx11858Rs431); // PTX L11860
	r_ConvertedE4PairAtPtx11862Rs432 = PublishE4(r_PackedHalf2AtPtx11725R3722);				 // PTX L11862
	r_ConvertedE4PairAtPtx11865Rs433 = PublishE4(r_PackedHalf2AtPtx11739R3723);				 // PTX L11865
	r_MmaAE4x4WordAtPtx11867R3752 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11862Rs432, r_ConvertedE4PairAtPtx11865Rs433); // PTX L11867
	r_ConvertedE4PairAtPtx11869Rs434 = PublishE4(r_PackedHalf2AtPtx11732R3724);				 // PTX L11869
	r_ConvertedE4PairAtPtx11872Rs435 = PublishE4(r_PackedHalf2AtPtx11746R3725);				 // PTX L11872
	r_MmaAE4x4WordAtPtx11874R3753 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11869Rs434, r_ConvertedE4PairAtPtx11872Rs435); // PTX L11874
	r_ConvertedE4PairAtPtx11876Rs436 = PublishE4(r_PackedHalf2AtPtx11753R3726);				 // PTX L11876
	r_ConvertedE4PairAtPtx11879Rs437 = PublishE4(r_PackedHalf2AtPtx11767R3727);				 // PTX L11879
	r_MmaAE4x4WordAtPtx11881R3754 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11876Rs436, r_ConvertedE4PairAtPtx11879Rs437); // PTX L11881
	r_ConvertedE4PairAtPtx11883Rs438 = PublishE4(r_PackedHalf2AtPtx11760R3728);				 // PTX L11883
	r_ConvertedE4PairAtPtx11886Rs439 = PublishE4(r_PackedHalf2AtPtx11774R3729);				 // PTX L11886
	r_MmaAE4x4WordAtPtx11888R3755 =
		JoinConvertedE4(r_ConvertedE4PairAtPtx11883Rs438, r_ConvertedE4PairAtPtx11886Rs439); // PTX L11888
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11890R3734, r_MmaAccumulatorHalf2WordAtPtx11890R3735,
		  r_MmaAE4x4WordAtPtx11783R3730, r_MmaAE4x4WordAtPtx11790R3731, r_MmaAE4x4WordAtPtx11797R3732,
		  r_MmaAE4x4WordAtPtx11804R3733, r_MmaBE4x4WordAtPtx7941R2723, r_MmaBE4x4WordAtPtx7948R2724,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L11890
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11897R3740, r_MmaAccumulatorHalf2WordAtPtx11897R3741,
		  r_MmaAE4x4WordAtPtx11783R3730, r_MmaAE4x4WordAtPtx11790R3731, r_MmaAE4x4WordAtPtx11797R3732,
		  r_MmaAE4x4WordAtPtx11804R3733, r_MmaBE4x4WordAtPtx7955R2729, r_MmaBE4x4WordAtPtx7962R2730,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L11897
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11904R3838, r_MmaAccumulatorHalf2WordAtPtx11904R3840,
		  r_MmaAE4x4WordAtPtx11811R3736, r_MmaAE4x4WordAtPtx11818R3737, r_MmaAE4x4WordAtPtx11825R3738,
		  r_MmaAE4x4WordAtPtx11832R3739, r_MmaBE4x4WordAtPtx7997R2731, r_MmaBE4x4WordAtPtx8004R2732,
		  r_MmaAccumulatorHalf2WordAtPtx11890R3734,
		  r_MmaAccumulatorHalf2WordAtPtx11890R3735); // PTX L11904
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11911R3839, r_MmaAccumulatorHalf2WordAtPtx11911R3841,
		  r_MmaAE4x4WordAtPtx11811R3736, r_MmaAE4x4WordAtPtx11818R3737, r_MmaAE4x4WordAtPtx11825R3738,
		  r_MmaAE4x4WordAtPtx11832R3739, r_MmaBE4x4WordAtPtx8011R2739, r_MmaBE4x4WordAtPtx8018R2740,
		  r_MmaAccumulatorHalf2WordAtPtx11897R3740,
		  r_MmaAccumulatorHalf2WordAtPtx11897R3741); // PTX L11911
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11918R3742, r_MmaAccumulatorHalf2WordAtPtx11918R3743,
		  r_MmaAE4x4WordAtPtx11783R3730, r_MmaAE4x4WordAtPtx11790R3731, r_MmaAE4x4WordAtPtx11797R3732,
		  r_MmaAE4x4WordAtPtx11804R3733, r_MmaBE4x4WordAtPtx7969R2743, r_MmaBE4x4WordAtPtx7976R2744,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L11918
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11925R3744, r_MmaAccumulatorHalf2WordAtPtx11925R3745,
		  r_MmaAE4x4WordAtPtx11783R3730, r_MmaAE4x4WordAtPtx11790R3731, r_MmaAE4x4WordAtPtx11797R3732,
		  r_MmaAE4x4WordAtPtx11804R3733, r_MmaBE4x4WordAtPtx7983R2745, r_MmaBE4x4WordAtPtx7990R2746,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L11925
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11932R3842, r_MmaAccumulatorHalf2WordAtPtx11932R3844,
		  r_MmaAE4x4WordAtPtx11811R3736, r_MmaAE4x4WordAtPtx11818R3737, r_MmaAE4x4WordAtPtx11825R3738,
		  r_MmaAE4x4WordAtPtx11832R3739, r_MmaBE4x4WordAtPtx8025R2747, r_MmaBE4x4WordAtPtx8032R2748,
		  r_MmaAccumulatorHalf2WordAtPtx11918R3742,
		  r_MmaAccumulatorHalf2WordAtPtx11918R3743); // PTX L11932
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11939R3843, r_MmaAccumulatorHalf2WordAtPtx11939R3845,
		  r_MmaAE4x4WordAtPtx11811R3736, r_MmaAE4x4WordAtPtx11818R3737, r_MmaAE4x4WordAtPtx11825R3738,
		  r_MmaAE4x4WordAtPtx11832R3739, r_MmaBE4x4WordAtPtx8039R2751, r_MmaBE4x4WordAtPtx8046R2752,
		  r_MmaAccumulatorHalf2WordAtPtx11925R3744,
		  r_MmaAccumulatorHalf2WordAtPtx11925R3745); // PTX L11939
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11946R3750, r_MmaAccumulatorHalf2WordAtPtx11946R3751,
		  r_MmaAE4x4WordAtPtx11839R3746, r_MmaAE4x4WordAtPtx11846R3747, r_MmaAE4x4WordAtPtx11853R3748,
		  r_MmaAE4x4WordAtPtx11860R3749, r_MmaBE4x4WordAtPtx7941R2723, r_MmaBE4x4WordAtPtx7948R2724,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L11946
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11953R3756, r_MmaAccumulatorHalf2WordAtPtx11953R3757,
		  r_MmaAE4x4WordAtPtx11839R3746, r_MmaAE4x4WordAtPtx11846R3747, r_MmaAE4x4WordAtPtx11853R3748,
		  r_MmaAE4x4WordAtPtx11860R3749, r_MmaBE4x4WordAtPtx7955R2729, r_MmaBE4x4WordAtPtx7962R2730,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L11953
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11960R3846, r_MmaAccumulatorHalf2WordAtPtx11960R3848,
		  r_MmaAE4x4WordAtPtx11867R3752, r_MmaAE4x4WordAtPtx11874R3753, r_MmaAE4x4WordAtPtx11881R3754,
		  r_MmaAE4x4WordAtPtx11888R3755, r_MmaBE4x4WordAtPtx7997R2731, r_MmaBE4x4WordAtPtx8004R2732,
		  r_MmaAccumulatorHalf2WordAtPtx11946R3750,
		  r_MmaAccumulatorHalf2WordAtPtx11946R3751); // PTX L11960
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11967R3847, r_MmaAccumulatorHalf2WordAtPtx11967R3849,
		  r_MmaAE4x4WordAtPtx11867R3752, r_MmaAE4x4WordAtPtx11874R3753, r_MmaAE4x4WordAtPtx11881R3754,
		  r_MmaAE4x4WordAtPtx11888R3755, r_MmaBE4x4WordAtPtx8011R2739, r_MmaBE4x4WordAtPtx8018R2740,
		  r_MmaAccumulatorHalf2WordAtPtx11953R3756,
		  r_MmaAccumulatorHalf2WordAtPtx11953R3757); // PTX L11967
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11974R3758, r_MmaAccumulatorHalf2WordAtPtx11974R3759,
		  r_MmaAE4x4WordAtPtx11839R3746, r_MmaAE4x4WordAtPtx11846R3747, r_MmaAE4x4WordAtPtx11853R3748,
		  r_MmaAE4x4WordAtPtx11860R3749, r_MmaBE4x4WordAtPtx7969R2743, r_MmaBE4x4WordAtPtx7976R2744,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L11974
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11981R3760, r_MmaAccumulatorHalf2WordAtPtx11981R3761,
		  r_MmaAE4x4WordAtPtx11839R3746, r_MmaAE4x4WordAtPtx11846R3747, r_MmaAE4x4WordAtPtx11853R3748,
		  r_MmaAE4x4WordAtPtx11860R3749, r_MmaBE4x4WordAtPtx7983R2745, r_MmaBE4x4WordAtPtx7990R2746,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L11981
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11988R3850, r_MmaAccumulatorHalf2WordAtPtx11988R3852,
		  r_MmaAE4x4WordAtPtx11867R3752, r_MmaAE4x4WordAtPtx11874R3753, r_MmaAE4x4WordAtPtx11881R3754,
		  r_MmaAE4x4WordAtPtx11888R3755, r_MmaBE4x4WordAtPtx8025R2747, r_MmaBE4x4WordAtPtx8032R2748,
		  r_MmaAccumulatorHalf2WordAtPtx11974R3758,
		  r_MmaAccumulatorHalf2WordAtPtx11974R3759); // PTX L11988
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx11995R3851, r_MmaAccumulatorHalf2WordAtPtx11995R3853,
		  r_MmaAE4x4WordAtPtx11867R3752, r_MmaAE4x4WordAtPtx11874R3753, r_MmaAE4x4WordAtPtx11881R3754,
		  r_MmaAE4x4WordAtPtx11888R3755, r_MmaBE4x4WordAtPtx8039R2751, r_MmaBE4x4WordAtPtx8046R2752,
		  r_MmaAccumulatorHalf2WordAtPtx11981R3760,
		  r_MmaAccumulatorHalf2WordAtPtx11981R3761);							 // PTX L11995
	r_LaneIndexAtPtx12002 = uint32_t((threadIdx.x & 31u));						 // PTX L12002
	r_PtxRegister4170 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12002), uint32_t(4)); // PTX L12004
	r_PtxRegister4171 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister4170); // PTX L12005
	r_PtxRegister3767 = uint32_t(r_PtxRegister4171) + uint32_t(2048);			 // PTX L12006
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister3767));
		r_PtxRegister3763 = r_Value.x;
		r_PtxRegister3764 = r_Value.y;
		r_PtxRegister3765 = r_Value.z;
		r_PtxRegister3766 = r_Value.w;
	} // PTX L12008
	r_LaneIndexAtPtx12011 = uint32_t((threadIdx.x & 31u));						 // PTX L12011
	r_PtxRegister4172 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12011), uint32_t(4)); // PTX L12013
	r_PtxRegister4173 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister4172); // PTX L12014
	r_PtxRegister3773 = uint32_t(r_PtxRegister4173) + uint32_t(3072);			 // PTX L12015
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister3773));
		r_PtxRegister3769 = r_Value.x;
		r_PtxRegister3770 = r_Value.y;
		r_PtxRegister3771 = r_Value.z;
		r_PtxRegister3772 = r_Value.w;
	} // PTX L12017
	r_PtxU16Register440 = uint16_t(r_PtxRegister3763);
	r_PtxU16Register441 = uint16_t(r_PtxRegister3763 >> 16);	  // PTX L12019
	r_PackedHalf2AtPtx12021R3791 = DecodeE4(r_PtxU16Register440); // PTX L12021
	r_PackedHalf2AtPtx12024R3797 = DecodeE4(r_PtxU16Register441); // PTX L12024
	r_PtxU16Register442 = uint16_t(r_PtxRegister3764);
	r_PtxU16Register443 = uint16_t(r_PtxRegister3764 >> 16);	  // PTX L12026
	r_PackedHalf2AtPtx12028R3794 = DecodeE4(r_PtxU16Register442); // PTX L12028
	r_PackedHalf2AtPtx12031R3800 = DecodeE4(r_PtxU16Register443); // PTX L12031
	r_PtxU16Register444 = uint16_t(r_PtxRegister3765);
	r_PtxU16Register445 = uint16_t(r_PtxRegister3765 >> 16);	  // PTX L12033
	r_PackedHalf2AtPtx12035R3803 = DecodeE4(r_PtxU16Register444); // PTX L12035
	r_PackedHalf2AtPtx12038R3809 = DecodeE4(r_PtxU16Register445); // PTX L12038
	r_PtxU16Register446 = uint16_t(r_PtxRegister3766);
	r_PtxU16Register447 = uint16_t(r_PtxRegister3766 >> 16);	  // PTX L12040
	r_PackedHalf2AtPtx12042R3806 = DecodeE4(r_PtxU16Register446); // PTX L12042
	r_PackedHalf2AtPtx12045R3812 = DecodeE4(r_PtxU16Register447); // PTX L12045
	r_PtxU16Register448 = uint16_t(r_PtxRegister3769);
	r_PtxU16Register449 = uint16_t(r_PtxRegister3769 >> 16);	  // PTX L12047
	r_PackedHalf2AtPtx12049R3815 = DecodeE4(r_PtxU16Register448); // PTX L12049
	r_PackedHalf2AtPtx12052R3821 = DecodeE4(r_PtxU16Register449); // PTX L12052
	r_PtxU16Register450 = uint16_t(r_PtxRegister3770);
	r_PtxU16Register451 = uint16_t(r_PtxRegister3770 >> 16);	  // PTX L12054
	r_PackedHalf2AtPtx12056R3818 = DecodeE4(r_PtxU16Register450); // PTX L12056
	r_PackedHalf2AtPtx12059R3824 = DecodeE4(r_PtxU16Register451); // PTX L12059
	r_PtxU16Register452 = uint16_t(r_PtxRegister3771);
	r_PtxU16Register453 = uint16_t(r_PtxRegister3771 >> 16);	  // PTX L12061
	r_PackedHalf2AtPtx12063R3827 = DecodeE4(r_PtxU16Register452); // PTX L12063
	r_PackedHalf2AtPtx12066R3833 = DecodeE4(r_PtxU16Register453); // PTX L12066
	r_PtxU16Register454 = uint16_t(r_PtxRegister3772);
	r_PtxU16Register455 = uint16_t(r_PtxRegister3772 >> 16);								   // PTX L12068
	r_PackedHalf2AtPtx12070R3830 = DecodeE4(r_PtxU16Register454);							   // PTX L12070
	r_PackedHalf2AtPtx12073R3836 = DecodeE4(r_PtxU16Register455);							   // PTX L12073
	r_LaneIndexAtPtx12076 = uint32_t((threadIdx.x & 31u));									   // PTX L12076
	r_PtxRegister4174 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12076), uint32_t(31));		   // PTX L12078
	r_PtxRegister4175 = ShiftRight(uint32_t(r_PtxRegister4174), uint32_t(30));				   // PTX L12079
	r_PtxRegister4176 = uint32_t(r_LaneIndexAtPtx12076) + uint32_t(r_PtxRegister4175);		   // PTX L12080
	r_PtxRegister4177 = r_PtxRegister4176 & 2147483644;										   // PTX L12081
	r_PtxRegister4178 = uint32_t(r_LaneIndexAtPtx12076) - uint32_t(r_PtxRegister4177);		   // PTX L12082
	r_PtxRegister4179 = ShiftLeft(uint32_t(r_PtxRegister4178), uint32_t(1));				   // PTX L12083
	r_PtxRegister4180 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister4179);			   // PTX L12084
	r_PtxRegister4181 = ShiftRightSigned(int32_t(r_PtxRegister4180), uint32_t(1));			   // PTX L12085
	g_RecordByteAddressAtPtx12086 = g_RecordBaseAddress;									   // PTX L12086
	r_PtxU64Register328 = uint64_t(int64_t(int32_t(r_PtxRegister4181)) * int64_t(int32_t(4))); // PTX L12087
	g_RecordByteAddressAtPtx12088 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register328); // PTX L12088
	r_PtxRegister3792 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12088 + 61616ull);		   // PTX L12089
	r_LaneIndexAtPtx12091 = uint32_t((threadIdx.x & 31u));									   // PTX L12091
	r_PtxRegister4182 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12091), uint32_t(31));		   // PTX L12093
	r_PtxRegister4183 = ShiftRight(uint32_t(r_PtxRegister4182), uint32_t(30));				   // PTX L12094
	r_PtxRegister4184 = uint32_t(r_LaneIndexAtPtx12091) + uint32_t(r_PtxRegister4183);		   // PTX L12095
	r_PtxRegister4185 = r_PtxRegister4184 & 2147483644;										   // PTX L12096
	r_PtxRegister4186 = uint32_t(r_LaneIndexAtPtx12091) - uint32_t(r_PtxRegister4185);		   // PTX L12097
	r_PtxRegister4187 = ShiftLeft(uint32_t(r_PtxRegister4186), uint32_t(1));				   // PTX L12098
	r_PtxRegister4188 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister4187);			   // PTX L12099
	r_PtxRegister4189 = ShiftRightSigned(int32_t(r_PtxRegister4188), uint32_t(1));			   // PTX L12100
	r_PtxU64Register330 = uint64_t(int64_t(int32_t(r_PtxRegister4189)) * int64_t(int32_t(4))); // PTX L12101
	g_RecordByteAddressAtPtx12102 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register330); // PTX L12102
	r_PtxRegister3795 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12102 + 61616ull);	 // PTX L12103
	r_LaneIndexAtPtx12105 = uint32_t((threadIdx.x & 31u));								 // PTX L12105
	r_PtxRegister4190 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12105), uint32_t(31));	 // PTX L12107
	r_PtxRegister4191 = ShiftRight(uint32_t(r_PtxRegister4190), uint32_t(30));			 // PTX L12108
	r_PtxRegister4192 = uint32_t(r_LaneIndexAtPtx12105) + uint32_t(r_PtxRegister4191);	 // PTX L12109
	r_PtxRegister4193 = r_PtxRegister4192 & -4;											 // PTX L12110
	r_PtxRegister4194 = uint32_t(r_LaneIndexAtPtx12105) - uint32_t(r_PtxRegister4193);	 // PTX L12111
	r_PtxRegister4195 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister4194);		 // PTX L12112
	r_PtxU64Register332 = uint64_t(uint32_t(r_PtxRegister4195)) * uint64_t(uint32_t(4)); // PTX L12113
	g_RecordByteAddressAtPtx12114 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register332); // PTX L12114
	r_PtxRegister3798 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12114 + 61616ull);	 // PTX L12115
	r_LaneIndexAtPtx12117 = uint32_t((threadIdx.x & 31u));								 // PTX L12117
	r_PtxRegister4196 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12117), uint32_t(31));	 // PTX L12119
	r_PtxRegister4197 = ShiftRight(uint32_t(r_PtxRegister4196), uint32_t(30));			 // PTX L12120
	r_PtxRegister4198 = uint32_t(r_LaneIndexAtPtx12117) + uint32_t(r_PtxRegister4197);	 // PTX L12121
	r_PtxRegister4199 = r_PtxRegister4198 & -4;											 // PTX L12122
	r_PtxRegister4200 = uint32_t(r_LaneIndexAtPtx12117) - uint32_t(r_PtxRegister4199);	 // PTX L12123
	r_PtxRegister4201 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister4200);		 // PTX L12124
	r_PtxU64Register334 = uint64_t(uint32_t(r_PtxRegister4201)) * uint64_t(uint32_t(4)); // PTX L12125
	g_RecordByteAddressAtPtx12126 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register334); // PTX L12126
	r_PtxRegister3801 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12126 + 61616ull);	 // PTX L12127
	r_LaneIndexAtPtx12129 = uint32_t((threadIdx.x & 31u));								 // PTX L12129
	r_PtxRegister4202 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12129), uint32_t(31));	 // PTX L12131
	r_PtxRegister4203 = ShiftRight(uint32_t(r_PtxRegister4202), uint32_t(30));			 // PTX L12132
	r_PtxRegister4204 = uint32_t(r_LaneIndexAtPtx12129) + uint32_t(r_PtxRegister4203);	 // PTX L12133
	r_PtxRegister4205 = r_PtxRegister4204 & -4;											 // PTX L12134
	r_PtxRegister4206 = uint32_t(r_LaneIndexAtPtx12129) - uint32_t(r_PtxRegister4205);	 // PTX L12135
	r_PtxRegister4207 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister4206);		 // PTX L12136
	r_PtxU64Register336 = uint64_t(uint32_t(r_PtxRegister4207)) * uint64_t(uint32_t(4)); // PTX L12137
	g_RecordByteAddressAtPtx12138 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register336); // PTX L12138
	r_PtxRegister3804 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12138 + 61616ull);	 // PTX L12139
	r_LaneIndexAtPtx12141 = uint32_t((threadIdx.x & 31u));								 // PTX L12141
	r_PtxRegister4208 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12141), uint32_t(31));	 // PTX L12143
	r_PtxRegister4209 = ShiftRight(uint32_t(r_PtxRegister4208), uint32_t(30));			 // PTX L12144
	r_PtxRegister4210 = uint32_t(r_LaneIndexAtPtx12141) + uint32_t(r_PtxRegister4209);	 // PTX L12145
	r_PtxRegister4211 = r_PtxRegister4210 & -4;											 // PTX L12146
	r_PtxRegister4212 = uint32_t(r_LaneIndexAtPtx12141) - uint32_t(r_PtxRegister4211);	 // PTX L12147
	r_PtxRegister4213 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister4212);		 // PTX L12148
	r_PtxU64Register338 = uint64_t(uint32_t(r_PtxRegister4213)) * uint64_t(uint32_t(4)); // PTX L12149
	g_RecordByteAddressAtPtx12150 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register338); // PTX L12150
	r_PtxRegister3807 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12150 + 61616ull);	 // PTX L12151
	r_LaneIndexAtPtx12153 = uint32_t((threadIdx.x & 31u));								 // PTX L12153
	r_PtxRegister4214 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12153), uint32_t(31));	 // PTX L12155
	r_PtxRegister4215 = ShiftRight(uint32_t(r_PtxRegister4214), uint32_t(30));			 // PTX L12156
	r_PtxRegister4216 = uint32_t(r_LaneIndexAtPtx12153) + uint32_t(r_PtxRegister4215);	 // PTX L12157
	r_PtxRegister4217 = r_PtxRegister4216 & -4;											 // PTX L12158
	r_PtxRegister4218 = uint32_t(r_LaneIndexAtPtx12153) - uint32_t(r_PtxRegister4217);	 // PTX L12159
	r_PtxRegister4219 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister4218);		 // PTX L12160
	r_PtxU64Register340 = uint64_t(uint32_t(r_PtxRegister4219)) * uint64_t(uint32_t(4)); // PTX L12161
	g_RecordByteAddressAtPtx12162 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register340); // PTX L12162
	r_PtxRegister3810 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12162 + 61616ull);	 // PTX L12163
	r_LaneIndexAtPtx12165 = uint32_t((threadIdx.x & 31u));								 // PTX L12165
	r_PtxRegister4220 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12165), uint32_t(31));	 // PTX L12167
	r_PtxRegister4221 = ShiftRight(uint32_t(r_PtxRegister4220), uint32_t(30));			 // PTX L12168
	r_PtxRegister4222 = uint32_t(r_LaneIndexAtPtx12165) + uint32_t(r_PtxRegister4221);	 // PTX L12169
	r_PtxRegister4223 = r_PtxRegister4222 & -4;											 // PTX L12170
	r_PtxRegister4224 = uint32_t(r_LaneIndexAtPtx12165) - uint32_t(r_PtxRegister4223);	 // PTX L12171
	r_PtxRegister4225 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister4224);		 // PTX L12172
	r_PtxU64Register342 = uint64_t(uint32_t(r_PtxRegister4225)) * uint64_t(uint32_t(4)); // PTX L12173
	g_RecordByteAddressAtPtx12174 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register342); // PTX L12174
	r_PtxRegister3813 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12174 + 61616ull);		   // PTX L12175
	r_LaneIndexAtPtx12177 = uint32_t((threadIdx.x & 31u));									   // PTX L12177
	r_PtxRegister4226 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12177), uint32_t(31));		   // PTX L12179
	r_PtxRegister4227 = ShiftRight(uint32_t(r_PtxRegister4226), uint32_t(30));				   // PTX L12180
	r_PtxRegister4228 = uint32_t(r_LaneIndexAtPtx12177) + uint32_t(r_PtxRegister4227);		   // PTX L12181
	r_PtxRegister4229 = r_PtxRegister4228 & 2147483644;										   // PTX L12182
	r_PtxRegister4230 = uint32_t(r_LaneIndexAtPtx12177) - uint32_t(r_PtxRegister4229);		   // PTX L12183
	r_PtxRegister4231 = ShiftLeft(uint32_t(r_PtxRegister4230), uint32_t(1));				   // PTX L12184
	r_PtxRegister4232 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister4231);			   // PTX L12185
	r_PtxRegister4233 = ShiftRightSigned(int32_t(r_PtxRegister4232), uint32_t(1));			   // PTX L12186
	r_PtxU64Register344 = uint64_t(int64_t(int32_t(r_PtxRegister4233)) * int64_t(int32_t(4))); // PTX L12187
	g_RecordByteAddressAtPtx12188 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register344); // PTX L12188
	r_PtxRegister3816 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12188 + 61616ull);		   // PTX L12189
	r_LaneIndexAtPtx12191 = uint32_t((threadIdx.x & 31u));									   // PTX L12191
	r_PtxRegister4234 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12191), uint32_t(31));		   // PTX L12193
	r_PtxRegister4235 = ShiftRight(uint32_t(r_PtxRegister4234), uint32_t(30));				   // PTX L12194
	r_PtxRegister4236 = uint32_t(r_LaneIndexAtPtx12191) + uint32_t(r_PtxRegister4235);		   // PTX L12195
	r_PtxRegister4237 = r_PtxRegister4236 & 2147483644;										   // PTX L12196
	r_PtxRegister4238 = uint32_t(r_LaneIndexAtPtx12191) - uint32_t(r_PtxRegister4237);		   // PTX L12197
	r_PtxRegister4239 = ShiftLeft(uint32_t(r_PtxRegister4238), uint32_t(1));				   // PTX L12198
	r_PtxRegister4240 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister4239);			   // PTX L12199
	r_PtxRegister4241 = ShiftRightSigned(int32_t(r_PtxRegister4240), uint32_t(1));			   // PTX L12200
	r_PtxU64Register346 = uint64_t(int64_t(int32_t(r_PtxRegister4241)) * int64_t(int32_t(4))); // PTX L12201
	g_RecordByteAddressAtPtx12202 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register346); // PTX L12202
	r_PtxRegister3819 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12202 + 61616ull);	 // PTX L12203
	r_LaneIndexAtPtx12205 = uint32_t((threadIdx.x & 31u));								 // PTX L12205
	r_PtxRegister4242 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12205), uint32_t(31));	 // PTX L12207
	r_PtxRegister4243 = ShiftRight(uint32_t(r_PtxRegister4242), uint32_t(30));			 // PTX L12208
	r_PtxRegister4244 = uint32_t(r_LaneIndexAtPtx12205) + uint32_t(r_PtxRegister4243);	 // PTX L12209
	r_PtxRegister4245 = r_PtxRegister4244 & -4;											 // PTX L12210
	r_PtxRegister4246 = uint32_t(r_LaneIndexAtPtx12205) - uint32_t(r_PtxRegister4245);	 // PTX L12211
	r_PtxRegister4247 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister4246);		 // PTX L12212
	r_PtxU64Register348 = uint64_t(uint32_t(r_PtxRegister4247)) * uint64_t(uint32_t(4)); // PTX L12213
	g_RecordByteAddressAtPtx12214 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register348); // PTX L12214
	r_PtxRegister3822 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12214 + 61616ull);	 // PTX L12215
	r_LaneIndexAtPtx12217 = uint32_t((threadIdx.x & 31u));								 // PTX L12217
	r_PtxRegister4248 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12217), uint32_t(31));	 // PTX L12219
	r_PtxRegister4249 = ShiftRight(uint32_t(r_PtxRegister4248), uint32_t(30));			 // PTX L12220
	r_PtxRegister4250 = uint32_t(r_LaneIndexAtPtx12217) + uint32_t(r_PtxRegister4249);	 // PTX L12221
	r_PtxRegister4251 = r_PtxRegister4250 & -4;											 // PTX L12222
	r_PtxRegister4252 = uint32_t(r_LaneIndexAtPtx12217) - uint32_t(r_PtxRegister4251);	 // PTX L12223
	r_PtxRegister4253 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister4252);		 // PTX L12224
	r_PtxU64Register350 = uint64_t(uint32_t(r_PtxRegister4253)) * uint64_t(uint32_t(4)); // PTX L12225
	g_RecordByteAddressAtPtx12226 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register350); // PTX L12226
	r_PtxRegister3825 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12226 + 61616ull);	 // PTX L12227
	r_LaneIndexAtPtx12229 = uint32_t((threadIdx.x & 31u));								 // PTX L12229
	r_PtxRegister4254 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12229), uint32_t(31));	 // PTX L12231
	r_PtxRegister4255 = ShiftRight(uint32_t(r_PtxRegister4254), uint32_t(30));			 // PTX L12232
	r_PtxRegister4256 = uint32_t(r_LaneIndexAtPtx12229) + uint32_t(r_PtxRegister4255);	 // PTX L12233
	r_PtxRegister4257 = r_PtxRegister4256 & -4;											 // PTX L12234
	r_PtxRegister4258 = uint32_t(r_LaneIndexAtPtx12229) - uint32_t(r_PtxRegister4257);	 // PTX L12235
	r_PtxRegister4259 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister4258);		 // PTX L12236
	r_PtxU64Register352 = uint64_t(uint32_t(r_PtxRegister4259)) * uint64_t(uint32_t(4)); // PTX L12237
	g_RecordByteAddressAtPtx12238 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register352); // PTX L12238
	r_PtxRegister3828 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12238 + 61616ull);	 // PTX L12239
	r_LaneIndexAtPtx12241 = uint32_t((threadIdx.x & 31u));								 // PTX L12241
	r_PtxRegister4260 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12241), uint32_t(31));	 // PTX L12243
	r_PtxRegister4261 = ShiftRight(uint32_t(r_PtxRegister4260), uint32_t(30));			 // PTX L12244
	r_PtxRegister4262 = uint32_t(r_LaneIndexAtPtx12241) + uint32_t(r_PtxRegister4261);	 // PTX L12245
	r_PtxRegister4263 = r_PtxRegister4262 & -4;											 // PTX L12246
	r_PtxRegister4264 = uint32_t(r_LaneIndexAtPtx12241) - uint32_t(r_PtxRegister4263);	 // PTX L12247
	r_PtxRegister4265 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister4264);		 // PTX L12248
	r_PtxU64Register354 = uint64_t(uint32_t(r_PtxRegister4265)) * uint64_t(uint32_t(4)); // PTX L12249
	g_RecordByteAddressAtPtx12250 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register354); // PTX L12250
	r_PtxRegister3831 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12250 + 61616ull);	 // PTX L12251
	r_LaneIndexAtPtx12253 = uint32_t((threadIdx.x & 31u));								 // PTX L12253
	r_PtxRegister4266 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12253), uint32_t(31));	 // PTX L12255
	r_PtxRegister4267 = ShiftRight(uint32_t(r_PtxRegister4266), uint32_t(30));			 // PTX L12256
	r_PtxRegister4268 = uint32_t(r_LaneIndexAtPtx12253) + uint32_t(r_PtxRegister4267);	 // PTX L12257
	r_PtxRegister4269 = r_PtxRegister4268 & -4;											 // PTX L12258
	r_PtxRegister4270 = uint32_t(r_LaneIndexAtPtx12253) - uint32_t(r_PtxRegister4269);	 // PTX L12259
	r_PtxRegister4271 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister4270);		 // PTX L12260
	r_PtxU64Register356 = uint64_t(uint32_t(r_PtxRegister4271)) * uint64_t(uint32_t(4)); // PTX L12261
	g_RecordByteAddressAtPtx12262 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register356); // PTX L12262
	r_PtxRegister3834 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12262 + 61616ull);	 // PTX L12263
	r_LaneIndexAtPtx12265 = uint32_t((threadIdx.x & 31u));								 // PTX L12265
	r_PtxRegister4272 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx12265), uint32_t(31));	 // PTX L12267
	r_PtxRegister4273 = ShiftRight(uint32_t(r_PtxRegister4272), uint32_t(30));			 // PTX L12268
	r_PtxRegister4274 = uint32_t(r_LaneIndexAtPtx12265) + uint32_t(r_PtxRegister4273);	 // PTX L12269
	r_PtxRegister4275 = r_PtxRegister4274 & -4;											 // PTX L12270
	r_PtxRegister4276 = uint32_t(r_LaneIndexAtPtx12265) - uint32_t(r_PtxRegister4275);	 // PTX L12271
	r_PtxRegister4277 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister4276);		 // PTX L12272
	r_PtxU64Register358 = uint64_t(uint32_t(r_PtxRegister4277)) * uint64_t(uint32_t(4)); // PTX L12273
	g_RecordByteAddressAtPtx12274 =
		uint64_t(g_RecordByteAddressAtPtx12086) + uint64_t(r_PtxU64Register358); // PTX L12274
	r_PtxRegister3837 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx12274 + 61616ull);		 // PTX L12275
	r_LaneIndexAtPtx12277 = uint32_t((threadIdx.x & 31u));									 // PTX L12277
	r_PackedHalf2AtPtx12280R3878 = HalfMul(r_PackedHalf2AtPtx12021R3791, r_PtxRegister3792); // PTX L12280
	r_LaneIndexAtPtx12284 = uint32_t((threadIdx.x & 31u));									 // PTX L12284
	r_PackedHalf2AtPtx12287R3879 = HalfMul(r_PackedHalf2AtPtx12028R3794, r_PtxRegister3795); // PTX L12287
	r_LaneIndexAtPtx12291 = uint32_t((threadIdx.x & 31u));									 // PTX L12291
	r_PackedHalf2AtPtx12294R3882 = HalfMul(r_PackedHalf2AtPtx12024R3797, r_PtxRegister3798); // PTX L12294
	r_LaneIndexAtPtx12298 = uint32_t((threadIdx.x & 31u));									 // PTX L12298
	r_PackedHalf2AtPtx12301R3883 = HalfMul(r_PackedHalf2AtPtx12031R3800, r_PtxRegister3801); // PTX L12301
	r_LaneIndexAtPtx12305 = uint32_t((threadIdx.x & 31u));									 // PTX L12305
	r_PackedHalf2AtPtx12308R3886 = HalfMul(r_PackedHalf2AtPtx12035R3803, r_PtxRegister3804); // PTX L12308
	r_LaneIndexAtPtx12312 = uint32_t((threadIdx.x & 31u));									 // PTX L12312
	r_PackedHalf2AtPtx12315R3887 = HalfMul(r_PackedHalf2AtPtx12042R3806, r_PtxRegister3807); // PTX L12315
	r_LaneIndexAtPtx12319 = uint32_t((threadIdx.x & 31u));									 // PTX L12319
	r_PackedHalf2AtPtx12322R3890 = HalfMul(r_PackedHalf2AtPtx12038R3809, r_PtxRegister3810); // PTX L12322
	r_LaneIndexAtPtx12326 = uint32_t((threadIdx.x & 31u));									 // PTX L12326
	r_PackedHalf2AtPtx12329R3891 = HalfMul(r_PackedHalf2AtPtx12045R3812, r_PtxRegister3813); // PTX L12329
	r_LaneIndexAtPtx12333 = uint32_t((threadIdx.x & 31u));									 // PTX L12333
	r_PackedHalf2AtPtx12336R3896 = HalfMul(r_PackedHalf2AtPtx12049R3815, r_PtxRegister3816); // PTX L12336
	r_LaneIndexAtPtx12340 = uint32_t((threadIdx.x & 31u));									 // PTX L12340
	r_PackedHalf2AtPtx12343R3897 = HalfMul(r_PackedHalf2AtPtx12056R3818, r_PtxRegister3819); // PTX L12343
	r_LaneIndexAtPtx12347 = uint32_t((threadIdx.x & 31u));									 // PTX L12347
	r_PackedHalf2AtPtx12350R3898 = HalfMul(r_PackedHalf2AtPtx12052R3821, r_PtxRegister3822); // PTX L12350
	r_LaneIndexAtPtx12354 = uint32_t((threadIdx.x & 31u));									 // PTX L12354
	r_PackedHalf2AtPtx12357R3899 = HalfMul(r_PackedHalf2AtPtx12059R3824, r_PtxRegister3825); // PTX L12357
	r_LaneIndexAtPtx12361 = uint32_t((threadIdx.x & 31u));									 // PTX L12361
	r_PackedHalf2AtPtx12364R3900 = HalfMul(r_PackedHalf2AtPtx12063R3827, r_PtxRegister3828); // PTX L12364
	r_LaneIndexAtPtx12368 = uint32_t((threadIdx.x & 31u));									 // PTX L12368
	r_PackedHalf2AtPtx12371R3901 = HalfMul(r_PackedHalf2AtPtx12070R3830, r_PtxRegister3831); // PTX L12371
	r_LaneIndexAtPtx12375 = uint32_t((threadIdx.x & 31u));									 // PTX L12375
	r_PackedHalf2AtPtx12378R3902 = HalfMul(r_PackedHalf2AtPtx12066R3833, r_PtxRegister3834); // PTX L12378
	r_LaneIndexAtPtx12382 = uint32_t((threadIdx.x & 31u));									 // PTX L12382
	r_PackedHalf2AtPtx12385R3903 = HalfMul(r_PackedHalf2AtPtx12073R3836, r_PtxRegister3837); // PTX L12385
	r_ConvertedE4PairAtPtx12389Rs456 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11904R3838);	 // PTX L12389
	r_ConvertedE4PairAtPtx12392Rs457 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11911R3839);	 // PTX L12392
	r_PackedE4WordAtPtx12394R3856 = JoinConvertedE4(r_ConvertedE4PairAtPtx12389Rs456,
													r_ConvertedE4PairAtPtx12392Rs457);		// PTX L12394
	r_ConvertedE4PairAtPtx12396Rs458 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11904R3840); // PTX L12396
	r_ConvertedE4PairAtPtx12399Rs459 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11911R3841); // PTX L12399
	r_PackedE4WordAtPtx12401R3857 = JoinConvertedE4(r_ConvertedE4PairAtPtx12396Rs458,
													r_ConvertedE4PairAtPtx12399Rs459);		// PTX L12401
	r_ConvertedE4PairAtPtx12403Rs460 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11932R3842); // PTX L12403
	r_ConvertedE4PairAtPtx12406Rs461 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11939R3843); // PTX L12406
	r_PackedE4WordAtPtx12408R3858 = JoinConvertedE4(r_ConvertedE4PairAtPtx12403Rs460,
													r_ConvertedE4PairAtPtx12406Rs461);		// PTX L12408
	r_ConvertedE4PairAtPtx12410Rs462 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11932R3844); // PTX L12410
	r_ConvertedE4PairAtPtx12413Rs463 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11939R3845); // PTX L12413
	r_PackedE4WordAtPtx12415R3859 = JoinConvertedE4(r_ConvertedE4PairAtPtx12410Rs462,
													r_ConvertedE4PairAtPtx12413Rs463);		// PTX L12415
	r_ConvertedE4PairAtPtx12417Rs464 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11960R3846); // PTX L12417
	r_ConvertedE4PairAtPtx12420Rs465 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11967R3847); // PTX L12420
	r_PackedE4WordAtPtx12422R3862 = JoinConvertedE4(r_ConvertedE4PairAtPtx12417Rs464,
													r_ConvertedE4PairAtPtx12420Rs465);		// PTX L12422
	r_ConvertedE4PairAtPtx12424Rs466 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11960R3848); // PTX L12424
	r_ConvertedE4PairAtPtx12427Rs467 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11967R3849); // PTX L12427
	r_PackedE4WordAtPtx12429R3863 = JoinConvertedE4(r_ConvertedE4PairAtPtx12424Rs466,
													r_ConvertedE4PairAtPtx12427Rs467);		// PTX L12429
	r_ConvertedE4PairAtPtx12431Rs468 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11988R3850); // PTX L12431
	r_ConvertedE4PairAtPtx12434Rs469 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11995R3851); // PTX L12434
	r_PackedE4WordAtPtx12436R3864 = JoinConvertedE4(r_ConvertedE4PairAtPtx12431Rs468,
													r_ConvertedE4PairAtPtx12434Rs469);		// PTX L12436
	r_ConvertedE4PairAtPtx12438Rs470 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11988R3852); // PTX L12438
	r_ConvertedE4PairAtPtx12441Rs471 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx11995R3853); // PTX L12441
	r_PackedE4WordAtPtx12443R3865 = JoinConvertedE4(r_ConvertedE4PairAtPtx12438Rs470,
													r_ConvertedE4PairAtPtx12441Rs471); // PTX L12443
	r_LaneIndexAtPtx12445 = uint32_t((threadIdx.x & 31u));							   // PTX L12445
	r_PtxRegister4278 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12445), uint32_t(4));	   // PTX L12447
	r_PtxRegister3855 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister4278);	   // PTX L12448
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister3855)) =
		make_uint4(r_PackedE4WordAtPtx12394R3856, r_PackedE4WordAtPtx12401R3857,
				   r_PackedE4WordAtPtx12408R3858, r_PackedE4WordAtPtx12415R3859); // PTX L12450
	r_LaneIndexAtPtx12453 = uint32_t((threadIdx.x & 31u));						  // PTX L12453
	r_PtxRegister4279 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12453), uint32_t(4));  // PTX L12455
	r_PtxRegister4280 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister4279);  // PTX L12456
	r_PtxRegister3861 = uint32_t(r_PtxRegister4280) + uint32_t(1024);			  // PTX L12457
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister3861)) =
		make_uint4(r_PackedE4WordAtPtx12422R3862, r_PackedE4WordAtPtx12429R3863,
				   r_PackedE4WordAtPtx12436R3864, r_PackedE4WordAtPtx12443R3865); // PTX L12459

	// Final projection, native high-output vector publication
	__syncthreads();									   // PTX L12461
	r_LaneIndexAtPtx12463 = uint32_t((threadIdx.x & 31u)); // PTX L12463
	r_PtxU64Register360 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx12463)) * int64_t(int32_t(16))); // PTX L12465
	g_RecordByteAddressAtPtx12466 =
		uint64_t(g_RecordByteAddressAtPtx10133) + uint64_t(r_PtxU64Register360);			   // PTX L12466
	g_RecordByteAddressAtPtx12467 = uint64_t(g_RecordByteAddressAtPtx12466) + uint64_t(57520); // PTX L12467
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx12467));
		r_MmaBE4x4WordAtPtx12469R3876 = r_Value.x;
		r_MmaBE4x4WordAtPtx12469R3877 = r_Value.y;
		r_MmaBE4x4WordAtPtx12469R3880 = r_Value.z;
		r_MmaBE4x4WordAtPtx12469R3881 = r_Value.w;
	} // PTX L12469
	r_LaneIndexAtPtx12472 = uint32_t((threadIdx.x & 31u)); // PTX L12472
	r_PtxU64Register362 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx12472)) * int64_t(int32_t(16))); // PTX L12474
	g_RecordByteAddressAtPtx12475 =
		uint64_t(g_RecordByteAddressAtPtx10133) + uint64_t(r_PtxU64Register362);			   // PTX L12475
	g_RecordByteAddressAtPtx12476 = uint64_t(g_RecordByteAddressAtPtx12475) + uint64_t(58032); // PTX L12476
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx12476));
		r_MmaBE4x4WordAtPtx12478R3884 = r_Value.x;
		r_MmaBE4x4WordAtPtx12478R3885 = r_Value.y;
		r_MmaBE4x4WordAtPtx12478R3888 = r_Value.z;
		r_MmaBE4x4WordAtPtx12478R3889 = r_Value.w;
	} // PTX L12478
	r_LaneIndexAtPtx12481 = uint32_t((threadIdx.x & 31u));						   // PTX L12481
	r_PtxRegister4281 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12481), uint32_t(4));   // PTX L12483
	r_PtxRegister4282 = uint32_t(0u /* native shared-region base */);			   // PTX L12484
	r_PtxRegister3869 = uint32_t(r_PtxRegister4282) + uint32_t(r_PtxRegister4281); // PTX L12485
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister3869));
		r_MmaAE4x4WordAtPtx12487R3872 = r_Value.x;
		r_MmaAE4x4WordAtPtx12487R3873 = r_Value.y;
		r_MmaAE4x4WordAtPtx12487R3874 = r_Value.z;
		r_MmaAE4x4WordAtPtx12487R3875 = r_Value.w;
	} // PTX L12487
	r_LaneIndexAtPtx12490 = uint32_t((threadIdx.x & 31u));						   // PTX L12490
	r_PtxRegister4283 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12490), uint32_t(4));   // PTX L12492
	r_PtxRegister4284 = uint32_t(r_PtxRegister4282) + uint32_t(r_PtxRegister4283); // PTX L12493
	r_PtxRegister3871 = uint32_t(r_PtxRegister4284) + uint32_t(1024);			   // PTX L12494
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister3871));
		r_MmaAE4x4WordAtPtx12496R3892 = r_Value.x;
		r_MmaAE4x4WordAtPtx12496R3893 = r_Value.y;
		r_MmaAE4x4WordAtPtx12496R3894 = r_Value.z;
		r_MmaAE4x4WordAtPtx12496R3895 = r_Value.w;
	} // PTX L12496
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx12499R3916, r_MmaAccumulatorHalf2WordAtPtx12499R3917,
		  r_MmaAE4x4WordAtPtx12487R3872, r_MmaAE4x4WordAtPtx12487R3873, r_MmaAE4x4WordAtPtx12487R3874,
		  r_MmaAE4x4WordAtPtx12487R3875, r_MmaBE4x4WordAtPtx12469R3876, r_MmaBE4x4WordAtPtx12469R3877,
		  r_PackedHalf2AtPtx12280R3878, r_PackedHalf2AtPtx12287R3879); // PTX L12499
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx12506R3920, r_MmaAccumulatorHalf2WordAtPtx12506R3921,
		  r_MmaAE4x4WordAtPtx12487R3872, r_MmaAE4x4WordAtPtx12487R3873, r_MmaAE4x4WordAtPtx12487R3874,
		  r_MmaAE4x4WordAtPtx12487R3875, r_MmaBE4x4WordAtPtx12469R3880, r_MmaBE4x4WordAtPtx12469R3881,
		  r_PackedHalf2AtPtx12294R3882, r_PackedHalf2AtPtx12301R3883); // PTX L12506
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx12513R3924, r_MmaAccumulatorHalf2WordAtPtx12513R3925,
		  r_MmaAE4x4WordAtPtx12487R3872, r_MmaAE4x4WordAtPtx12487R3873, r_MmaAE4x4WordAtPtx12487R3874,
		  r_MmaAE4x4WordAtPtx12487R3875, r_MmaBE4x4WordAtPtx12478R3884, r_MmaBE4x4WordAtPtx12478R3885,
		  r_PackedHalf2AtPtx12308R3886, r_PackedHalf2AtPtx12315R3887); // PTX L12513
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx12520R3928, r_MmaAccumulatorHalf2WordAtPtx12520R3929,
		  r_MmaAE4x4WordAtPtx12487R3872, r_MmaAE4x4WordAtPtx12487R3873, r_MmaAE4x4WordAtPtx12487R3874,
		  r_MmaAE4x4WordAtPtx12487R3875, r_MmaBE4x4WordAtPtx12478R3888, r_MmaBE4x4WordAtPtx12478R3889,
		  r_PackedHalf2AtPtx12322R3890, r_PackedHalf2AtPtx12329R3891); // PTX L12520
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx12527R3934, r_MmaAccumulatorHalf2WordAtPtx12527R3935,
		  r_MmaAE4x4WordAtPtx12496R3892, r_MmaAE4x4WordAtPtx12496R3893, r_MmaAE4x4WordAtPtx12496R3894,
		  r_MmaAE4x4WordAtPtx12496R3895, r_MmaBE4x4WordAtPtx12469R3876, r_MmaBE4x4WordAtPtx12469R3877,
		  r_PackedHalf2AtPtx12336R3896, r_PackedHalf2AtPtx12343R3897); // PTX L12527
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx12534R3936, r_MmaAccumulatorHalf2WordAtPtx12534R3937,
		  r_MmaAE4x4WordAtPtx12496R3892, r_MmaAE4x4WordAtPtx12496R3893, r_MmaAE4x4WordAtPtx12496R3894,
		  r_MmaAE4x4WordAtPtx12496R3895, r_MmaBE4x4WordAtPtx12469R3880, r_MmaBE4x4WordAtPtx12469R3881,
		  r_PackedHalf2AtPtx12350R3898, r_PackedHalf2AtPtx12357R3899); // PTX L12534
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx12541R3938, r_MmaAccumulatorHalf2WordAtPtx12541R3939,
		  r_MmaAE4x4WordAtPtx12496R3892, r_MmaAE4x4WordAtPtx12496R3893, r_MmaAE4x4WordAtPtx12496R3894,
		  r_MmaAE4x4WordAtPtx12496R3895, r_MmaBE4x4WordAtPtx12478R3884, r_MmaBE4x4WordAtPtx12478R3885,
		  r_PackedHalf2AtPtx12364R3900, r_PackedHalf2AtPtx12371R3901); // PTX L12541
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx12548R3940, r_MmaAccumulatorHalf2WordAtPtx12548R3941,
		  r_MmaAE4x4WordAtPtx12496R3892, r_MmaAE4x4WordAtPtx12496R3893, r_MmaAE4x4WordAtPtx12496R3894,
		  r_MmaAE4x4WordAtPtx12496R3895, r_MmaBE4x4WordAtPtx12478R3888, r_MmaBE4x4WordAtPtx12478R3889,
		  r_PackedHalf2AtPtx12378R3902, r_PackedHalf2AtPtx12385R3903); // PTX L12548
	r_LaneIndexAtPtx12555 = uint32_t((threadIdx.x & 31u));			   // PTX L12555
	r_PtxU64Register364 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx12555)) * int64_t(int32_t(16))); // PTX L12557
	g_RecordByteAddressAtPtx12558 =
		uint64_t(g_RecordByteAddressAtPtx10133) + uint64_t(r_PtxU64Register364);			   // PTX L12558
	g_RecordByteAddressAtPtx12559 = uint64_t(g_RecordByteAddressAtPtx12558) + uint64_t(59568); // PTX L12559
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx12559));
		r_MmaBE4x4WordAtPtx12561R3914 = r_Value.x;
		r_MmaBE4x4WordAtPtx12561R3915 = r_Value.y;
		r_MmaBE4x4WordAtPtx12561R3918 = r_Value.z;
		r_MmaBE4x4WordAtPtx12561R3919 = r_Value.w;
	} // PTX L12561
	r_LaneIndexAtPtx12564 = uint32_t((threadIdx.x & 31u)); // PTX L12564
	r_PtxU64Register366 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx12564)) * int64_t(int32_t(16))); // PTX L12566
	g_RecordByteAddressAtPtx12567 =
		uint64_t(g_RecordByteAddressAtPtx10133) + uint64_t(r_PtxU64Register366);			   // PTX L12567
	g_RecordByteAddressAtPtx12568 = uint64_t(g_RecordByteAddressAtPtx12567) + uint64_t(60080); // PTX L12568
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx12568));
		r_MmaBE4x4WordAtPtx12570R3922 = r_Value.x;
		r_MmaBE4x4WordAtPtx12570R3923 = r_Value.y;
		r_MmaBE4x4WordAtPtx12570R3926 = r_Value.z;
		r_MmaBE4x4WordAtPtx12570R3927 = r_Value.w;
	} // PTX L12570
	r_LaneIndexAtPtx12573 = uint32_t((threadIdx.x & 31u));						   // PTX L12573
	r_PtxRegister4285 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12573), uint32_t(4));   // PTX L12575
	r_PtxRegister4286 = uint32_t(r_PtxRegister4282) + uint32_t(r_PtxRegister4285); // PTX L12576
	r_PtxRegister3907 = uint32_t(r_PtxRegister4286) + uint32_t(512);			   // PTX L12577
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister3907));
		r_MmaAE4x4WordAtPtx12579R3910 = r_Value.x;
		r_MmaAE4x4WordAtPtx12579R3911 = r_Value.y;
		r_MmaAE4x4WordAtPtx12579R3912 = r_Value.z;
		r_MmaAE4x4WordAtPtx12579R3913 = r_Value.w;
	} // PTX L12579
	r_LaneIndexAtPtx12582 = uint32_t((threadIdx.x & 31u));						   // PTX L12582
	r_PtxRegister4287 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12582), uint32_t(4));   // PTX L12584
	r_PtxRegister4288 = uint32_t(r_PtxRegister4282) + uint32_t(r_PtxRegister4287); // PTX L12585
	r_PtxRegister3909 = uint32_t(r_PtxRegister4288) + uint32_t(1536);			   // PTX L12586
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister3909));
		r_MmaAE4x4WordAtPtx12588R3930 = r_Value.x;
		r_MmaAE4x4WordAtPtx12588R3931 = r_Value.y;
		r_MmaAE4x4WordAtPtx12588R3932 = r_Value.z;
		r_MmaAE4x4WordAtPtx12588R3933 = r_Value.w;
	} // PTX L12588
	MmaE4(r_PtxRegister3942, r_PtxRegister3944, r_MmaAE4x4WordAtPtx12579R3910, r_MmaAE4x4WordAtPtx12579R3911,
		  r_MmaAE4x4WordAtPtx12579R3912, r_MmaAE4x4WordAtPtx12579R3913, r_MmaBE4x4WordAtPtx12561R3914,
		  r_MmaBE4x4WordAtPtx12561R3915, r_MmaAccumulatorHalf2WordAtPtx12499R3916,
		  r_MmaAccumulatorHalf2WordAtPtx12499R3917); // PTX L12591
	MmaE4(r_PtxRegister3943, r_PtxRegister3945, r_MmaAE4x4WordAtPtx12579R3910, r_MmaAE4x4WordAtPtx12579R3911,
		  r_MmaAE4x4WordAtPtx12579R3912, r_MmaAE4x4WordAtPtx12579R3913, r_MmaBE4x4WordAtPtx12561R3918,
		  r_MmaBE4x4WordAtPtx12561R3919, r_MmaAccumulatorHalf2WordAtPtx12506R3920,
		  r_MmaAccumulatorHalf2WordAtPtx12506R3921); // PTX L12598
	MmaE4(r_PtxRegister3946, r_PtxRegister3948, r_MmaAE4x4WordAtPtx12579R3910, r_MmaAE4x4WordAtPtx12579R3911,
		  r_MmaAE4x4WordAtPtx12579R3912, r_MmaAE4x4WordAtPtx12579R3913, r_MmaBE4x4WordAtPtx12570R3922,
		  r_MmaBE4x4WordAtPtx12570R3923, r_MmaAccumulatorHalf2WordAtPtx12513R3924,
		  r_MmaAccumulatorHalf2WordAtPtx12513R3925); // PTX L12605
	MmaE4(r_PtxRegister3947, r_PtxRegister3949, r_MmaAE4x4WordAtPtx12579R3910, r_MmaAE4x4WordAtPtx12579R3911,
		  r_MmaAE4x4WordAtPtx12579R3912, r_MmaAE4x4WordAtPtx12579R3913, r_MmaBE4x4WordAtPtx12570R3926,
		  r_MmaBE4x4WordAtPtx12570R3927, r_MmaAccumulatorHalf2WordAtPtx12520R3928,
		  r_MmaAccumulatorHalf2WordAtPtx12520R3929); // PTX L12612
	MmaE4(r_PtxRegister3950, r_PtxRegister3952, r_MmaAE4x4WordAtPtx12588R3930, r_MmaAE4x4WordAtPtx12588R3931,
		  r_MmaAE4x4WordAtPtx12588R3932, r_MmaAE4x4WordAtPtx12588R3933, r_MmaBE4x4WordAtPtx12561R3914,
		  r_MmaBE4x4WordAtPtx12561R3915, r_MmaAccumulatorHalf2WordAtPtx12527R3934,
		  r_MmaAccumulatorHalf2WordAtPtx12527R3935); // PTX L12619
	MmaE4(r_PtxRegister3951, r_PtxRegister3953, r_MmaAE4x4WordAtPtx12588R3930, r_MmaAE4x4WordAtPtx12588R3931,
		  r_MmaAE4x4WordAtPtx12588R3932, r_MmaAE4x4WordAtPtx12588R3933, r_MmaBE4x4WordAtPtx12561R3918,
		  r_MmaBE4x4WordAtPtx12561R3919, r_MmaAccumulatorHalf2WordAtPtx12534R3936,
		  r_MmaAccumulatorHalf2WordAtPtx12534R3937); // PTX L12626
	MmaE4(r_PtxRegister3954, r_PtxRegister3956, r_MmaAE4x4WordAtPtx12588R3930, r_MmaAE4x4WordAtPtx12588R3931,
		  r_MmaAE4x4WordAtPtx12588R3932, r_MmaAE4x4WordAtPtx12588R3933, r_MmaBE4x4WordAtPtx12570R3922,
		  r_MmaBE4x4WordAtPtx12570R3923, r_MmaAccumulatorHalf2WordAtPtx12541R3938,
		  r_MmaAccumulatorHalf2WordAtPtx12541R3939); // PTX L12633
	MmaE4(r_PtxRegister3955, r_PtxRegister3957, r_MmaAE4x4WordAtPtx12588R3930, r_MmaAE4x4WordAtPtx12588R3931,
		  r_MmaAE4x4WordAtPtx12588R3932, r_MmaAE4x4WordAtPtx12588R3933, r_MmaBE4x4WordAtPtx12570R3926,
		  r_MmaBE4x4WordAtPtx12570R3927, r_MmaAccumulatorHalf2WordAtPtx12548R3940,
		  r_MmaAccumulatorHalf2WordAtPtx12548R3941);							 // PTX L12640
	r_ConvertedE4PairAtPtx12647Rs472 = PublishE4(r_PtxRegister3942);			 // PTX L12647
	r_ConvertedE4PairAtPtx12650Rs473 = PublishE4(r_PtxRegister3943);			 // PTX L12650
	r_ConvertedE4PairAtPtx12653Rs474 = PublishE4(r_PtxRegister3944);			 // PTX L12653
	r_ConvertedE4PairAtPtx12656Rs475 = PublishE4(r_PtxRegister3945);			 // PTX L12656
	r_ConvertedE4PairAtPtx12659Rs476 = PublishE4(r_PtxRegister3946);			 // PTX L12659
	r_ConvertedE4PairAtPtx12662Rs477 = PublishE4(r_PtxRegister3947);			 // PTX L12662
	r_ConvertedE4PairAtPtx12665Rs478 = PublishE4(r_PtxRegister3948);			 // PTX L12665
	r_ConvertedE4PairAtPtx12668Rs479 = PublishE4(r_PtxRegister3949);			 // PTX L12668
	r_ConvertedE4PairAtPtx12671Rs480 = PublishE4(r_PtxRegister3950);			 // PTX L12671
	r_ConvertedE4PairAtPtx12674Rs481 = PublishE4(r_PtxRegister3951);			 // PTX L12674
	r_ConvertedE4PairAtPtx12677Rs482 = PublishE4(r_PtxRegister3952);			 // PTX L12677
	r_ConvertedE4PairAtPtx12680Rs483 = PublishE4(r_PtxRegister3953);			 // PTX L12680
	r_ConvertedE4PairAtPtx12683Rs484 = PublishE4(r_PtxRegister3954);			 // PTX L12683
	r_ConvertedE4PairAtPtx12686Rs485 = PublishE4(r_PtxRegister3955);			 // PTX L12686
	r_ConvertedE4PairAtPtx12689Rs486 = PublishE4(r_PtxRegister3956);			 // PTX L12689
	r_ConvertedE4PairAtPtx12692Rs487 = PublishE4(r_PtxRegister3957);			 // PTX L12692
	r_PtxRegister4289 = uint32_t(r_PtxRegister2) + uint32_t(1);					 // PTX L12694
	r_bPtxPredicate125 = int32_t(r_PtxRegister24) > int32_t(-8);				 // PTX L12695
	r_bPtxPredicate126 = int32_t(r_PtxRegister4289) < int32_t(r_HeightDiv4Bits); // PTX L12696
	r_bPtxPredicate5 = r_bPtxPredicate125 & r_bPtxPredicate126;					 // PTX L12697
	r_bPtxPredicate127 = r_bPtxPredicate5 & r_bPtxPredicate1;					 // PTX L12698
	r_PtxRegister4290 =
		uint32_t(r_WidthDiv4Bits) * uint32_t(r_PtxRegister2) + uint32_t(r_WidthDiv4Bits);	   // PTX L12699
	r_PtxRegister4291 = uint32_t(r_PtxRegister4290) + uint32_t(r_PtxRegister3);				   // PTX L12700
	r_PtxRegister4292 = ShiftLeft(uint32_t(r_PtxRegister4291), uint32_t(8));				   // PTX L12701
	r_PtxRegister4293 = uint32_t(r_PtxRegister4292) + uint32_t(r_PtxRegister25);			   // PTX L12702
	r_PtxU64Register368 = uint64_t(int64_t(int32_t(r_PtxRegister4293)) * int64_t(int32_t(4))); // PTX L12703
	g_OutputByteAddressAtPtx12704 =
		uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register368); // PTX L12704
	r_bPtxPredicate128 = !r_bPtxPredicate127;						   // PTX L12705
	if (r_bPtxPredicate128)
	{
		goto L__BB11_28;
	} // PTX L12706
	r_PackedE4WordAtPtx12707R4298 = JoinConvertedE4(r_ConvertedE4PairAtPtx12665Rs478,
													r_ConvertedE4PairAtPtx12668Rs479); // PTX L12707
	r_PackedE4WordAtPtx12708R4297 = JoinConvertedE4(r_ConvertedE4PairAtPtx12659Rs476,
													r_ConvertedE4PairAtPtx12662Rs477); // PTX L12708
	r_PackedE4WordAtPtx12709R4296 = JoinConvertedE4(r_ConvertedE4PairAtPtx12653Rs474,
													r_ConvertedE4PairAtPtx12656Rs475); // PTX L12709
	r_PackedE4WordAtPtx12710R4295 = JoinConvertedE4(r_ConvertedE4PairAtPtx12647Rs472,
													r_ConvertedE4PairAtPtx12650Rs473); // PTX L12710
	r_LaneIndexAtPtx12712 = uint32_t((threadIdx.x & 31u));							   // PTX L12712
	r_PtxU64Register370 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx12712)) * int64_t(int32_t(16))); // PTX L12714
	g_OutputByteAddressAtPtx12715 =
		uint64_t(g_OutputByteAddressAtPtx12704) + uint64_t(r_PtxU64Register370); // PTX L12715
	StoreNoAllocate(g_OutputByteAddressAtPtx12715,
					make_uint4(r_PackedE4WordAtPtx12710R4295, r_PackedE4WordAtPtx12709R4296,
							   r_PackedE4WordAtPtx12708R4297,
							   r_PackedE4WordAtPtx12707R4298)); // PTX L12717
L__BB11_28:														// PTX L12719
	r_bPtxPredicate129 = r_bPtxPredicate5 & r_bPtxPredicate2;	// PTX L12720
	r_bPtxPredicate130 = !r_bPtxPredicate129;					// PTX L12721
	if (r_bPtxPredicate130)
	{
		goto L__BB11_30;
	} // PTX L12722
	r_LaneIndexAtPtx12724 = uint32_t((threadIdx.x & 31u)); // PTX L12724
	r_PtxU64Register372 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx12724)) * int64_t(int32_t(16))); // PTX L12726
	g_OutputByteAddressAtPtx12727 =
		uint64_t(g_OutputByteAddressAtPtx12704) + uint64_t(r_PtxU64Register372);			  // PTX L12727
	g_OutputByteAddressAtPtx12728 = uint64_t(g_OutputByteAddressAtPtx12727) + uint64_t(1024); // PTX L12728
	r_PackedE4WordAtPtx12729R4303 = JoinConvertedE4(r_ConvertedE4PairAtPtx12689Rs486,
													r_ConvertedE4PairAtPtx12692Rs487); // PTX L12729
	r_PackedE4WordAtPtx12730R4302 = JoinConvertedE4(r_ConvertedE4PairAtPtx12683Rs484,
													r_ConvertedE4PairAtPtx12686Rs485); // PTX L12730
	r_PackedE4WordAtPtx12731R4301 = JoinConvertedE4(r_ConvertedE4PairAtPtx12677Rs482,
													r_ConvertedE4PairAtPtx12680Rs483); // PTX L12731
	r_PackedE4WordAtPtx12732R4300 = JoinConvertedE4(r_ConvertedE4PairAtPtx12671Rs480,
													r_ConvertedE4PairAtPtx12674Rs481); // PTX L12732
	StoreNoAllocate(g_OutputByteAddressAtPtx12728,
					make_uint4(r_PackedE4WordAtPtx12732R4300, r_PackedE4WordAtPtx12731R4301,
							   r_PackedE4WordAtPtx12730R4302,
							   r_PackedE4WordAtPtx12729R4303)); // PTX L12734

// Raw Half pooling: original lane-dependent operand order
L__BB11_30:																			// PTX L12736
	r_LaneIndexAtPtx12738 = uint32_t((threadIdx.x & 31u));							// PTX L12738
	r_PtxRegister4384 = r_LaneIndexAtPtx12738 & 4;									// PTX L12740
	r_bPtxPredicate131 = uint32_t(r_PtxRegister4384) == uint32_t(0);				// PTX L12741
	r_PtxRegister4385 = r_bPtxPredicate131 ? r_PtxRegister2952 : r_PtxRegister2960; // PTX L12742
	r_PtxRegister4386 = r_bPtxPredicate131 ? r_PtxRegister2960 : r_PtxRegister2952; // PTX L12743
	r_PtxRegister4387 = r_bPtxPredicate131 ? r_PtxRegister2954 : r_PtxRegister2962; // PTX L12744
	r_PtxRegister4388 = r_bPtxPredicate131 ? r_PtxRegister2962 : r_PtxRegister2954; // PTX L12745
	r_PtxRegister4389 = r_LaneIndexAtPtx12738 & 16;									// PTX L12746
	r_bPtxPredicate132 = uint32_t(r_PtxRegister4389) == uint32_t(0);				// PTX L12747
	r_PtxRegister4390 = r_bPtxPredicate132 ? r_PtxRegister4385 : r_PtxRegister4387; // PTX L12748
	r_PtxRegister4391 = r_bPtxPredicate132 ? r_PtxRegister4386 : r_PtxRegister4388; // PTX L12749
	r_PtxRegister4392 = r_bPtxPredicate132 ? r_PtxRegister4387 : r_PtxRegister4385; // PTX L12750
	r_PtxRegister4393 = r_bPtxPredicate132 ? r_PtxRegister4388 : r_PtxRegister4386; // PTX L12751
	r_PtxRegister4394 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12738), uint32_t(1));	// PTX L12752
	r_PtxRegister4395 = r_PtxRegister4394 & 8;										// PTX L12753
	r_PtxRegister4396 = ShiftRight(uint32_t(r_LaneIndexAtPtx12738), uint32_t(1));	// PTX L12754
	r_PtxRegister4397 = r_PtxRegister4396 & 4;										// PTX L12755
	r_PtxRegister4398 = r_LaneIndexAtPtx12738 & 19;									// PTX L12756
	r_PtxRegister4399 = r_PtxRegister4398 | r_PtxRegister4397;						// PTX L12757
	r_PtxRegister4400 = r_PtxRegister4399 | r_PtxRegister4395;						// PTX L12758
	r_PtxRegister4401 = r_PtxRegister4400 ^ 4;										// PTX L12759
	r_PtxRegister4402 = r_PtxRegister4400 ^ 16;										// PTX L12760
	r_PtxRegister4403 = r_PtxRegister4400 ^ 20;										// PTX L12761
	r_PtxRegister4305 =
		ShuffleIdxPredicate(r_bPtxPredicate133, r_PtxRegister4390, r_PtxRegister4400, 31, -1); // PTX L12762
	r_PtxRegister4306 =
		ShuffleIdxPredicate(r_bPtxPredicate134, r_PtxRegister4391, r_PtxRegister4401, 31, -1); // PTX L12763
	r_PtxRegister4307 =
		ShuffleIdxPredicate(r_bPtxPredicate135, r_PtxRegister4392, r_PtxRegister4402, 31, -1); // PTX L12764
	r_PtxRegister4308 =
		ShuffleIdxPredicate(r_bPtxPredicate136, r_PtxRegister4393, r_PtxRegister4403, 31, -1); // PTX L12765
	r_PackedHalf2AtPtx12767R4309 = HalfAdd(r_PtxRegister4305, r_PtxRegister4306);			   // PTX L12767
	r_PackedHalf2AtPtx12771R4310 = HalfAdd(r_PtxRegister4307, r_PtxRegister4308);			   // PTX L12771
	r_PackedHalf2AtPtx12775R4312 =
		HalfAdd(r_PackedHalf2AtPtx12767R4309, r_PackedHalf2AtPtx12771R4310);					 // PTX L12775
	r_PtxRegister4311 = uint32_t(1048576000);													 // PTX L12778
	r_PtxU16Register494 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister4311))); // PTX L12780
	r_PackedHalf2AtPtx12783R4321 = JoinHalfwords(r_PtxU16Register494, r_PtxU16Register494);		 // PTX L12783
	r_PackedHalf2AtPtx12785R4370 =
		HalfMul(r_PackedHalf2AtPtx12775R4312, r_PackedHalf2AtPtx12783R4321);		// PTX L12785
	r_LaneIndexAtPtx12789 = uint32_t((threadIdx.x & 31u));							// PTX L12789
	r_PtxRegister4404 = r_LaneIndexAtPtx12789 & 4;									// PTX L12791
	r_bPtxPredicate137 = uint32_t(r_PtxRegister4404) == uint32_t(0);				// PTX L12792
	r_PtxRegister4405 = r_bPtxPredicate137 ? r_PtxRegister3942 : r_PtxRegister3950; // PTX L12793
	r_PtxRegister4406 = r_bPtxPredicate137 ? r_PtxRegister3950 : r_PtxRegister3942; // PTX L12794
	r_PtxRegister4407 = r_bPtxPredicate137 ? r_PtxRegister3944 : r_PtxRegister3952; // PTX L12795
	r_PtxRegister4408 = r_bPtxPredicate137 ? r_PtxRegister3952 : r_PtxRegister3944; // PTX L12796
	r_PtxRegister4409 = r_LaneIndexAtPtx12789 & 16;									// PTX L12797
	r_bPtxPredicate138 = uint32_t(r_PtxRegister4409) == uint32_t(0);				// PTX L12798
	r_PtxRegister4410 = r_bPtxPredicate138 ? r_PtxRegister4405 : r_PtxRegister4407; // PTX L12799
	r_PtxRegister4411 = r_bPtxPredicate138 ? r_PtxRegister4406 : r_PtxRegister4408; // PTX L12800
	r_PtxRegister4412 = r_bPtxPredicate138 ? r_PtxRegister4407 : r_PtxRegister4405; // PTX L12801
	r_PtxRegister4413 = r_bPtxPredicate138 ? r_PtxRegister4408 : r_PtxRegister4406; // PTX L12802
	r_PtxRegister4414 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12789), uint32_t(1));	// PTX L12803
	r_PtxRegister4415 = r_PtxRegister4414 & 8;										// PTX L12804
	r_PtxRegister4416 = ShiftRight(uint32_t(r_LaneIndexAtPtx12789), uint32_t(1));	// PTX L12805
	r_PtxRegister4417 = r_PtxRegister4416 & 4;										// PTX L12806
	r_PtxRegister4418 = r_LaneIndexAtPtx12789 & 19;									// PTX L12807
	r_PtxRegister4419 = r_PtxRegister4418 | r_PtxRegister4417;						// PTX L12808
	r_PtxRegister4420 = r_PtxRegister4419 | r_PtxRegister4415;						// PTX L12809
	r_PtxRegister4421 = r_PtxRegister4420 ^ 4;										// PTX L12810
	r_PtxRegister4422 = r_PtxRegister4420 ^ 16;										// PTX L12811
	r_PtxRegister4423 = r_PtxRegister4420 ^ 20;										// PTX L12812
	r_PtxRegister4314 =
		ShuffleIdxPredicate(r_bPtxPredicate139, r_PtxRegister4410, r_PtxRegister4420, 31, -1); // PTX L12813
	r_PtxRegister4315 =
		ShuffleIdxPredicate(r_bPtxPredicate140, r_PtxRegister4411, r_PtxRegister4421, 31, -1); // PTX L12814
	r_PtxRegister4316 =
		ShuffleIdxPredicate(r_bPtxPredicate141, r_PtxRegister4412, r_PtxRegister4422, 31, -1); // PTX L12815
	r_PtxRegister4317 =
		ShuffleIdxPredicate(r_bPtxPredicate142, r_PtxRegister4413, r_PtxRegister4423, 31, -1); // PTX L12816
	r_PackedHalf2AtPtx12818R4318 = HalfAdd(r_PtxRegister4314, r_PtxRegister4315);			   // PTX L12818
	r_PackedHalf2AtPtx12822R4319 = HalfAdd(r_PtxRegister4316, r_PtxRegister4317);			   // PTX L12822
	r_PackedHalf2AtPtx12826R4320 =
		HalfAdd(r_PackedHalf2AtPtx12818R4318, r_PackedHalf2AtPtx12822R4319); // PTX L12826
	r_PackedHalf2AtPtx12830R4372 =
		HalfMul(r_PackedHalf2AtPtx12826R4320, r_PackedHalf2AtPtx12783R4321);		// PTX L12830
	r_LaneIndexAtPtx12834 = uint32_t((threadIdx.x & 31u));							// PTX L12834
	r_PtxRegister4424 = r_LaneIndexAtPtx12834 & 4;									// PTX L12836
	r_bPtxPredicate143 = uint32_t(r_PtxRegister4424) == uint32_t(0);				// PTX L12837
	r_PtxRegister4425 = r_bPtxPredicate143 ? r_PtxRegister2953 : r_PtxRegister2961; // PTX L12838
	r_PtxRegister4426 = r_bPtxPredicate143 ? r_PtxRegister2961 : r_PtxRegister2953; // PTX L12839
	r_PtxRegister4427 = r_bPtxPredicate143 ? r_PtxRegister2955 : r_PtxRegister2963; // PTX L12840
	r_PtxRegister4428 = r_bPtxPredicate143 ? r_PtxRegister2963 : r_PtxRegister2955; // PTX L12841
	r_PtxRegister4429 = r_LaneIndexAtPtx12834 & 16;									// PTX L12842
	r_bPtxPredicate144 = uint32_t(r_PtxRegister4429) == uint32_t(0);				// PTX L12843
	r_PtxRegister4430 = r_bPtxPredicate144 ? r_PtxRegister4425 : r_PtxRegister4427; // PTX L12844
	r_PtxRegister4431 = r_bPtxPredicate144 ? r_PtxRegister4426 : r_PtxRegister4428; // PTX L12845
	r_PtxRegister4432 = r_bPtxPredicate144 ? r_PtxRegister4427 : r_PtxRegister4425; // PTX L12846
	r_PtxRegister4433 = r_bPtxPredicate144 ? r_PtxRegister4428 : r_PtxRegister4426; // PTX L12847
	r_PtxRegister4434 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12834), uint32_t(1));	// PTX L12848
	r_PtxRegister4435 = r_PtxRegister4434 & 8;										// PTX L12849
	r_PtxRegister4436 = ShiftRight(uint32_t(r_LaneIndexAtPtx12834), uint32_t(1));	// PTX L12850
	r_PtxRegister4437 = r_PtxRegister4436 & 4;										// PTX L12851
	r_PtxRegister4438 = r_LaneIndexAtPtx12834 & 19;									// PTX L12852
	r_PtxRegister4439 = r_PtxRegister4438 | r_PtxRegister4437;						// PTX L12853
	r_PtxRegister4440 = r_PtxRegister4439 | r_PtxRegister4435;						// PTX L12854
	r_PtxRegister4441 = r_PtxRegister4440 ^ 4;										// PTX L12855
	r_PtxRegister4442 = r_PtxRegister4440 ^ 16;										// PTX L12856
	r_PtxRegister4443 = r_PtxRegister4440 ^ 20;										// PTX L12857
	r_PtxRegister4323 =
		ShuffleIdxPredicate(r_bPtxPredicate145, r_PtxRegister4430, r_PtxRegister4440, 31, -1); // PTX L12858
	r_PtxRegister4324 =
		ShuffleIdxPredicate(r_bPtxPredicate146, r_PtxRegister4431, r_PtxRegister4441, 31, -1); // PTX L12859
	r_PtxRegister4325 =
		ShuffleIdxPredicate(r_bPtxPredicate147, r_PtxRegister4432, r_PtxRegister4442, 31, -1); // PTX L12860
	r_PtxRegister4326 =
		ShuffleIdxPredicate(r_bPtxPredicate148, r_PtxRegister4433, r_PtxRegister4443, 31, -1); // PTX L12861
	r_PackedHalf2AtPtx12863R4327 = HalfAdd(r_PtxRegister4323, r_PtxRegister4324);			   // PTX L12863
	r_PackedHalf2AtPtx12867R4328 = HalfAdd(r_PtxRegister4325, r_PtxRegister4326);			   // PTX L12867
	r_PackedHalf2AtPtx12871R4329 =
		HalfAdd(r_PackedHalf2AtPtx12863R4327, r_PackedHalf2AtPtx12867R4328); // PTX L12871
	r_PackedHalf2AtPtx12875R4371 =
		HalfMul(r_PackedHalf2AtPtx12871R4329, r_PackedHalf2AtPtx12783R4321);		// PTX L12875
	r_LaneIndexAtPtx12879 = uint32_t((threadIdx.x & 31u));							// PTX L12879
	r_PtxRegister4444 = r_LaneIndexAtPtx12879 & 4;									// PTX L12881
	r_bPtxPredicate149 = uint32_t(r_PtxRegister4444) == uint32_t(0);				// PTX L12882
	r_PtxRegister4445 = r_bPtxPredicate149 ? r_PtxRegister3943 : r_PtxRegister3951; // PTX L12883
	r_PtxRegister4446 = r_bPtxPredicate149 ? r_PtxRegister3951 : r_PtxRegister3943; // PTX L12884
	r_PtxRegister4447 = r_bPtxPredicate149 ? r_PtxRegister3945 : r_PtxRegister3953; // PTX L12885
	r_PtxRegister4448 = r_bPtxPredicate149 ? r_PtxRegister3953 : r_PtxRegister3945; // PTX L12886
	r_PtxRegister4449 = r_LaneIndexAtPtx12879 & 16;									// PTX L12887
	r_bPtxPredicate150 = uint32_t(r_PtxRegister4449) == uint32_t(0);				// PTX L12888
	r_PtxRegister4450 = r_bPtxPredicate150 ? r_PtxRegister4445 : r_PtxRegister4447; // PTX L12889
	r_PtxRegister4451 = r_bPtxPredicate150 ? r_PtxRegister4446 : r_PtxRegister4448; // PTX L12890
	r_PtxRegister4452 = r_bPtxPredicate150 ? r_PtxRegister4447 : r_PtxRegister4445; // PTX L12891
	r_PtxRegister4453 = r_bPtxPredicate150 ? r_PtxRegister4448 : r_PtxRegister4446; // PTX L12892
	r_PtxRegister4454 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12879), uint32_t(1));	// PTX L12893
	r_PtxRegister4455 = r_PtxRegister4454 & 8;										// PTX L12894
	r_PtxRegister4456 = ShiftRight(uint32_t(r_LaneIndexAtPtx12879), uint32_t(1));	// PTX L12895
	r_PtxRegister4457 = r_PtxRegister4456 & 4;										// PTX L12896
	r_PtxRegister4458 = r_LaneIndexAtPtx12879 & 19;									// PTX L12897
	r_PtxRegister4459 = r_PtxRegister4458 | r_PtxRegister4457;						// PTX L12898
	r_PtxRegister4460 = r_PtxRegister4459 | r_PtxRegister4455;						// PTX L12899
	r_PtxRegister4461 = r_PtxRegister4460 ^ 4;										// PTX L12900
	r_PtxRegister4462 = r_PtxRegister4460 ^ 16;										// PTX L12901
	r_PtxRegister4463 = r_PtxRegister4460 ^ 20;										// PTX L12902
	r_PtxRegister4331 =
		ShuffleIdxPredicate(r_bPtxPredicate151, r_PtxRegister4450, r_PtxRegister4460, 31, -1); // PTX L12903
	r_PtxRegister4332 =
		ShuffleIdxPredicate(r_bPtxPredicate152, r_PtxRegister4451, r_PtxRegister4461, 31, -1); // PTX L12904
	r_PtxRegister4333 =
		ShuffleIdxPredicate(r_bPtxPredicate153, r_PtxRegister4452, r_PtxRegister4462, 31, -1); // PTX L12905
	r_PtxRegister4334 =
		ShuffleIdxPredicate(r_bPtxPredicate154, r_PtxRegister4453, r_PtxRegister4463, 31, -1); // PTX L12906
	r_PackedHalf2AtPtx12908R4335 = HalfAdd(r_PtxRegister4331, r_PtxRegister4332);			   // PTX L12908
	r_PackedHalf2AtPtx12912R4336 = HalfAdd(r_PtxRegister4333, r_PtxRegister4334);			   // PTX L12912
	r_PackedHalf2AtPtx12916R4337 =
		HalfAdd(r_PackedHalf2AtPtx12908R4335, r_PackedHalf2AtPtx12912R4336); // PTX L12916
	r_PackedHalf2AtPtx12920R4373 =
		HalfMul(r_PackedHalf2AtPtx12916R4337, r_PackedHalf2AtPtx12783R4321);		// PTX L12920
	r_LaneIndexAtPtx12924 = uint32_t((threadIdx.x & 31u));							// PTX L12924
	r_PtxRegister4464 = r_LaneIndexAtPtx12924 & 4;									// PTX L12926
	r_bPtxPredicate155 = uint32_t(r_PtxRegister4464) == uint32_t(0);				// PTX L12927
	r_PtxRegister4465 = r_bPtxPredicate155 ? r_PtxRegister2956 : r_PtxRegister2964; // PTX L12928
	r_PtxRegister4466 = r_bPtxPredicate155 ? r_PtxRegister2964 : r_PtxRegister2956; // PTX L12929
	r_PtxRegister4467 = r_bPtxPredicate155 ? r_PtxRegister2958 : r_PtxRegister2966; // PTX L12930
	r_PtxRegister4468 = r_bPtxPredicate155 ? r_PtxRegister2966 : r_PtxRegister2958; // PTX L12931
	r_PtxRegister4469 = r_LaneIndexAtPtx12924 & 16;									// PTX L12932
	r_bPtxPredicate156 = uint32_t(r_PtxRegister4469) == uint32_t(0);				// PTX L12933
	r_PtxRegister4470 = r_bPtxPredicate156 ? r_PtxRegister4465 : r_PtxRegister4467; // PTX L12934
	r_PtxRegister4471 = r_bPtxPredicate156 ? r_PtxRegister4466 : r_PtxRegister4468; // PTX L12935
	r_PtxRegister4472 = r_bPtxPredicate156 ? r_PtxRegister4467 : r_PtxRegister4465; // PTX L12936
	r_PtxRegister4473 = r_bPtxPredicate156 ? r_PtxRegister4468 : r_PtxRegister4466; // PTX L12937
	r_PtxRegister4474 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12924), uint32_t(1));	// PTX L12938
	r_PtxRegister4475 = r_PtxRegister4474 & 8;										// PTX L12939
	r_PtxRegister4476 = ShiftRight(uint32_t(r_LaneIndexAtPtx12924), uint32_t(1));	// PTX L12940
	r_PtxRegister4477 = r_PtxRegister4476 & 4;										// PTX L12941
	r_PtxRegister4478 = r_LaneIndexAtPtx12924 & 19;									// PTX L12942
	r_PtxRegister4479 = r_PtxRegister4478 | r_PtxRegister4477;						// PTX L12943
	r_PtxRegister4480 = r_PtxRegister4479 | r_PtxRegister4475;						// PTX L12944
	r_PtxRegister4481 = r_PtxRegister4480 ^ 4;										// PTX L12945
	r_PtxRegister4482 = r_PtxRegister4480 ^ 16;										// PTX L12946
	r_PtxRegister4483 = r_PtxRegister4480 ^ 20;										// PTX L12947
	r_PtxRegister4339 =
		ShuffleIdxPredicate(r_bPtxPredicate157, r_PtxRegister4470, r_PtxRegister4480, 31, -1); // PTX L12948
	r_PtxRegister4340 =
		ShuffleIdxPredicate(r_bPtxPredicate158, r_PtxRegister4471, r_PtxRegister4481, 31, -1); // PTX L12949
	r_PtxRegister4341 =
		ShuffleIdxPredicate(r_bPtxPredicate159, r_PtxRegister4472, r_PtxRegister4482, 31, -1); // PTX L12950
	r_PtxRegister4342 =
		ShuffleIdxPredicate(r_bPtxPredicate160, r_PtxRegister4473, r_PtxRegister4483, 31, -1); // PTX L12951
	r_PackedHalf2AtPtx12953R4343 = HalfAdd(r_PtxRegister4339, r_PtxRegister4340);			   // PTX L12953
	r_PackedHalf2AtPtx12957R4344 = HalfAdd(r_PtxRegister4341, r_PtxRegister4342);			   // PTX L12957
	r_PackedHalf2AtPtx12961R4345 =
		HalfAdd(r_PackedHalf2AtPtx12953R4343, r_PackedHalf2AtPtx12957R4344); // PTX L12961
	r_PackedHalf2AtPtx12965R4374 =
		HalfMul(r_PackedHalf2AtPtx12961R4345, r_PackedHalf2AtPtx12783R4321);		// PTX L12965
	r_LaneIndexAtPtx12969 = uint32_t((threadIdx.x & 31u));							// PTX L12969
	r_PtxRegister4484 = r_LaneIndexAtPtx12969 & 4;									// PTX L12971
	r_bPtxPredicate161 = uint32_t(r_PtxRegister4484) == uint32_t(0);				// PTX L12972
	r_PtxRegister4485 = r_bPtxPredicate161 ? r_PtxRegister3946 : r_PtxRegister3954; // PTX L12973
	r_PtxRegister4486 = r_bPtxPredicate161 ? r_PtxRegister3954 : r_PtxRegister3946; // PTX L12974
	r_PtxRegister4487 = r_bPtxPredicate161 ? r_PtxRegister3948 : r_PtxRegister3956; // PTX L12975
	r_PtxRegister4488 = r_bPtxPredicate161 ? r_PtxRegister3956 : r_PtxRegister3948; // PTX L12976
	r_PtxRegister4489 = r_LaneIndexAtPtx12969 & 16;									// PTX L12977
	r_bPtxPredicate162 = uint32_t(r_PtxRegister4489) == uint32_t(0);				// PTX L12978
	r_PtxRegister4490 = r_bPtxPredicate162 ? r_PtxRegister4485 : r_PtxRegister4487; // PTX L12979
	r_PtxRegister4491 = r_bPtxPredicate162 ? r_PtxRegister4486 : r_PtxRegister4488; // PTX L12980
	r_PtxRegister4492 = r_bPtxPredicate162 ? r_PtxRegister4487 : r_PtxRegister4485; // PTX L12981
	r_PtxRegister4493 = r_bPtxPredicate162 ? r_PtxRegister4488 : r_PtxRegister4486; // PTX L12982
	r_PtxRegister4494 = ShiftLeft(uint32_t(r_LaneIndexAtPtx12969), uint32_t(1));	// PTX L12983
	r_PtxRegister4495 = r_PtxRegister4494 & 8;										// PTX L12984
	r_PtxRegister4496 = ShiftRight(uint32_t(r_LaneIndexAtPtx12969), uint32_t(1));	// PTX L12985
	r_PtxRegister4497 = r_PtxRegister4496 & 4;										// PTX L12986
	r_PtxRegister4498 = r_LaneIndexAtPtx12969 & 19;									// PTX L12987
	r_PtxRegister4499 = r_PtxRegister4498 | r_PtxRegister4497;						// PTX L12988
	r_PtxRegister4500 = r_PtxRegister4499 | r_PtxRegister4495;						// PTX L12989
	r_PtxRegister4501 = r_PtxRegister4500 ^ 4;										// PTX L12990
	r_PtxRegister4502 = r_PtxRegister4500 ^ 16;										// PTX L12991
	r_PtxRegister4503 = r_PtxRegister4500 ^ 20;										// PTX L12992
	r_PtxRegister4347 =
		ShuffleIdxPredicate(r_bPtxPredicate163, r_PtxRegister4490, r_PtxRegister4500, 31, -1); // PTX L12993
	r_PtxRegister4348 =
		ShuffleIdxPredicate(r_bPtxPredicate164, r_PtxRegister4491, r_PtxRegister4501, 31, -1); // PTX L12994
	r_PtxRegister4349 =
		ShuffleIdxPredicate(r_bPtxPredicate165, r_PtxRegister4492, r_PtxRegister4502, 31, -1); // PTX L12995
	r_PtxRegister4350 =
		ShuffleIdxPredicate(r_bPtxPredicate166, r_PtxRegister4493, r_PtxRegister4503, 31, -1); // PTX L12996
	r_PackedHalf2AtPtx12998R4351 = HalfAdd(r_PtxRegister4347, r_PtxRegister4348);			   // PTX L12998
	r_PackedHalf2AtPtx13002R4352 = HalfAdd(r_PtxRegister4349, r_PtxRegister4350);			   // PTX L13002
	r_PackedHalf2AtPtx13006R4353 =
		HalfAdd(r_PackedHalf2AtPtx12998R4351, r_PackedHalf2AtPtx13002R4352); // PTX L13006
	r_PackedHalf2AtPtx13010R4376 =
		HalfMul(r_PackedHalf2AtPtx13006R4353, r_PackedHalf2AtPtx12783R4321);		// PTX L13010
	r_LaneIndexAtPtx13014 = uint32_t((threadIdx.x & 31u));							// PTX L13014
	r_PtxRegister4504 = r_LaneIndexAtPtx13014 & 4;									// PTX L13016
	r_bPtxPredicate167 = uint32_t(r_PtxRegister4504) == uint32_t(0);				// PTX L13017
	r_PtxRegister4505 = r_bPtxPredicate167 ? r_PtxRegister2957 : r_PtxRegister2965; // PTX L13018
	r_PtxRegister4506 = r_bPtxPredicate167 ? r_PtxRegister2965 : r_PtxRegister2957; // PTX L13019
	r_PtxRegister4507 = r_bPtxPredicate167 ? r_PtxRegister2959 : r_PtxRegister2967; // PTX L13020
	r_PtxRegister4508 = r_bPtxPredicate167 ? r_PtxRegister2967 : r_PtxRegister2959; // PTX L13021
	r_PtxRegister4509 = r_LaneIndexAtPtx13014 & 16;									// PTX L13022
	r_bPtxPredicate168 = uint32_t(r_PtxRegister4509) == uint32_t(0);				// PTX L13023
	r_PtxRegister4510 = r_bPtxPredicate168 ? r_PtxRegister4505 : r_PtxRegister4507; // PTX L13024
	r_PtxRegister4511 = r_bPtxPredicate168 ? r_PtxRegister4506 : r_PtxRegister4508; // PTX L13025
	r_PtxRegister4512 = r_bPtxPredicate168 ? r_PtxRegister4507 : r_PtxRegister4505; // PTX L13026
	r_PtxRegister4513 = r_bPtxPredicate168 ? r_PtxRegister4508 : r_PtxRegister4506; // PTX L13027
	r_PtxRegister4514 = ShiftLeft(uint32_t(r_LaneIndexAtPtx13014), uint32_t(1));	// PTX L13028
	r_PtxRegister4515 = r_PtxRegister4514 & 8;										// PTX L13029
	r_PtxRegister4516 = ShiftRight(uint32_t(r_LaneIndexAtPtx13014), uint32_t(1));	// PTX L13030
	r_PtxRegister4517 = r_PtxRegister4516 & 4;										// PTX L13031
	r_PtxRegister4518 = r_LaneIndexAtPtx13014 & 19;									// PTX L13032
	r_PtxRegister4519 = r_PtxRegister4518 | r_PtxRegister4517;						// PTX L13033
	r_PtxRegister4520 = r_PtxRegister4519 | r_PtxRegister4515;						// PTX L13034
	r_PtxRegister4521 = r_PtxRegister4520 ^ 4;										// PTX L13035
	r_PtxRegister4522 = r_PtxRegister4520 ^ 16;										// PTX L13036
	r_PtxRegister4523 = r_PtxRegister4520 ^ 20;										// PTX L13037
	r_PtxRegister4355 =
		ShuffleIdxPredicate(r_bPtxPredicate169, r_PtxRegister4510, r_PtxRegister4520, 31, -1); // PTX L13038
	r_PtxRegister4356 =
		ShuffleIdxPredicate(r_bPtxPredicate170, r_PtxRegister4511, r_PtxRegister4521, 31, -1); // PTX L13039
	r_PtxRegister4357 =
		ShuffleIdxPredicate(r_bPtxPredicate171, r_PtxRegister4512, r_PtxRegister4522, 31, -1); // PTX L13040
	r_PtxRegister4358 =
		ShuffleIdxPredicate(r_bPtxPredicate172, r_PtxRegister4513, r_PtxRegister4523, 31, -1); // PTX L13041
	r_PackedHalf2AtPtx13043R4359 = HalfAdd(r_PtxRegister4355, r_PtxRegister4356);			   // PTX L13043
	r_PackedHalf2AtPtx13047R4360 = HalfAdd(r_PtxRegister4357, r_PtxRegister4358);			   // PTX L13047
	r_PackedHalf2AtPtx13051R4361 =
		HalfAdd(r_PackedHalf2AtPtx13043R4359, r_PackedHalf2AtPtx13047R4360); // PTX L13051
	r_PackedHalf2AtPtx13055R4375 =
		HalfMul(r_PackedHalf2AtPtx13051R4361, r_PackedHalf2AtPtx12783R4321);		// PTX L13055
	r_LaneIndexAtPtx13059 = uint32_t((threadIdx.x & 31u));							// PTX L13059
	r_PtxRegister4524 = r_LaneIndexAtPtx13059 & 4;									// PTX L13061
	r_bPtxPredicate173 = uint32_t(r_PtxRegister4524) == uint32_t(0);				// PTX L13062
	r_PtxRegister4525 = r_bPtxPredicate173 ? r_PtxRegister3947 : r_PtxRegister3955; // PTX L13063
	r_PtxRegister4526 = r_bPtxPredicate173 ? r_PtxRegister3955 : r_PtxRegister3947; // PTX L13064
	r_PtxRegister4527 = r_bPtxPredicate173 ? r_PtxRegister3949 : r_PtxRegister3957; // PTX L13065
	r_PtxRegister4528 = r_bPtxPredicate173 ? r_PtxRegister3957 : r_PtxRegister3949; // PTX L13066
	r_PtxRegister4529 = r_LaneIndexAtPtx13059 & 16;									// PTX L13067
	r_bPtxPredicate174 = uint32_t(r_PtxRegister4529) == uint32_t(0);				// PTX L13068
	r_PtxRegister4530 = r_bPtxPredicate174 ? r_PtxRegister4525 : r_PtxRegister4527; // PTX L13069
	r_PtxRegister4531 = r_bPtxPredicate174 ? r_PtxRegister4526 : r_PtxRegister4528; // PTX L13070
	r_PtxRegister4532 = r_bPtxPredicate174 ? r_PtxRegister4527 : r_PtxRegister4525; // PTX L13071
	r_PtxRegister4533 = r_bPtxPredicate174 ? r_PtxRegister4528 : r_PtxRegister4526; // PTX L13072
	r_PtxRegister4534 = ShiftLeft(uint32_t(r_LaneIndexAtPtx13059), uint32_t(1));	// PTX L13073
	r_PtxRegister4535 = r_PtxRegister4534 & 8;										// PTX L13074
	r_PtxRegister4536 = ShiftRight(uint32_t(r_LaneIndexAtPtx13059), uint32_t(1));	// PTX L13075
	r_PtxRegister4537 = r_PtxRegister4536 & 4;										// PTX L13076
	r_PtxRegister4538 = r_LaneIndexAtPtx13059 & 19;									// PTX L13077
	r_PtxRegister4539 = r_PtxRegister4538 | r_PtxRegister4537;						// PTX L13078
	r_PtxRegister4540 = r_PtxRegister4539 | r_PtxRegister4535;						// PTX L13079
	r_PtxRegister4541 = r_PtxRegister4540 ^ 4;										// PTX L13080
	r_PtxRegister4542 = r_PtxRegister4540 ^ 16;										// PTX L13081
	r_PtxRegister4543 = r_PtxRegister4540 ^ 20;										// PTX L13082
	r_PtxRegister4363 =
		ShuffleIdxPredicate(r_bPtxPredicate175, r_PtxRegister4530, r_PtxRegister4540, 31, -1); // PTX L13083
	r_PtxRegister4364 =
		ShuffleIdxPredicate(r_bPtxPredicate176, r_PtxRegister4531, r_PtxRegister4541, 31, -1); // PTX L13084
	r_PtxRegister4365 =
		ShuffleIdxPredicate(r_bPtxPredicate177, r_PtxRegister4532, r_PtxRegister4542, 31, -1); // PTX L13085
	r_PtxRegister4366 =
		ShuffleIdxPredicate(r_bPtxPredicate178, r_PtxRegister4533, r_PtxRegister4543, 31, -1); // PTX L13086
	r_PackedHalf2AtPtx13088R4367 = HalfAdd(r_PtxRegister4363, r_PtxRegister4364);			   // PTX L13088
	r_PackedHalf2AtPtx13092R4368 = HalfAdd(r_PtxRegister4365, r_PtxRegister4366);			   // PTX L13092
	r_PackedHalf2AtPtx13096R4369 =
		HalfAdd(r_PackedHalf2AtPtx13088R4367, r_PackedHalf2AtPtx13092R4368); // PTX L13096
	r_PackedHalf2AtPtx13100R4377 =
		HalfMul(r_PackedHalf2AtPtx13096R4369, r_PackedHalf2AtPtx12783R4321); // PTX L13100

	// Original paired barriers before pooled shared publication
	__syncthreads();															// PTX L13103
	__syncthreads();															// PTX L13104
	r_ConvertedE4PairAtPtx13106Rs495 = PublishE4(r_PackedHalf2AtPtx12785R4370); // PTX L13106
	r_ConvertedE4PairAtPtx13109Rs496 = PublishE4(r_PackedHalf2AtPtx12875R4371); // PTX L13109
	r_PackedE4WordAtPtx13111R4380 = JoinConvertedE4(r_ConvertedE4PairAtPtx13106Rs495,
													r_ConvertedE4PairAtPtx13109Rs496); // PTX L13111
	r_ConvertedE4PairAtPtx13113Rs497 = PublishE4(r_PackedHalf2AtPtx12830R4372);		   // PTX L13113
	r_ConvertedE4PairAtPtx13116Rs498 = PublishE4(r_PackedHalf2AtPtx12920R4373);		   // PTX L13116
	r_PackedE4WordAtPtx13118R4381 = JoinConvertedE4(r_ConvertedE4PairAtPtx13113Rs497,
													r_ConvertedE4PairAtPtx13116Rs498); // PTX L13118
	r_ConvertedE4PairAtPtx13120Rs499 = PublishE4(r_PackedHalf2AtPtx12965R4374);		   // PTX L13120
	r_ConvertedE4PairAtPtx13123Rs500 = PublishE4(r_PackedHalf2AtPtx13055R4375);		   // PTX L13123
	r_PackedE4WordAtPtx13125R4382 = JoinConvertedE4(r_ConvertedE4PairAtPtx13120Rs499,
													r_ConvertedE4PairAtPtx13123Rs500); // PTX L13125
	r_ConvertedE4PairAtPtx13127Rs501 = PublishE4(r_PackedHalf2AtPtx13010R4376);		   // PTX L13127
	r_ConvertedE4PairAtPtx13130Rs502 = PublishE4(r_PackedHalf2AtPtx13100R4377);		   // PTX L13130
	r_PackedE4WordAtPtx13132R4383 = JoinConvertedE4(r_ConvertedE4PairAtPtx13127Rs501,
													r_ConvertedE4PairAtPtx13130Rs502); // PTX L13132
	r_LaneIndexAtPtx13134 = uint32_t((threadIdx.x & 31u));							   // PTX L13134
	r_PtxRegister4544 = ShiftLeft(uint32_t(r_LaneIndexAtPtx13134), uint32_t(4));	   // PTX L13136
	r_PtxRegister4379 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister4544);	   // PTX L13137
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister4379)) =
		make_uint4(r_PackedE4WordAtPtx13111R4380, r_PackedE4WordAtPtx13118R4381,
				   r_PackedE4WordAtPtx13125R4382, r_PackedE4WordAtPtx13132R4383); // PTX L13139

	// Shared K64 down projection; ordered K0 then K32, N0 then N64
	__syncthreads();																	 // PTX L13141
	r_PtxRegister4545 = ShiftRight(uint32_t(r_PtxRegister24), uint32_t(31));			 // PTX L13142
	r_PtxRegister4546 = uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister4545);		 // PTX L13143
	r_PtxRegister26 = ShiftRightSigned(int32_t(r_PtxRegister4546), uint32_t(1));		 // PTX L13144
	r_CtaXAtPtx13145 = uint32_t(blockIdx.x);											 // PTX L13145
	r_PtxRegister4548 = ShiftLeft(uint32_t(r_CtaXAtPtx13145), uint32_t(3));				 // PTX L13146
	r_PtxRegister4549 = uint32_t(r_OriginXBits) + uint32_t(r_PtxRegister4548);			 // PTX L13147
	r_PtxRegister4550 = ShiftRight(uint32_t(r_PtxRegister4549), uint32_t(31));			 // PTX L13148
	r_PtxRegister4551 = uint32_t(r_PtxRegister4549) + uint32_t(r_PtxRegister4550);		 // PTX L13149
	r_PtxRegister27 = ShiftRightSigned(int32_t(r_PtxRegister4551), uint32_t(1));		 // PTX L13150
	r_PtxRegister4552 = ShiftRight(uint32_t(r_HeightBits), uint32_t(31));				 // PTX L13151
	r_PtxRegister4553 = uint32_t(r_HeightBits) + uint32_t(r_PtxRegister4552);			 // PTX L13152
	r_PtxRegister28 = ShiftRightSigned(int32_t(r_PtxRegister4553), uint32_t(1));		 // PTX L13153
	r_PtxRegister4554 = ShiftRight(uint32_t(r_WidthBits), uint32_t(31));				 // PTX L13154
	r_PtxRegister4555 = uint32_t(r_WidthBits) + uint32_t(r_PtxRegister4554);			 // PTX L13155
	r_PtxRegister29 = ShiftRightSigned(int32_t(r_PtxRegister4555), uint32_t(1));		 // PTX L13156
	r_PtxRegister30 = ShiftLeft(uint32_t(r_ThreadYAtPtx4287), uint32_t(1));				 // PTX L13157
	r_PtxRegister31 = ShiftLeft(uint32_t(r_PtxRegister29), uint32_t(2));				 // PTX L13158
	r_PtxRegister32 = uint32_t(r_PtxRegister26) + uint32_t(2);							 // PTX L13159
	r_PtxRegister4889 = uint32_t(0);													 // PTX L13160
	r_bPtxPredicate299 = bool(-1);														 // PTX L13161
L__BB11_31:																				 // PTX L13162
	r_bPtxPredicate6 = bool(r_bPtxPredicate299);										 // PTX L13163
	g_DownOutputByteAddressAtPtx13164 = g_DownOutputBaseAddress;						 // PTX L13164
	r_PtxRegister4605 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister4889);		 // PTX L13165
	r_PtxRegister4606 = ShiftLeft(uint32_t(r_PtxRegister4605), uint32_t(3));			 // PTX L13166
	r_PtxU64Register378 = uint64_t(uint32_t(r_PtxRegister4606)) * uint64_t(uint32_t(4)); // PTX L13167
	g_RecordByteAddressAtPtx13168 =
		uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register378); // PTX L13168
	r_LaneIndexAtPtx13170 = uint32_t((threadIdx.x & 31u));			   // PTX L13170
	r_PtxU64Register380 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx13170)) * int64_t(int32_t(16))); // PTX L13172
	g_RecordByteAddressAtPtx13173 =
		uint64_t(g_RecordByteAddressAtPtx13168) + uint64_t(r_PtxU64Register380);			   // PTX L13173
	g_RecordByteAddressAtPtx13174 = uint64_t(g_RecordByteAddressAtPtx13173) + uint64_t(61744); // PTX L13174
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx13174));
		r_MmaBE4x4WordAtPtx13176R4564 = r_Value.x;
		r_MmaBE4x4WordAtPtx13176R4565 = r_Value.y;
		r_MmaBE4x4WordAtPtx13176R4566 = r_Value.z;
		r_MmaBE4x4WordAtPtx13176R4567 = r_Value.w;
	} // PTX L13176
	r_PtxRegister4607 = uint32_t(r_PtxRegister4606) + uint32_t(128);					 // PTX L13178
	r_PtxU64Register382 = uint64_t(uint32_t(r_PtxRegister4607)) * uint64_t(uint32_t(4)); // PTX L13179
	g_RecordByteAddressAtPtx13180 =
		uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register382); // PTX L13180
	r_LaneIndexAtPtx13182 = uint32_t((threadIdx.x & 31u));			   // PTX L13182
	r_PtxU64Register384 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx13182)) * int64_t(int32_t(16))); // PTX L13184
	g_RecordByteAddressAtPtx13185 =
		uint64_t(g_RecordByteAddressAtPtx13180) + uint64_t(r_PtxU64Register384);			   // PTX L13185
	g_RecordByteAddressAtPtx13186 = uint64_t(g_RecordByteAddressAtPtx13185) + uint64_t(61744); // PTX L13186
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx13186));
		r_MmaBE4x4WordAtPtx13188R4568 = r_Value.x;
		r_MmaBE4x4WordAtPtx13188R4569 = r_Value.y;
		r_MmaBE4x4WordAtPtx13188R4570 = r_Value.z;
		r_MmaBE4x4WordAtPtx13188R4571 = r_Value.w;
	} // PTX L13188
	r_LaneIndexAtPtx13191 = uint32_t((threadIdx.x & 31u));						   // PTX L13191
	r_PtxRegister4608 = ShiftLeft(uint32_t(r_LaneIndexAtPtx13191), uint32_t(4));   // PTX L13193
	r_PtxRegister4609 = uint32_t(0u /* native shared-region base */);			   // PTX L13194
	r_PtxRegister4559 = uint32_t(r_PtxRegister4609) + uint32_t(r_PtxRegister4608); // PTX L13195
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister4559));
		r_MmaAE4x4WordAtPtx13197R4560 = r_Value.x;
		r_MmaAE4x4WordAtPtx13197R4561 = r_Value.y;
		r_MmaAE4x4WordAtPtx13197R4562 = r_Value.z;
		r_MmaAE4x4WordAtPtx13197R4563 = r_Value.w;
	} // PTX L13197
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx13200R4582, r_MmaAccumulatorHalf2WordAtPtx13200R4583,
		  r_MmaAE4x4WordAtPtx13197R4560, r_MmaAE4x4WordAtPtx13197R4561, r_MmaAE4x4WordAtPtx13197R4562,
		  r_MmaAE4x4WordAtPtx13197R4563, r_MmaBE4x4WordAtPtx13176R4564, r_MmaBE4x4WordAtPtx13176R4565,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L13200
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx13207R4586, r_MmaAccumulatorHalf2WordAtPtx13207R4587,
		  r_MmaAE4x4WordAtPtx13197R4560, r_MmaAE4x4WordAtPtx13197R4561, r_MmaAE4x4WordAtPtx13197R4562,
		  r_MmaAE4x4WordAtPtx13197R4563, r_MmaBE4x4WordAtPtx13176R4566, r_MmaBE4x4WordAtPtx13176R4567,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L13207
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx13214R4590, r_MmaAccumulatorHalf2WordAtPtx13214R4591,
		  r_MmaAE4x4WordAtPtx13197R4560, r_MmaAE4x4WordAtPtx13197R4561, r_MmaAE4x4WordAtPtx13197R4562,
		  r_MmaAE4x4WordAtPtx13197R4563, r_MmaBE4x4WordAtPtx13188R4568, r_MmaBE4x4WordAtPtx13188R4569,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L13214
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx13221R4594, r_MmaAccumulatorHalf2WordAtPtx13221R4595,
		  r_MmaAE4x4WordAtPtx13197R4560, r_MmaAE4x4WordAtPtx13197R4561, r_MmaAE4x4WordAtPtx13197R4562,
		  r_MmaAE4x4WordAtPtx13197R4563, r_MmaBE4x4WordAtPtx13188R4570, r_MmaBE4x4WordAtPtx13188R4571,
		  r_PackedHalf2AtPtx965R2767, r_PackedHalf2AtPtx965R2767); // PTX L13221
	r_LaneIndexAtPtx13228 = uint32_t((threadIdx.x & 31u));		   // PTX L13228
	r_PtxU64Register386 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx13228)) * int64_t(int32_t(16))); // PTX L13230
	g_RecordByteAddressAtPtx13231 =
		uint64_t(g_RecordByteAddressAtPtx13168) + uint64_t(r_PtxU64Register386);			   // PTX L13231
	g_RecordByteAddressAtPtx13232 = uint64_t(g_RecordByteAddressAtPtx13231) + uint64_t(65840); // PTX L13232
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx13232));
		r_MmaBE4x4WordAtPtx13234R4580 = r_Value.x;
		r_MmaBE4x4WordAtPtx13234R4581 = r_Value.y;
		r_MmaBE4x4WordAtPtx13234R4584 = r_Value.z;
		r_MmaBE4x4WordAtPtx13234R4585 = r_Value.w;
	} // PTX L13234
	r_PtxRegister4610 = uint32_t(r_PtxRegister4606) + uint32_t(1152);						   // PTX L13236
	r_PtxU64Register388 = uint64_t(int64_t(int32_t(r_PtxRegister4610)) * int64_t(int32_t(4))); // PTX L13237
	g_RecordByteAddressAtPtx13238 =
		uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register388); // PTX L13238
	r_LaneIndexAtPtx13240 = uint32_t((threadIdx.x & 31u));			   // PTX L13240
	r_PtxU64Register390 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx13240)) * int64_t(int32_t(16))); // PTX L13242
	g_RecordByteAddressAtPtx13243 =
		uint64_t(g_RecordByteAddressAtPtx13238) + uint64_t(r_PtxU64Register390);			   // PTX L13243
	g_RecordByteAddressAtPtx13244 = uint64_t(g_RecordByteAddressAtPtx13243) + uint64_t(61744); // PTX L13244
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx13244));
		r_MmaBE4x4WordAtPtx13246R4588 = r_Value.x;
		r_MmaBE4x4WordAtPtx13246R4589 = r_Value.y;
		r_MmaBE4x4WordAtPtx13246R4592 = r_Value.z;
		r_MmaBE4x4WordAtPtx13246R4593 = r_Value.w;
	} // PTX L13246
	r_LaneIndexAtPtx13249 = uint32_t((threadIdx.x & 31u));						   // PTX L13249
	r_PtxRegister4611 = ShiftLeft(uint32_t(r_LaneIndexAtPtx13249), uint32_t(4));   // PTX L13251
	r_PtxRegister4612 = uint32_t(r_PtxRegister4609) + uint32_t(r_PtxRegister4611); // PTX L13252
	r_PtxRegister4575 = uint32_t(r_PtxRegister4612) + uint32_t(512);			   // PTX L13253
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister4575));
		r_MmaAE4x4WordAtPtx13255R4576 = r_Value.x;
		r_MmaAE4x4WordAtPtx13255R4577 = r_Value.y;
		r_MmaAE4x4WordAtPtx13255R4578 = r_Value.z;
		r_MmaAE4x4WordAtPtx13255R4579 = r_Value.w;
	} // PTX L13255
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx13258R4596, r_MmaAccumulatorHalf2WordAtPtx13258R4598,
		  r_MmaAE4x4WordAtPtx13255R4576, r_MmaAE4x4WordAtPtx13255R4577, r_MmaAE4x4WordAtPtx13255R4578,
		  r_MmaAE4x4WordAtPtx13255R4579, r_MmaBE4x4WordAtPtx13234R4580, r_MmaBE4x4WordAtPtx13234R4581,
		  r_MmaAccumulatorHalf2WordAtPtx13200R4582,
		  r_MmaAccumulatorHalf2WordAtPtx13200R4583); // PTX L13258
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx13265R4597, r_MmaAccumulatorHalf2WordAtPtx13265R4599,
		  r_MmaAE4x4WordAtPtx13255R4576, r_MmaAE4x4WordAtPtx13255R4577, r_MmaAE4x4WordAtPtx13255R4578,
		  r_MmaAE4x4WordAtPtx13255R4579, r_MmaBE4x4WordAtPtx13234R4584, r_MmaBE4x4WordAtPtx13234R4585,
		  r_MmaAccumulatorHalf2WordAtPtx13207R4586,
		  r_MmaAccumulatorHalf2WordAtPtx13207R4587); // PTX L13265
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx13272R4600, r_MmaAccumulatorHalf2WordAtPtx13272R4602,
		  r_MmaAE4x4WordAtPtx13255R4576, r_MmaAE4x4WordAtPtx13255R4577, r_MmaAE4x4WordAtPtx13255R4578,
		  r_MmaAE4x4WordAtPtx13255R4579, r_MmaBE4x4WordAtPtx13246R4588, r_MmaBE4x4WordAtPtx13246R4589,
		  r_MmaAccumulatorHalf2WordAtPtx13214R4590,
		  r_MmaAccumulatorHalf2WordAtPtx13214R4591); // PTX L13272
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx13279R4601, r_MmaAccumulatorHalf2WordAtPtx13279R4603,
		  r_MmaAE4x4WordAtPtx13255R4576, r_MmaAE4x4WordAtPtx13255R4577, r_MmaAE4x4WordAtPtx13255R4578,
		  r_MmaAE4x4WordAtPtx13255R4579, r_MmaBE4x4WordAtPtx13246R4592, r_MmaBE4x4WordAtPtx13246R4593,
		  r_MmaAccumulatorHalf2WordAtPtx13221R4594,
		  r_MmaAccumulatorHalf2WordAtPtx13221R4595);									// PTX L13279
	r_PtxRegister4613 = ShiftRight(uint32_t(r_PtxRegister4889), uint32_t(4));			// PTX L13285
	r_PtxU16Register1 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx13258R4596);			// PTX L13287
	r_PtxU16Register2 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx13265R4597);			// PTX L13290
	r_PtxU16Register3 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx13258R4598);			// PTX L13293
	r_PtxU16Register4 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx13265R4599);			// PTX L13296
	r_PtxU16Register5 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx13272R4600);			// PTX L13299
	r_PtxU16Register6 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx13279R4601);			// PTX L13302
	r_PtxU16Register7 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx13272R4602);			// PTX L13305
	r_PtxU16Register8 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx13279R4603);			// PTX L13308
	r_LaneIndexAtPtx13311 = uint32_t((threadIdx.x & 31u));								// PTX L13311
	r_PtxRegister4614 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx13311), uint32_t(31)); // PTX L13313
	r_PtxRegister4615 = ShiftRight(uint32_t(r_PtxRegister4614), uint32_t(30));			// PTX L13314
	r_PtxRegister4616 = uint32_t(r_LaneIndexAtPtx13311) + uint32_t(r_PtxRegister4615);	// PTX L13315
	r_PtxRegister4617 = ShiftRightSigned(int32_t(r_PtxRegister4616), uint32_t(2));		// PTX L13316
	r_PtxRegister4618 = ShiftRight(uint32_t(r_PtxRegister4617), uint32_t(30));			// PTX L13317
	r_PtxRegister4619 = uint32_t(r_PtxRegister4617) + uint32_t(r_PtxRegister4618);		// PTX L13318
	r_PtxRegister4620 = r_PtxRegister4619 & -4;											// PTX L13319
	r_PtxRegister4621 = uint32_t(r_PtxRegister4617) - uint32_t(r_PtxRegister4620);		// PTX L13320
	r_PtxRegister4622 = ShiftRight(uint32_t(r_PtxRegister4614), uint32_t(28));			// PTX L13321
	r_PtxRegister4623 = uint32_t(r_LaneIndexAtPtx13311) + uint32_t(r_PtxRegister4622);	// PTX L13322
	r_PtxRegister4624 = ShiftRightSigned(int32_t(r_PtxRegister4623), uint32_t(4));		// PTX L13323
	r_PtxRegister33 = uint32_t(r_PtxRegister4613) + uint32_t(r_PtxRegister30);			// PTX L13324
	r_PtxRegister34 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister4624);			// PTX L13325
	r_PtxRegister35 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister4621);			// PTX L13326
	r_bPtxPredicate179 = int32_t(r_PtxRegister34) < int32_t(0);							// PTX L13327
	r_bPtxPredicate180 = int32_t(r_PtxRegister34) >= int32_t(r_PtxRegister28);			// PTX L13328
	r_bPtxPredicate181 = r_bPtxPredicate179 | r_bPtxPredicate180;						// PTX L13329
	r_bPtxPredicate182 = int32_t(r_PtxRegister35) < int32_t(0);							// PTX L13330
	r_bPtxPredicate183 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister29);			// PTX L13331
	r_bPtxPredicate184 = r_bPtxPredicate182 | r_bPtxPredicate183;						// PTX L13332
	r_bPtxPredicate185 = r_bPtxPredicate181 | r_bPtxPredicate184;						// PTX L13333
	if (r_bPtxPredicate185)
	{
		goto L__BB11_33;
	} // PTX L13334
	r_PtxRegister4625 = r_PtxRegister4616 & -4;										   // PTX L13335
	r_PtxRegister4626 = uint32_t(r_LaneIndexAtPtx13311) - uint32_t(r_PtxRegister4625); // PTX L13336
	r_PtxRegister4627 = ShiftLeft(uint32_t(r_PtxRegister35), uint32_t(2));			   // PTX L13337
	r_PtxRegister4628 =
		uint32_t(r_PtxRegister33) * uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister34); // PTX L13338
	r_PtxRegister4629 =
		uint32_t(r_PtxRegister4628) * uint32_t(r_PtxRegister31) + uint32_t(r_PtxRegister4627); // PTX L13339
	r_PtxRegister4630 = uint32_t(r_PtxRegister4629) + uint32_t(r_PtxRegister4626);			   // PTX L13340
	r_PtxU64Register392 = uint64_t(int64_t(int32_t(r_PtxRegister4630)) * int64_t(int32_t(4))); // PTX L13341
	g_DownOutputByteAddressAtPtx13342 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register392); // PTX L13342
	*reinterpret_cast<ushort2*>(g_DownOutputByteAddressAtPtx13342) =
		make_ushort2(r_PtxU16Register1, r_PtxU16Register2);								// PTX L13343
L__BB11_33:																				// PTX L13344
	r_LaneIndexAtPtx13346 = uint32_t((threadIdx.x & 31u));								// PTX L13346
	r_PtxRegister4632 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx13346), uint32_t(31)); // PTX L13348
	r_PtxRegister4633 = ShiftRight(uint32_t(r_PtxRegister4632), uint32_t(30));			// PTX L13349
	r_PtxRegister4634 = uint32_t(r_LaneIndexAtPtx13346) + uint32_t(r_PtxRegister4633);	// PTX L13350
	r_PtxRegister4635 = ShiftRightSigned(int32_t(r_PtxRegister4634), uint32_t(2));		// PTX L13351
	r_PtxRegister4636 = ShiftRight(uint32_t(r_PtxRegister4635), uint32_t(30));			// PTX L13352
	r_PtxRegister4637 = uint32_t(r_PtxRegister4635) + uint32_t(r_PtxRegister4636);		// PTX L13353
	r_PtxRegister4638 = r_PtxRegister4637 & -4;											// PTX L13354
	r_PtxRegister4639 = uint32_t(r_PtxRegister4635) - uint32_t(r_PtxRegister4638);		// PTX L13355
	r_PtxRegister4640 = ShiftRight(uint32_t(r_PtxRegister4632), uint32_t(28));			// PTX L13356
	r_PtxRegister4641 = uint32_t(r_LaneIndexAtPtx13346) + uint32_t(r_PtxRegister4640);	// PTX L13357
	r_PtxRegister4642 = ShiftRightSigned(int32_t(r_PtxRegister4641), uint32_t(4));		// PTX L13358
	r_PtxRegister36 = uint32_t(r_PtxRegister4642) + uint32_t(r_PtxRegister32);			// PTX L13359
	r_PtxRegister37 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister4639);			// PTX L13360
	r_bPtxPredicate186 = int32_t(r_PtxRegister36) < int32_t(0);							// PTX L13361
	r_bPtxPredicate187 = int32_t(r_PtxRegister36) >= int32_t(r_PtxRegister28);			// PTX L13362
	r_bPtxPredicate188 = r_bPtxPredicate186 | r_bPtxPredicate187;						// PTX L13363
	r_bPtxPredicate189 = int32_t(r_PtxRegister37) < int32_t(0);							// PTX L13364
	r_bPtxPredicate190 = int32_t(r_PtxRegister37) >= int32_t(r_PtxRegister29);			// PTX L13365
	r_bPtxPredicate191 = r_bPtxPredicate189 | r_bPtxPredicate190;						// PTX L13366
	r_bPtxPredicate192 = r_bPtxPredicate188 | r_bPtxPredicate191;						// PTX L13367
	if (r_bPtxPredicate192)
	{
		goto L__BB11_35;
	} // PTX L13368
	r_PtxRegister4643 = r_PtxRegister4634 & -4;										   // PTX L13369
	r_PtxRegister4644 = uint32_t(r_LaneIndexAtPtx13346) - uint32_t(r_PtxRegister4643); // PTX L13370
	r_PtxRegister4645 = ShiftLeft(uint32_t(r_PtxRegister37), uint32_t(2));			   // PTX L13371
	r_PtxRegister4646 =
		uint32_t(r_PtxRegister33) * uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister36); // PTX L13372
	r_PtxRegister4647 =
		uint32_t(r_PtxRegister4646) * uint32_t(r_PtxRegister31) + uint32_t(r_PtxRegister4645); // PTX L13373
	r_PtxRegister4648 = uint32_t(r_PtxRegister4647) + uint32_t(r_PtxRegister4644);			   // PTX L13374
	r_PtxU64Register394 = uint64_t(int64_t(int32_t(r_PtxRegister4648)) * int64_t(int32_t(4))); // PTX L13375
	g_DownOutputByteAddressAtPtx13376 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register394); // PTX L13376
	*reinterpret_cast<ushort2*>(g_DownOutputByteAddressAtPtx13376) =
		make_ushort2(r_PtxU16Register3, r_PtxU16Register4);								// PTX L13377
L__BB11_35:																				// PTX L13378
	r_LaneIndexAtPtx13380 = uint32_t((threadIdx.x & 31u));								// PTX L13380
	r_PtxRegister4650 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx13380), uint32_t(31)); // PTX L13382
	r_PtxRegister4651 = ShiftRight(uint32_t(r_PtxRegister4650), uint32_t(30));			// PTX L13383
	r_PtxRegister4652 = uint32_t(r_LaneIndexAtPtx13380) + uint32_t(r_PtxRegister4651);	// PTX L13384
	r_PtxRegister4653 = ShiftRightSigned(int32_t(r_PtxRegister4652), uint32_t(2));		// PTX L13385
	r_PtxRegister4654 = ShiftRight(uint32_t(r_PtxRegister4653), uint32_t(30));			// PTX L13386
	r_PtxRegister4655 = uint32_t(r_PtxRegister4653) + uint32_t(r_PtxRegister4654);		// PTX L13387
	r_PtxRegister4656 = r_PtxRegister4655 & -4;											// PTX L13388
	r_PtxRegister4657 = uint32_t(r_PtxRegister4653) - uint32_t(r_PtxRegister4656);		// PTX L13389
	r_PtxRegister4658 = ShiftRight(uint32_t(r_PtxRegister4650), uint32_t(28));			// PTX L13390
	r_PtxRegister4659 = uint32_t(r_LaneIndexAtPtx13380) + uint32_t(r_PtxRegister4658);	// PTX L13391
	r_PtxRegister4660 = ShiftRightSigned(int32_t(r_PtxRegister4659), uint32_t(4));		// PTX L13392
	r_PtxRegister38 = uint32_t(r_PtxRegister33) + uint32_t(1);							// PTX L13393
	r_PtxRegister39 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister4660);			// PTX L13394
	r_PtxRegister40 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister4657);			// PTX L13395
	r_bPtxPredicate193 = int32_t(r_PtxRegister39) < int32_t(0);							// PTX L13396
	r_bPtxPredicate194 = int32_t(r_PtxRegister39) >= int32_t(r_PtxRegister28);			// PTX L13397
	r_bPtxPredicate195 = r_bPtxPredicate193 | r_bPtxPredicate194;						// PTX L13398
	r_bPtxPredicate196 = int32_t(r_PtxRegister40) < int32_t(0);							// PTX L13399
	r_bPtxPredicate197 = int32_t(r_PtxRegister40) >= int32_t(r_PtxRegister29);			// PTX L13400
	r_bPtxPredicate198 = r_bPtxPredicate196 | r_bPtxPredicate197;						// PTX L13401
	r_bPtxPredicate199 = r_bPtxPredicate195 | r_bPtxPredicate198;						// PTX L13402
	if (r_bPtxPredicate199)
	{
		goto L__BB11_37;
	} // PTX L13403
	r_PtxRegister4661 = r_PtxRegister4652 & -4;										   // PTX L13404
	r_PtxRegister4662 = uint32_t(r_LaneIndexAtPtx13380) - uint32_t(r_PtxRegister4661); // PTX L13405
	r_PtxRegister4663 = ShiftLeft(uint32_t(r_PtxRegister40), uint32_t(2));			   // PTX L13406
	r_PtxRegister4664 =
		uint32_t(r_PtxRegister38) * uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister39); // PTX L13407
	r_PtxRegister4665 =
		uint32_t(r_PtxRegister4664) * uint32_t(r_PtxRegister31) + uint32_t(r_PtxRegister4663); // PTX L13408
	r_PtxRegister4666 = uint32_t(r_PtxRegister4665) + uint32_t(r_PtxRegister4662);			   // PTX L13409
	r_PtxU64Register396 = uint64_t(int64_t(int32_t(r_PtxRegister4666)) * int64_t(int32_t(4))); // PTX L13410
	g_DownOutputByteAddressAtPtx13411 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register396); // PTX L13411
	*reinterpret_cast<ushort2*>(g_DownOutputByteAddressAtPtx13411) =
		make_ushort2(r_PtxU16Register5, r_PtxU16Register6);								// PTX L13412
L__BB11_37:																				// PTX L13413
	r_LaneIndexAtPtx13415 = uint32_t((threadIdx.x & 31u));								// PTX L13415
	r_PtxRegister4668 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx13415), uint32_t(31)); // PTX L13417
	r_PtxRegister4669 = ShiftRight(uint32_t(r_PtxRegister4668), uint32_t(30));			// PTX L13418
	r_PtxRegister4670 = uint32_t(r_LaneIndexAtPtx13415) + uint32_t(r_PtxRegister4669);	// PTX L13419
	r_PtxRegister4671 = ShiftRightSigned(int32_t(r_PtxRegister4670), uint32_t(2));		// PTX L13420
	r_PtxRegister4672 = ShiftRight(uint32_t(r_PtxRegister4671), uint32_t(30));			// PTX L13421
	r_PtxRegister4673 = uint32_t(r_PtxRegister4671) + uint32_t(r_PtxRegister4672);		// PTX L13422
	r_PtxRegister4674 = r_PtxRegister4673 & -4;											// PTX L13423
	r_PtxRegister4675 = uint32_t(r_PtxRegister4671) - uint32_t(r_PtxRegister4674);		// PTX L13424
	r_PtxRegister4676 = ShiftRight(uint32_t(r_PtxRegister4668), uint32_t(28));			// PTX L13425
	r_PtxRegister4677 = uint32_t(r_LaneIndexAtPtx13415) + uint32_t(r_PtxRegister4676);	// PTX L13426
	r_PtxRegister4678 = ShiftRightSigned(int32_t(r_PtxRegister4677), uint32_t(4));		// PTX L13427
	r_PtxRegister41 = uint32_t(r_PtxRegister4678) + uint32_t(r_PtxRegister32);			// PTX L13428
	r_PtxRegister42 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister4675);			// PTX L13429
	r_bPtxPredicate200 = int32_t(r_PtxRegister41) < int32_t(0);							// PTX L13430
	r_bPtxPredicate201 = int32_t(r_PtxRegister41) >= int32_t(r_PtxRegister28);			// PTX L13431
	r_bPtxPredicate202 = r_bPtxPredicate200 | r_bPtxPredicate201;						// PTX L13432
	r_bPtxPredicate203 = int32_t(r_PtxRegister42) < int32_t(0);							// PTX L13433
	r_bPtxPredicate204 = int32_t(r_PtxRegister42) >= int32_t(r_PtxRegister29);			// PTX L13434
	r_bPtxPredicate205 = r_bPtxPredicate203 | r_bPtxPredicate204;						// PTX L13435
	r_bPtxPredicate206 = r_bPtxPredicate202 | r_bPtxPredicate205;						// PTX L13436
	if (r_bPtxPredicate206)
	{
		goto L__BB11_39;
	} // PTX L13437
	r_PtxRegister4679 = r_PtxRegister4670 & -4;										   // PTX L13438
	r_PtxRegister4680 = uint32_t(r_LaneIndexAtPtx13415) - uint32_t(r_PtxRegister4679); // PTX L13439
	r_PtxRegister4681 = ShiftLeft(uint32_t(r_PtxRegister42), uint32_t(2));			   // PTX L13440
	r_PtxRegister4682 =
		uint32_t(r_PtxRegister38) * uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister41); // PTX L13441
	r_PtxRegister4683 =
		uint32_t(r_PtxRegister4682) * uint32_t(r_PtxRegister31) + uint32_t(r_PtxRegister4681); // PTX L13442
	r_PtxRegister4684 = uint32_t(r_PtxRegister4683) + uint32_t(r_PtxRegister4680);			   // PTX L13443
	r_PtxU64Register398 = uint64_t(int64_t(int32_t(r_PtxRegister4684)) * int64_t(int32_t(4))); // PTX L13444
	g_DownOutputByteAddressAtPtx13445 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register398); // PTX L13445
	*reinterpret_cast<ushort2*>(g_DownOutputByteAddressAtPtx13445) =
		make_ushort2(r_PtxU16Register7, r_PtxU16Register8); // PTX L13446
L__BB11_39:													// PTX L13447

	// Original optional target-padding control (unreached in the exact-half pilot)
	r_PtxRegister4889 = uint32_t(64); // PTX L13448
	r_bPtxPredicate299 = bool(0);	  // PTX L13449
	if (r_bPtxPredicate6)
	{
		goto L__BB11_31;
	} // PTX L13450
	r_PtxRegister4685 = uint32_t(r_HeightBits) + uint32_t(1);					   // PTX L13451
	r_PtxRegister4686 = ShiftRight(uint32_t(r_PtxRegister4685), uint32_t(31));	   // PTX L13452
	r_PtxRegister4687 = uint32_t(r_PtxRegister4685) + uint32_t(r_PtxRegister4686); // PTX L13453
	r_PtxRegister43 = ShiftRightSigned(int32_t(r_PtxRegister4687), uint32_t(1));   // PTX L13454
	r_PtxRegister4688 = uint32_t(r_WidthBits) + uint32_t(1);					   // PTX L13455
	r_PtxRegister4689 = ShiftRight(uint32_t(r_PtxRegister4688), uint32_t(31));	   // PTX L13456
	r_PtxRegister4690 = uint32_t(r_PtxRegister4688) + uint32_t(r_PtxRegister4689); // PTX L13457
	r_PtxRegister44 = ShiftRightSigned(int32_t(r_PtxRegister4690), uint32_t(1));   // PTX L13458
	r_bPtxPredicate207 = uint64_t(g_DownOutputBaseAddress) == uint64_t(0);		   // PTX L13459
	if (r_bPtxPredicate207)
	{
		goto L__BB11_80;
	} // PTX L13460
	r_bPtxPredicate208 = int32_t(r_DownHeightBits) <= int32_t(r_PtxRegister43); // PTX L13461
	r_bPtxPredicate209 = int32_t(r_DownWidthBits) <= int32_t(r_PtxRegister44);	// PTX L13462
	r_bPtxPredicate210 = r_bPtxPredicate208 & r_bPtxPredicate209;				// PTX L13463
	if (r_bPtxPredicate210)
	{
		goto L__BB11_80;
	} // PTX L13464
	r_PtxRegister45 = ShiftLeft(uint32_t(r_DownWidthBits), uint32_t(2));	  // PTX L13465
	r_PtxRegister46 = uint32_t(r_PtxRegister45) * uint32_t(r_DownHeightBits); // PTX L13466
	r_ThreadX = uint32_t(threadIdx.x);										  // PTX L13467
	r_BlockSizeX = uint32_t(blockDim.x);									  // PTX L13468
	r_BlockSizeY = uint32_t(blockDim.y);									  // PTX L13469
	r_ThreadZ = uint32_t(threadIdx.z);										  // PTX L13470
	r_PtxRegister4691 =
		uint32_t(r_BlockSizeY) * uint32_t(r_ThreadZ) + uint32_t(r_ThreadYAtPtx4287); // PTX L13471
	r_PtxRegister4898 =
		uint32_t(r_PtxRegister4691) * uint32_t(r_BlockSizeX) + uint32_t(r_ThreadX);			// PTX L13472
	r_PtxRegister4692 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);					// PTX L13473
	r_BlockSizeZ = uint32_t(blockDim.z);													// PTX L13474
	r_PtxRegister52 = uint32_t(r_PtxRegister4692) * uint32_t(r_BlockSizeZ);					// PTX L13475
	r_GridSizeY = uint32_t(gridDim.y);														// PTX L13476
	r_PtxRegister4694 = ShiftLeft(uint32_t(r_GridSizeY), uint32_t(3));						// PTX L13477
	r_PtxRegister4695 = uint32_t(r_PtxRegister4694) + uint32_t(r_OriginYBits);				// PTX L13478
	r_PtxRegister4696 = uint32_t(r_PtxRegister4695) + uint32_t(-8);							// PTX L13479
	r_PtxRegister4697 = ShiftRight(uint32_t(r_PtxRegister4696), uint32_t(31));				// PTX L13480
	r_PtxRegister4698 = uint32_t(r_PtxRegister4696) + uint32_t(r_PtxRegister4697);			// PTX L13481
	r_PtxRegister4699 = ShiftRightSigned(int32_t(r_PtxRegister4698), uint32_t(1));			// PTX L13482
	r_PtxRegister4700 = uint32_t(r_PtxRegister4699) + uint32_t(4);							// PTX L13483
	r_GridSizeX = uint32_t(gridDim.x);														// PTX L13484
	r_PtxRegister4702 = ShiftLeft(uint32_t(r_GridSizeX), uint32_t(3));						// PTX L13485
	r_PtxRegister4703 = uint32_t(r_PtxRegister4702) + uint32_t(r_OriginXBits);				// PTX L13486
	r_PtxRegister4704 = uint32_t(r_PtxRegister4703) + uint32_t(-8);							// PTX L13487
	r_PtxRegister4705 = ShiftRight(uint32_t(r_PtxRegister4704), uint32_t(31));				// PTX L13488
	r_PtxRegister4706 = uint32_t(r_PtxRegister4704) + uint32_t(r_PtxRegister4705);			// PTX L13489
	r_PtxRegister4707 = ShiftRightSigned(int32_t(r_PtxRegister4706), uint32_t(1));			// PTX L13490
	r_PtxRegister53 = uint32_t(r_PtxRegister4707) + uint32_t(4);							// PTX L13491
	r_PtxRegister54 = uint32_t(min(int32_t(r_PtxRegister4700), int32_t(r_DownHeightBits))); // PTX L13492
	r_bPtxPredicate211 = int32_t(r_PtxRegister26) < int32_t(r_DownHeightBits);				// PTX L13493
	r_PtxRegister4708 = uint32_t(r_PtxRegister26) + uint32_t(4);							// PTX L13494
	r_bPtxPredicate212 = int32_t(r_PtxRegister4708) > int32_t(r_PtxRegister43);				// PTX L13495
	r_bPtxPredicate213 = r_bPtxPredicate211 & r_bPtxPredicate212;							// PTX L13496
	r_bPtxPredicate214 = int32_t(r_PtxRegister27) < int32_t(r_DownWidthBits);				// PTX L13497
	r_PtxRegister4709 = uint32_t(r_PtxRegister27) + uint32_t(4);							// PTX L13498
	r_bPtxPredicate215 = int32_t(r_PtxRegister4709) > int32_t(r_PtxRegister44);				// PTX L13499
	r_bPtxPredicate216 = r_bPtxPredicate214 & r_bPtxPredicate215;							// PTX L13500
	r_bPtxPredicate217 = r_bPtxPredicate213 | r_bPtxPredicate216;							// PTX L13501
	r_bPtxPredicate218 = !r_bPtxPredicate217;												// PTX L13502
	if (r_bPtxPredicate218)
	{
		goto L__BB11_65;
	} // PTX L13503
	__syncthreads();												  // PTX L13504
	r_bPtxPredicate219 = uint32_t(r_PtxRegister4898) > uint32_t(255); // PTX L13505
	if (r_bPtxPredicate219)
	{
		goto L__BB11_65;
	} // PTX L13506
	r_PtxRegister4710 = uint32_t(r_ThreadZ) + uint32_t(r_BlockSizeZ); // PTX L13507
	r_PtxRegister4711 =
		uint32_t(r_BlockSizeY) * uint32_t(r_PtxRegister4710) + uint32_t(r_ThreadYAtPtx4287); // PTX L13508
	r_PtxRegister4712 =
		uint32_t(r_BlockSizeX) * uint32_t(r_PtxRegister4711) + uint32_t(r_ThreadX);		   // PTX L13509
	r_PtxRegister4713 = uint32_t(max(uint32_t(r_PtxRegister4712), uint32_t(256)));		   // PTX L13510
	r_bPtxPredicate220 = uint32_t(r_PtxRegister4712) < uint32_t(256);					   // PTX L13511
	r_PtxRegister4714 = r_bPtxPredicate220 ? 1 : 0;										   // PTX L13512
	r_PtxRegister4715 = uint32_t(r_PtxRegister4712) + uint32_t(r_PtxRegister4714);		   // PTX L13513
	r_PtxRegister4716 = uint32_t(r_PtxRegister4713) - uint32_t(r_PtxRegister4715);		   // PTX L13514
	r_PtxRegister4717 = uint32_t(uint32_t(r_PtxRegister4716) / uint32_t(r_PtxRegister52)); // PTX L13515
	r_PtxRegister55 = uint32_t(r_PtxRegister4717) + uint32_t(r_PtxRegister4714);		   // PTX L13516
	r_PtxRegister4718 = uint32_t(r_PtxRegister55) + uint32_t(1);						   // PTX L13517
	r_PtxRegister56 = r_PtxRegister4718 & 3;											   // PTX L13518
	r_bPtxPredicate221 = uint32_t(r_PtxRegister56) == uint32_t(0);						   // PTX L13519
	r_PtxRegister4891 = uint32_t(r_PtxRegister4898);									   // PTX L13520
	if (r_bPtxPredicate221)
	{
		goto L__BB11_50;
	} // PTX L13521
	r_PtxRegister4890 = uint32_t(0) - uint32_t(r_PtxRegister56);				 // PTX L13522
	r_PtxRegister4891 = uint32_t(r_PtxRegister4898);							 // PTX L13523
	goto L__BB11_46;															 // PTX L13524
L__BB11_49:																		 // PTX L13525
	r_PtxRegister4891 = uint32_t(r_PtxRegister4891) + uint32_t(r_PtxRegister52); // PTX L13526
	r_PtxRegister4890 = uint32_t(r_PtxRegister4890) + uint32_t(1);				 // PTX L13527
	r_bPtxPredicate232 = uint32_t(r_PtxRegister4890) != uint32_t(0);			 // PTX L13528
	if (r_bPtxPredicate232)
	{
		goto L__BB11_46;
	} // PTX L13529
	goto L__BB11_50; // PTX L13530
L__BB11_46:			 // PTX L13531
	// Native padding-loop nounroll hint; goto control edges retained. // PTX L13532
	r_PtxRegister4719 = ShiftRight(uint32_t(r_PtxRegister4891), uint32_t(4));	// PTX L13533
	r_PtxRegister4720 = ShiftRight(uint32_t(r_PtxRegister4891), uint32_t(6));	// PTX L13534
	r_PtxRegister57 = uint32_t(r_PtxRegister4720) + uint32_t(r_PtxRegister26);	// PTX L13535
	r_PtxRegister4721 = r_PtxRegister4719 & 3;									// PTX L13536
	r_PtxRegister58 = uint32_t(r_PtxRegister4721) + uint32_t(r_PtxRegister27);	// PTX L13537
	r_bPtxPredicate222 = int32_t(r_PtxRegister57) < int32_t(0);					// PTX L13538
	r_bPtxPredicate223 = int32_t(r_PtxRegister57) >= int32_t(r_DownHeightBits); // PTX L13539
	r_bPtxPredicate224 = r_bPtxPredicate222 | r_bPtxPredicate223;				// PTX L13540
	r_bPtxPredicate225 = int32_t(r_PtxRegister58) < int32_t(0);					// PTX L13541
	r_bPtxPredicate226 = int32_t(r_PtxRegister58) >= int32_t(r_DownWidthBits);	// PTX L13542
	r_bPtxPredicate227 = r_bPtxPredicate225 | r_bPtxPredicate226;				// PTX L13543
	r_bPtxPredicate228 = r_bPtxPredicate224 | r_bPtxPredicate227;				// PTX L13544
	if (r_bPtxPredicate228)
	{
		goto L__BB11_49;
	} // PTX L13545
	r_bPtxPredicate229 = int32_t(r_PtxRegister57) < int32_t(r_PtxRegister43); // PTX L13546
	r_bPtxPredicate230 = int32_t(r_PtxRegister58) < int32_t(r_PtxRegister44); // PTX L13547
	r_bPtxPredicate231 = r_bPtxPredicate229 & r_bPtxPredicate230;			  // PTX L13548
	if (r_bPtxPredicate231)
	{
		goto L__BB11_49;
	} // PTX L13549
	r_PtxRegister4722 = r_PtxRegister4891 & 15; // PTX L13550
	r_PtxU64Register400 =
		uint64_t(int64_t(int32_t(r_PtxRegister4722)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13551
	r_PtxU64Register401 =
		uint64_t(int64_t(int32_t(r_PtxRegister57)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13552
	r_PtxU64Register402 = uint64_t(r_PtxU64Register401) + uint64_t(r_PtxU64Register400); // PTX L13553
	r_PtxRegister4723 = ShiftLeft(uint32_t(r_PtxRegister58), uint32_t(2));				 // PTX L13554
	r_PtxU64Register403 = uint64_t(r_PtxRegister4723);									 // PTX L13555
	r_PtxU64Register404 = uint64_t(r_PtxU64Register402) + uint64_t(r_PtxU64Register403); // PTX L13556
	r_PtxU64Register405 = ShiftLeft(uint64_t(r_PtxU64Register404), uint32_t(2));		 // PTX L13557
	g_DownOutputByteAddressAtPtx13558 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register405); // PTX L13558
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13558) = 0;			 // PTX L13559
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13558 + 4ull) = 0;		 // PTX L13560
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13558 + 8ull) = 0;		 // PTX L13561
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13558 + 12ull) = 0;	 // PTX L13562
	goto L__BB11_49;																 // PTX L13563
L__BB11_50:																			 // PTX L13564
	r_bPtxPredicate233 = uint32_t(r_PtxRegister55) < uint32_t(3);					 // PTX L13565
	if (r_bPtxPredicate233)
	{
		goto L__BB11_65;
	} // PTX L13566
	goto L__BB11_51;												 // PTX L13567
L__BB11_65:															 // PTX L13568
	r_CtaZ = uint32_t(blockIdx.z);									 // PTX L13569
	r_CtaYAtPtx13570 = uint32_t(blockIdx.y);						 // PTX L13570
	r_PtxRegister4750 = r_CtaYAtPtx13570 | r_CtaZ;					 // PTX L13571
	r_PtxRegister4751 = r_PtxRegister4750 | r_CtaXAtPtx13145;		 // PTX L13572
	r_bPtxPredicate275 = uint32_t(r_PtxRegister4751) != uint32_t(0); // PTX L13573
	if (r_bPtxPredicate275)
	{
		goto L__BB11_80;
	} // PTX L13574
	r_PtxRegister70 = uint32_t(max(int32_t(r_PtxRegister54), int32_t(r_PtxRegister43)));   // PTX L13575
	r_PtxRegister4752 = uint32_t(min(int32_t(r_PtxRegister53), int32_t(r_DownWidthBits))); // PTX L13576
	r_PtxRegister71 = uint32_t(max(int32_t(r_PtxRegister4752), int32_t(r_PtxRegister44))); // PTX L13577
	r_PtxRegister72 = uint32_t(r_DownHeightBits) - uint32_t(r_PtxRegister70);			   // PTX L13578
	r_bPtxPredicate276 = int32_t(r_PtxRegister72) < int32_t(1);							   // PTX L13579
	if (r_bPtxPredicate276)
	{
		goto L__BB11_73;
	} // PTX L13580
	r_PtxRegister4753 = uint32_t(r_DownWidthBits) * uint32_t(r_PtxRegister72);	 // PTX L13581
	r_PtxRegister73 = ShiftLeft(uint32_t(r_PtxRegister4753), uint32_t(4));		 // PTX L13582
	r_bPtxPredicate277 = int32_t(r_PtxRegister4898) >= int32_t(r_PtxRegister73); // PTX L13583
	if (r_bPtxPredicate277)
	{
		goto L__BB11_73;
	} // PTX L13584
	r_PtxRegister4754 = uint32_t(r_PtxRegister4898) + uint32_t(r_PtxRegister52);			 // PTX L13585
	r_PtxRegister4755 = uint32_t(max(int32_t(r_PtxRegister73), int32_t(r_PtxRegister4754))); // PTX L13586
	r_bPtxPredicate278 = int32_t(r_PtxRegister4754) < int32_t(r_PtxRegister73);				 // PTX L13587
	r_PtxRegister4756 = r_bPtxPredicate278 ? 1 : 0;											 // PTX L13588
	r_PtxRegister4757 = uint32_t(r_PtxRegister4754) + uint32_t(r_PtxRegister4756);			 // PTX L13589
	r_PtxRegister4758 = uint32_t(r_PtxRegister4755) - uint32_t(r_PtxRegister4757);			 // PTX L13590
	r_PtxRegister4759 = uint32_t(uint32_t(r_PtxRegister4758) / uint32_t(r_PtxRegister52));	 // PTX L13591
	r_PtxRegister74 = uint32_t(r_PtxRegister4759) + uint32_t(r_PtxRegister4756);			 // PTX L13592
	r_PtxRegister4760 = uint32_t(r_PtxRegister74) + uint32_t(1);							 // PTX L13593
	r_PtxRegister75 = r_PtxRegister4760 & 3;												 // PTX L13594
	r_bPtxPredicate279 = uint32_t(r_PtxRegister75) == uint32_t(0);							 // PTX L13595
	r_PtxRegister4896 = uint32_t(r_PtxRegister4898);										 // PTX L13596
	if (r_bPtxPredicate279)
	{
		goto L__BB11_71;
	} // PTX L13597
	r_PtxRegister4895 = uint32_t(0) - uint32_t(r_PtxRegister75); // PTX L13598
	r_PtxRegister4896 = uint32_t(r_PtxRegister4898);			 // PTX L13599
L__BB11_70:														 // PTX L13600
	// Native padding-loop nounroll hint; goto control edges retained. // PTX L13601
	r_PtxRegister4761 = r_PtxRegister4896 & 15;											 // PTX L13602
	r_PtxRegister4762 = ShiftRight(uint32_t(r_PtxRegister4896), uint32_t(4));			 // PTX L13603
	r_PtxRegister4763 = uint32_t(int32_t(r_PtxRegister4762) / int32_t(r_DownWidthBits)); // PTX L13604
	r_PtxRegister4764 = uint32_t(r_PtxRegister4763) + uint32_t(r_PtxRegister70);		 // PTX L13605
	r_PtxRegister4765 = uint32_t(r_PtxRegister4763) * uint32_t(r_DownWidthBits);		 // PTX L13606
	r_PtxRegister4766 = uint32_t(r_PtxRegister4762) - uint32_t(r_PtxRegister4765);		 // PTX L13607
	r_PtxU64Register435 =
		uint64_t(int64_t(int32_t(r_PtxRegister4761)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13608
	r_PtxU64Register436 =
		uint64_t(int64_t(int32_t(r_PtxRegister4764)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13609
	r_PtxU64Register437 = uint64_t(r_PtxU64Register436) + uint64_t(r_PtxU64Register435);   // PTX L13610
	r_PtxU64Register438 = uint64_t(uint32_t(r_PtxRegister4766)) * uint64_t(uint32_t(4));   // PTX L13611
	r_PtxU64Register439 = uint64_t(r_PtxU64Register437) + uint64_t(r_PtxU64Register438);   // PTX L13612
	r_PtxU64Register440 = ShiftLeft(uint64_t(r_PtxU64Register439), uint32_t(2));		   // PTX L13613
	g_DownOutputByteAddressAtPtx13614 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register440); // PTX L13614
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13614) = 0;			 // PTX L13615
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13614 + 4ull) = 0;		 // PTX L13616
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13614 + 8ull) = 0;		 // PTX L13617
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13614 + 12ull) = 0;	 // PTX L13618
	r_PtxRegister4896 = uint32_t(r_PtxRegister4896) + uint32_t(r_PtxRegister52);	 // PTX L13619
	r_PtxRegister4895 = uint32_t(r_PtxRegister4895) + uint32_t(1);					 // PTX L13620
	r_bPtxPredicate280 = uint32_t(r_PtxRegister4895) != uint32_t(0);				 // PTX L13621
	if (r_bPtxPredicate280)
	{
		goto L__BB11_70;
	} // PTX L13622
L__BB11_71:														  // PTX L13623
	r_bPtxPredicate281 = uint32_t(r_PtxRegister74) < uint32_t(3); // PTX L13624
	if (r_bPtxPredicate281)
	{
		goto L__BB11_73;
	} // PTX L13625
L__BB11_72:																				 // PTX L13626
	r_PtxRegister4767 = r_PtxRegister4896 & 15;											 // PTX L13627
	r_PtxRegister4768 = ShiftRight(uint32_t(r_PtxRegister4896), uint32_t(4));			 // PTX L13628
	r_PtxRegister4769 = uint32_t(int32_t(r_PtxRegister4768) / int32_t(r_DownWidthBits)); // PTX L13629
	r_PtxRegister4770 = uint32_t(r_PtxRegister4769) + uint32_t(r_PtxRegister70);		 // PTX L13630
	r_PtxRegister4771 = uint32_t(r_PtxRegister4769) * uint32_t(r_DownWidthBits);		 // PTX L13631
	r_PtxRegister4772 = uint32_t(r_PtxRegister4768) - uint32_t(r_PtxRegister4771);		 // PTX L13632
	r_PtxU64Register442 =
		uint64_t(int64_t(int32_t(r_PtxRegister4767)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13633
	r_PtxU64Register443 =
		uint64_t(int64_t(int32_t(r_PtxRegister4770)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13634
	r_PtxU64Register444 = uint64_t(r_PtxU64Register443) + uint64_t(r_PtxU64Register442);   // PTX L13635
	r_PtxU64Register445 = uint64_t(uint32_t(r_PtxRegister4772)) * uint64_t(uint32_t(4));   // PTX L13636
	r_PtxU64Register446 = uint64_t(r_PtxU64Register444) + uint64_t(r_PtxU64Register445);   // PTX L13637
	r_PtxU64Register447 = ShiftLeft(uint64_t(r_PtxU64Register446), uint32_t(2));		   // PTX L13638
	g_DownOutputByteAddressAtPtx13639 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register447);	 // PTX L13639
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13639) = 0;				 // PTX L13640
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13639 + 4ull) = 0;			 // PTX L13641
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13639 + 8ull) = 0;			 // PTX L13642
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13639 + 12ull) = 0;		 // PTX L13643
	r_PtxRegister4773 = uint32_t(r_PtxRegister4896) + uint32_t(r_PtxRegister52);		 // PTX L13644
	r_PtxRegister4774 = r_PtxRegister4773 & 15;											 // PTX L13645
	r_PtxRegister4775 = ShiftRight(uint32_t(r_PtxRegister4773), uint32_t(4));			 // PTX L13646
	r_PtxRegister4776 = uint32_t(int32_t(r_PtxRegister4775) / int32_t(r_DownWidthBits)); // PTX L13647
	r_PtxRegister4777 = uint32_t(r_PtxRegister4776) + uint32_t(r_PtxRegister70);		 // PTX L13648
	r_PtxRegister4778 = uint32_t(r_PtxRegister4776) * uint32_t(r_DownWidthBits);		 // PTX L13649
	r_PtxRegister4779 = uint32_t(r_PtxRegister4775) - uint32_t(r_PtxRegister4778);		 // PTX L13650
	r_PtxU64Register449 =
		uint64_t(int64_t(int32_t(r_PtxRegister4774)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13651
	r_PtxU64Register450 =
		uint64_t(int64_t(int32_t(r_PtxRegister4777)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13652
	r_PtxU64Register451 = uint64_t(r_PtxU64Register450) + uint64_t(r_PtxU64Register449);   // PTX L13653
	r_PtxU64Register452 = uint64_t(uint32_t(r_PtxRegister4779)) * uint64_t(uint32_t(4));   // PTX L13654
	r_PtxU64Register453 = uint64_t(r_PtxU64Register451) + uint64_t(r_PtxU64Register452);   // PTX L13655
	r_PtxU64Register454 = ShiftLeft(uint64_t(r_PtxU64Register453), uint32_t(2));		   // PTX L13656
	g_DownOutputByteAddressAtPtx13657 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register454);	 // PTX L13657
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13657) = 0;				 // PTX L13658
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13657 + 4ull) = 0;			 // PTX L13659
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13657 + 8ull) = 0;			 // PTX L13660
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13657 + 12ull) = 0;		 // PTX L13661
	r_PtxRegister4780 = uint32_t(r_PtxRegister4773) + uint32_t(r_PtxRegister52);		 // PTX L13662
	r_PtxRegister4781 = r_PtxRegister4780 & 15;											 // PTX L13663
	r_PtxRegister4782 = ShiftRight(uint32_t(r_PtxRegister4780), uint32_t(4));			 // PTX L13664
	r_PtxRegister4783 = uint32_t(int32_t(r_PtxRegister4782) / int32_t(r_DownWidthBits)); // PTX L13665
	r_PtxRegister4784 = uint32_t(r_PtxRegister4783) + uint32_t(r_PtxRegister70);		 // PTX L13666
	r_PtxRegister4785 = uint32_t(r_PtxRegister4783) * uint32_t(r_DownWidthBits);		 // PTX L13667
	r_PtxRegister4786 = uint32_t(r_PtxRegister4782) - uint32_t(r_PtxRegister4785);		 // PTX L13668
	r_PtxU64Register456 =
		uint64_t(int64_t(int32_t(r_PtxRegister4781)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13669
	r_PtxU64Register457 =
		uint64_t(int64_t(int32_t(r_PtxRegister4784)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13670
	r_PtxU64Register458 = uint64_t(r_PtxU64Register457) + uint64_t(r_PtxU64Register456);   // PTX L13671
	r_PtxU64Register459 = uint64_t(uint32_t(r_PtxRegister4786)) * uint64_t(uint32_t(4));   // PTX L13672
	r_PtxU64Register460 = uint64_t(r_PtxU64Register458) + uint64_t(r_PtxU64Register459);   // PTX L13673
	r_PtxU64Register461 = ShiftLeft(uint64_t(r_PtxU64Register460), uint32_t(2));		   // PTX L13674
	g_DownOutputByteAddressAtPtx13675 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register461);	 // PTX L13675
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13675) = 0;				 // PTX L13676
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13675 + 4ull) = 0;			 // PTX L13677
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13675 + 8ull) = 0;			 // PTX L13678
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13675 + 12ull) = 0;		 // PTX L13679
	r_PtxRegister4787 = uint32_t(r_PtxRegister4780) + uint32_t(r_PtxRegister52);		 // PTX L13680
	r_PtxRegister4788 = r_PtxRegister4787 & 15;											 // PTX L13681
	r_PtxRegister4789 = ShiftRight(uint32_t(r_PtxRegister4787), uint32_t(4));			 // PTX L13682
	r_PtxRegister4790 = uint32_t(int32_t(r_PtxRegister4789) / int32_t(r_DownWidthBits)); // PTX L13683
	r_PtxRegister4791 = uint32_t(r_PtxRegister4790) + uint32_t(r_PtxRegister70);		 // PTX L13684
	r_PtxRegister4792 = uint32_t(r_PtxRegister4790) * uint32_t(r_DownWidthBits);		 // PTX L13685
	r_PtxRegister4793 = uint32_t(r_PtxRegister4789) - uint32_t(r_PtxRegister4792);		 // PTX L13686
	r_PtxU64Register463 =
		uint64_t(int64_t(int32_t(r_PtxRegister4788)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13687
	r_PtxU64Register464 =
		uint64_t(int64_t(int32_t(r_PtxRegister4791)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13688
	r_PtxU64Register465 = uint64_t(r_PtxU64Register464) + uint64_t(r_PtxU64Register463);   // PTX L13689
	r_PtxU64Register466 = uint64_t(uint32_t(r_PtxRegister4793)) * uint64_t(uint32_t(4));   // PTX L13690
	r_PtxU64Register467 = uint64_t(r_PtxU64Register465) + uint64_t(r_PtxU64Register466);   // PTX L13691
	r_PtxU64Register468 = ShiftLeft(uint64_t(r_PtxU64Register467), uint32_t(2));		   // PTX L13692
	g_DownOutputByteAddressAtPtx13693 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register468); // PTX L13693
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13693) = 0;			 // PTX L13694
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13693 + 4ull) = 0;		 // PTX L13695
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13693 + 8ull) = 0;		 // PTX L13696
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13693 + 12ull) = 0;	 // PTX L13697
	r_PtxRegister4896 = uint32_t(r_PtxRegister4787) + uint32_t(r_PtxRegister52);	 // PTX L13698
	r_bPtxPredicate282 = int32_t(r_PtxRegister4896) < int32_t(r_PtxRegister73);		 // PTX L13699
	if (r_bPtxPredicate282)
	{
		goto L__BB11_72;
	} // PTX L13700
L__BB11_73:																				   // PTX L13701
	r_PtxRegister76 = uint32_t(r_DownWidthBits) - uint32_t(r_PtxRegister71);			   // PTX L13702
	r_PtxRegister4794 = uint32_t(min(int32_t(r_PtxRegister76), int32_t(r_PtxRegister54))); // PTX L13703
	r_bPtxPredicate283 = int32_t(r_PtxRegister4794) < int32_t(1);						   // PTX L13704
	if (r_bPtxPredicate283)
	{
		goto L__BB11_80;
	} // PTX L13705
	r_PtxRegister4795 = uint32_t(r_PtxRegister54) * uint32_t(r_PtxRegister76);	 // PTX L13706
	r_PtxRegister77 = ShiftLeft(uint32_t(r_PtxRegister4795), uint32_t(4));		 // PTX L13707
	r_bPtxPredicate284 = int32_t(r_PtxRegister4898) >= int32_t(r_PtxRegister77); // PTX L13708
	if (r_bPtxPredicate284)
	{
		goto L__BB11_80;
	} // PTX L13709
	r_PtxRegister4796 = uint32_t(r_PtxRegister4898) + uint32_t(r_PtxRegister52);			 // PTX L13710
	r_PtxRegister4797 = uint32_t(max(int32_t(r_PtxRegister77), int32_t(r_PtxRegister4796))); // PTX L13711
	r_bPtxPredicate285 = int32_t(r_PtxRegister4796) < int32_t(r_PtxRegister77);				 // PTX L13712
	r_PtxRegister4798 = r_bPtxPredicate285 ? 1 : 0;											 // PTX L13713
	r_PtxRegister4799 = uint32_t(r_PtxRegister4796) + uint32_t(r_PtxRegister4798);			 // PTX L13714
	r_PtxRegister4800 = uint32_t(r_PtxRegister4797) - uint32_t(r_PtxRegister4799);			 // PTX L13715
	r_PtxRegister4801 = uint32_t(uint32_t(r_PtxRegister4800) / uint32_t(r_PtxRegister52));	 // PTX L13716
	r_PtxRegister78 = uint32_t(r_PtxRegister4801) + uint32_t(r_PtxRegister4798);			 // PTX L13717
	r_PtxRegister4802 = uint32_t(r_PtxRegister78) + uint32_t(1);							 // PTX L13718
	r_PtxRegister79 = r_PtxRegister4802 & 3;												 // PTX L13719
	r_bPtxPredicate286 = uint32_t(r_PtxRegister79) == uint32_t(0);							 // PTX L13720
	if (r_bPtxPredicate286)
	{
		goto L__BB11_78;
	} // PTX L13721
	r_PtxRegister4897 = uint32_t(0) - uint32_t(r_PtxRegister79); // PTX L13722
L__BB11_77:														 // PTX L13723
	// Native padding-loop nounroll hint; goto control edges retained. // PTX L13724
	r_PtxRegister4803 = r_PtxRegister4898 & 15;											   // PTX L13725
	r_PtxRegister4804 = ShiftRight(uint32_t(r_PtxRegister4898), uint32_t(4));			   // PTX L13726
	r_PtxRegister4805 = uint32_t(uint32_t(r_PtxRegister4804) / uint32_t(r_PtxRegister76)); // PTX L13727
	r_PtxRegister4806 = uint32_t(r_PtxRegister4805) * uint32_t(r_PtxRegister76);		   // PTX L13728
	r_PtxRegister4807 = uint32_t(r_PtxRegister4804) - uint32_t(r_PtxRegister4806);		   // PTX L13729
	r_PtxRegister4808 = uint32_t(r_PtxRegister4807) + uint32_t(r_PtxRegister71);		   // PTX L13730
	r_PtxU64Register470 =
		uint64_t(int64_t(int32_t(r_PtxRegister4803)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13731
	r_PtxU64Register471 =
		uint64_t(int64_t(int32_t(r_PtxRegister4805)) * int64_t(int32_t(r_PtxRegister45)));	   // PTX L13732
	r_PtxU64Register472 = uint64_t(r_PtxU64Register471) + uint64_t(r_PtxU64Register470);	   // PTX L13733
	r_PtxU64Register473 = uint64_t(int64_t(int32_t(r_PtxRegister4808)) * int64_t(int32_t(4))); // PTX L13734
	r_PtxU64Register474 = uint64_t(r_PtxU64Register472) + uint64_t(r_PtxU64Register473);	   // PTX L13735
	r_PtxU64Register475 = ShiftLeft(uint64_t(r_PtxU64Register474), uint32_t(2));			   // PTX L13736
	g_DownOutputByteAddressAtPtx13737 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register475); // PTX L13737
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13737) = 0;			 // PTX L13738
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13737 + 4ull) = 0;		 // PTX L13739
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13737 + 8ull) = 0;		 // PTX L13740
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13737 + 12ull) = 0;	 // PTX L13741
	r_PtxRegister4898 = uint32_t(r_PtxRegister4898) + uint32_t(r_PtxRegister52);	 // PTX L13742
	r_PtxRegister4897 = uint32_t(r_PtxRegister4897) + uint32_t(1);					 // PTX L13743
	r_bPtxPredicate287 = uint32_t(r_PtxRegister4897) != uint32_t(0);				 // PTX L13744
	if (r_bPtxPredicate287)
	{
		goto L__BB11_77;
	} // PTX L13745
L__BB11_78:														  // PTX L13746
	r_bPtxPredicate288 = uint32_t(r_PtxRegister78) < uint32_t(3); // PTX L13747
	if (r_bPtxPredicate288)
	{
		goto L__BB11_80;
	} // PTX L13748
L__BB11_79:																				   // PTX L13749
	r_PtxRegister4809 = r_PtxRegister4898 & 15;											   // PTX L13750
	r_PtxRegister4810 = ShiftRight(uint32_t(r_PtxRegister4898), uint32_t(4));			   // PTX L13751
	r_PtxRegister4811 = uint32_t(uint32_t(r_PtxRegister4810) / uint32_t(r_PtxRegister76)); // PTX L13752
	r_PtxRegister4812 = uint32_t(r_PtxRegister4811) * uint32_t(r_PtxRegister76);		   // PTX L13753
	r_PtxRegister4813 = uint32_t(r_PtxRegister4810) - uint32_t(r_PtxRegister4812);		   // PTX L13754
	r_PtxRegister4814 = uint32_t(r_PtxRegister4813) + uint32_t(r_PtxRegister71);		   // PTX L13755
	r_PtxU64Register477 =
		uint64_t(int64_t(int32_t(r_PtxRegister4809)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13756
	r_PtxU64Register478 =
		uint64_t(int64_t(int32_t(r_PtxRegister4811)) * int64_t(int32_t(r_PtxRegister45)));	   // PTX L13757
	r_PtxU64Register479 = uint64_t(r_PtxU64Register478) + uint64_t(r_PtxU64Register477);	   // PTX L13758
	r_PtxU64Register480 = uint64_t(int64_t(int32_t(r_PtxRegister4814)) * int64_t(int32_t(4))); // PTX L13759
	r_PtxU64Register481 = uint64_t(r_PtxU64Register479) + uint64_t(r_PtxU64Register480);	   // PTX L13760
	r_PtxU64Register482 = ShiftLeft(uint64_t(r_PtxU64Register481), uint32_t(2));			   // PTX L13761
	g_DownOutputByteAddressAtPtx13762 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register482);	   // PTX L13762
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13762) = 0;				   // PTX L13763
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13762 + 4ull) = 0;			   // PTX L13764
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13762 + 8ull) = 0;			   // PTX L13765
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13762 + 12ull) = 0;		   // PTX L13766
	r_PtxRegister4815 = uint32_t(r_PtxRegister4898) + uint32_t(r_PtxRegister52);		   // PTX L13767
	r_PtxRegister4816 = r_PtxRegister4815 & 15;											   // PTX L13768
	r_PtxRegister4817 = ShiftRight(uint32_t(r_PtxRegister4815), uint32_t(4));			   // PTX L13769
	r_PtxRegister4818 = uint32_t(uint32_t(r_PtxRegister4817) / uint32_t(r_PtxRegister76)); // PTX L13770
	r_PtxRegister4819 = uint32_t(r_PtxRegister4818) * uint32_t(r_PtxRegister76);		   // PTX L13771
	r_PtxRegister4820 = uint32_t(r_PtxRegister4817) - uint32_t(r_PtxRegister4819);		   // PTX L13772
	r_PtxRegister4821 = uint32_t(r_PtxRegister4820) + uint32_t(r_PtxRegister71);		   // PTX L13773
	r_PtxU64Register484 =
		uint64_t(int64_t(int32_t(r_PtxRegister4816)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13774
	r_PtxU64Register485 =
		uint64_t(int64_t(int32_t(r_PtxRegister4818)) * int64_t(int32_t(r_PtxRegister45)));	   // PTX L13775
	r_PtxU64Register486 = uint64_t(r_PtxU64Register485) + uint64_t(r_PtxU64Register484);	   // PTX L13776
	r_PtxU64Register487 = uint64_t(int64_t(int32_t(r_PtxRegister4821)) * int64_t(int32_t(4))); // PTX L13777
	r_PtxU64Register488 = uint64_t(r_PtxU64Register486) + uint64_t(r_PtxU64Register487);	   // PTX L13778
	r_PtxU64Register489 = ShiftLeft(uint64_t(r_PtxU64Register488), uint32_t(2));			   // PTX L13779
	g_DownOutputByteAddressAtPtx13780 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register489);	   // PTX L13780
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13780) = 0;				   // PTX L13781
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13780 + 4ull) = 0;			   // PTX L13782
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13780 + 8ull) = 0;			   // PTX L13783
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13780 + 12ull) = 0;		   // PTX L13784
	r_PtxRegister4822 = uint32_t(r_PtxRegister4815) + uint32_t(r_PtxRegister52);		   // PTX L13785
	r_PtxRegister4823 = r_PtxRegister4822 & 15;											   // PTX L13786
	r_PtxRegister4824 = ShiftRight(uint32_t(r_PtxRegister4822), uint32_t(4));			   // PTX L13787
	r_PtxRegister4825 = uint32_t(uint32_t(r_PtxRegister4824) / uint32_t(r_PtxRegister76)); // PTX L13788
	r_PtxRegister4826 = uint32_t(r_PtxRegister4825) * uint32_t(r_PtxRegister76);		   // PTX L13789
	r_PtxRegister4827 = uint32_t(r_PtxRegister4824) - uint32_t(r_PtxRegister4826);		   // PTX L13790
	r_PtxRegister4828 = uint32_t(r_PtxRegister4827) + uint32_t(r_PtxRegister71);		   // PTX L13791
	r_PtxU64Register491 =
		uint64_t(int64_t(int32_t(r_PtxRegister4823)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13792
	r_PtxU64Register492 =
		uint64_t(int64_t(int32_t(r_PtxRegister4825)) * int64_t(int32_t(r_PtxRegister45)));	   // PTX L13793
	r_PtxU64Register493 = uint64_t(r_PtxU64Register492) + uint64_t(r_PtxU64Register491);	   // PTX L13794
	r_PtxU64Register494 = uint64_t(int64_t(int32_t(r_PtxRegister4828)) * int64_t(int32_t(4))); // PTX L13795
	r_PtxU64Register495 = uint64_t(r_PtxU64Register493) + uint64_t(r_PtxU64Register494);	   // PTX L13796
	r_PtxU64Register496 = ShiftLeft(uint64_t(r_PtxU64Register495), uint32_t(2));			   // PTX L13797
	g_DownOutputByteAddressAtPtx13798 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register496);	   // PTX L13798
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13798) = 0;				   // PTX L13799
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13798 + 4ull) = 0;			   // PTX L13800
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13798 + 8ull) = 0;			   // PTX L13801
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13798 + 12ull) = 0;		   // PTX L13802
	r_PtxRegister4829 = uint32_t(r_PtxRegister4822) + uint32_t(r_PtxRegister52);		   // PTX L13803
	r_PtxRegister4830 = r_PtxRegister4829 & 15;											   // PTX L13804
	r_PtxRegister4831 = ShiftRight(uint32_t(r_PtxRegister4829), uint32_t(4));			   // PTX L13805
	r_PtxRegister4832 = uint32_t(uint32_t(r_PtxRegister4831) / uint32_t(r_PtxRegister76)); // PTX L13806
	r_PtxRegister4833 = uint32_t(r_PtxRegister4832) * uint32_t(r_PtxRegister76);		   // PTX L13807
	r_PtxRegister4834 = uint32_t(r_PtxRegister4831) - uint32_t(r_PtxRegister4833);		   // PTX L13808
	r_PtxRegister4835 = uint32_t(r_PtxRegister4834) + uint32_t(r_PtxRegister71);		   // PTX L13809
	r_PtxU64Register498 =
		uint64_t(int64_t(int32_t(r_PtxRegister4830)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13810
	r_PtxU64Register499 =
		uint64_t(int64_t(int32_t(r_PtxRegister4832)) * int64_t(int32_t(r_PtxRegister45)));	   // PTX L13811
	r_PtxU64Register500 = uint64_t(r_PtxU64Register499) + uint64_t(r_PtxU64Register498);	   // PTX L13812
	r_PtxU64Register501 = uint64_t(int64_t(int32_t(r_PtxRegister4835)) * int64_t(int32_t(4))); // PTX L13813
	r_PtxU64Register502 = uint64_t(r_PtxU64Register500) + uint64_t(r_PtxU64Register501);	   // PTX L13814
	r_PtxU64Register503 = ShiftLeft(uint64_t(r_PtxU64Register502), uint32_t(2));			   // PTX L13815
	g_DownOutputByteAddressAtPtx13816 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register503); // PTX L13816
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13816) = 0;			 // PTX L13817
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13816 + 4ull) = 0;		 // PTX L13818
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13816 + 8ull) = 0;		 // PTX L13819
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13816 + 12ull) = 0;	 // PTX L13820
	r_PtxRegister4898 = uint32_t(r_PtxRegister4829) + uint32_t(r_PtxRegister52);	 // PTX L13821
	r_bPtxPredicate289 = int32_t(r_PtxRegister4898) < int32_t(r_PtxRegister77);		 // PTX L13822
	if (r_bPtxPredicate289)
	{
		goto L__BB11_79;
	} // PTX L13823
L__BB11_80:																						 // PTX L13824
	return;																						 // PTX L13825
L__BB11_51:																						 // PTX L13826
	r_PtxRegister4724 = uint32_t(r_BlockSizeZ) * uint32_t(r_BlockSizeY);						 // PTX L13827
	r_PtxRegister4725 = uint32_t(r_PtxRegister4724) * uint32_t(r_BlockSizeX);					 // PTX L13828
	r_PtxRegister4726 = ShiftLeft(uint32_t(r_PtxRegister4725), uint32_t(1));					 // PTX L13829
	r_PtxRegister4894 = uint32_t(r_PtxRegister4891) + uint32_t(r_PtxRegister4726);				 // PTX L13830
	r_PtxRegister59 = ShiftLeft(uint32_t(r_PtxRegister4725), uint32_t(2));						 // PTX L13831
	r_PtxRegister4893 = uint32_t(r_PtxRegister4725) * uint32_t(3) + uint32_t(r_PtxRegister4891); // PTX L13832
	r_PtxRegister4892 = uint32_t(r_PtxRegister4891) + uint32_t(r_PtxRegister52);				 // PTX L13833
	goto L__BB11_52;																			 // PTX L13834
L__BB11_64:																						 // PTX L13835
	r_PtxRegister4747 = uint32_t(r_PtxRegister67) + uint32_t(r_PtxRegister52);					 // PTX L13836
	r_PtxRegister4891 = uint32_t(r_PtxRegister4747) + uint32_t(r_PtxRegister52);				 // PTX L13837
	r_PtxRegister4894 = uint32_t(r_PtxRegister4894) + uint32_t(r_PtxRegister59);				 // PTX L13838
	r_PtxRegister4893 = uint32_t(r_PtxRegister4893) + uint32_t(r_PtxRegister59);				 // PTX L13839
	r_PtxRegister4892 = uint32_t(r_PtxRegister4892) + uint32_t(r_PtxRegister59);				 // PTX L13840
	r_bPtxPredicate274 = uint32_t(r_PtxRegister4891) < uint32_t(256);							 // PTX L13841
	if (r_bPtxPredicate274)
	{
		goto L__BB11_52;
	} // PTX L13842
	goto L__BB11_65;															// PTX L13843
L__BB11_52:																		// PTX L13844
	r_PtxRegister4727 = ShiftRight(uint32_t(r_PtxRegister4891), uint32_t(4));	// PTX L13845
	r_PtxRegister4728 = ShiftRight(uint32_t(r_PtxRegister4891), uint32_t(6));	// PTX L13846
	r_PtxRegister60 = uint32_t(r_PtxRegister4728) + uint32_t(r_PtxRegister26);	// PTX L13847
	r_PtxRegister4729 = r_PtxRegister4727 & 3;									// PTX L13848
	r_PtxRegister61 = uint32_t(r_PtxRegister4729) + uint32_t(r_PtxRegister27);	// PTX L13849
	r_bPtxPredicate234 = int32_t(r_PtxRegister60) < int32_t(0);					// PTX L13850
	r_bPtxPredicate235 = int32_t(r_PtxRegister60) >= int32_t(r_DownHeightBits); // PTX L13851
	r_bPtxPredicate236 = r_bPtxPredicate234 | r_bPtxPredicate235;				// PTX L13852
	r_bPtxPredicate237 = int32_t(r_PtxRegister61) < int32_t(0);					// PTX L13853
	r_bPtxPredicate238 = int32_t(r_PtxRegister61) >= int32_t(r_DownWidthBits);	// PTX L13854
	r_bPtxPredicate239 = r_bPtxPredicate237 | r_bPtxPredicate238;				// PTX L13855
	r_bPtxPredicate240 = r_bPtxPredicate236 | r_bPtxPredicate239;				// PTX L13856
	if (r_bPtxPredicate240)
	{
		goto L__BB11_55;
	} // PTX L13857
	r_bPtxPredicate241 = int32_t(r_PtxRegister60) < int32_t(r_PtxRegister43); // PTX L13858
	r_bPtxPredicate242 = int32_t(r_PtxRegister61) < int32_t(r_PtxRegister44); // PTX L13859
	r_bPtxPredicate243 = r_bPtxPredicate241 & r_bPtxPredicate242;			  // PTX L13860
	if (r_bPtxPredicate243)
	{
		goto L__BB11_55;
	} // PTX L13861
	r_PtxRegister4730 = r_PtxRegister4891 & 15; // PTX L13862
	r_PtxU64Register407 =
		uint64_t(int64_t(int32_t(r_PtxRegister4730)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13863
	r_PtxU64Register408 =
		uint64_t(int64_t(int32_t(r_PtxRegister60)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13864
	r_PtxU64Register409 = uint64_t(r_PtxU64Register408) + uint64_t(r_PtxU64Register407); // PTX L13865
	r_PtxRegister4731 = ShiftLeft(uint32_t(r_PtxRegister61), uint32_t(2));				 // PTX L13866
	r_PtxU64Register410 = uint64_t(r_PtxRegister4731);									 // PTX L13867
	r_PtxU64Register411 = uint64_t(r_PtxU64Register409) + uint64_t(r_PtxU64Register410); // PTX L13868
	r_PtxU64Register412 = ShiftLeft(uint64_t(r_PtxU64Register411), uint32_t(2));		 // PTX L13869
	g_DownOutputByteAddressAtPtx13870 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register412); // PTX L13870
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13870) = 0;			 // PTX L13871
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13870 + 4ull) = 0;		 // PTX L13872
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13870 + 8ull) = 0;		 // PTX L13873
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13870 + 12ull) = 0;	 // PTX L13874
L__BB11_55:																			 // PTX L13875
	r_PtxRegister4732 = ShiftRight(uint32_t(r_PtxRegister4892), uint32_t(4));		 // PTX L13876
	r_PtxRegister4733 = ShiftRight(uint32_t(r_PtxRegister4892), uint32_t(6));		 // PTX L13877
	r_PtxRegister62 = uint32_t(r_PtxRegister4733) + uint32_t(r_PtxRegister26);		 // PTX L13878
	r_PtxRegister4734 = r_PtxRegister4732 & 3;										 // PTX L13879
	r_PtxRegister63 = uint32_t(r_PtxRegister4734) + uint32_t(r_PtxRegister27);		 // PTX L13880
	r_bPtxPredicate244 = int32_t(r_PtxRegister62) < int32_t(0);						 // PTX L13881
	r_bPtxPredicate245 = int32_t(r_PtxRegister62) >= int32_t(r_DownHeightBits);		 // PTX L13882
	r_bPtxPredicate246 = r_bPtxPredicate244 | r_bPtxPredicate245;					 // PTX L13883
	r_bPtxPredicate247 = int32_t(r_PtxRegister63) < int32_t(0);						 // PTX L13884
	r_bPtxPredicate248 = int32_t(r_PtxRegister63) >= int32_t(r_DownWidthBits);		 // PTX L13885
	r_bPtxPredicate249 = r_bPtxPredicate247 | r_bPtxPredicate248;					 // PTX L13886
	r_bPtxPredicate250 = r_bPtxPredicate246 | r_bPtxPredicate249;					 // PTX L13887
	if (r_bPtxPredicate250)
	{
		goto L__BB11_58;
	} // PTX L13888
	r_bPtxPredicate251 = int32_t(r_PtxRegister62) < int32_t(r_PtxRegister43); // PTX L13889
	r_bPtxPredicate252 = int32_t(r_PtxRegister63) < int32_t(r_PtxRegister44); // PTX L13890
	r_bPtxPredicate253 = r_bPtxPredicate251 & r_bPtxPredicate252;			  // PTX L13891
	if (r_bPtxPredicate253)
	{
		goto L__BB11_58;
	} // PTX L13892
	r_PtxRegister4735 = r_PtxRegister4892 & 15; // PTX L13893
	r_PtxU64Register414 =
		uint64_t(int64_t(int32_t(r_PtxRegister4735)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13894
	r_PtxU64Register415 =
		uint64_t(int64_t(int32_t(r_PtxRegister62)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13895
	r_PtxU64Register416 = uint64_t(r_PtxU64Register415) + uint64_t(r_PtxU64Register414); // PTX L13896
	r_PtxRegister4736 = ShiftLeft(uint32_t(r_PtxRegister63), uint32_t(2));				 // PTX L13897
	r_PtxU64Register417 = uint64_t(r_PtxRegister4736);									 // PTX L13898
	r_PtxU64Register418 = uint64_t(r_PtxU64Register416) + uint64_t(r_PtxU64Register417); // PTX L13899
	r_PtxU64Register419 = ShiftLeft(uint64_t(r_PtxU64Register418), uint32_t(2));		 // PTX L13900
	g_DownOutputByteAddressAtPtx13901 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register419); // PTX L13901
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13901) = 0;			 // PTX L13902
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13901 + 4ull) = 0;		 // PTX L13903
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13901 + 8ull) = 0;		 // PTX L13904
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13901 + 12ull) = 0;	 // PTX L13905
L__BB11_58:																			 // PTX L13906
	r_PtxRegister64 = uint32_t(r_PtxRegister4891) + uint32_t(r_PtxRegister52);		 // PTX L13907
	r_PtxRegister4737 = ShiftRight(uint32_t(r_PtxRegister4894), uint32_t(4));		 // PTX L13908
	r_PtxRegister4738 = ShiftRight(uint32_t(r_PtxRegister4894), uint32_t(6));		 // PTX L13909
	r_PtxRegister65 = uint32_t(r_PtxRegister4738) + uint32_t(r_PtxRegister26);		 // PTX L13910
	r_PtxRegister4739 = r_PtxRegister4737 & 3;										 // PTX L13911
	r_PtxRegister66 = uint32_t(r_PtxRegister4739) + uint32_t(r_PtxRegister27);		 // PTX L13912
	r_bPtxPredicate254 = int32_t(r_PtxRegister65) < int32_t(0);						 // PTX L13913
	r_bPtxPredicate255 = int32_t(r_PtxRegister65) >= int32_t(r_DownHeightBits);		 // PTX L13914
	r_bPtxPredicate256 = r_bPtxPredicate254 | r_bPtxPredicate255;					 // PTX L13915
	r_bPtxPredicate257 = int32_t(r_PtxRegister66) < int32_t(0);						 // PTX L13916
	r_bPtxPredicate258 = int32_t(r_PtxRegister66) >= int32_t(r_DownWidthBits);		 // PTX L13917
	r_bPtxPredicate259 = r_bPtxPredicate257 | r_bPtxPredicate258;					 // PTX L13918
	r_bPtxPredicate260 = r_bPtxPredicate256 | r_bPtxPredicate259;					 // PTX L13919
	if (r_bPtxPredicate260)
	{
		goto L__BB11_61;
	} // PTX L13920
	r_bPtxPredicate261 = int32_t(r_PtxRegister65) < int32_t(r_PtxRegister43); // PTX L13921
	r_bPtxPredicate262 = int32_t(r_PtxRegister66) < int32_t(r_PtxRegister44); // PTX L13922
	r_bPtxPredicate263 = r_bPtxPredicate261 & r_bPtxPredicate262;			  // PTX L13923
	if (r_bPtxPredicate263)
	{
		goto L__BB11_61;
	} // PTX L13924
	r_PtxRegister4740 = r_PtxRegister4894 & 15; // PTX L13925
	r_PtxU64Register421 =
		uint64_t(int64_t(int32_t(r_PtxRegister4740)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13926
	r_PtxU64Register422 =
		uint64_t(int64_t(int32_t(r_PtxRegister65)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13927
	r_PtxU64Register423 = uint64_t(r_PtxU64Register422) + uint64_t(r_PtxU64Register421); // PTX L13928
	r_PtxRegister4741 = ShiftLeft(uint32_t(r_PtxRegister66), uint32_t(2));				 // PTX L13929
	r_PtxU64Register424 = uint64_t(r_PtxRegister4741);									 // PTX L13930
	r_PtxU64Register425 = uint64_t(r_PtxU64Register423) + uint64_t(r_PtxU64Register424); // PTX L13931
	r_PtxU64Register426 = ShiftLeft(uint64_t(r_PtxU64Register425), uint32_t(2));		 // PTX L13932
	g_DownOutputByteAddressAtPtx13933 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register426); // PTX L13933
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13933) = 0;			 // PTX L13934
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13933 + 4ull) = 0;		 // PTX L13935
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13933 + 8ull) = 0;		 // PTX L13936
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13933 + 12ull) = 0;	 // PTX L13937
L__BB11_61:																			 // PTX L13938
	r_PtxRegister67 = uint32_t(r_PtxRegister64) + uint32_t(r_PtxRegister52);		 // PTX L13939
	r_PtxRegister4742 = ShiftRight(uint32_t(r_PtxRegister4893), uint32_t(4));		 // PTX L13940
	r_PtxRegister4743 = ShiftRight(uint32_t(r_PtxRegister4893), uint32_t(6));		 // PTX L13941
	r_PtxRegister68 = uint32_t(r_PtxRegister4743) + uint32_t(r_PtxRegister26);		 // PTX L13942
	r_PtxRegister4744 = r_PtxRegister4742 & 3;										 // PTX L13943
	r_PtxRegister69 = uint32_t(r_PtxRegister4744) + uint32_t(r_PtxRegister27);		 // PTX L13944
	r_bPtxPredicate264 = int32_t(r_PtxRegister68) < int32_t(0);						 // PTX L13945
	r_bPtxPredicate265 = int32_t(r_PtxRegister68) >= int32_t(r_DownHeightBits);		 // PTX L13946
	r_bPtxPredicate266 = r_bPtxPredicate264 | r_bPtxPredicate265;					 // PTX L13947
	r_bPtxPredicate267 = int32_t(r_PtxRegister69) < int32_t(0);						 // PTX L13948
	r_bPtxPredicate268 = int32_t(r_PtxRegister69) >= int32_t(r_DownWidthBits);		 // PTX L13949
	r_bPtxPredicate269 = r_bPtxPredicate267 | r_bPtxPredicate268;					 // PTX L13950
	r_bPtxPredicate270 = r_bPtxPredicate266 | r_bPtxPredicate269;					 // PTX L13951
	if (r_bPtxPredicate270)
	{
		goto L__BB11_64;
	} // PTX L13952
	r_bPtxPredicate271 = int32_t(r_PtxRegister68) < int32_t(r_PtxRegister43); // PTX L13953
	r_bPtxPredicate272 = int32_t(r_PtxRegister69) < int32_t(r_PtxRegister44); // PTX L13954
	r_bPtxPredicate273 = r_bPtxPredicate271 & r_bPtxPredicate272;			  // PTX L13955
	if (r_bPtxPredicate273)
	{
		goto L__BB11_64;
	} // PTX L13956
	r_PtxRegister4745 = r_PtxRegister4893 & 15; // PTX L13957
	r_PtxU64Register428 =
		uint64_t(int64_t(int32_t(r_PtxRegister4745)) * int64_t(int32_t(r_PtxRegister46))); // PTX L13958
	r_PtxU64Register429 =
		uint64_t(int64_t(int32_t(r_PtxRegister68)) * int64_t(int32_t(r_PtxRegister45))); // PTX L13959
	r_PtxU64Register430 = uint64_t(r_PtxU64Register429) + uint64_t(r_PtxU64Register428); // PTX L13960
	r_PtxRegister4746 = ShiftLeft(uint32_t(r_PtxRegister69), uint32_t(2));				 // PTX L13961
	r_PtxU64Register431 = uint64_t(r_PtxRegister4746);									 // PTX L13962
	r_PtxU64Register432 = uint64_t(r_PtxU64Register430) + uint64_t(r_PtxU64Register431); // PTX L13963
	r_PtxU64Register433 = ShiftLeft(uint64_t(r_PtxU64Register432), uint32_t(2));		 // PTX L13964
	g_DownOutputByteAddressAtPtx13965 =
		uint64_t(g_DownOutputByteAddressAtPtx13164) + uint64_t(r_PtxU64Register433); // PTX L13965
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13965) = 0;			 // PTX L13966
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13965 + 4ull) = 0;		 // PTX L13967
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13965 + 8ull) = 0;		 // PTX L13968
	*reinterpret_cast<uint32_t*>(g_DownOutputByteAddressAtPtx13965 + 12ull) = 0;	 // PTX L13969
	goto L__BB11_64;																 // PTX L13970
#endif
}
} // namespace dlssnr::reconstructed::window_block_c64_downsample_fp8
