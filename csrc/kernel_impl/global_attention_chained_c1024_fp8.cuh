// Readable CUDA C++ reconstruction of cc_vit_1d_attention_chained_fp8.
// Not historical source; original scalar/control identities are retained for audit.
#pragma once
#include "global_attention_chained_c1024_abi_fp8.cuh"

namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8
{
__global__ __maxnreg__(168) void global_attention_chained_c1024_fp8(Parameters r_Parameters)
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
	uint16_t r_PtxU16Register1, r_ConvertedE4PairAtPtx145Rs2, r_PtxU16Register3, r_ConvertedE4PairAtPtx179Rs4,
		r_PtxU16Register5, r_ConvertedE4PairAtPtx213Rs6, r_PtxU16Register7, r_ConvertedE4PairAtPtx247Rs8,
		r_PtxU16Register9, r_ConvertedE4PairAtPtx349Rs10, r_PtxU16Register11, r_ConvertedE4PairAtPtx403Rs12;
	uint16_t r_ConvertedE4PairAtPtx2251Rs13, r_ConvertedE4PairAtPtx2254Rs14, r_ConvertedE4PairAtPtx2258Rs15,
		r_ConvertedE4PairAtPtx2261Rs16, r_ConvertedE4PairAtPtx2265Rs17, r_ConvertedE4PairAtPtx2268Rs18,
		r_ConvertedE4PairAtPtx2272Rs19, r_ConvertedE4PairAtPtx2275Rs20, r_ConvertedE4PairAtPtx2279Rs21,
		r_ConvertedE4PairAtPtx2282Rs22, r_ConvertedE4PairAtPtx2286Rs23, r_ConvertedE4PairAtPtx2289Rs24;
	uint16_t r_ConvertedE4PairAtPtx2293Rs25, r_ConvertedE4PairAtPtx2296Rs26, r_ConvertedE4PairAtPtx2300Rs27,
		r_ConvertedE4PairAtPtx2303Rs28, r_ConvertedE4PairAtPtx2307Rs29, r_ConvertedE4PairAtPtx2310Rs30,
		r_ConvertedE4PairAtPtx2314Rs31, r_ConvertedE4PairAtPtx2317Rs32, r_ConvertedE4PairAtPtx2321Rs33,
		r_ConvertedE4PairAtPtx2324Rs34, r_ConvertedE4PairAtPtx2328Rs35, r_ConvertedE4PairAtPtx2331Rs36;
	uint16_t r_ConvertedE4PairAtPtx2335Rs37, r_ConvertedE4PairAtPtx2338Rs38, r_ConvertedE4PairAtPtx2342Rs39,
		r_ConvertedE4PairAtPtx2345Rs40, r_ConvertedE4PairAtPtx2349Rs41, r_ConvertedE4PairAtPtx2352Rs42,
		r_ConvertedE4PairAtPtx2356Rs43, r_ConvertedE4PairAtPtx2359Rs44, r_ConvertedE4PairAtPtx2363Rs45,
		r_ConvertedE4PairAtPtx2366Rs46, r_ConvertedE4PairAtPtx2370Rs47, r_ConvertedE4PairAtPtx2373Rs48;
	uint16_t r_ConvertedE4PairAtPtx2377Rs49, r_ConvertedE4PairAtPtx2380Rs50, r_ConvertedE4PairAtPtx2384Rs51,
		r_ConvertedE4PairAtPtx2387Rs52, r_ConvertedE4PairAtPtx2391Rs53, r_ConvertedE4PairAtPtx2394Rs54,
		r_ConvertedE4PairAtPtx2398Rs55, r_ConvertedE4PairAtPtx2401Rs56, r_ConvertedE4PairAtPtx2405Rs57,
		r_ConvertedE4PairAtPtx2408Rs58, r_ConvertedE4PairAtPtx2412Rs59, r_ConvertedE4PairAtPtx2415Rs60;
	uint16_t r_ConvertedE4PairAtPtx2419Rs61, r_ConvertedE4PairAtPtx2422Rs62, r_ConvertedE4PairAtPtx2426Rs63,
		r_ConvertedE4PairAtPtx2429Rs64, r_ConvertedE4PairAtPtx2433Rs65, r_ConvertedE4PairAtPtx2436Rs66,
		r_ConvertedE4PairAtPtx2440Rs67, r_ConvertedE4PairAtPtx2443Rs68, r_ConvertedE4PairAtPtx2447Rs69,
		r_ConvertedE4PairAtPtx2450Rs70, r_ConvertedE4PairAtPtx2454Rs71, r_ConvertedE4PairAtPtx2457Rs72;
	uint16_t r_ConvertedE4PairAtPtx2461Rs73, r_ConvertedE4PairAtPtx2464Rs74, r_ConvertedE4PairAtPtx2468Rs75,
		r_ConvertedE4PairAtPtx2471Rs76, r_PtxU16Register77, r_PtxU16Register78, r_PtxU16Register79,
		r_PtxU16Register80, r_PtxU16Register81, r_PtxU16Register82, r_PtxU16Register83, r_PtxU16Register84;
	uint16_t r_PtxU16Register85, r_ConvertedE4PairAtPtx2784Rs86, r_PtxU16Register87,
		r_ConvertedE4PairAtPtx2845Rs88, r_PtxU16Register89, r_PtxU16Register90, r_PtxU16Register91,
		r_PtxU16Register92, r_PtxU16Register93, r_ConvertedE4PairAtPtx3674Rs94,
		r_ConvertedE4PairAtPtx3677Rs95, r_ConvertedE4PairAtPtx3680Rs96;
	uint16_t r_ConvertedE4PairAtPtx3683Rs97, r_ConvertedE4PairAtPtx3686Rs98, r_ConvertedE4PairAtPtx3689Rs99,
		r_ConvertedE4PairAtPtx3692Rs100, r_ConvertedE4PairAtPtx3695Rs101, r_ConvertedE4PairAtPtx3698Rs102,
		r_ConvertedE4PairAtPtx3701Rs103, r_ConvertedE4PairAtPtx3704Rs104, r_ConvertedE4PairAtPtx3707Rs105,
		r_ConvertedE4PairAtPtx3710Rs106, r_ConvertedE4PairAtPtx3713Rs107, r_ConvertedE4PairAtPtx3716Rs108;
	uint16_t r_ConvertedE4PairAtPtx3719Rs109, r_ConvertedE4PairAtPtx3722Rs110,
		r_ConvertedE4PairAtPtx3725Rs111, r_ConvertedE4PairAtPtx3728Rs112, r_ConvertedE4PairAtPtx3731Rs113,
		r_ConvertedE4PairAtPtx3734Rs114, r_ConvertedE4PairAtPtx3737Rs115, r_ConvertedE4PairAtPtx3740Rs116,
		r_ConvertedE4PairAtPtx3743Rs117, r_ConvertedE4PairAtPtx3746Rs118, r_ConvertedE4PairAtPtx3749Rs119,
		r_ConvertedE4PairAtPtx3752Rs120;
	uint16_t r_ConvertedE4PairAtPtx3755Rs121, r_ConvertedE4PairAtPtx3758Rs122,
		r_ConvertedE4PairAtPtx3761Rs123, r_ConvertedE4PairAtPtx3764Rs124, r_ConvertedE4PairAtPtx3767Rs125,
		r_PtxU16Register126, r_PtxU16Register127, r_PtxU16Register128, r_PtxU16Register129,
		r_PtxU16Register130, r_PtxU16Register131, r_PtxU16Register132;
	uint16_t r_PtxU16Register133, r_PtxU16Register134, r_PtxU16Register135, r_PtxU16Register136,
		r_PtxU16Register137, r_PtxU16Register138, r_PtxU16Register139, r_PtxU16Register140,
		r_PtxU16Register141, r_PtxU16Register142, r_PtxU16Register143, r_PtxU16Register144;
	uint16_t r_PtxU16Register145, r_PtxU16Register146, r_PtxU16Register147, r_PtxU16Register148,
		r_PtxU16Register149, r_PtxU16Register150, r_PtxU16Register151, r_PtxU16Register152,
		r_PtxU16Register153, r_PtxU16Register154, r_PtxU16Register155, r_PtxU16Register156;
	uint16_t r_PtxU16Register157, r_PtxU16Register158, r_PtxU16Register159, r_PtxU16Register160,
		r_PtxU16Register161, r_PtxU16Register162, r_PtxU16Register163, r_PtxU16Register164,
		r_PtxU16Register165, r_PtxU16Register166, r_PtxU16Register167, r_PtxU16Register168;
	uint16_t r_PtxU16Register169, r_PtxU16Register170, r_PtxU16Register171, r_PtxU16Register172,
		r_PtxU16Register173, r_PtxU16Register174, r_PtxU16Register175, r_PtxU16Register176,
		r_PtxU16Register177, r_PtxU16Register178, r_PtxU16Register179, r_PtxU16Register180;
	uint16_t r_PtxU16Register181, r_PtxU16Register182, r_PtxU16Register183, r_PtxU16Register184,
		r_PtxU16Register185, r_PtxU16Register186, r_PtxU16Register187, r_PtxU16Register188,
		r_PtxU16Register189, r_PtxU16Register190, r_PtxU16Register191, r_PtxU16Register192;
	uint16_t r_PtxU16Register193, r_PtxU16Register194, r_PtxU16Register195, r_PtxU16Register196,
		r_PtxU16Register197, r_PtxU16Register198, r_PtxU16Register199, r_PtxU16Register200,
		r_PtxU16Register201, r_PtxU16Register202, r_PtxU16Register203, r_PtxU16Register204;
	uint16_t r_PtxU16Register205, r_PtxU16Register206, r_PtxU16Register207, r_PtxU16Register208,
		r_PtxU16Register209, r_PtxU16Register210, r_PtxU16Register211, r_PtxU16Register212,
		r_PtxU16Register213, r_PtxU16Register214, r_PtxU16Register215, r_PtxU16Register216;
	uint16_t r_PtxU16Register217, r_PtxU16Register218, r_PtxU16Register219, r_PtxU16Register220,
		r_PtxU16Register221, r_PtxU16Register222, r_PtxU16Register223, r_PtxU16Register224,
		r_PtxU16Register225, r_PtxU16Register226, r_PtxU16Register227, r_PtxU16Register228;
	uint16_t r_PtxU16Register229, r_PtxU16Register230, r_PtxU16Register231, r_PtxU16Register232,
		r_PtxU16Register233, r_PtxU16Register234, r_PtxU16Register235, r_PtxU16Register236,
		r_PtxU16Register237, r_PtxU16Register238, r_PtxU16Register239, r_PtxU16Register240;
	uint16_t r_PtxU16Register241, r_PtxU16Register242, r_PtxU16Register243, r_PtxU16Register244,
		r_PtxU16Register245, r_PtxU16Register246, r_PtxU16Register247, r_PtxU16Register248,
		r_PtxU16Register249, r_PtxU16Register250, r_PtxU16Register251, r_PtxU16Register252;
	uint16_t r_PtxU16Register253, r_PtxU16Register254, r_PtxU16Register255, r_PtxU16Register256,
		r_PtxU16Register257, r_PtxU16Register258, r_PtxU16Register259, r_PtxU16Register260,
		r_PtxU16Register261, r_PtxU16Register262, r_PtxU16Register263, r_PtxU16Register264;
	uint16_t r_PtxU16Register265, r_PtxU16Register266, r_PtxU16Register267, r_PtxU16Register268,
		r_PtxU16Register269, r_PtxU16Register270, r_PtxU16Register271, r_PtxU16Register272,
		r_PtxU16Register273, r_PtxU16Register274, r_PtxU16Register275, r_PtxU16Register276;
	uint16_t r_PtxU16Register277, r_PtxU16Register278, r_PtxU16Register279, r_PtxU16Register280,
		r_PtxU16Register281, r_PtxU16Register282, r_PtxU16Register283, r_PtxU16Register284,
		r_PtxU16Register285, r_PtxU16Register286, r_PtxU16Register287, r_PtxU16Register288;
	uint16_t r_PtxU16Register289, r_PtxU16Register290, r_PtxU16Register291, r_PtxU16Register292,
		r_PtxU16Register293, r_PtxU16Register294, r_PtxU16Register295, r_PtxU16Register296,
		r_PtxU16Register297, r_PtxU16Register298, r_PtxU16Register299, r_PtxU16Register300;
	uint16_t r_PtxU16Register301, r_PtxU16Register302, r_PtxU16Register303, r_PtxU16Register304,
		r_PtxU16Register305, r_PtxU16Register306, r_PtxU16Register307, r_PtxU16Register308,
		r_PtxU16Register309, r_PtxU16Register310, r_PtxU16Register311, r_PtxU16Register312;
	uint16_t r_PtxU16Register313, r_PtxU16Register314, r_PtxU16Register315, r_PtxU16Register316,
		r_PtxU16Register317, r_PtxU16Register318, r_PtxU16Register319, r_PtxU16Register320,
		r_PtxU16Register321, r_PtxU16Register322, r_PtxU16Register323, r_PtxU16Register324;
	uint16_t r_PtxU16Register325, r_PtxU16Register326, r_PtxU16Register327, r_PtxU16Register328,
		r_PtxU16Register329, r_PtxU16Register330, r_PtxU16Register331, r_PtxU16Register332,
		r_PtxU16Register333, r_PtxU16Register334, r_PtxU16Register335, r_PtxU16Register336;
	uint16_t r_PtxU16Register337, r_PtxU16Register338, r_PtxU16Register339, r_PtxU16Register340,
		r_PtxU16Register341, r_PtxU16Register342, r_PtxU16Register343, r_PtxU16Register344,
		r_PtxU16Register345, r_PtxU16Register346, r_PtxU16Register347, r_PtxU16Register348;
	uint16_t r_PtxU16Register349, r_PtxU16Register350, r_PtxU16Register351, r_PtxU16Register352,
		r_PtxU16Register353, r_PtxU16Register354, r_PtxU16Register355, r_PtxU16Register356,
		r_PtxU16Register357, r_PtxU16Register358, r_PtxU16Register359, r_PtxU16Register360;
	uint16_t r_PtxU16Register361, r_PtxU16Register362, r_PtxU16Register363, r_PtxU16Register364,
		r_PtxU16Register365, r_PtxU16Register366, r_PtxU16Register367, r_PtxU16Register368,
		r_PtxU16Register369, r_PtxU16Register370, r_PtxU16Register371, r_PtxU16Register372;
	uint16_t r_PtxU16Register373, r_PtxU16Register374, r_PtxU16Register375, r_PtxU16Register376,
		r_PtxU16Register377, r_PtxU16Register378, r_PtxU16Register379, r_PtxU16Register380,
		r_PtxU16Register381, r_PtxU16Register382, r_PtxU16Register383, r_PtxU16Register384;
	uint16_t r_PtxU16Register385, r_PtxU16Register386, r_PtxU16Register387, r_PtxU16Register388,
		r_PtxU16Register389, r_PtxU16Register390, r_PtxU16Register391, r_PtxU16Register392,
		r_PtxU16Register393, r_PtxU16Register394, r_PtxU16Register395;
	uint32_t r_CtaXAtPtx23, r_CtaYAtPtx24, r_PtxRegister3, r_PtxRegister4, r_PtxRegister5, r_PtxRegister6,
		r_ThreadYAtPtx63, r_PtxRegister8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_CtaXAtPtx2701, r_ThreadYAtPtx2703, r_PtxRegister33, r_PtxRegister34,
		r_ThreadYAtPtx3769, r_CtaXAtPtx3775;
	uint32_t r_PtxRegister37, r_BlockSizeYAtPtx3873, r_ThreadZAtPtx3874, r_BlockSizeXAtPtx3876,
		r_ThreadXAtPtx3877, r_BlockSizeZ, r_PtxRegister43, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46,
		r_PtxRegister47, r_PtxRegister48;
	uint32_t r_BatchBits, r_TokensBits, r_PtxRegister51, r_PtxRegister52, r_PtxRegister53, r_PtxRegister54,
		r_PtxRegister55, r_PtxRegister56, r_PtxRegister57, r_PtxRegister58, r_PtxRegister59, r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_ThreadXAtPtx62,
		r_PtxRegister72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_BlockSizeXAtPtx67, r_BlockSizeYAtPtx68, r_PtxRegister77,
		r_PtxRegister78, r_ThreadZAtPtx84, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82, r_PtxRegister83,
		r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PackedHalf2AtPtx143R86, r_LaneIndexAtPtx129, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PackedHalf2AtPtx177R92, r_LaneIndexAtPtx163, r_PtxRegister94,
		r_PtxRegister95, r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PackedHalf2AtPtx211R98, r_LaneIndexAtPtx197, r_PtxRegister100,
		r_PtxRegister101, r_PtxRegister102, r_PtxRegister103, r_PackedHalf2AtPtx245R104, r_LaneIndexAtPtx231,
		r_PtxRegister106, r_PtxRegister107, r_PtxRegister108;
	uint32_t r_Float32BitsAtPtx254R109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112,
		r_PtxRegister113, r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117,
		r_PtxRegister118, r_PtxRegister119, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PackedHalf2AtPtx347R126, r_LaneIndexAtPtx353, r_PtxRegister128, r_PackedE4WordAtPtx351R129,
		r_PtxRegister130, r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PtxRegister135, r_PtxRegister136, r_PtxRegister137,
		r_PtxRegister138, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141, r_PackedHalf2AtPtx401R142,
		r_LaneIndexAtPtx407, r_PtxRegister144;
	uint32_t r_PackedE4WordAtPtx405R145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148,
		r_PtxRegister149, r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153,
		r_PtxRegister154, r_PtxRegister155, r_PtxRegister156;
	uint32_t r_LaneIndexAtPtx508, r_PtxRegister158, r_LaneIndexAtPtx518, r_PtxRegister160,
		r_LaneIndexAtPtx527, r_PtxRegister162, r_LaneIndexAtPtx536, r_PtxRegister164,
		r_MmaBE4x4WordAtPtx515R165, r_MmaBE4x4WordAtPtx515R166, r_MmaBE4x4WordAtPtx515R167,
		r_MmaBE4x4WordAtPtx515R168;
	uint32_t r_MmaBE4x4WordAtPtx524R169, r_MmaBE4x4WordAtPtx524R170, r_MmaBE4x4WordAtPtx524R171,
		r_MmaBE4x4WordAtPtx524R172, r_MmaBE4x4WordAtPtx533R173, r_MmaBE4x4WordAtPtx533R174,
		r_MmaBE4x4WordAtPtx533R175, r_MmaBE4x4WordAtPtx533R176, r_MmaBE4x4WordAtPtx542R177,
		r_MmaBE4x4WordAtPtx542R178, r_MmaBE4x4WordAtPtx542R179, r_MmaBE4x4WordAtPtx542R180;
	uint32_t r_LaneIndexAtPtx769, r_Float32BitsAtPtx771R182, r_Float32BitsAtPtx778R183,
		r_Float32BitsAtPtx785R184, r_Float32BitsAtPtx792R185, r_MmaAccumulatorHalf2WordAtPtx545R186,
		r_PackedHalf2AtPtx773R187, r_PackedHalf2AtPtx780R188, r_PackedHalf2AtPtx800R189,
		r_PackedHalf2AtPtx787R190, r_PtxRegister191, r_PackedHalf2AtPtx804R192;
	uint32_t r_PackedHalf2AtPtx794R193, r_LaneIndexAtPtx814, r_MmaAccumulatorHalf2WordAtPtx545R195,
		r_PackedHalf2AtPtx817R196, r_PtxRegister197, r_PackedHalf2AtPtx821R198, r_LaneIndexAtPtx831,
		r_MmaAccumulatorHalf2WordAtPtx552R200, r_PackedHalf2AtPtx834R201, r_PtxRegister202,
		r_PackedHalf2AtPtx838R203, r_LaneIndexAtPtx848;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx552R205, r_PackedHalf2AtPtx851R206, r_PtxRegister207,
		r_PackedHalf2AtPtx855R208, r_LaneIndexAtPtx865, r_MmaAccumulatorHalf2WordAtPtx559R210,
		r_PackedHalf2AtPtx868R211, r_PtxRegister212, r_PackedHalf2AtPtx872R213, r_LaneIndexAtPtx882,
		r_MmaAccumulatorHalf2WordAtPtx559R215, r_PackedHalf2AtPtx885R216;
	uint32_t r_PtxRegister217, r_PackedHalf2AtPtx889R218, r_LaneIndexAtPtx899,
		r_MmaAccumulatorHalf2WordAtPtx566R220, r_PackedHalf2AtPtx902R221, r_PtxRegister222,
		r_PackedHalf2AtPtx906R223, r_LaneIndexAtPtx916, r_MmaAccumulatorHalf2WordAtPtx566R225,
		r_PackedHalf2AtPtx919R226, r_PtxRegister227, r_PackedHalf2AtPtx923R228;
	uint32_t r_LaneIndexAtPtx933, r_MmaAccumulatorHalf2WordAtPtx573R230, r_PackedHalf2AtPtx936R231,
		r_PtxRegister232, r_PackedHalf2AtPtx940R233, r_LaneIndexAtPtx950,
		r_MmaAccumulatorHalf2WordAtPtx573R235, r_PackedHalf2AtPtx953R236, r_PtxRegister237,
		r_PackedHalf2AtPtx957R238, r_LaneIndexAtPtx967, r_MmaAccumulatorHalf2WordAtPtx580R240;
	uint32_t r_PackedHalf2AtPtx970R241, r_PtxRegister242, r_PackedHalf2AtPtx974R243, r_LaneIndexAtPtx984,
		r_MmaAccumulatorHalf2WordAtPtx580R245, r_PackedHalf2AtPtx987R246, r_PtxRegister247,
		r_PackedHalf2AtPtx991R248, r_LaneIndexAtPtx1001, r_MmaAccumulatorHalf2WordAtPtx587R250,
		r_PackedHalf2AtPtx1004R251, r_PtxRegister252;
	uint32_t r_PackedHalf2AtPtx1008R253, r_LaneIndexAtPtx1018, r_MmaAccumulatorHalf2WordAtPtx587R255,
		r_PackedHalf2AtPtx1021R256, r_PtxRegister257, r_PackedHalf2AtPtx1025R258, r_LaneIndexAtPtx1035,
		r_MmaAccumulatorHalf2WordAtPtx594R260, r_PackedHalf2AtPtx1038R261, r_PtxRegister262,
		r_PackedHalf2AtPtx1042R263, r_LaneIndexAtPtx1052;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx594R265, r_PackedHalf2AtPtx1055R266, r_PtxRegister267,
		r_PackedHalf2AtPtx1059R268, r_LaneIndexAtPtx1069, r_MmaAccumulatorHalf2WordAtPtx601R270,
		r_PackedHalf2AtPtx1072R271, r_PtxRegister272, r_PackedHalf2AtPtx1076R273, r_LaneIndexAtPtx1086,
		r_MmaAccumulatorHalf2WordAtPtx601R275, r_PackedHalf2AtPtx1089R276;
	uint32_t r_PtxRegister277, r_PackedHalf2AtPtx1093R278, r_LaneIndexAtPtx1103,
		r_MmaAccumulatorHalf2WordAtPtx608R280, r_PackedHalf2AtPtx1106R281, r_PtxRegister282,
		r_PackedHalf2AtPtx1110R283, r_LaneIndexAtPtx1120, r_MmaAccumulatorHalf2WordAtPtx608R285,
		r_PackedHalf2AtPtx1123R286, r_PtxRegister287, r_PackedHalf2AtPtx1127R288;
	uint32_t r_LaneIndexAtPtx1137, r_MmaAccumulatorHalf2WordAtPtx615R290, r_PackedHalf2AtPtx1140R291,
		r_PtxRegister292, r_PackedHalf2AtPtx1144R293, r_LaneIndexAtPtx1154,
		r_MmaAccumulatorHalf2WordAtPtx615R295, r_PackedHalf2AtPtx1157R296, r_PtxRegister297,
		r_PackedHalf2AtPtx1161R298, r_LaneIndexAtPtx1171, r_MmaAccumulatorHalf2WordAtPtx622R300;
	uint32_t r_PackedHalf2AtPtx1174R301, r_PtxRegister302, r_PackedHalf2AtPtx1178R303, r_LaneIndexAtPtx1188,
		r_MmaAccumulatorHalf2WordAtPtx622R305, r_PackedHalf2AtPtx1191R306, r_PtxRegister307,
		r_PackedHalf2AtPtx1195R308, r_LaneIndexAtPtx1205, r_MmaAccumulatorHalf2WordAtPtx629R310,
		r_PackedHalf2AtPtx1208R311, r_PtxRegister312;
	uint32_t r_PackedHalf2AtPtx1212R313, r_LaneIndexAtPtx1222, r_MmaAccumulatorHalf2WordAtPtx629R315,
		r_PackedHalf2AtPtx1225R316, r_PtxRegister317, r_PackedHalf2AtPtx1229R318, r_LaneIndexAtPtx1239,
		r_MmaAccumulatorHalf2WordAtPtx636R320, r_PackedHalf2AtPtx1242R321, r_PtxRegister322,
		r_PackedHalf2AtPtx1246R323, r_LaneIndexAtPtx1256;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx636R325, r_PackedHalf2AtPtx1259R326, r_PtxRegister327,
		r_PackedHalf2AtPtx1263R328, r_LaneIndexAtPtx1273, r_MmaAccumulatorHalf2WordAtPtx643R330,
		r_PackedHalf2AtPtx1276R331, r_PtxRegister332, r_PackedHalf2AtPtx1280R333, r_LaneIndexAtPtx1290,
		r_MmaAccumulatorHalf2WordAtPtx643R335, r_PackedHalf2AtPtx1293R336;
	uint32_t r_PtxRegister337, r_PackedHalf2AtPtx1297R338, r_LaneIndexAtPtx1307,
		r_MmaAccumulatorHalf2WordAtPtx650R340, r_PackedHalf2AtPtx1310R341, r_PtxRegister342,
		r_PackedHalf2AtPtx1314R343, r_LaneIndexAtPtx1324, r_MmaAccumulatorHalf2WordAtPtx650R345,
		r_PackedHalf2AtPtx1327R346, r_PtxRegister347, r_PackedHalf2AtPtx1331R348;
	uint32_t r_LaneIndexAtPtx1341, r_MmaAccumulatorHalf2WordAtPtx657R350, r_PackedHalf2AtPtx1344R351,
		r_PtxRegister352, r_PackedHalf2AtPtx1348R353, r_LaneIndexAtPtx1358,
		r_MmaAccumulatorHalf2WordAtPtx657R355, r_PackedHalf2AtPtx1361R356, r_PtxRegister357,
		r_PackedHalf2AtPtx1365R358, r_LaneIndexAtPtx1375, r_MmaAccumulatorHalf2WordAtPtx664R360;
	uint32_t r_PackedHalf2AtPtx1378R361, r_PtxRegister362, r_PackedHalf2AtPtx1382R363, r_LaneIndexAtPtx1392,
		r_MmaAccumulatorHalf2WordAtPtx664R365, r_PackedHalf2AtPtx1395R366, r_PtxRegister367,
		r_PackedHalf2AtPtx1399R368, r_LaneIndexAtPtx1409, r_MmaAccumulatorHalf2WordAtPtx671R370,
		r_PackedHalf2AtPtx1412R371, r_PtxRegister372;
	uint32_t r_PackedHalf2AtPtx1416R373, r_LaneIndexAtPtx1426, r_MmaAccumulatorHalf2WordAtPtx671R375,
		r_PackedHalf2AtPtx1429R376, r_PtxRegister377, r_PackedHalf2AtPtx1433R378, r_LaneIndexAtPtx1443,
		r_MmaAccumulatorHalf2WordAtPtx678R380, r_PackedHalf2AtPtx1446R381, r_PtxRegister382,
		r_PackedHalf2AtPtx1450R383, r_LaneIndexAtPtx1460;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx678R385, r_PackedHalf2AtPtx1463R386, r_PtxRegister387,
		r_PackedHalf2AtPtx1467R388, r_LaneIndexAtPtx1477, r_MmaAccumulatorHalf2WordAtPtx685R390,
		r_PackedHalf2AtPtx1480R391, r_PtxRegister392, r_PackedHalf2AtPtx1484R393, r_LaneIndexAtPtx1494,
		r_MmaAccumulatorHalf2WordAtPtx685R395, r_PackedHalf2AtPtx1497R396;
	uint32_t r_PtxRegister397, r_PackedHalf2AtPtx1501R398, r_LaneIndexAtPtx1511,
		r_MmaAccumulatorHalf2WordAtPtx692R400, r_PackedHalf2AtPtx1514R401, r_PtxRegister402,
		r_PackedHalf2AtPtx1518R403, r_LaneIndexAtPtx1528, r_MmaAccumulatorHalf2WordAtPtx692R405,
		r_PackedHalf2AtPtx1531R406, r_PtxRegister407, r_PackedHalf2AtPtx1535R408;
	uint32_t r_LaneIndexAtPtx1545, r_MmaAccumulatorHalf2WordAtPtx699R410, r_PackedHalf2AtPtx1548R411,
		r_PtxRegister412, r_PackedHalf2AtPtx1552R413, r_LaneIndexAtPtx1562,
		r_MmaAccumulatorHalf2WordAtPtx699R415, r_PackedHalf2AtPtx1565R416, r_PtxRegister417,
		r_PackedHalf2AtPtx1569R418, r_LaneIndexAtPtx1579, r_MmaAccumulatorHalf2WordAtPtx706R420;
	uint32_t r_PackedHalf2AtPtx1582R421, r_PtxRegister422, r_PackedHalf2AtPtx1586R423, r_LaneIndexAtPtx1596,
		r_MmaAccumulatorHalf2WordAtPtx706R425, r_PackedHalf2AtPtx1599R426, r_PtxRegister427,
		r_PackedHalf2AtPtx1603R428, r_LaneIndexAtPtx1613, r_MmaAccumulatorHalf2WordAtPtx713R430,
		r_PackedHalf2AtPtx1616R431, r_PtxRegister432;
	uint32_t r_PackedHalf2AtPtx1620R433, r_LaneIndexAtPtx1630, r_MmaAccumulatorHalf2WordAtPtx713R435,
		r_PackedHalf2AtPtx1633R436, r_PtxRegister437, r_PackedHalf2AtPtx1637R438, r_LaneIndexAtPtx1647,
		r_MmaAccumulatorHalf2WordAtPtx720R440, r_PackedHalf2AtPtx1650R441, r_PtxRegister442,
		r_PackedHalf2AtPtx1654R443, r_LaneIndexAtPtx1664;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx720R445, r_PackedHalf2AtPtx1667R446, r_PtxRegister447,
		r_PackedHalf2AtPtx1671R448, r_LaneIndexAtPtx1681, r_MmaAccumulatorHalf2WordAtPtx727R450,
		r_PackedHalf2AtPtx1684R451, r_PtxRegister452, r_PackedHalf2AtPtx1688R453, r_LaneIndexAtPtx1698,
		r_MmaAccumulatorHalf2WordAtPtx727R455, r_PackedHalf2AtPtx1701R456;
	uint32_t r_PtxRegister457, r_PackedHalf2AtPtx1705R458, r_LaneIndexAtPtx1715,
		r_MmaAccumulatorHalf2WordAtPtx734R460, r_PackedHalf2AtPtx1718R461, r_PtxRegister462,
		r_PackedHalf2AtPtx1722R463, r_LaneIndexAtPtx1732, r_MmaAccumulatorHalf2WordAtPtx734R465,
		r_PackedHalf2AtPtx1735R466, r_PtxRegister467, r_PackedHalf2AtPtx1739R468;
	uint32_t r_LaneIndexAtPtx1749, r_MmaAccumulatorHalf2WordAtPtx741R470, r_PackedHalf2AtPtx1752R471,
		r_PtxRegister472, r_PackedHalf2AtPtx1756R473, r_LaneIndexAtPtx1766,
		r_MmaAccumulatorHalf2WordAtPtx741R475, r_PackedHalf2AtPtx1769R476, r_PtxRegister477,
		r_PackedHalf2AtPtx1773R478, r_LaneIndexAtPtx1783, r_MmaAccumulatorHalf2WordAtPtx748R480;
	uint32_t r_PackedHalf2AtPtx1786R481, r_PtxRegister482, r_PackedHalf2AtPtx1790R483, r_LaneIndexAtPtx1800,
		r_MmaAccumulatorHalf2WordAtPtx748R485, r_PackedHalf2AtPtx1803R486, r_PtxRegister487,
		r_PackedHalf2AtPtx1807R488, r_LaneIndexAtPtx1817, r_MmaAccumulatorHalf2WordAtPtx755R490,
		r_PackedHalf2AtPtx1820R491, r_PtxRegister492;
	uint32_t r_PackedHalf2AtPtx1824R493, r_LaneIndexAtPtx1834, r_MmaAccumulatorHalf2WordAtPtx755R495,
		r_PackedHalf2AtPtx1837R496, r_PtxRegister497, r_PackedHalf2AtPtx1841R498, r_LaneIndexAtPtx1851,
		r_MmaAccumulatorHalf2WordAtPtx762R500, r_PackedHalf2AtPtx1854R501, r_PtxRegister502,
		r_PackedHalf2AtPtx1858R503, r_LaneIndexAtPtx1868;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx762R505, r_PackedHalf2AtPtx1871R506, r_PtxRegister507,
		r_PackedHalf2AtPtx1875R508, r_LaneIndexAtPtx1885, r_PackedHalf2AtPtx1888R510,
		r_PackedHalf2AtPtx1892R511, r_PackedHalf2AtPtx1896R512, r_PackedHalf2AtPtx1900R513, r_PtxRegister514,
		r_PackedHalf2AtPtx1904R515, r_PackedHalf2AtPtx1908R516;
	uint32_t r_PackedHalf2AtPtx1916R517, r_PackedHalf2AtPtx1920R518, r_PackedHalf2AtPtx1924R519,
		r_PackedHalf2AtPtx1928R520, r_PtxRegister521, r_PackedHalf2AtPtx1932R522, r_PackedHalf2AtPtx1936R523,
		r_PackedHalf2AtPtx1944R524, r_PackedHalf2AtPtx1948R525, r_PackedHalf2AtPtx1952R526,
		r_PackedHalf2AtPtx1956R527, r_PtxRegister528;
	uint32_t r_PackedHalf2AtPtx1960R529, r_PackedHalf2AtPtx1964R530, r_PackedHalf2AtPtx1972R531,
		r_PackedHalf2AtPtx1976R532, r_PackedHalf2AtPtx1980R533, r_PackedHalf2AtPtx1984R534, r_PtxRegister535,
		r_PackedHalf2AtPtx1988R536, r_PackedHalf2AtPtx1992R537, r_PtxRegister538, r_PtxRegister539,
		r_PackedHalf2AtPtx2036R540;
	uint32_t r_PtxRegister541, r_PtxRegister542, r_PackedHalf2AtPtx2040R543, r_PtxRegister544,
		r_PtxRegister545, r_PackedHalf2AtPtx2048R546, r_PackedHalf2AtPtx2049R547, r_PackedHalf2AtPtx2055R548,
		r_PackedHalf2AtPtx2059R549, r_PackedHalf2AtPtx2063R550, r_PackedHalf2AtPtx2067R551, r_PtxRegister552;
	uint32_t r_PackedHalf2AtPtx2071R553, r_PackedHalf2AtPtx2075R554, r_PackedHalf2AtPtx2083R555,
		r_PackedHalf2AtPtx2087R556, r_PackedHalf2AtPtx2091R557, r_PackedHalf2AtPtx2095R558, r_PtxRegister559,
		r_PackedHalf2AtPtx2099R560, r_PackedHalf2AtPtx2103R561, r_PackedHalf2AtPtx2111R562,
		r_PackedHalf2AtPtx2115R563, r_PackedHalf2AtPtx2119R564;
	uint32_t r_PackedHalf2AtPtx2123R565, r_PtxRegister566, r_PackedHalf2AtPtx2127R567,
		r_PackedHalf2AtPtx2131R568, r_PackedHalf2AtPtx2139R569, r_PackedHalf2AtPtx2143R570,
		r_PackedHalf2AtPtx2147R571, r_PackedHalf2AtPtx2151R572, r_PtxRegister573, r_PackedHalf2AtPtx2155R574,
		r_PackedHalf2AtPtx2159R575, r_PtxRegister576;
	uint32_t r_PtxRegister577, r_PackedHalf2AtPtx2187R578, r_PtxRegister579, r_PtxRegister580,
		r_PackedHalf2AtPtx2191R581, r_PtxRegister582, r_PtxRegister583, r_PackedHalf2AtPtx2199R584,
		r_PackedHalf2AtPtx2200R585, r_LaneIndexAtPtx2207, r_PtxRegister587, r_LaneIndexAtPtx2216;
	uint32_t r_PtxRegister589, r_LaneIndexAtPtx2224, r_PtxRegister591, r_LaneIndexAtPtx2233, r_PtxRegister593,
		r_LaneIndexAtPtx2242, r_PtxRegister595, r_PtxRegister596, r_PtxRegister597, r_PtxRegister598,
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
		r_PtxRegister659, r_MmaBE4x4WordAtPtx2221R660;
	uint32_t r_MmaBE4x4WordAtPtx2221R661, r_MmaAE4x4WordAtPtx2256R662, r_MmaAE4x4WordAtPtx2263R663,
		r_MmaAE4x4WordAtPtx2270R664, r_MmaAE4x4WordAtPtx2277R665, r_MmaBE4x4WordAtPtx2221R666,
		r_MmaBE4x4WordAtPtx2221R667, r_MmaBE4x4WordAtPtx2239R668, r_MmaBE4x4WordAtPtx2239R669,
		r_MmaAccumulatorHalf2WordAtPtx2475R670, r_MmaAccumulatorHalf2WordAtPtx2475R671,
		r_MmaAE4x4WordAtPtx2284R672;
	uint32_t r_MmaAE4x4WordAtPtx2291R673, r_MmaAE4x4WordAtPtx2298R674, r_MmaAE4x4WordAtPtx2305R675,
		r_MmaBE4x4WordAtPtx2239R676, r_MmaBE4x4WordAtPtx2239R677, r_MmaAccumulatorHalf2WordAtPtx2482R678,
		r_MmaAccumulatorHalf2WordAtPtx2482R679, r_MmaBE4x4WordAtPtx2230R680, r_MmaBE4x4WordAtPtx2230R681,
		r_MmaBE4x4WordAtPtx2230R682, r_MmaBE4x4WordAtPtx2230R683, r_MmaBE4x4WordAtPtx2248R684;
	uint32_t r_MmaBE4x4WordAtPtx2248R685, r_MmaAccumulatorHalf2WordAtPtx2503R686,
		r_MmaAccumulatorHalf2WordAtPtx2503R687, r_MmaBE4x4WordAtPtx2248R688, r_MmaBE4x4WordAtPtx2248R689,
		r_MmaAccumulatorHalf2WordAtPtx2510R690, r_MmaAccumulatorHalf2WordAtPtx2510R691,
		r_MmaAE4x4WordAtPtx2312R692, r_MmaAE4x4WordAtPtx2319R693, r_MmaAE4x4WordAtPtx2326R694,
		r_MmaAE4x4WordAtPtx2333R695, r_MmaAccumulatorHalf2WordAtPtx2531R696;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2531R697, r_MmaAE4x4WordAtPtx2340R698, r_MmaAE4x4WordAtPtx2347R699,
		r_MmaAE4x4WordAtPtx2354R700, r_MmaAE4x4WordAtPtx2361R701, r_MmaAccumulatorHalf2WordAtPtx2538R702,
		r_MmaAccumulatorHalf2WordAtPtx2538R703, r_MmaAccumulatorHalf2WordAtPtx2559R704,
		r_MmaAccumulatorHalf2WordAtPtx2559R705, r_MmaAccumulatorHalf2WordAtPtx2566R706,
		r_MmaAccumulatorHalf2WordAtPtx2566R707, r_MmaAE4x4WordAtPtx2368R708;
	uint32_t r_MmaAE4x4WordAtPtx2375R709, r_MmaAE4x4WordAtPtx2382R710, r_MmaAE4x4WordAtPtx2389R711,
		r_MmaAccumulatorHalf2WordAtPtx2587R712, r_MmaAccumulatorHalf2WordAtPtx2587R713,
		r_MmaAE4x4WordAtPtx2396R714, r_MmaAE4x4WordAtPtx2403R715, r_MmaAE4x4WordAtPtx2410R716,
		r_MmaAE4x4WordAtPtx2417R717, r_MmaAccumulatorHalf2WordAtPtx2594R718,
		r_MmaAccumulatorHalf2WordAtPtx2594R719, r_MmaAccumulatorHalf2WordAtPtx2615R720;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2615R721, r_MmaAccumulatorHalf2WordAtPtx2622R722,
		r_MmaAccumulatorHalf2WordAtPtx2622R723, r_MmaAE4x4WordAtPtx2424R724, r_MmaAE4x4WordAtPtx2431R725,
		r_MmaAE4x4WordAtPtx2438R726, r_MmaAE4x4WordAtPtx2445R727, r_MmaAccumulatorHalf2WordAtPtx2643R728,
		r_MmaAccumulatorHalf2WordAtPtx2643R729, r_MmaAE4x4WordAtPtx2452R730, r_MmaAE4x4WordAtPtx2459R731,
		r_MmaAE4x4WordAtPtx2466R732;
	uint32_t r_MmaAE4x4WordAtPtx2473R733, r_MmaAccumulatorHalf2WordAtPtx2650R734,
		r_MmaAccumulatorHalf2WordAtPtx2650R735, r_MmaAccumulatorHalf2WordAtPtx2671R736,
		r_MmaAccumulatorHalf2WordAtPtx2671R737, r_MmaAccumulatorHalf2WordAtPtx2678R738,
		r_MmaAccumulatorHalf2WordAtPtx2678R739, r_PtxRegister740, r_PtxRegister741, r_PtxRegister742,
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
		r_PtxRegister858, r_PtxRegister859, r_PtxRegister860, r_PtxRegister861, r_ThreadXAtPtx2702,
		r_PtxRegister863, r_ThreadZAtPtx2705;
	uint32_t r_PtxRegister865, r_PtxRegister866, r_PtxRegister867, r_PtxRegister868, r_PtxRegister869,
		r_PtxRegister870, r_PtxRegister871, r_PtxRegister872, r_PtxRegister873, r_PtxRegister874,
		r_PtxRegister875, r_PtxRegister876;
	uint32_t r_PtxRegister877, r_PtxRegister878, r_PtxRegister879, r_PackedHalf2AtPtx2782R880,
		r_LaneIndexAtPtx2788, r_PtxRegister882, r_PackedE4WordAtPtx2786R883, r_PtxRegister884,
		r_PtxRegister885, r_PtxRegister886, r_PtxRegister887, r_PtxRegister888;
	uint32_t r_PtxRegister889, r_PtxRegister890, r_PtxRegister891, r_PtxRegister892, r_PtxRegister893,
		r_PtxRegister894, r_PtxRegister895, r_PtxRegister896, r_PtxRegister897, r_PtxRegister898,
		r_PtxRegister899, r_PtxRegister900;
	uint32_t r_PtxRegister901, r_PackedHalf2AtPtx2843R902, r_LaneIndexAtPtx2849, r_PtxRegister904,
		r_PackedE4WordAtPtx2847R905, r_PtxRegister906, r_PtxRegister907, r_PtxRegister908, r_PtxRegister909,
		r_PtxRegister910, r_PtxRegister911, r_PtxRegister912;
	uint32_t r_PtxRegister913, r_PtxRegister914, r_PtxRegister915, r_PtxRegister916, r_PtxRegister917,
		r_PtxRegister918, r_PtxRegister919, r_PtxRegister920, r_PtxRegister921, r_Float32BitsAtPtx2888R922,
		r_Float32BitsAtPtx2895R923, r_Float32BitsAtPtx2902R924;
	uint32_t r_Float32BitsAtPtx2909R925, r_PackedHalf2AtPtx256R926, r_PackedHalf2AtPtx2890R927,
		r_PackedHalf2AtPtx2897R928, r_PackedHalf2AtPtx2917R929, r_PackedHalf2AtPtx2904R930, r_PtxRegister931,
		r_PackedHalf2AtPtx2921R932, r_PackedHalf2AtPtx2911R933, r_PtxRegister934, r_PtxRegister935,
		r_LaneIndexAtPtx2943;
	uint32_t r_PackedHalf2AtPtx2941R937, r_PtxRegister938, r_PtxRegister939, r_LaneIndexAtPtx2957,
		r_PackedHalf2AtPtx2955R941, r_LaneIndexAtPtx2964, r_PtxRegister943, r_PackedHalf2AtPtx2960R944,
		r_LaneIndexAtPtx2980, r_LaneIndexAtPtx3038, r_LaneIndexAtPtx3096, r_LaneIndexAtPtx3155;
	uint32_t r_LaneIndexAtPtx3214, r_LaneIndexAtPtx3273, r_LaneIndexAtPtx3332, r_LaneIndexAtPtx3391,
		r_LaneIndexAtPtx3450, r_PackedHalf2AtPtx3006R954, r_LaneIndexAtPtx3457, r_PackedHalf2AtPtx3028R956,
		r_LaneIndexAtPtx3464, r_PackedHalf2AtPtx3032R958, r_LaneIndexAtPtx3471, r_PackedHalf2AtPtx3036R960;
	uint32_t r_LaneIndexAtPtx3478, r_PackedHalf2AtPtx3064R962, r_LaneIndexAtPtx3485,
		r_PackedHalf2AtPtx3086R964, r_LaneIndexAtPtx3492, r_PackedHalf2AtPtx3090R966, r_LaneIndexAtPtx3499,
		r_PackedHalf2AtPtx3094R968, r_LaneIndexAtPtx3506, r_PackedHalf2AtPtx3123R970, r_LaneIndexAtPtx3513,
		r_PackedHalf2AtPtx3145R972;
	uint32_t r_LaneIndexAtPtx3520, r_PackedHalf2AtPtx3149R974, r_LaneIndexAtPtx3527,
		r_PackedHalf2AtPtx3153R976, r_LaneIndexAtPtx3534, r_PackedHalf2AtPtx3182R978, r_LaneIndexAtPtx3541,
		r_PackedHalf2AtPtx3204R980, r_LaneIndexAtPtx3548, r_PackedHalf2AtPtx3208R982, r_LaneIndexAtPtx3555,
		r_PackedHalf2AtPtx3212R984;
	uint32_t r_LaneIndexAtPtx3562, r_PackedHalf2AtPtx3241R986, r_LaneIndexAtPtx3569,
		r_PackedHalf2AtPtx3263R988, r_LaneIndexAtPtx3576, r_PackedHalf2AtPtx3267R990, r_LaneIndexAtPtx3583,
		r_PackedHalf2AtPtx3271R992, r_LaneIndexAtPtx3590, r_PackedHalf2AtPtx3300R994, r_LaneIndexAtPtx3597,
		r_PackedHalf2AtPtx3322R996;
	uint32_t r_LaneIndexAtPtx3604, r_PackedHalf2AtPtx3326R998, r_LaneIndexAtPtx3611,
		r_PackedHalf2AtPtx3330R1000, r_LaneIndexAtPtx3618, r_PackedHalf2AtPtx3359R1002, r_LaneIndexAtPtx3625,
		r_PackedHalf2AtPtx3381R1004, r_LaneIndexAtPtx3632, r_PackedHalf2AtPtx3385R1006, r_LaneIndexAtPtx3639,
		r_PackedHalf2AtPtx3389R1008;
	uint32_t r_LaneIndexAtPtx3646, r_PackedHalf2AtPtx3418R1010, r_LaneIndexAtPtx3653,
		r_PackedHalf2AtPtx3440R1012, r_LaneIndexAtPtx3660, r_PackedHalf2AtPtx3444R1014, r_LaneIndexAtPtx3667,
		r_PackedHalf2AtPtx3448R1016, r_PackedHalf2AtPtx3453R1017, r_PackedHalf2AtPtx3467R1018,
		r_PackedHalf2AtPtx3460R1019, r_PackedHalf2AtPtx3474R1020;
	uint32_t r_PackedHalf2AtPtx3481R1021, r_PackedHalf2AtPtx3495R1022, r_PackedHalf2AtPtx3488R1023,
		r_PackedHalf2AtPtx3502R1024, r_PackedHalf2AtPtx3509R1025, r_PackedHalf2AtPtx3523R1026,
		r_PackedHalf2AtPtx3516R1027, r_PackedHalf2AtPtx3530R1028, r_PackedHalf2AtPtx3537R1029,
		r_PackedHalf2AtPtx3551R1030, r_PackedHalf2AtPtx3544R1031, r_PackedHalf2AtPtx3558R1032;
	uint32_t r_PackedHalf2AtPtx3565R1033, r_PackedHalf2AtPtx3579R1034, r_PackedHalf2AtPtx3572R1035,
		r_PackedHalf2AtPtx3586R1036, r_PackedHalf2AtPtx3593R1037, r_PackedHalf2AtPtx3607R1038,
		r_PackedHalf2AtPtx3600R1039, r_PackedHalf2AtPtx3614R1040, r_PackedHalf2AtPtx3621R1041,
		r_PackedHalf2AtPtx3635R1042, r_PackedHalf2AtPtx3628R1043, r_PackedHalf2AtPtx3642R1044;
	uint32_t r_PackedHalf2AtPtx3649R1045, r_PackedHalf2AtPtx3663R1046, r_PackedHalf2AtPtx3656R1047,
		r_PackedHalf2AtPtx3670R1048, r_PtxRegister1049, r_PtxRegister1050, r_PtxRegister1051,
		r_PtxRegister1052, r_PtxRegister1053, r_PtxRegister1054, r_PtxRegister1055, r_PtxRegister1056;
	uint32_t r_PtxRegister1057, r_PtxRegister1058, r_PtxRegister1059, r_PtxRegister1060, r_PtxRegister1061,
		r_PtxRegister1062, r_PtxRegister1063, r_PtxRegister1064, r_PtxRegister1065, r_PtxRegister1066,
		r_PtxRegister1067, r_PtxRegister1068;
	uint32_t r_PtxRegister1069, r_PtxRegister1070, r_PtxRegister1071, r_PtxRegister1072, r_PtxRegister1073,
		r_PtxRegister1074, r_PtxRegister1075, r_PtxRegister1076, r_PtxRegister1077, r_PtxRegister1078,
		r_PtxRegister1079, r_PtxRegister1080;
	uint32_t r_PtxRegister1081, r_PtxRegister1082, r_PtxRegister1083, r_PtxRegister1084, r_PtxRegister1085,
		r_PtxRegister1086, r_PtxRegister1087, r_PtxRegister1088, r_PtxRegister1089, r_PtxRegister1090,
		r_PtxRegister1091, r_PtxRegister1092;
	uint32_t r_PtxRegister1093, r_PtxRegister1094, r_PtxRegister1095, r_PtxRegister1096, r_PtxRegister1097,
		r_PtxRegister1098, r_PtxRegister1099, r_PtxRegister1100, r_PtxRegister1101, r_PtxRegister1102,
		r_PtxRegister1103, r_PtxRegister1104;
	uint32_t r_PtxRegister1105, r_PtxRegister1106, r_PtxRegister1107, r_PtxRegister1108, r_PtxRegister1109,
		r_PtxRegister1110, r_PtxRegister1111, r_PtxRegister1112, r_PtxRegister1113, r_PtxRegister1114,
		r_PtxRegister1115, r_PtxRegister1116;
	uint32_t r_PtxRegister1117, r_PtxRegister1118, r_PtxRegister1119, r_PtxRegister1120, r_PtxRegister1121,
		r_PtxRegister1122, r_PtxRegister1123, r_PtxRegister1124, r_PtxRegister1125, r_PtxRegister1126,
		r_PtxRegister1127, r_PtxRegister1128;
	uint32_t r_PtxRegister1129, r_PtxRegister1130, r_PtxRegister1131, r_PtxRegister1132, r_PtxRegister1133,
		r_PtxRegister1134, r_PtxRegister1135, r_PtxRegister1136, r_PtxRegister1137, r_PtxRegister1138,
		r_PtxRegister1139, r_PtxRegister1140;
	uint32_t r_PtxRegister1141, r_PtxRegister1142, r_PtxRegister1143, r_PtxRegister1144, r_PtxRegister1145,
		r_PtxRegister1146, r_PtxRegister1147, r_PtxRegister1148, r_PtxRegister1149, r_PtxRegister1150,
		r_PtxRegister1151, r_PtxRegister1152;
	uint32_t r_PtxRegister1153, r_PtxRegister1154, r_PtxRegister1155, r_PtxRegister1156, r_PtxRegister1157,
		r_PtxRegister1158, r_PtxRegister1159, r_PtxRegister1160, r_PtxRegister1161, r_PtxRegister1162,
		r_PtxRegister1163, r_PtxRegister1164;
	uint32_t r_PtxRegister1165, r_PtxRegister1166, r_PtxRegister1167, r_PtxRegister1168, r_PtxRegister1169,
		r_PtxRegister1170, r_PtxRegister1171, r_PtxRegister1172, r_PtxRegister1173, r_PtxRegister1174,
		r_PtxRegister1175, r_PtxRegister1176;
	uint32_t r_PtxRegister1177, r_PtxRegister1178, r_PtxRegister1179, r_PtxRegister1180, r_PtxRegister1181,
		r_PtxRegister1182, r_PtxRegister1183, r_PtxRegister1184, r_PtxRegister1185, r_PtxRegister1186,
		r_PtxRegister1187, r_PtxRegister1188;
	uint32_t r_PtxRegister1189, r_PtxRegister1190, r_PtxRegister1191, r_PtxRegister1192, r_PtxRegister1193,
		r_PtxRegister1194, r_PtxRegister1195, r_PtxRegister1196, r_PtxRegister1197, r_PtxRegister1198,
		r_PtxRegister1199, r_PtxRegister1200;
	uint32_t r_PtxRegister1201, r_PtxRegister1202, r_PtxRegister1203, r_PtxRegister1204, r_PtxRegister1205,
		r_PtxRegister1206, r_PtxRegister1207, r_PtxRegister1208, r_PtxRegister1209, r_PtxRegister1210,
		r_PtxRegister1211, r_PtxRegister1212;
	uint32_t r_PtxRegister1213, r_PtxRegister1214, r_PtxRegister1215, r_PtxRegister1216, r_PtxRegister1217,
		r_PtxRegister1218, r_PtxRegister1219, r_PtxRegister1220, r_PtxRegister1221, r_PtxRegister1222,
		r_PtxRegister1223, r_PtxRegister1224;
	uint32_t r_PtxRegister1225, r_PtxRegister1226, r_PtxRegister1227, r_PtxRegister1228, r_PtxRegister1229,
		r_PtxRegister1230, r_PtxRegister1231, r_PtxRegister1232, r_PtxRegister1233, r_PtxRegister1234,
		r_PtxRegister1235, r_PtxRegister1236;
	uint32_t r_PtxRegister1237, r_PtxRegister1238, r_PtxRegister1239, r_CtaYAtPtx3771, r_PtxRegister1241,
		r_PtxRegister1242, r_PtxRegister1243, r_PtxRegister1244, r_PtxRegister1245, r_LaneIndexAtPtx3787,
		r_PackedE4WordAtPtx3785R1247, r_PackedE4WordAtPtx3784R1248;
	uint32_t r_PackedE4WordAtPtx3783R1249, r_PackedE4WordAtPtx3782R1250, r_PtxRegister1251,
		r_LaneIndexAtPtx3799, r_PackedE4WordAtPtx3807R1253, r_PackedE4WordAtPtx3806R1254,
		r_PackedE4WordAtPtx3805R1255, r_PackedE4WordAtPtx3804R1256, r_PtxRegister1257, r_LaneIndexAtPtx3816,
		r_PackedE4WordAtPtx3824R1259, r_PackedE4WordAtPtx3823R1260;
	uint32_t r_PackedE4WordAtPtx3822R1261, r_PackedE4WordAtPtx3821R1262, r_PtxRegister1263,
		r_LaneIndexAtPtx3833, r_PackedE4WordAtPtx3841R1265, r_PackedE4WordAtPtx3840R1266,
		r_PackedE4WordAtPtx3839R1267, r_PackedE4WordAtPtx3838R1268, r_PtxRegister1269, r_PtxRegister1270,
		r_PtxRegister1271, r_PtxRegister1272;
	uint32_t r_PtxRegister1273, r_PtxRegister1274, r_PtxRegister1275, r_PtxRegister1276, r_PtxRegister1277,
		r_PtxRegister1278, r_PtxRegister1279, r_PtxRegister1280, r_PtxRegister1281, r_PtxRegister1282,
		r_PtxRegister1283, r_PtxRegister1284;
	uint32_t r_PtxRegister1285, r_PtxRegister1286, r_PtxRegister1287, r_PtxRegister1288, r_PtxRegister1289,
		r_PtxRegister1290, r_PtxRegister1291, r_PtxRegister1292, r_PtxRegister1293, r_PtxRegister1294,
		r_PtxRegister1295, r_PtxRegister1296;
	uint32_t r_PtxRegister1297, r_PtxRegister1298, r_PtxRegister1299, r_PtxRegister1300, r_PtxRegister1301,
		r_PtxRegister1302, r_PtxRegister1303, r_PtxRegister1304, r_PtxRegister1305, r_PtxRegister1306,
		r_PtxRegister1307, r_PtxRegister1308;
	uint32_t r_PtxRegister1309, r_PtxRegister1310, r_PtxRegister1311, r_PtxRegister1312, r_PtxRegister1313,
		r_PtxRegister1314, r_PtxRegister1315, r_PtxRegister1316, r_PtxRegister1317, r_PtxRegister1318,
		r_PtxRegister1319, r_PtxRegister1320;
	uint32_t r_PtxRegister1321, r_PtxRegister1322, r_PtxRegister1323, r_PtxRegister1324, r_PtxRegister1325,
		r_PtxRegister1326, r_PtxRegister1327, r_PtxRegister1328, r_PtxRegister1329, r_PtxRegister1330,
		r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_PtxRegister1333, r_PtxRegister1334, r_PtxRegister1335, r_PtxRegister1336, r_PtxRegister1337,
		r_PtxRegister1338, r_PtxRegister1339, r_PtxRegister1340, r_PtxRegister1341, r_PtxRegister1342,
		r_PtxRegister1343, r_PtxRegister1344;
	uint32_t r_PtxRegister1345, r_PtxRegister1346, r_PtxRegister1347, r_PtxRegister1348, r_PtxRegister1349,
		r_PtxRegister1350, r_PtxRegister1351, r_PtxRegister1352, r_PtxRegister1353, r_PtxRegister1354,
		r_PtxRegister1355, r_PtxRegister1356;
	uint32_t r_PtxRegister1357, r_PtxRegister1358, r_PtxRegister1359, r_PtxRegister1360, r_PtxRegister1361,
		r_PtxRegister1362, r_PtxRegister1363, r_PtxRegister1364, r_PtxRegister1365, r_PtxRegister1366,
		r_PtxRegister1367, r_PtxRegister1368;
	uint32_t r_ThreadXAtPtx4023, r_PtxRegister1370, r_ThreadZAtPtx4025, r_PtxRegister1372, r_PtxRegister1373,
		r_PtxRegister1374, r_PtxRegister1375, r_PtxRegister1376, r_PtxRegister1377, r_PtxRegister1378,
		r_PtxRegister1379, r_PtxRegister1380;
	uint32_t r_PtxRegister1381, r_PtxRegister1382, r_PtxRegister1383, r_PtxRegister1384, r_PtxRegister1385,
		r_PtxRegister1386, r_PtxRegister1387, r_PtxRegister1388, r_PtxRegister1389,
		r_MmaAE4x4WordAtPtx134R1390, r_MmaAE4x4WordAtPtx134R1391, r_MmaAE4x4WordAtPtx134R1392;
	uint32_t r_MmaAE4x4WordAtPtx134R1393, r_MmaAE4x4WordAtPtx168R1394, r_MmaAE4x4WordAtPtx168R1395,
		r_MmaAE4x4WordAtPtx168R1396, r_MmaAE4x4WordAtPtx168R1397, r_MmaAE4x4WordAtPtx202R1398,
		r_MmaAE4x4WordAtPtx202R1399, r_MmaAE4x4WordAtPtx202R1400, r_MmaAE4x4WordAtPtx202R1401,
		r_MmaAE4x4WordAtPtx236R1402, r_MmaAE4x4WordAtPtx236R1403, r_MmaAE4x4WordAtPtx236R1404;
	uint32_t r_MmaAE4x4WordAtPtx236R1405, r_PtxRegister1406, r_PtxRegister1407, r_PtxRegister1408,
		r_MmaAccumulatorHalf2WordAtPtx435R1409, r_MmaAccumulatorHalf2WordAtPtx436R1410,
		r_MmaAccumulatorHalf2WordAtPtx437R1411, r_MmaAccumulatorHalf2WordAtPtx438R1412,
		r_MmaAccumulatorHalf2WordAtPtx439R1413, r_MmaAccumulatorHalf2WordAtPtx440R1414,
		r_MmaAccumulatorHalf2WordAtPtx441R1415, r_MmaAccumulatorHalf2WordAtPtx442R1416;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx443R1417, r_MmaAccumulatorHalf2WordAtPtx444R1418,
		r_MmaAccumulatorHalf2WordAtPtx445R1419, r_MmaAccumulatorHalf2WordAtPtx446R1420,
		r_MmaAccumulatorHalf2WordAtPtx447R1421, r_MmaAccumulatorHalf2WordAtPtx448R1422,
		r_MmaAccumulatorHalf2WordAtPtx449R1423, r_MmaAccumulatorHalf2WordAtPtx450R1424,
		r_MmaAccumulatorHalf2WordAtPtx451R1425, r_MmaAccumulatorHalf2WordAtPtx452R1426,
		r_MmaAccumulatorHalf2WordAtPtx453R1427, r_MmaAccumulatorHalf2WordAtPtx454R1428;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx455R1429, r_MmaAccumulatorHalf2WordAtPtx456R1430,
		r_MmaAccumulatorHalf2WordAtPtx457R1431, r_MmaAccumulatorHalf2WordAtPtx458R1432,
		r_MmaAccumulatorHalf2WordAtPtx459R1433, r_MmaAccumulatorHalf2WordAtPtx460R1434,
		r_MmaAccumulatorHalf2WordAtPtx461R1435, r_MmaAccumulatorHalf2WordAtPtx462R1436,
		r_MmaAccumulatorHalf2WordAtPtx463R1437, r_MmaAccumulatorHalf2WordAtPtx464R1438,
		r_MmaAccumulatorHalf2WordAtPtx465R1439, r_MmaAccumulatorHalf2WordAtPtx466R1440;
	uint32_t r_PackedHalf2AtPtx434R1441, r_PtxRegister1442, r_PtxRegister1443;
	uint64_t r_QBits, r_PredecessorCounterBits, r_PtxU64Register3, r_PtxU64Register4, r_PtxU64Register5,
		r_PtxU64Register6, r_PtxU64Register7, r_PtxU64Register8, g_OutputByteAddressAtPtx3780,
		g_OutputByteAddressAtPtx3885, r_KBits, r_VBits;
	uint64_t g_OutputBaseAddress, r_CompletionCounterBits, r_PtxU64Register15, r_PtxU64Register16,
		r_PtxU64Register17, r_PtxU64Register18, r_PtxU64Register19, r_PtxU64Register20, r_PtxU64Register21,
		r_PtxU64Register22, r_PtxU64Register23, r_PtxU64Register24;
	uint64_t r_PtxU64Register25, r_PtxU64Register26, r_PtxU64Register27, r_PtxU64Register28,
		r_PtxU64Register29, r_PtxU64Register30, r_PtxU64Register31, r_PtxU64Register32, r_PtxU64Register33,
		r_PtxU64Register34, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_PtxU64Register39, r_PtxU64Register40,
		r_PtxU64Register41, r_PtxU64Register42, r_PtxU64Register43, r_PtxU64Register44, r_PtxU64Register45,
		r_PtxU64Register46, r_PtxU64Register47, r_PtxU64Register48;
	uint64_t r_PtxU64Register49, r_PtxU64Register50, r_PtxU64Register51, r_PtxU64Register52,
		r_PtxU64Register53, g_OutputByteAddressAtPtx3790, r_PtxU64Register55, g_OutputByteAddressAtPtx3803,
		r_PtxU64Register57, g_OutputByteAddressAtPtx3802, g_OutputByteAddressAtPtx3820, r_PtxU64Register60;
	uint64_t g_OutputByteAddressAtPtx3819, g_OutputByteAddressAtPtx3837, r_PtxU64Register63,
		g_OutputByteAddressAtPtx3836, r_PtxU64Register65, g_OutputByteAddressAtPtx3934, r_PtxU64Register67,
		g_OutputByteAddressAtPtx3976, r_PtxU64Register69, g_OutputByteAddressAtPtx4014, r_PtxU64Register71,
		r_PtxU64Register72;
	uint64_t r_PtxU64Register73, r_PtxU64Register74;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	r_CompletionCounterBits = uint64_t(r_Parameters.g_CompletionCounter);	// PTX L16
	r_PredecessorCounterBits = uint64_t(r_Parameters.g_PredecessorCounter); // PTX L17
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);					// PTX L18
	r_VBits = uint64_t(r_Parameters.g_V);									// PTX L19
	r_KBits = uint64_t(r_Parameters.g_K);									// PTX L20
	r_QBits = uint64_t(r_Parameters.g_Q);									// PTX L21
	r_BatchBits = uint32_t(r_Parameters.Batch);
	r_TokensBits = uint32_t(r_Parameters.Tokens);					 // PTX L22
	r_CtaXAtPtx23 = uint32_t(blockIdx.x);							 // PTX L23
	r_CtaYAtPtx24 = uint32_t(blockIdx.y);							 // PTX L24
	r_PtxRegister3 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits); // PTX L25
	r_bPtxPredicate1 = uint32_t(r_PtxRegister3) == uint32_t(0);		 // PTX L26
	r_PtxRegister1386 = uint32_t(0);								 // PTX L27
	if (r_bPtxPredicate1)
	{
		goto L__BB55_2;
	} // PTX L28
	r_PtxRegister51 = uint32_t(r_PtxRegister3) + uint32_t(-1);					// PTX L29
	r_PtxRegister52 = ShiftRightSigned(int32_t(r_PtxRegister51), uint32_t(31)); // PTX L30
	r_PtxRegister53 = ShiftRight(uint32_t(r_PtxRegister52), uint32_t(27));		// PTX L31
	r_PtxRegister54 = uint32_t(r_PtxRegister51) + uint32_t(r_PtxRegister53);	// PTX L32
	r_PtxRegister55 = r_PtxRegister54 & -32;									// PTX L33
	r_PtxRegister1386 = uint32_t(r_PtxRegister55) + uint32_t(32);				// PTX L34
L__BB55_2:																		// PTX L35
	r_PtxRegister1387 = uint32_t(0);											// PTX L36
	if (r_bPtxPredicate1)
	{
		goto L__BB55_4;
	} // PTX L37
	r_PtxRegister56 = uint32_t(r_PtxRegister3) + uint32_t(-1);					// PTX L38
	r_PtxRegister57 = ShiftRightSigned(int32_t(r_PtxRegister56), uint32_t(31)); // PTX L39
	r_PtxRegister58 = ShiftRight(uint32_t(r_PtxRegister57), uint32_t(25));		// PTX L40
	r_PtxRegister59 = uint32_t(r_PtxRegister56) + uint32_t(r_PtxRegister58);	// PTX L41
	r_PtxRegister60 = ShiftRightSigned(int32_t(r_PtxRegister59), uint32_t(7));	// PTX L42
	r_PtxRegister1387 = uint32_t(r_PtxRegister60) + uint32_t(1);				// PTX L43
L__BB55_4:																		// PTX L44
	r_PtxRegister4 = ShiftLeft(uint32_t(r_CtaXAtPtx23), uint32_t(5));			// PTX L45
	r_PtxRegister1388 = uint32_t(0);											// PTX L46
	if (r_bPtxPredicate1)
	{
		goto L__BB55_6;
	} // PTX L47
	r_PtxRegister61 = uint32_t(r_PtxRegister3) + uint32_t(-1);					  // PTX L48
	r_PtxRegister62 = ShiftRightSigned(int32_t(r_PtxRegister61), uint32_t(31));	  // PTX L49
	r_PtxRegister63 = ShiftRight(uint32_t(r_PtxRegister62), uint32_t(26));		  // PTX L50
	r_PtxRegister64 = uint32_t(r_PtxRegister61) + uint32_t(r_PtxRegister63);	  // PTX L51
	r_PtxRegister65 = ShiftRightSigned(int32_t(r_PtxRegister64), uint32_t(6));	  // PTX L52
	r_PtxRegister1388 = uint32_t(r_PtxRegister65) + uint32_t(1);				  // PTX L53
L__BB55_6:																		  // PTX L54
	r_PtxRegister66 = ShiftRightSigned(int32_t(r_PtxRegister1386), uint32_t(31)); // PTX L55
	r_PtxRegister67 = ShiftRight(uint32_t(r_PtxRegister66), uint32_t(28));		  // PTX L56
	r_PtxRegister68 = uint32_t(r_PtxRegister1386) + uint32_t(r_PtxRegister67);	  // PTX L57
	r_PtxRegister5 = ShiftRightSigned(int32_t(r_PtxRegister68), uint32_t(4));	  // PTX L58
	r_PtxRegister69 = ShiftRight(uint32_t(r_PtxRegister66), uint32_t(27));		  // PTX L59
	r_PtxRegister70 = uint32_t(r_PtxRegister1386) + uint32_t(r_PtxRegister69);	  // PTX L60
	r_PtxRegister6 = ShiftRightSigned(int32_t(r_PtxRegister70), uint32_t(5));	  // PTX L61
	r_ThreadXAtPtx62 = uint32_t(threadIdx.x);									  // PTX L62
	r_ThreadYAtPtx63 = uint32_t(threadIdx.y);									  // PTX L63
	r_PtxRegister8 = r_ThreadXAtPtx62 | r_ThreadYAtPtx63;						  // PTX L64
	r_bPtxPredicate2 = uint32_t(r_PtxRegister8) != uint32_t(0);					  // PTX L65
	if (r_bPtxPredicate2)
	{
		goto L__BB55_8;
	} // PTX L66
	r_BlockSizeXAtPtx67 = uint32_t(blockDim.x);										 // PTX L67
	r_BlockSizeYAtPtx68 = uint32_t(blockDim.y);										 // PTX L68
	r_PtxRegister73 = uint32_t(r_BlockSizeXAtPtx67) * uint32_t(r_BlockSizeYAtPtx68); // PTX L69
	r_PtxRegister72 = uint32_t(8192u /* original named shared base */);				 // PTX L70
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister72, r_PtxRegister73); // PTX L72
	r_PtxRegister74 = uint32_t(r_PtxRegister72) + uint32_t(8);		// PTX L74
	BarrierInit(s_SharedStorage, r_PtxRegister74, r_PtxRegister73); // PTX L76
L__BB55_8:															// PTX L78
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																	  // PTX L79
	r_PtxRegister1389 = ShiftLeft(uint32_t(r_CtaYAtPtx24), uint32_t(1));				  // PTX L80
	r_PtxRegister77 = r_PtxRegister1389 & 33554430;										  // PTX L81
	r_PtxRegister78 = uint32_t(r_PtxRegister77) + uint32_t(2);							  // PTX L82
	r_PtxRegister9 = uint32_t(min(int32_t(r_PtxRegister78), int32_t(r_PtxRegister1387))); // PTX L83
	r_ThreadZAtPtx84 = uint32_t(threadIdx.z);											  // PTX L84
	r_PtxRegister10 = r_PtxRegister8 | r_ThreadZAtPtx84;								  // PTX L85
	r_bPtxPredicate3 = uint32_t(r_PtxRegister10) != uint32_t(0);						  // PTX L86
	r_bPtxPredicate4 = int32_t(r_PtxRegister1389) >= int32_t(r_PtxRegister9);			  // PTX L87
	r_bPtxPredicate5 = r_bPtxPredicate3 | r_bPtxPredicate4;								  // PTX L88
	if (r_bPtxPredicate5)
	{
		goto L__BB55_14;
	} // PTX L89
	r_PtxRegister11 = ShiftRight(uint32_t(r_CtaXAtPtx23), uint32_t(1));			// PTX L90
	goto L__BB55_10;															// PTX L91
L__BB55_13:																		// PTX L92
	r_PtxRegister1389 = uint32_t(r_PtxRegister1389) + uint32_t(1);				// PTX L93
	r_bPtxPredicate7 = uint32_t(r_PtxRegister1389) != uint32_t(r_PtxRegister9); // PTX L94
	if (r_bPtxPredicate7)
	{
		goto L__BB55_10;
	} // PTX L95
	goto L__BB55_14;																		// PTX L96
L__BB55_10:																					// PTX L97
	r_PtxRegister80 = ShiftLeft(uint32_t(r_PtxRegister1389), uint32_t(4));					// PTX L98
	r_PtxRegister81 = uint32_t(r_PtxRegister80) + uint32_t(r_PtxRegister11);				// PTX L99
	r_PtxU64Register15 = uint64_t(uint32_t(r_PtxRegister81)) * uint64_t(uint32_t(4));		// PTX L100
	r_PtxU64Register16 = uint64_t(r_PredecessorCounterBits) + uint64_t(r_PtxU64Register15); // PTX L101
L__BB55_11:																					// PTX L102
	r_PtxRegister82 = CounterLoadRelaxed(r_PtxU64Register16);								// PTX L104
	r_bPtxPredicate6 = int32_t(r_PtxRegister82) > int32_t(-1);								// PTX L106
	if (r_bPtxPredicate6)
	{
		goto L__BB55_13;
	} // PTX L107
	r_PtxRegister1385 = uint32_t(64);										 // PTX L108
	PollSleep(r_PtxRegister1385);											 // PTX L110
	goto L__BB55_11;														 // PTX L112
L__BB55_14:																	 // PTX L113
	__syncthreads();														 // PTX L114
	r_PtxRegister12 = r_ThreadYAtPtx63 & 1;									 // PTX L115
	r_PtxRegister83 = ShiftLeft(uint32_t(r_ThreadYAtPtx63), uint32_t(2));	 // PTX L116
	r_PtxRegister84 = ShiftLeft(uint32_t(r_CtaYAtPtx24), uint32_t(4));		 // PTX L117
	r_PtxRegister13 = uint32_t(r_PtxRegister83) + uint32_t(r_PtxRegister84); // PTX L118
	r_bPtxPredicate8 = int32_t(r_PtxRegister13) < int32_t(r_PtxRegister5);	 // PTX L119
	if (r_bPtxPredicate8)
	{
		goto L__BB55_16;
	} // PTX L120
	goto L__BB55_15;																			 // PTX L121
L__BB55_16:																						 // PTX L122
	r_PtxRegister88 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(12));						 // PTX L123
	r_PtxRegister89 = ShiftLeft(uint32_t(r_CtaXAtPtx23), uint32_t(7));							 // PTX L124
	r_PtxRegister90 = uint32_t(r_PtxRegister88) + uint32_t(r_PtxRegister89);					 // PTX L125
	r_PtxU64Register18 = uint64_t(int64_t(int32_t(r_PtxRegister90)) * int64_t(int32_t(4)));		 // PTX L126
	r_PtxU64Register19 = uint64_t(r_QBits) + uint64_t(r_PtxU64Register18);						 // PTX L127
	r_LaneIndexAtPtx129 = uint32_t((threadIdx.x & 31u));										 // PTX L129
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx129)) * int64_t(int32_t(16))); // PTX L131
	r_PtxU64Register17 = uint64_t(r_PtxU64Register19) + uint64_t(r_PtxU64Register20);			 // PTX L132
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register17));
		r_MmaAE4x4WordAtPtx134R1390 = r_Value.x;
		r_MmaAE4x4WordAtPtx134R1391 = r_Value.y;
		r_MmaAE4x4WordAtPtx134R1392 = r_Value.z;
		r_MmaAE4x4WordAtPtx134R1393 = r_Value.w;
	} // PTX L134
	goto L__BB55_17;																		 // PTX L136
L__BB55_15:																					 // PTX L137
	r_PtxRegister85 = uint32_t(0);															 // PTX L138
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister85))); // PTX L140
	r_PackedHalf2AtPtx143R86 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);			 // PTX L143
	r_ConvertedE4PairAtPtx145Rs2 = PublishE4(r_PackedHalf2AtPtx143R86);						 // PTX L145
	r_MmaAE4x4WordAtPtx134R1390 =
		JoinHalfwords(r_ConvertedE4PairAtPtx145Rs2, r_ConvertedE4PairAtPtx145Rs2); // PTX L147
	r_MmaAE4x4WordAtPtx134R1391 = uint32_t(r_MmaAE4x4WordAtPtx134R1390);		   // PTX L148
	r_MmaAE4x4WordAtPtx134R1392 = uint32_t(r_MmaAE4x4WordAtPtx134R1390);		   // PTX L149
	r_MmaAE4x4WordAtPtx134R1393 = uint32_t(r_MmaAE4x4WordAtPtx134R1390);		   // PTX L150
L__BB55_17:																		   // PTX L151
	r_PtxRegister14 = uint32_t(r_PtxRegister13) + uint32_t(1);					   // PTX L152
	r_bPtxPredicate9 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister5);		   // PTX L153
	if (r_bPtxPredicate9)
	{
		goto L__BB55_19;
	} // PTX L154
	goto L__BB55_18;																			 // PTX L155
L__BB55_19:																						 // PTX L156
	r_PtxRegister94 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(12));						 // PTX L157
	r_PtxRegister95 = ShiftLeft(uint32_t(r_CtaXAtPtx23), uint32_t(7));							 // PTX L158
	r_PtxRegister96 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister95);					 // PTX L159
	r_PtxU64Register22 = uint64_t(int64_t(int32_t(r_PtxRegister96)) * int64_t(int32_t(4)));		 // PTX L160
	r_PtxU64Register23 = uint64_t(r_QBits) + uint64_t(r_PtxU64Register22);						 // PTX L161
	r_LaneIndexAtPtx163 = uint32_t((threadIdx.x & 31u));										 // PTX L163
	r_PtxU64Register24 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx163)) * int64_t(int32_t(16))); // PTX L165
	r_PtxU64Register21 = uint64_t(r_PtxU64Register23) + uint64_t(r_PtxU64Register24);			 // PTX L166
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register21));
		r_MmaAE4x4WordAtPtx168R1394 = r_Value.x;
		r_MmaAE4x4WordAtPtx168R1395 = r_Value.y;
		r_MmaAE4x4WordAtPtx168R1396 = r_Value.z;
		r_MmaAE4x4WordAtPtx168R1397 = r_Value.w;
	} // PTX L168
	goto L__BB55_20;																		 // PTX L170
L__BB55_18:																					 // PTX L171
	r_PtxRegister91 = uint32_t(0);															 // PTX L172
	r_PtxU16Register3 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister91))); // PTX L174
	r_PackedHalf2AtPtx177R92 = JoinHalfwords(r_PtxU16Register3, r_PtxU16Register3);			 // PTX L177
	r_ConvertedE4PairAtPtx179Rs4 = PublishE4(r_PackedHalf2AtPtx177R92);						 // PTX L179
	r_MmaAE4x4WordAtPtx168R1394 =
		JoinHalfwords(r_ConvertedE4PairAtPtx179Rs4, r_ConvertedE4PairAtPtx179Rs4); // PTX L181
	r_MmaAE4x4WordAtPtx168R1395 = uint32_t(r_MmaAE4x4WordAtPtx168R1394);		   // PTX L182
	r_MmaAE4x4WordAtPtx168R1396 = uint32_t(r_MmaAE4x4WordAtPtx168R1394);		   // PTX L183
	r_MmaAE4x4WordAtPtx168R1397 = uint32_t(r_MmaAE4x4WordAtPtx168R1394);		   // PTX L184
L__BB55_20:																		   // PTX L185
	r_PtxRegister15 = uint32_t(r_PtxRegister14) + uint32_t(1);					   // PTX L186
	r_bPtxPredicate10 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister5);		   // PTX L187
	if (r_bPtxPredicate10)
	{
		goto L__BB55_22;
	} // PTX L188
	goto L__BB55_21;																			 // PTX L189
L__BB55_22:																						 // PTX L190
	r_PtxRegister100 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(12));						 // PTX L191
	r_PtxRegister101 = ShiftLeft(uint32_t(r_CtaXAtPtx23), uint32_t(7));							 // PTX L192
	r_PtxRegister102 = uint32_t(r_PtxRegister100) + uint32_t(r_PtxRegister101);					 // PTX L193
	r_PtxU64Register26 = uint64_t(int64_t(int32_t(r_PtxRegister102)) * int64_t(int32_t(4)));	 // PTX L194
	r_PtxU64Register27 = uint64_t(r_QBits) + uint64_t(r_PtxU64Register26);						 // PTX L195
	r_LaneIndexAtPtx197 = uint32_t((threadIdx.x & 31u));										 // PTX L197
	r_PtxU64Register28 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx197)) * int64_t(int32_t(16))); // PTX L199
	r_PtxU64Register25 = uint64_t(r_PtxU64Register27) + uint64_t(r_PtxU64Register28);			 // PTX L200
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register25));
		r_MmaAE4x4WordAtPtx202R1398 = r_Value.x;
		r_MmaAE4x4WordAtPtx202R1399 = r_Value.y;
		r_MmaAE4x4WordAtPtx202R1400 = r_Value.z;
		r_MmaAE4x4WordAtPtx202R1401 = r_Value.w;
	} // PTX L202
	goto L__BB55_23;																		 // PTX L204
L__BB55_21:																					 // PTX L205
	r_PtxRegister97 = uint32_t(0);															 // PTX L206
	r_PtxU16Register5 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister97))); // PTX L208
	r_PackedHalf2AtPtx211R98 = JoinHalfwords(r_PtxU16Register5, r_PtxU16Register5);			 // PTX L211
	r_ConvertedE4PairAtPtx213Rs6 = PublishE4(r_PackedHalf2AtPtx211R98);						 // PTX L213
	r_MmaAE4x4WordAtPtx202R1398 =
		JoinHalfwords(r_ConvertedE4PairAtPtx213Rs6, r_ConvertedE4PairAtPtx213Rs6); // PTX L215
	r_MmaAE4x4WordAtPtx202R1399 = uint32_t(r_MmaAE4x4WordAtPtx202R1398);		   // PTX L216
	r_MmaAE4x4WordAtPtx202R1400 = uint32_t(r_MmaAE4x4WordAtPtx202R1398);		   // PTX L217
	r_MmaAE4x4WordAtPtx202R1401 = uint32_t(r_MmaAE4x4WordAtPtx202R1398);		   // PTX L218
L__BB55_23:																		   // PTX L219
	r_PtxRegister16 = uint32_t(r_PtxRegister14) + uint32_t(2);					   // PTX L220
	r_bPtxPredicate11 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister5);		   // PTX L221
	if (r_bPtxPredicate11)
	{
		goto L__BB55_25;
	} // PTX L222
	goto L__BB55_24;																			 // PTX L223
L__BB55_25:																						 // PTX L224
	r_PtxRegister106 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(12));						 // PTX L225
	r_PtxRegister107 = ShiftLeft(uint32_t(r_CtaXAtPtx23), uint32_t(7));							 // PTX L226
	r_PtxRegister108 = uint32_t(r_PtxRegister106) + uint32_t(r_PtxRegister107);					 // PTX L227
	r_PtxU64Register30 = uint64_t(int64_t(int32_t(r_PtxRegister108)) * int64_t(int32_t(4)));	 // PTX L228
	r_PtxU64Register31 = uint64_t(r_QBits) + uint64_t(r_PtxU64Register30);						 // PTX L229
	r_LaneIndexAtPtx231 = uint32_t((threadIdx.x & 31u));										 // PTX L231
	r_PtxU64Register32 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx231)) * int64_t(int32_t(16))); // PTX L233
	r_PtxU64Register29 = uint64_t(r_PtxU64Register31) + uint64_t(r_PtxU64Register32);			 // PTX L234
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register29));
		r_MmaAE4x4WordAtPtx236R1402 = r_Value.x;
		r_MmaAE4x4WordAtPtx236R1403 = r_Value.y;
		r_MmaAE4x4WordAtPtx236R1404 = r_Value.z;
		r_MmaAE4x4WordAtPtx236R1405 = r_Value.w;
	} // PTX L236
	goto L__BB55_26;																		  // PTX L238
L__BB55_24:																					  // PTX L239
	r_PtxRegister103 = uint32_t(0);															  // PTX L240
	r_PtxU16Register7 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister103))); // PTX L242
	r_PackedHalf2AtPtx245R104 = JoinHalfwords(r_PtxU16Register7, r_PtxU16Register7);		  // PTX L245
	r_ConvertedE4PairAtPtx247Rs8 = PublishE4(r_PackedHalf2AtPtx245R104);					  // PTX L247
	r_MmaAE4x4WordAtPtx236R1402 =
		JoinHalfwords(r_ConvertedE4PairAtPtx247Rs8, r_ConvertedE4PairAtPtx247Rs8); // PTX L249
	r_MmaAE4x4WordAtPtx236R1403 = uint32_t(r_MmaAE4x4WordAtPtx236R1402);		   // PTX L250
	r_MmaAE4x4WordAtPtx236R1404 = uint32_t(r_MmaAE4x4WordAtPtx236R1402);		   // PTX L251
	r_MmaAE4x4WordAtPtx236R1405 = uint32_t(r_MmaAE4x4WordAtPtx236R1402);		   // PTX L252
L__BB55_26:																		   // PTX L253
	r_Float32BitsAtPtx254R109 = uint32_t(0);									   // PTX L254
	r_PackedHalf2AtPtx256R926 = FloatToHalf2(r_Float32BitsAtPtx254R109);		   // PTX L256
	r_bPtxPredicate12 = int32_t(r_PtxRegister1388) < int32_t(1);				   // PTX L261
	if (r_bPtxPredicate12)
	{
		goto L__BB55_41;
	} // PTX L262
	r_PtxRegister17 = ShiftRight(uint32_t(r_CtaXAtPtx23), uint32_t(1));			  // PTX L263
	r_PtxRegister18 = ShiftRight(uint32_t(r_ThreadYAtPtx63), uint32_t(1));		  // PTX L264
	r_PtxU64Register3 = r_KBits;												  // PTX L265
	r_PtxRegister19 = r_PtxRegister1386 & -32;									  // PTX L266
	r_PtxU64Register4 = r_VBits;												  // PTX L267
	r_PtxRegister110 = ShiftLeft(uint32_t(r_ThreadYAtPtx63), uint32_t(9));		  // PTX L268
	r_PtxRegister111 = uint32_t(0u /* original named shared base */);			  // PTX L269
	r_PtxRegister20 = uint32_t(r_PtxRegister111) + uint32_t(r_PtxRegister110);	  // PTX L270
	r_PtxRegister112 = ShiftRight(uint32_t(r_PtxRegister4), uint32_t(4));		  // PTX L271
	r_PtxRegister113 = uint32_t(r_PtxRegister112) + uint32_t(r_PtxRegister12);	  // PTX L272
	r_PtxRegister21 = ShiftLeft(uint32_t(r_PtxRegister113), uint32_t(7));		  // PTX L273
	r_PtxRegister114 = uint32_t(4096u /* original named shared base */);		  // PTX L274
	r_PtxRegister22 = uint32_t(r_PtxRegister114) + uint32_t(r_PtxRegister110);	  // PTX L275
	r_PtxRegister23 = uint32_t(min(int32_t(r_PtxRegister1388), int32_t(2)));	  // PTX L276
	r_PtxRegister1406 = uint32_t(0);											  // PTX L277
	goto L__BB55_28;															  // PTX L278
L__BB55_40:																		  // PTX L279
	r_PtxRegister1406 = uint32_t(r_PtxRegister1406) + uint32_t(1);				  // PTX L280
	r_bPtxPredicate24 = uint32_t(r_PtxRegister1406) != uint32_t(r_PtxRegister23); // PTX L281
	if (r_bPtxPredicate24)
	{
		goto L__BB55_28;
	} // PTX L282
	goto L__BB55_41;															// PTX L283
L__BB55_28:																		// PTX L284
	r_PtxRegister24 = ShiftRight(uint32_t(r_PtxRegister1406), uint32_t(1));		// PTX L285
	r_bPtxPredicate13 = int32_t(r_PtxRegister1387) <= int32_t(r_PtxRegister24); // PTX L286
	r_bPtxPredicate14 = r_bPtxPredicate3 | r_bPtxPredicate13;					// PTX L287
	if (r_bPtxPredicate14)
	{
		goto L__BB55_32;
	} // PTX L288
	r_PtxRegister115 = ShiftLeft(uint32_t(r_PtxRegister24), uint32_t(4));					// PTX L289
	r_PtxRegister116 = uint32_t(r_PtxRegister115) + uint32_t(r_PtxRegister17);				// PTX L290
	r_PtxU64Register33 = uint64_t(uint32_t(r_PtxRegister116)) * uint64_t(uint32_t(4));		// PTX L291
	r_PtxU64Register34 = uint64_t(r_PredecessorCounterBits) + uint64_t(r_PtxU64Register33); // PTX L292
L__BB55_30:																					// PTX L293
	r_PtxRegister117 = CounterLoadRelaxed(r_PtxU64Register34);								// PTX L295
	r_bPtxPredicate15 = int32_t(r_PtxRegister117) > int32_t(-1);							// PTX L297
	if (r_bPtxPredicate15)
	{
		goto L__BB55_32;
	} // PTX L298
	r_PtxRegister1384 = uint32_t(64);											// PTX L299
	PollSleep(r_PtxRegister1384);												// PTX L301
	goto L__BB55_30;															// PTX L303
L__BB55_32:																		// PTX L304
	__syncthreads();															// PTX L305
	r_PtxRegister25 = ShiftLeft(uint32_t(r_PtxRegister1406), uint32_t(11));		// PTX L306
	r_PtxRegister118 = ShiftLeft(uint32_t(r_PtxRegister1406), uint32_t(2));		// PTX L307
	r_PtxRegister119 = uint32_t(r_ThreadYAtPtx63) + uint32_t(r_PtxRegister118); // PTX L308
	r_bPtxPredicate16 = int32_t(r_PtxRegister119) >= int32_t(r_PtxRegister5);	// PTX L309
	r_bPtxPredicate17 = int32_t(r_PtxRegister119) < int32_t(r_PtxRegister5);	// PTX L310
	r_PtxRegister120 = ShiftLeft(uint32_t(r_PtxRegister119), uint32_t(5));		// PTX L311
	r_PtxRegister121 = uint32_t(r_PtxRegister120) + uint32_t(r_CtaXAtPtx23);	// PTX L312
	r_PtxRegister122 = ShiftLeft(uint32_t(r_PtxRegister121), uint32_t(7));		// PTX L313
	r_PtxU64Register35 = uint64_t(r_PtxRegister122);							// PTX L314
	r_PtxU64Register5 = r_bPtxPredicate17 ? r_PtxU64Register35 : 0;				// PTX L315
	r_PtxRegister123 = ShiftLeft(uint32_t(r_PtxRegister1406), uint32_t(3));		// PTX L316
	r_PtxRegister124 = uint32_t(8192u /* original named shared base */);		// PTX L317
	r_PtxRegister152 = uint32_t(r_PtxRegister124) + uint32_t(r_PtxRegister123); // PTX L318
	if (r_bPtxPredicate16)
	{
		goto L__BB55_35;
	} // PTX L319
	r_PtxRegister133 = uint32_t(-1);							   // PTX L320
	r_PtxRegister132 = Elected(r_PtxRegister133);				   // PTX L322
	r_bPtxPredicate18 = uint32_t(r_PtxRegister132) == uint32_t(0); // PTX L328
	if (r_bPtxPredicate18)
	{
		goto L__BB55_36;
	} // PTX L329
	r_PtxRegister134 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister25);		 // PTX L330
	r_PtxU64Register37 = ShiftLeft(uint64_t(r_PtxU64Register5), uint32_t(2));		 // PTX L331
	r_PtxU64Register36 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register37); // PTX L332
	r_PtxRegister135 = uint32_t(512);												 // PTX L333
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister134, r_PtxU64Register36, r_PtxRegister135,
			 r_PtxRegister152);																  // PTX L335
	BarrierExpect(s_SharedStorage, r_PtxRegister152, r_PtxRegister135);						  // PTX L338
	goto L__BB55_36;																		  // PTX L340
L__BB55_35:																					  // PTX L341
	r_PtxRegister125 = uint32_t(0);															  // PTX L342
	r_PtxU16Register9 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister125))); // PTX L344
	r_PackedHalf2AtPtx347R126 = JoinHalfwords(r_PtxU16Register9, r_PtxU16Register9);		  // PTX L347
	r_ConvertedE4PairAtPtx349Rs10 = PublishE4(r_PackedHalf2AtPtx347R126);					  // PTX L349
	r_PackedE4WordAtPtx351R129 =
		JoinHalfwords(r_ConvertedE4PairAtPtx349Rs10, r_ConvertedE4PairAtPtx349Rs10); // PTX L351
	r_LaneIndexAtPtx353 = uint32_t((threadIdx.x & 31u));							 // PTX L353
	r_PtxRegister130 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister25);		 // PTX L355
	r_PtxRegister131 = ShiftLeft(uint32_t(r_LaneIndexAtPtx353), uint32_t(4));		 // PTX L356
	r_PtxRegister128 = uint32_t(r_PtxRegister130) + uint32_t(r_PtxRegister131);		 // PTX L357
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister128)) =
		make_uint4(r_PackedE4WordAtPtx351R129, r_PackedE4WordAtPtx351R129, r_PackedE4WordAtPtx351R129,
				   r_PackedE4WordAtPtx351R129);								   // PTX L359
L__BB55_36:																	   // PTX L361
	r_bPtxPredicate19 = uint32_t(r_PtxRegister19) == uint32_t(32);			   // PTX L362
	r_PtxRegister136 = ShiftLeft(uint32_t(r_PtxRegister1406), uint32_t(1));	   // PTX L363
	r_PtxRegister137 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister136); // PTX L364
	r_bPtxPredicate20 = int32_t(r_PtxRegister137) < int32_t(r_PtxRegister6);   // PTX L365
	r_bPtxPredicate21 = r_bPtxPredicate19 | r_bPtxPredicate20;				   // PTX L366
	r_PtxRegister138 = ShiftLeft(uint32_t(r_PtxRegister137), uint32_t(13));	   // PTX L367
	r_PtxRegister139 = r_bPtxPredicate19 ? 0 : r_PtxRegister138;			   // PTX L368
	r_PtxRegister140 = uint32_t(r_PtxRegister139) + uint32_t(r_PtxRegister21); // PTX L369
	r_PtxU64Register38 = SignExtendWordBits(r_PtxRegister140);				   // PTX L370
	r_PtxU64Register6 = r_bPtxPredicate21 ? r_PtxU64Register38 : 0;			   // PTX L371
	r_bPtxPredicate22 = !r_bPtxPredicate21;									   // PTX L372
	if (r_bPtxPredicate22)
	{
		goto L__BB55_39;
	} // PTX L373
	r_PtxRegister149 = uint32_t(-1);							   // PTX L374
	r_PtxRegister148 = Elected(r_PtxRegister149);				   // PTX L376
	r_bPtxPredicate23 = uint32_t(r_PtxRegister148) == uint32_t(0); // PTX L382
	if (r_bPtxPredicate23)
	{
		goto L__BB55_40;
	} // PTX L383
	r_PtxRegister150 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister25);		 // PTX L384
	r_PtxU64Register40 = ShiftLeft(uint64_t(r_PtxU64Register6), uint32_t(2));		 // PTX L385
	r_PtxU64Register39 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register40); // PTX L386
	r_PtxRegister151 = uint32_t(512);												 // PTX L387
	CopyBulk(s_SharedStorage, r_PtxRegister150, r_PtxU64Register39, r_PtxRegister151,
			 r_PtxRegister152);																   // PTX L389
	BarrierExpect(s_SharedStorage, r_PtxRegister152, r_PtxRegister151);						   // PTX L392
	goto L__BB55_40;																		   // PTX L394
L__BB55_39:																					   // PTX L395
	r_PtxRegister141 = uint32_t(0);															   // PTX L396
	r_PtxU16Register11 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister141))); // PTX L398
	r_PackedHalf2AtPtx401R142 = JoinHalfwords(r_PtxU16Register11, r_PtxU16Register11);		   // PTX L401
	r_ConvertedE4PairAtPtx403Rs12 = PublishE4(r_PackedHalf2AtPtx401R142);					   // PTX L403
	r_PackedE4WordAtPtx405R145 =
		JoinHalfwords(r_ConvertedE4PairAtPtx403Rs12, r_ConvertedE4PairAtPtx403Rs12); // PTX L405
	r_LaneIndexAtPtx407 = uint32_t((threadIdx.x & 31u));							 // PTX L407
	r_PtxRegister146 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister25);		 // PTX L409
	r_PtxRegister147 = ShiftLeft(uint32_t(r_LaneIndexAtPtx407), uint32_t(4));		 // PTX L410
	r_PtxRegister144 = uint32_t(r_PtxRegister146) + uint32_t(r_PtxRegister147);		 // PTX L411
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister144)) =
		make_uint4(r_PackedE4WordAtPtx405R145, r_PackedE4WordAtPtx405R145, r_PackedE4WordAtPtx405R145,
				   r_PackedE4WordAtPtx405R145);							 // PTX L413
	goto L__BB55_40;													 // PTX L415
L__BB55_41:																 // PTX L416
	r_PtxRegister153 = uint32_t(8192u /* original named shared base */); // PTX L417
	r_PtxRegister154 = uint32_t(1);										 // PTX L418
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register41 = BarrierArrive(s_SharedStorage, r_PtxRegister153, r_PtxRegister154); // PTX L420
L__BB55_42:																					 // PTX L422
	r_PtxRegister156 = uint32_t(8192u /* original named shared base */);					 // PTX L423
	r_PtxRegister155 = BarrierReady(s_SharedStorage, r_PtxRegister156, r_PtxU64Register41);	 // PTX L425
	r_bPtxPredicate25 = uint32_t(r_PtxRegister155) == uint32_t(0);							 // PTX L431
	if (r_bPtxPredicate25)
	{
		goto L__BB55_42;
	} // PTX L432
	r_bPtxPredicate26 = int32_t(r_PtxRegister1388) < int32_t(1);				  // PTX L433
	r_PackedHalf2AtPtx434R1441 = uint32_t(0);									  // PTX L434
	r_MmaAccumulatorHalf2WordAtPtx435R1409 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L435
	r_MmaAccumulatorHalf2WordAtPtx436R1410 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L436
	r_MmaAccumulatorHalf2WordAtPtx437R1411 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L437
	r_MmaAccumulatorHalf2WordAtPtx438R1412 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L438
	r_MmaAccumulatorHalf2WordAtPtx439R1413 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L439
	r_MmaAccumulatorHalf2WordAtPtx440R1414 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L440
	r_MmaAccumulatorHalf2WordAtPtx441R1415 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L441
	r_MmaAccumulatorHalf2WordAtPtx442R1416 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L442
	r_MmaAccumulatorHalf2WordAtPtx443R1417 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L443
	r_MmaAccumulatorHalf2WordAtPtx444R1418 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L444
	r_MmaAccumulatorHalf2WordAtPtx445R1419 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L445
	r_MmaAccumulatorHalf2WordAtPtx446R1420 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L446
	r_MmaAccumulatorHalf2WordAtPtx447R1421 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L447
	r_MmaAccumulatorHalf2WordAtPtx448R1422 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L448
	r_MmaAccumulatorHalf2WordAtPtx449R1423 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L449
	r_MmaAccumulatorHalf2WordAtPtx450R1424 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L450
	r_MmaAccumulatorHalf2WordAtPtx451R1425 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L451
	r_MmaAccumulatorHalf2WordAtPtx452R1426 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L452
	r_MmaAccumulatorHalf2WordAtPtx453R1427 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L453
	r_MmaAccumulatorHalf2WordAtPtx454R1428 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L454
	r_MmaAccumulatorHalf2WordAtPtx455R1429 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L455
	r_MmaAccumulatorHalf2WordAtPtx456R1430 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L456
	r_MmaAccumulatorHalf2WordAtPtx457R1431 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L457
	r_MmaAccumulatorHalf2WordAtPtx458R1432 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L458
	r_MmaAccumulatorHalf2WordAtPtx459R1433 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L459
	r_MmaAccumulatorHalf2WordAtPtx460R1434 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L460
	r_MmaAccumulatorHalf2WordAtPtx461R1435 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L461
	r_MmaAccumulatorHalf2WordAtPtx462R1436 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L462
	r_MmaAccumulatorHalf2WordAtPtx463R1437 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L463
	r_MmaAccumulatorHalf2WordAtPtx464R1438 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L464
	r_MmaAccumulatorHalf2WordAtPtx465R1439 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L465
	r_MmaAccumulatorHalf2WordAtPtx466R1440 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L466
	if (r_bPtxPredicate26)
	{
		goto L__BB55_63;
	} // PTX L467
	r_PtxRegister26 = r_PtxRegister1386 & -32;									  // PTX L468
	r_PackedHalf2AtPtx434R1441 = uint32_t(0);									  // PTX L469
	r_MmaAccumulatorHalf2WordAtPtx435R1409 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L470
	r_MmaAccumulatorHalf2WordAtPtx436R1410 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L471
	r_MmaAccumulatorHalf2WordAtPtx437R1411 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L472
	r_MmaAccumulatorHalf2WordAtPtx438R1412 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L473
	r_MmaAccumulatorHalf2WordAtPtx439R1413 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L474
	r_MmaAccumulatorHalf2WordAtPtx440R1414 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L475
	r_MmaAccumulatorHalf2WordAtPtx441R1415 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L476
	r_MmaAccumulatorHalf2WordAtPtx442R1416 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L477
	r_MmaAccumulatorHalf2WordAtPtx443R1417 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L478
	r_MmaAccumulatorHalf2WordAtPtx444R1418 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L479
	r_MmaAccumulatorHalf2WordAtPtx445R1419 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L480
	r_MmaAccumulatorHalf2WordAtPtx446R1420 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L481
	r_MmaAccumulatorHalf2WordAtPtx447R1421 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L482
	r_MmaAccumulatorHalf2WordAtPtx448R1422 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L483
	r_MmaAccumulatorHalf2WordAtPtx449R1423 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L484
	r_MmaAccumulatorHalf2WordAtPtx450R1424 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L485
	r_MmaAccumulatorHalf2WordAtPtx451R1425 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L486
	r_MmaAccumulatorHalf2WordAtPtx452R1426 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L487
	r_MmaAccumulatorHalf2WordAtPtx453R1427 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L488
	r_MmaAccumulatorHalf2WordAtPtx454R1428 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L489
	r_MmaAccumulatorHalf2WordAtPtx455R1429 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L490
	r_MmaAccumulatorHalf2WordAtPtx456R1430 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L491
	r_MmaAccumulatorHalf2WordAtPtx457R1431 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L492
	r_MmaAccumulatorHalf2WordAtPtx458R1432 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L493
	r_MmaAccumulatorHalf2WordAtPtx459R1433 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L494
	r_MmaAccumulatorHalf2WordAtPtx460R1434 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L495
	r_MmaAccumulatorHalf2WordAtPtx461R1435 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L496
	r_MmaAccumulatorHalf2WordAtPtx462R1436 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L497
	r_MmaAccumulatorHalf2WordAtPtx463R1437 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L498
	r_MmaAccumulatorHalf2WordAtPtx464R1438 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L499
	r_MmaAccumulatorHalf2WordAtPtx465R1439 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L500
	r_MmaAccumulatorHalf2WordAtPtx466R1440 = uint32_t(r_PackedHalf2AtPtx256R926); // PTX L501
	r_PtxRegister1407 = uint32_t(r_PackedHalf2AtPtx434R1441);					  // PTX L502
L__BB55_45:																		  // PTX L503
	r_PtxRegister27 = r_PtxRegister1407 & 1;									  // PTX L504
	r_PtxRegister740 = ShiftLeft(uint32_t(r_PtxRegister1407), uint32_t(11));	  // PTX L505
	r_PtxRegister741 = r_PtxRegister740 & 2048;									  // PTX L506
	r_LaneIndexAtPtx508 = uint32_t((threadIdx.x & 31u));						  // PTX L508
	r_PtxRegister742 = uint32_t(0u /* original named shared base */);			  // PTX L510
	r_PtxRegister28 = uint32_t(r_PtxRegister742) + uint32_t(r_PtxRegister741);	  // PTX L511
	r_PtxRegister743 = ShiftLeft(uint32_t(r_LaneIndexAtPtx508), uint32_t(4));	  // PTX L512
	r_PtxRegister158 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister743);	  // PTX L513
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister158));
		r_MmaBE4x4WordAtPtx515R165 = r_Value.x;
		r_MmaBE4x4WordAtPtx515R166 = r_Value.y;
		r_MmaBE4x4WordAtPtx515R167 = r_Value.z;
		r_MmaBE4x4WordAtPtx515R168 = r_Value.w;
	} // PTX L515
	r_LaneIndexAtPtx518 = uint32_t((threadIdx.x & 31u));					   // PTX L518
	r_PtxRegister744 = ShiftLeft(uint32_t(r_LaneIndexAtPtx518), uint32_t(4));  // PTX L520
	r_PtxRegister745 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister744); // PTX L521
	r_PtxRegister160 = uint32_t(r_PtxRegister745) + uint32_t(512);			   // PTX L522
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister160));
		r_MmaBE4x4WordAtPtx524R169 = r_Value.x;
		r_MmaBE4x4WordAtPtx524R170 = r_Value.y;
		r_MmaBE4x4WordAtPtx524R171 = r_Value.z;
		r_MmaBE4x4WordAtPtx524R172 = r_Value.w;
	} // PTX L524
	r_LaneIndexAtPtx527 = uint32_t((threadIdx.x & 31u));					   // PTX L527
	r_PtxRegister746 = ShiftLeft(uint32_t(r_LaneIndexAtPtx527), uint32_t(4));  // PTX L529
	r_PtxRegister747 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister746); // PTX L530
	r_PtxRegister162 = uint32_t(r_PtxRegister747) + uint32_t(1024);			   // PTX L531
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister162));
		r_MmaBE4x4WordAtPtx533R173 = r_Value.x;
		r_MmaBE4x4WordAtPtx533R174 = r_Value.y;
		r_MmaBE4x4WordAtPtx533R175 = r_Value.z;
		r_MmaBE4x4WordAtPtx533R176 = r_Value.w;
	} // PTX L533
	r_LaneIndexAtPtx536 = uint32_t((threadIdx.x & 31u));					   // PTX L536
	r_PtxRegister748 = ShiftLeft(uint32_t(r_LaneIndexAtPtx536), uint32_t(4));  // PTX L538
	r_PtxRegister749 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister748); // PTX L539
	r_PtxRegister164 = uint32_t(r_PtxRegister749) + uint32_t(1536);			   // PTX L540
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister164));
		r_MmaBE4x4WordAtPtx542R177 = r_Value.x;
		r_MmaBE4x4WordAtPtx542R178 = r_Value.y;
		r_MmaBE4x4WordAtPtx542R179 = r_Value.z;
		r_MmaBE4x4WordAtPtx542R180 = r_Value.w;
	} // PTX L542
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx545R186, r_MmaAccumulatorHalf2WordAtPtx545R195,
		  r_MmaAE4x4WordAtPtx134R1390, r_MmaAE4x4WordAtPtx134R1391, r_MmaAE4x4WordAtPtx134R1392,
		  r_MmaAE4x4WordAtPtx134R1393, r_MmaBE4x4WordAtPtx515R165, r_MmaBE4x4WordAtPtx515R166,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L545
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx552R200, r_MmaAccumulatorHalf2WordAtPtx552R205,
		  r_MmaAE4x4WordAtPtx134R1390, r_MmaAE4x4WordAtPtx134R1391, r_MmaAE4x4WordAtPtx134R1392,
		  r_MmaAE4x4WordAtPtx134R1393, r_MmaBE4x4WordAtPtx515R167, r_MmaBE4x4WordAtPtx515R168,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L552
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx559R210, r_MmaAccumulatorHalf2WordAtPtx559R215,
		  r_MmaAE4x4WordAtPtx134R1390, r_MmaAE4x4WordAtPtx134R1391, r_MmaAE4x4WordAtPtx134R1392,
		  r_MmaAE4x4WordAtPtx134R1393, r_MmaBE4x4WordAtPtx524R169, r_MmaBE4x4WordAtPtx524R170,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L559
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx566R220, r_MmaAccumulatorHalf2WordAtPtx566R225,
		  r_MmaAE4x4WordAtPtx134R1390, r_MmaAE4x4WordAtPtx134R1391, r_MmaAE4x4WordAtPtx134R1392,
		  r_MmaAE4x4WordAtPtx134R1393, r_MmaBE4x4WordAtPtx524R171, r_MmaBE4x4WordAtPtx524R172,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L566
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx573R230, r_MmaAccumulatorHalf2WordAtPtx573R235,
		  r_MmaAE4x4WordAtPtx134R1390, r_MmaAE4x4WordAtPtx134R1391, r_MmaAE4x4WordAtPtx134R1392,
		  r_MmaAE4x4WordAtPtx134R1393, r_MmaBE4x4WordAtPtx533R173, r_MmaBE4x4WordAtPtx533R174,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L573
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx580R240, r_MmaAccumulatorHalf2WordAtPtx580R245,
		  r_MmaAE4x4WordAtPtx134R1390, r_MmaAE4x4WordAtPtx134R1391, r_MmaAE4x4WordAtPtx134R1392,
		  r_MmaAE4x4WordAtPtx134R1393, r_MmaBE4x4WordAtPtx533R175, r_MmaBE4x4WordAtPtx533R176,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L580
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx587R250, r_MmaAccumulatorHalf2WordAtPtx587R255,
		  r_MmaAE4x4WordAtPtx134R1390, r_MmaAE4x4WordAtPtx134R1391, r_MmaAE4x4WordAtPtx134R1392,
		  r_MmaAE4x4WordAtPtx134R1393, r_MmaBE4x4WordAtPtx542R177, r_MmaBE4x4WordAtPtx542R178,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L587
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx594R260, r_MmaAccumulatorHalf2WordAtPtx594R265,
		  r_MmaAE4x4WordAtPtx134R1390, r_MmaAE4x4WordAtPtx134R1391, r_MmaAE4x4WordAtPtx134R1392,
		  r_MmaAE4x4WordAtPtx134R1393, r_MmaBE4x4WordAtPtx542R179, r_MmaBE4x4WordAtPtx542R180,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L594
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx601R270, r_MmaAccumulatorHalf2WordAtPtx601R275,
		  r_MmaAE4x4WordAtPtx168R1394, r_MmaAE4x4WordAtPtx168R1395, r_MmaAE4x4WordAtPtx168R1396,
		  r_MmaAE4x4WordAtPtx168R1397, r_MmaBE4x4WordAtPtx515R165, r_MmaBE4x4WordAtPtx515R166,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L601
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx608R280, r_MmaAccumulatorHalf2WordAtPtx608R285,
		  r_MmaAE4x4WordAtPtx168R1394, r_MmaAE4x4WordAtPtx168R1395, r_MmaAE4x4WordAtPtx168R1396,
		  r_MmaAE4x4WordAtPtx168R1397, r_MmaBE4x4WordAtPtx515R167, r_MmaBE4x4WordAtPtx515R168,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L608
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx615R290, r_MmaAccumulatorHalf2WordAtPtx615R295,
		  r_MmaAE4x4WordAtPtx168R1394, r_MmaAE4x4WordAtPtx168R1395, r_MmaAE4x4WordAtPtx168R1396,
		  r_MmaAE4x4WordAtPtx168R1397, r_MmaBE4x4WordAtPtx524R169, r_MmaBE4x4WordAtPtx524R170,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L615
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx622R300, r_MmaAccumulatorHalf2WordAtPtx622R305,
		  r_MmaAE4x4WordAtPtx168R1394, r_MmaAE4x4WordAtPtx168R1395, r_MmaAE4x4WordAtPtx168R1396,
		  r_MmaAE4x4WordAtPtx168R1397, r_MmaBE4x4WordAtPtx524R171, r_MmaBE4x4WordAtPtx524R172,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L622
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx629R310, r_MmaAccumulatorHalf2WordAtPtx629R315,
		  r_MmaAE4x4WordAtPtx168R1394, r_MmaAE4x4WordAtPtx168R1395, r_MmaAE4x4WordAtPtx168R1396,
		  r_MmaAE4x4WordAtPtx168R1397, r_MmaBE4x4WordAtPtx533R173, r_MmaBE4x4WordAtPtx533R174,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L629
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx636R320, r_MmaAccumulatorHalf2WordAtPtx636R325,
		  r_MmaAE4x4WordAtPtx168R1394, r_MmaAE4x4WordAtPtx168R1395, r_MmaAE4x4WordAtPtx168R1396,
		  r_MmaAE4x4WordAtPtx168R1397, r_MmaBE4x4WordAtPtx533R175, r_MmaBE4x4WordAtPtx533R176,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L636
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx643R330, r_MmaAccumulatorHalf2WordAtPtx643R335,
		  r_MmaAE4x4WordAtPtx168R1394, r_MmaAE4x4WordAtPtx168R1395, r_MmaAE4x4WordAtPtx168R1396,
		  r_MmaAE4x4WordAtPtx168R1397, r_MmaBE4x4WordAtPtx542R177, r_MmaBE4x4WordAtPtx542R178,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L643
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx650R340, r_MmaAccumulatorHalf2WordAtPtx650R345,
		  r_MmaAE4x4WordAtPtx168R1394, r_MmaAE4x4WordAtPtx168R1395, r_MmaAE4x4WordAtPtx168R1396,
		  r_MmaAE4x4WordAtPtx168R1397, r_MmaBE4x4WordAtPtx542R179, r_MmaBE4x4WordAtPtx542R180,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L650
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx657R350, r_MmaAccumulatorHalf2WordAtPtx657R355,
		  r_MmaAE4x4WordAtPtx202R1398, r_MmaAE4x4WordAtPtx202R1399, r_MmaAE4x4WordAtPtx202R1400,
		  r_MmaAE4x4WordAtPtx202R1401, r_MmaBE4x4WordAtPtx515R165, r_MmaBE4x4WordAtPtx515R166,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L657
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx664R360, r_MmaAccumulatorHalf2WordAtPtx664R365,
		  r_MmaAE4x4WordAtPtx202R1398, r_MmaAE4x4WordAtPtx202R1399, r_MmaAE4x4WordAtPtx202R1400,
		  r_MmaAE4x4WordAtPtx202R1401, r_MmaBE4x4WordAtPtx515R167, r_MmaBE4x4WordAtPtx515R168,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L664
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx671R370, r_MmaAccumulatorHalf2WordAtPtx671R375,
		  r_MmaAE4x4WordAtPtx202R1398, r_MmaAE4x4WordAtPtx202R1399, r_MmaAE4x4WordAtPtx202R1400,
		  r_MmaAE4x4WordAtPtx202R1401, r_MmaBE4x4WordAtPtx524R169, r_MmaBE4x4WordAtPtx524R170,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L671
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx678R380, r_MmaAccumulatorHalf2WordAtPtx678R385,
		  r_MmaAE4x4WordAtPtx202R1398, r_MmaAE4x4WordAtPtx202R1399, r_MmaAE4x4WordAtPtx202R1400,
		  r_MmaAE4x4WordAtPtx202R1401, r_MmaBE4x4WordAtPtx524R171, r_MmaBE4x4WordAtPtx524R172,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L678
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx685R390, r_MmaAccumulatorHalf2WordAtPtx685R395,
		  r_MmaAE4x4WordAtPtx202R1398, r_MmaAE4x4WordAtPtx202R1399, r_MmaAE4x4WordAtPtx202R1400,
		  r_MmaAE4x4WordAtPtx202R1401, r_MmaBE4x4WordAtPtx533R173, r_MmaBE4x4WordAtPtx533R174,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L685
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx692R400, r_MmaAccumulatorHalf2WordAtPtx692R405,
		  r_MmaAE4x4WordAtPtx202R1398, r_MmaAE4x4WordAtPtx202R1399, r_MmaAE4x4WordAtPtx202R1400,
		  r_MmaAE4x4WordAtPtx202R1401, r_MmaBE4x4WordAtPtx533R175, r_MmaBE4x4WordAtPtx533R176,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L692
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx699R410, r_MmaAccumulatorHalf2WordAtPtx699R415,
		  r_MmaAE4x4WordAtPtx202R1398, r_MmaAE4x4WordAtPtx202R1399, r_MmaAE4x4WordAtPtx202R1400,
		  r_MmaAE4x4WordAtPtx202R1401, r_MmaBE4x4WordAtPtx542R177, r_MmaBE4x4WordAtPtx542R178,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L699
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx706R420, r_MmaAccumulatorHalf2WordAtPtx706R425,
		  r_MmaAE4x4WordAtPtx202R1398, r_MmaAE4x4WordAtPtx202R1399, r_MmaAE4x4WordAtPtx202R1400,
		  r_MmaAE4x4WordAtPtx202R1401, r_MmaBE4x4WordAtPtx542R179, r_MmaBE4x4WordAtPtx542R180,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L706
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx713R430, r_MmaAccumulatorHalf2WordAtPtx713R435,
		  r_MmaAE4x4WordAtPtx236R1402, r_MmaAE4x4WordAtPtx236R1403, r_MmaAE4x4WordAtPtx236R1404,
		  r_MmaAE4x4WordAtPtx236R1405, r_MmaBE4x4WordAtPtx515R165, r_MmaBE4x4WordAtPtx515R166,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L713
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx720R440, r_MmaAccumulatorHalf2WordAtPtx720R445,
		  r_MmaAE4x4WordAtPtx236R1402, r_MmaAE4x4WordAtPtx236R1403, r_MmaAE4x4WordAtPtx236R1404,
		  r_MmaAE4x4WordAtPtx236R1405, r_MmaBE4x4WordAtPtx515R167, r_MmaBE4x4WordAtPtx515R168,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L720
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx727R450, r_MmaAccumulatorHalf2WordAtPtx727R455,
		  r_MmaAE4x4WordAtPtx236R1402, r_MmaAE4x4WordAtPtx236R1403, r_MmaAE4x4WordAtPtx236R1404,
		  r_MmaAE4x4WordAtPtx236R1405, r_MmaBE4x4WordAtPtx524R169, r_MmaBE4x4WordAtPtx524R170,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L727
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx734R460, r_MmaAccumulatorHalf2WordAtPtx734R465,
		  r_MmaAE4x4WordAtPtx236R1402, r_MmaAE4x4WordAtPtx236R1403, r_MmaAE4x4WordAtPtx236R1404,
		  r_MmaAE4x4WordAtPtx236R1405, r_MmaBE4x4WordAtPtx524R171, r_MmaBE4x4WordAtPtx524R172,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L734
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx741R470, r_MmaAccumulatorHalf2WordAtPtx741R475,
		  r_MmaAE4x4WordAtPtx236R1402, r_MmaAE4x4WordAtPtx236R1403, r_MmaAE4x4WordAtPtx236R1404,
		  r_MmaAE4x4WordAtPtx236R1405, r_MmaBE4x4WordAtPtx533R173, r_MmaBE4x4WordAtPtx533R174,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L741
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx748R480, r_MmaAccumulatorHalf2WordAtPtx748R485,
		  r_MmaAE4x4WordAtPtx236R1402, r_MmaAE4x4WordAtPtx236R1403, r_MmaAE4x4WordAtPtx236R1404,
		  r_MmaAE4x4WordAtPtx236R1405, r_MmaBE4x4WordAtPtx533R175, r_MmaBE4x4WordAtPtx533R176,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L748
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx755R490, r_MmaAccumulatorHalf2WordAtPtx755R495,
		  r_MmaAE4x4WordAtPtx236R1402, r_MmaAE4x4WordAtPtx236R1403, r_MmaAE4x4WordAtPtx236R1404,
		  r_MmaAE4x4WordAtPtx236R1405, r_MmaBE4x4WordAtPtx542R177, r_MmaBE4x4WordAtPtx542R178,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926); // PTX L755
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx762R500, r_MmaAccumulatorHalf2WordAtPtx762R505,
		  r_MmaAE4x4WordAtPtx236R1402, r_MmaAE4x4WordAtPtx236R1403, r_MmaAE4x4WordAtPtx236R1404,
		  r_MmaAE4x4WordAtPtx236R1405, r_MmaBE4x4WordAtPtx542R179, r_MmaBE4x4WordAtPtx542R180,
		  r_PackedHalf2AtPtx256R926,
		  r_PackedHalf2AtPtx256R926);									 // PTX L762
	r_LaneIndexAtPtx769 = uint32_t((threadIdx.x & 31u));				 // PTX L769
	r_Float32BitsAtPtx771R182 = uint32_t(1035427960);					 // PTX L771
	r_PackedHalf2AtPtx773R187 = FloatToHalf2(r_Float32BitsAtPtx771R182); // PTX L773
	r_Float32BitsAtPtx778R183 = uint32_t(1071303771);					 // PTX L778
	r_PackedHalf2AtPtx780R188 = FloatToHalf2(r_Float32BitsAtPtx778R183); // PTX L780
	r_Float32BitsAtPtx785R184 = uint32_t(1069039616);					 // PTX L785
	r_PackedHalf2AtPtx787R190 = FloatToHalf2(r_Float32BitsAtPtx785R184); // PTX L787
	r_Float32BitsAtPtx792R185 = uint32_t(1073553408);					 // PTX L792
	r_PackedHalf2AtPtx794R193 = FloatToHalf2(r_Float32BitsAtPtx792R185); // PTX L794
	r_PackedHalf2AtPtx800R189 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx545R186, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L800
	r_PackedHalf2AtPtx804R192 = HalfMax(r_PackedHalf2AtPtx800R189, r_PackedHalf2AtPtx787R190); // PTX L804
	r_PtxRegister191 = HalfMin(r_PackedHalf2AtPtx804R192, r_PackedHalf2AtPtx794R193);		   // PTX L808
	r_PtxRegister750 = ShiftLeft(uint32_t(r_PtxRegister191), uint32_t(4));					   // PTX L811
	r_PtxRegister596 = uint32_t(r_PtxRegister750) + uint32_t(1073496064);					   // PTX L812
	r_LaneIndexAtPtx814 = uint32_t((threadIdx.x & 31u));									   // PTX L814
	r_PackedHalf2AtPtx817R196 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx545R195, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L817
	r_PackedHalf2AtPtx821R198 = HalfMax(r_PackedHalf2AtPtx817R196, r_PackedHalf2AtPtx787R190); // PTX L821
	r_PtxRegister197 = HalfMin(r_PackedHalf2AtPtx821R198, r_PackedHalf2AtPtx794R193);		   // PTX L825
	r_PtxRegister751 = ShiftLeft(uint32_t(r_PtxRegister197), uint32_t(4));					   // PTX L828
	r_PtxRegister598 = uint32_t(r_PtxRegister751) + uint32_t(1073496064);					   // PTX L829
	r_LaneIndexAtPtx831 = uint32_t((threadIdx.x & 31u));									   // PTX L831
	r_PackedHalf2AtPtx834R201 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx552R200, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L834
	r_PackedHalf2AtPtx838R203 = HalfMax(r_PackedHalf2AtPtx834R201, r_PackedHalf2AtPtx787R190); // PTX L838
	r_PtxRegister202 = HalfMin(r_PackedHalf2AtPtx838R203, r_PackedHalf2AtPtx794R193);		   // PTX L842
	r_PtxRegister752 = ShiftLeft(uint32_t(r_PtxRegister202), uint32_t(4));					   // PTX L845
	r_PtxRegister597 = uint32_t(r_PtxRegister752) + uint32_t(1073496064);					   // PTX L846
	r_LaneIndexAtPtx848 = uint32_t((threadIdx.x & 31u));									   // PTX L848
	r_PackedHalf2AtPtx851R206 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx552R205, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L851
	r_PackedHalf2AtPtx855R208 = HalfMax(r_PackedHalf2AtPtx851R206, r_PackedHalf2AtPtx787R190); // PTX L855
	r_PtxRegister207 = HalfMin(r_PackedHalf2AtPtx855R208, r_PackedHalf2AtPtx794R193);		   // PTX L859
	r_PtxRegister753 = ShiftLeft(uint32_t(r_PtxRegister207), uint32_t(4));					   // PTX L862
	r_PtxRegister599 = uint32_t(r_PtxRegister753) + uint32_t(1073496064);					   // PTX L863
	r_LaneIndexAtPtx865 = uint32_t((threadIdx.x & 31u));									   // PTX L865
	r_PackedHalf2AtPtx868R211 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx559R210, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L868
	r_PackedHalf2AtPtx872R213 = HalfMax(r_PackedHalf2AtPtx868R211, r_PackedHalf2AtPtx787R190); // PTX L872
	r_PtxRegister212 = HalfMin(r_PackedHalf2AtPtx872R213, r_PackedHalf2AtPtx794R193);		   // PTX L876
	r_PtxRegister754 = ShiftLeft(uint32_t(r_PtxRegister212), uint32_t(4));					   // PTX L879
	r_PtxRegister600 = uint32_t(r_PtxRegister754) + uint32_t(1073496064);					   // PTX L880
	r_LaneIndexAtPtx882 = uint32_t((threadIdx.x & 31u));									   // PTX L882
	r_PackedHalf2AtPtx885R216 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx559R215, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L885
	r_PackedHalf2AtPtx889R218 = HalfMax(r_PackedHalf2AtPtx885R216, r_PackedHalf2AtPtx787R190); // PTX L889
	r_PtxRegister217 = HalfMin(r_PackedHalf2AtPtx889R218, r_PackedHalf2AtPtx794R193);		   // PTX L893
	r_PtxRegister755 = ShiftLeft(uint32_t(r_PtxRegister217), uint32_t(4));					   // PTX L896
	r_PtxRegister602 = uint32_t(r_PtxRegister755) + uint32_t(1073496064);					   // PTX L897
	r_LaneIndexAtPtx899 = uint32_t((threadIdx.x & 31u));									   // PTX L899
	r_PackedHalf2AtPtx902R221 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx566R220, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L902
	r_PackedHalf2AtPtx906R223 = HalfMax(r_PackedHalf2AtPtx902R221, r_PackedHalf2AtPtx787R190); // PTX L906
	r_PtxRegister222 = HalfMin(r_PackedHalf2AtPtx906R223, r_PackedHalf2AtPtx794R193);		   // PTX L910
	r_PtxRegister756 = ShiftLeft(uint32_t(r_PtxRegister222), uint32_t(4));					   // PTX L913
	r_PtxRegister601 = uint32_t(r_PtxRegister756) + uint32_t(1073496064);					   // PTX L914
	r_LaneIndexAtPtx916 = uint32_t((threadIdx.x & 31u));									   // PTX L916
	r_PackedHalf2AtPtx919R226 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx566R225, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L919
	r_PackedHalf2AtPtx923R228 = HalfMax(r_PackedHalf2AtPtx919R226, r_PackedHalf2AtPtx787R190); // PTX L923
	r_PtxRegister227 = HalfMin(r_PackedHalf2AtPtx923R228, r_PackedHalf2AtPtx794R193);		   // PTX L927
	r_PtxRegister757 = ShiftLeft(uint32_t(r_PtxRegister227), uint32_t(4));					   // PTX L930
	r_PtxRegister603 = uint32_t(r_PtxRegister757) + uint32_t(1073496064);					   // PTX L931
	r_LaneIndexAtPtx933 = uint32_t((threadIdx.x & 31u));									   // PTX L933
	r_PackedHalf2AtPtx936R231 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx573R230, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L936
	r_PackedHalf2AtPtx940R233 = HalfMax(r_PackedHalf2AtPtx936R231, r_PackedHalf2AtPtx787R190); // PTX L940
	r_PtxRegister232 = HalfMin(r_PackedHalf2AtPtx940R233, r_PackedHalf2AtPtx794R193);		   // PTX L944
	r_PtxRegister758 = ShiftLeft(uint32_t(r_PtxRegister232), uint32_t(4));					   // PTX L947
	r_PtxRegister604 = uint32_t(r_PtxRegister758) + uint32_t(1073496064);					   // PTX L948
	r_LaneIndexAtPtx950 = uint32_t((threadIdx.x & 31u));									   // PTX L950
	r_PackedHalf2AtPtx953R236 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx573R235, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L953
	r_PackedHalf2AtPtx957R238 = HalfMax(r_PackedHalf2AtPtx953R236, r_PackedHalf2AtPtx787R190); // PTX L957
	r_PtxRegister237 = HalfMin(r_PackedHalf2AtPtx957R238, r_PackedHalf2AtPtx794R193);		   // PTX L961
	r_PtxRegister759 = ShiftLeft(uint32_t(r_PtxRegister237), uint32_t(4));					   // PTX L964
	r_PtxRegister606 = uint32_t(r_PtxRegister759) + uint32_t(1073496064);					   // PTX L965
	r_LaneIndexAtPtx967 = uint32_t((threadIdx.x & 31u));									   // PTX L967
	r_PackedHalf2AtPtx970R241 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx580R240, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L970
	r_PackedHalf2AtPtx974R243 = HalfMax(r_PackedHalf2AtPtx970R241, r_PackedHalf2AtPtx787R190); // PTX L974
	r_PtxRegister242 = HalfMin(r_PackedHalf2AtPtx974R243, r_PackedHalf2AtPtx794R193);		   // PTX L978
	r_PtxRegister760 = ShiftLeft(uint32_t(r_PtxRegister242), uint32_t(4));					   // PTX L981
	r_PtxRegister605 = uint32_t(r_PtxRegister760) + uint32_t(1073496064);					   // PTX L982
	r_LaneIndexAtPtx984 = uint32_t((threadIdx.x & 31u));									   // PTX L984
	r_PackedHalf2AtPtx987R246 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx580R245, r_PackedHalf2AtPtx773R187,
										r_PackedHalf2AtPtx780R188);							   // PTX L987
	r_PackedHalf2AtPtx991R248 = HalfMax(r_PackedHalf2AtPtx987R246, r_PackedHalf2AtPtx787R190); // PTX L991
	r_PtxRegister247 = HalfMin(r_PackedHalf2AtPtx991R248, r_PackedHalf2AtPtx794R193);		   // PTX L995
	r_PtxRegister761 = ShiftLeft(uint32_t(r_PtxRegister247), uint32_t(4));					   // PTX L998
	r_PtxRegister607 = uint32_t(r_PtxRegister761) + uint32_t(1073496064);					   // PTX L999
	r_LaneIndexAtPtx1001 = uint32_t((threadIdx.x & 31u));									   // PTX L1001
	r_PackedHalf2AtPtx1004R251 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx587R250, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1004
	r_PackedHalf2AtPtx1008R253 = HalfMax(r_PackedHalf2AtPtx1004R251, r_PackedHalf2AtPtx787R190); // PTX L1008
	r_PtxRegister252 = HalfMin(r_PackedHalf2AtPtx1008R253, r_PackedHalf2AtPtx794R193);			 // PTX L1012
	r_PtxRegister762 = ShiftLeft(uint32_t(r_PtxRegister252), uint32_t(4));						 // PTX L1015
	r_PtxRegister608 = uint32_t(r_PtxRegister762) + uint32_t(1073496064);						 // PTX L1016
	r_LaneIndexAtPtx1018 = uint32_t((threadIdx.x & 31u));										 // PTX L1018
	r_PackedHalf2AtPtx1021R256 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx587R255, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1021
	r_PackedHalf2AtPtx1025R258 = HalfMax(r_PackedHalf2AtPtx1021R256, r_PackedHalf2AtPtx787R190); // PTX L1025
	r_PtxRegister257 = HalfMin(r_PackedHalf2AtPtx1025R258, r_PackedHalf2AtPtx794R193);			 // PTX L1029
	r_PtxRegister763 = ShiftLeft(uint32_t(r_PtxRegister257), uint32_t(4));						 // PTX L1032
	r_PtxRegister610 = uint32_t(r_PtxRegister763) + uint32_t(1073496064);						 // PTX L1033
	r_LaneIndexAtPtx1035 = uint32_t((threadIdx.x & 31u));										 // PTX L1035
	r_PackedHalf2AtPtx1038R261 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx594R260, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1038
	r_PackedHalf2AtPtx1042R263 = HalfMax(r_PackedHalf2AtPtx1038R261, r_PackedHalf2AtPtx787R190); // PTX L1042
	r_PtxRegister262 = HalfMin(r_PackedHalf2AtPtx1042R263, r_PackedHalf2AtPtx794R193);			 // PTX L1046
	r_PtxRegister764 = ShiftLeft(uint32_t(r_PtxRegister262), uint32_t(4));						 // PTX L1049
	r_PtxRegister609 = uint32_t(r_PtxRegister764) + uint32_t(1073496064);						 // PTX L1050
	r_LaneIndexAtPtx1052 = uint32_t((threadIdx.x & 31u));										 // PTX L1052
	r_PackedHalf2AtPtx1055R266 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx594R265, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1055
	r_PackedHalf2AtPtx1059R268 = HalfMax(r_PackedHalf2AtPtx1055R266, r_PackedHalf2AtPtx787R190); // PTX L1059
	r_PtxRegister267 = HalfMin(r_PackedHalf2AtPtx1059R268, r_PackedHalf2AtPtx794R193);			 // PTX L1063
	r_PtxRegister765 = ShiftLeft(uint32_t(r_PtxRegister267), uint32_t(4));						 // PTX L1066
	r_PtxRegister611 = uint32_t(r_PtxRegister765) + uint32_t(1073496064);						 // PTX L1067
	r_LaneIndexAtPtx1069 = uint32_t((threadIdx.x & 31u));										 // PTX L1069
	r_PackedHalf2AtPtx1072R271 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx601R270, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1072
	r_PackedHalf2AtPtx1076R273 = HalfMax(r_PackedHalf2AtPtx1072R271, r_PackedHalf2AtPtx787R190); // PTX L1076
	r_PtxRegister272 = HalfMin(r_PackedHalf2AtPtx1076R273, r_PackedHalf2AtPtx794R193);			 // PTX L1080
	r_PtxRegister766 = ShiftLeft(uint32_t(r_PtxRegister272), uint32_t(4));						 // PTX L1083
	r_PtxRegister612 = uint32_t(r_PtxRegister766) + uint32_t(1073496064);						 // PTX L1084
	r_LaneIndexAtPtx1086 = uint32_t((threadIdx.x & 31u));										 // PTX L1086
	r_PackedHalf2AtPtx1089R276 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx601R275, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1089
	r_PackedHalf2AtPtx1093R278 = HalfMax(r_PackedHalf2AtPtx1089R276, r_PackedHalf2AtPtx787R190); // PTX L1093
	r_PtxRegister277 = HalfMin(r_PackedHalf2AtPtx1093R278, r_PackedHalf2AtPtx794R193);			 // PTX L1097
	r_PtxRegister767 = ShiftLeft(uint32_t(r_PtxRegister277), uint32_t(4));						 // PTX L1100
	r_PtxRegister614 = uint32_t(r_PtxRegister767) + uint32_t(1073496064);						 // PTX L1101
	r_LaneIndexAtPtx1103 = uint32_t((threadIdx.x & 31u));										 // PTX L1103
	r_PackedHalf2AtPtx1106R281 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx608R280, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1106
	r_PackedHalf2AtPtx1110R283 = HalfMax(r_PackedHalf2AtPtx1106R281, r_PackedHalf2AtPtx787R190); // PTX L1110
	r_PtxRegister282 = HalfMin(r_PackedHalf2AtPtx1110R283, r_PackedHalf2AtPtx794R193);			 // PTX L1114
	r_PtxRegister768 = ShiftLeft(uint32_t(r_PtxRegister282), uint32_t(4));						 // PTX L1117
	r_PtxRegister613 = uint32_t(r_PtxRegister768) + uint32_t(1073496064);						 // PTX L1118
	r_LaneIndexAtPtx1120 = uint32_t((threadIdx.x & 31u));										 // PTX L1120
	r_PackedHalf2AtPtx1123R286 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx608R285, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1123
	r_PackedHalf2AtPtx1127R288 = HalfMax(r_PackedHalf2AtPtx1123R286, r_PackedHalf2AtPtx787R190); // PTX L1127
	r_PtxRegister287 = HalfMin(r_PackedHalf2AtPtx1127R288, r_PackedHalf2AtPtx794R193);			 // PTX L1131
	r_PtxRegister769 = ShiftLeft(uint32_t(r_PtxRegister287), uint32_t(4));						 // PTX L1134
	r_PtxRegister615 = uint32_t(r_PtxRegister769) + uint32_t(1073496064);						 // PTX L1135
	r_LaneIndexAtPtx1137 = uint32_t((threadIdx.x & 31u));										 // PTX L1137
	r_PackedHalf2AtPtx1140R291 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx615R290, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1140
	r_PackedHalf2AtPtx1144R293 = HalfMax(r_PackedHalf2AtPtx1140R291, r_PackedHalf2AtPtx787R190); // PTX L1144
	r_PtxRegister292 = HalfMin(r_PackedHalf2AtPtx1144R293, r_PackedHalf2AtPtx794R193);			 // PTX L1148
	r_PtxRegister770 = ShiftLeft(uint32_t(r_PtxRegister292), uint32_t(4));						 // PTX L1151
	r_PtxRegister616 = uint32_t(r_PtxRegister770) + uint32_t(1073496064);						 // PTX L1152
	r_LaneIndexAtPtx1154 = uint32_t((threadIdx.x & 31u));										 // PTX L1154
	r_PackedHalf2AtPtx1157R296 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx615R295, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1157
	r_PackedHalf2AtPtx1161R298 = HalfMax(r_PackedHalf2AtPtx1157R296, r_PackedHalf2AtPtx787R190); // PTX L1161
	r_PtxRegister297 = HalfMin(r_PackedHalf2AtPtx1161R298, r_PackedHalf2AtPtx794R193);			 // PTX L1165
	r_PtxRegister771 = ShiftLeft(uint32_t(r_PtxRegister297), uint32_t(4));						 // PTX L1168
	r_PtxRegister618 = uint32_t(r_PtxRegister771) + uint32_t(1073496064);						 // PTX L1169
	r_LaneIndexAtPtx1171 = uint32_t((threadIdx.x & 31u));										 // PTX L1171
	r_PackedHalf2AtPtx1174R301 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx622R300, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1174
	r_PackedHalf2AtPtx1178R303 = HalfMax(r_PackedHalf2AtPtx1174R301, r_PackedHalf2AtPtx787R190); // PTX L1178
	r_PtxRegister302 = HalfMin(r_PackedHalf2AtPtx1178R303, r_PackedHalf2AtPtx794R193);			 // PTX L1182
	r_PtxRegister772 = ShiftLeft(uint32_t(r_PtxRegister302), uint32_t(4));						 // PTX L1185
	r_PtxRegister617 = uint32_t(r_PtxRegister772) + uint32_t(1073496064);						 // PTX L1186
	r_LaneIndexAtPtx1188 = uint32_t((threadIdx.x & 31u));										 // PTX L1188
	r_PackedHalf2AtPtx1191R306 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx622R305, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1191
	r_PackedHalf2AtPtx1195R308 = HalfMax(r_PackedHalf2AtPtx1191R306, r_PackedHalf2AtPtx787R190); // PTX L1195
	r_PtxRegister307 = HalfMin(r_PackedHalf2AtPtx1195R308, r_PackedHalf2AtPtx794R193);			 // PTX L1199
	r_PtxRegister773 = ShiftLeft(uint32_t(r_PtxRegister307), uint32_t(4));						 // PTX L1202
	r_PtxRegister619 = uint32_t(r_PtxRegister773) + uint32_t(1073496064);						 // PTX L1203
	r_LaneIndexAtPtx1205 = uint32_t((threadIdx.x & 31u));										 // PTX L1205
	r_PackedHalf2AtPtx1208R311 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx629R310, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1208
	r_PackedHalf2AtPtx1212R313 = HalfMax(r_PackedHalf2AtPtx1208R311, r_PackedHalf2AtPtx787R190); // PTX L1212
	r_PtxRegister312 = HalfMin(r_PackedHalf2AtPtx1212R313, r_PackedHalf2AtPtx794R193);			 // PTX L1216
	r_PtxRegister774 = ShiftLeft(uint32_t(r_PtxRegister312), uint32_t(4));						 // PTX L1219
	r_PtxRegister620 = uint32_t(r_PtxRegister774) + uint32_t(1073496064);						 // PTX L1220
	r_LaneIndexAtPtx1222 = uint32_t((threadIdx.x & 31u));										 // PTX L1222
	r_PackedHalf2AtPtx1225R316 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx629R315, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1225
	r_PackedHalf2AtPtx1229R318 = HalfMax(r_PackedHalf2AtPtx1225R316, r_PackedHalf2AtPtx787R190); // PTX L1229
	r_PtxRegister317 = HalfMin(r_PackedHalf2AtPtx1229R318, r_PackedHalf2AtPtx794R193);			 // PTX L1233
	r_PtxRegister775 = ShiftLeft(uint32_t(r_PtxRegister317), uint32_t(4));						 // PTX L1236
	r_PtxRegister622 = uint32_t(r_PtxRegister775) + uint32_t(1073496064);						 // PTX L1237
	r_LaneIndexAtPtx1239 = uint32_t((threadIdx.x & 31u));										 // PTX L1239
	r_PackedHalf2AtPtx1242R321 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx636R320, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1242
	r_PackedHalf2AtPtx1246R323 = HalfMax(r_PackedHalf2AtPtx1242R321, r_PackedHalf2AtPtx787R190); // PTX L1246
	r_PtxRegister322 = HalfMin(r_PackedHalf2AtPtx1246R323, r_PackedHalf2AtPtx794R193);			 // PTX L1250
	r_PtxRegister776 = ShiftLeft(uint32_t(r_PtxRegister322), uint32_t(4));						 // PTX L1253
	r_PtxRegister621 = uint32_t(r_PtxRegister776) + uint32_t(1073496064);						 // PTX L1254
	r_LaneIndexAtPtx1256 = uint32_t((threadIdx.x & 31u));										 // PTX L1256
	r_PackedHalf2AtPtx1259R326 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx636R325, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1259
	r_PackedHalf2AtPtx1263R328 = HalfMax(r_PackedHalf2AtPtx1259R326, r_PackedHalf2AtPtx787R190); // PTX L1263
	r_PtxRegister327 = HalfMin(r_PackedHalf2AtPtx1263R328, r_PackedHalf2AtPtx794R193);			 // PTX L1267
	r_PtxRegister777 = ShiftLeft(uint32_t(r_PtxRegister327), uint32_t(4));						 // PTX L1270
	r_PtxRegister623 = uint32_t(r_PtxRegister777) + uint32_t(1073496064);						 // PTX L1271
	r_LaneIndexAtPtx1273 = uint32_t((threadIdx.x & 31u));										 // PTX L1273
	r_PackedHalf2AtPtx1276R331 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx643R330, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1276
	r_PackedHalf2AtPtx1280R333 = HalfMax(r_PackedHalf2AtPtx1276R331, r_PackedHalf2AtPtx787R190); // PTX L1280
	r_PtxRegister332 = HalfMin(r_PackedHalf2AtPtx1280R333, r_PackedHalf2AtPtx794R193);			 // PTX L1284
	r_PtxRegister778 = ShiftLeft(uint32_t(r_PtxRegister332), uint32_t(4));						 // PTX L1287
	r_PtxRegister624 = uint32_t(r_PtxRegister778) + uint32_t(1073496064);						 // PTX L1288
	r_LaneIndexAtPtx1290 = uint32_t((threadIdx.x & 31u));										 // PTX L1290
	r_PackedHalf2AtPtx1293R336 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx643R335, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1293
	r_PackedHalf2AtPtx1297R338 = HalfMax(r_PackedHalf2AtPtx1293R336, r_PackedHalf2AtPtx787R190); // PTX L1297
	r_PtxRegister337 = HalfMin(r_PackedHalf2AtPtx1297R338, r_PackedHalf2AtPtx794R193);			 // PTX L1301
	r_PtxRegister779 = ShiftLeft(uint32_t(r_PtxRegister337), uint32_t(4));						 // PTX L1304
	r_PtxRegister626 = uint32_t(r_PtxRegister779) + uint32_t(1073496064);						 // PTX L1305
	r_LaneIndexAtPtx1307 = uint32_t((threadIdx.x & 31u));										 // PTX L1307
	r_PackedHalf2AtPtx1310R341 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx650R340, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1310
	r_PackedHalf2AtPtx1314R343 = HalfMax(r_PackedHalf2AtPtx1310R341, r_PackedHalf2AtPtx787R190); // PTX L1314
	r_PtxRegister342 = HalfMin(r_PackedHalf2AtPtx1314R343, r_PackedHalf2AtPtx794R193);			 // PTX L1318
	r_PtxRegister780 = ShiftLeft(uint32_t(r_PtxRegister342), uint32_t(4));						 // PTX L1321
	r_PtxRegister625 = uint32_t(r_PtxRegister780) + uint32_t(1073496064);						 // PTX L1322
	r_LaneIndexAtPtx1324 = uint32_t((threadIdx.x & 31u));										 // PTX L1324
	r_PackedHalf2AtPtx1327R346 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx650R345, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1327
	r_PackedHalf2AtPtx1331R348 = HalfMax(r_PackedHalf2AtPtx1327R346, r_PackedHalf2AtPtx787R190); // PTX L1331
	r_PtxRegister347 = HalfMin(r_PackedHalf2AtPtx1331R348, r_PackedHalf2AtPtx794R193);			 // PTX L1335
	r_PtxRegister781 = ShiftLeft(uint32_t(r_PtxRegister347), uint32_t(4));						 // PTX L1338
	r_PtxRegister627 = uint32_t(r_PtxRegister781) + uint32_t(1073496064);						 // PTX L1339
	r_LaneIndexAtPtx1341 = uint32_t((threadIdx.x & 31u));										 // PTX L1341
	r_PackedHalf2AtPtx1344R351 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx657R350, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1344
	r_PackedHalf2AtPtx1348R353 = HalfMax(r_PackedHalf2AtPtx1344R351, r_PackedHalf2AtPtx787R190); // PTX L1348
	r_PtxRegister352 = HalfMin(r_PackedHalf2AtPtx1348R353, r_PackedHalf2AtPtx794R193);			 // PTX L1352
	r_PtxRegister782 = ShiftLeft(uint32_t(r_PtxRegister352), uint32_t(4));						 // PTX L1355
	r_PtxRegister628 = uint32_t(r_PtxRegister782) + uint32_t(1073496064);						 // PTX L1356
	r_LaneIndexAtPtx1358 = uint32_t((threadIdx.x & 31u));										 // PTX L1358
	r_PackedHalf2AtPtx1361R356 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx657R355, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1361
	r_PackedHalf2AtPtx1365R358 = HalfMax(r_PackedHalf2AtPtx1361R356, r_PackedHalf2AtPtx787R190); // PTX L1365
	r_PtxRegister357 = HalfMin(r_PackedHalf2AtPtx1365R358, r_PackedHalf2AtPtx794R193);			 // PTX L1369
	r_PtxRegister783 = ShiftLeft(uint32_t(r_PtxRegister357), uint32_t(4));						 // PTX L1372
	r_PtxRegister630 = uint32_t(r_PtxRegister783) + uint32_t(1073496064);						 // PTX L1373
	r_LaneIndexAtPtx1375 = uint32_t((threadIdx.x & 31u));										 // PTX L1375
	r_PackedHalf2AtPtx1378R361 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx664R360, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1378
	r_PackedHalf2AtPtx1382R363 = HalfMax(r_PackedHalf2AtPtx1378R361, r_PackedHalf2AtPtx787R190); // PTX L1382
	r_PtxRegister362 = HalfMin(r_PackedHalf2AtPtx1382R363, r_PackedHalf2AtPtx794R193);			 // PTX L1386
	r_PtxRegister784 = ShiftLeft(uint32_t(r_PtxRegister362), uint32_t(4));						 // PTX L1389
	r_PtxRegister629 = uint32_t(r_PtxRegister784) + uint32_t(1073496064);						 // PTX L1390
	r_LaneIndexAtPtx1392 = uint32_t((threadIdx.x & 31u));										 // PTX L1392
	r_PackedHalf2AtPtx1395R366 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx664R365, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1395
	r_PackedHalf2AtPtx1399R368 = HalfMax(r_PackedHalf2AtPtx1395R366, r_PackedHalf2AtPtx787R190); // PTX L1399
	r_PtxRegister367 = HalfMin(r_PackedHalf2AtPtx1399R368, r_PackedHalf2AtPtx794R193);			 // PTX L1403
	r_PtxRegister785 = ShiftLeft(uint32_t(r_PtxRegister367), uint32_t(4));						 // PTX L1406
	r_PtxRegister631 = uint32_t(r_PtxRegister785) + uint32_t(1073496064);						 // PTX L1407
	r_LaneIndexAtPtx1409 = uint32_t((threadIdx.x & 31u));										 // PTX L1409
	r_PackedHalf2AtPtx1412R371 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx671R370, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1412
	r_PackedHalf2AtPtx1416R373 = HalfMax(r_PackedHalf2AtPtx1412R371, r_PackedHalf2AtPtx787R190); // PTX L1416
	r_PtxRegister372 = HalfMin(r_PackedHalf2AtPtx1416R373, r_PackedHalf2AtPtx794R193);			 // PTX L1420
	r_PtxRegister786 = ShiftLeft(uint32_t(r_PtxRegister372), uint32_t(4));						 // PTX L1423
	r_PtxRegister632 = uint32_t(r_PtxRegister786) + uint32_t(1073496064);						 // PTX L1424
	r_LaneIndexAtPtx1426 = uint32_t((threadIdx.x & 31u));										 // PTX L1426
	r_PackedHalf2AtPtx1429R376 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx671R375, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1429
	r_PackedHalf2AtPtx1433R378 = HalfMax(r_PackedHalf2AtPtx1429R376, r_PackedHalf2AtPtx787R190); // PTX L1433
	r_PtxRegister377 = HalfMin(r_PackedHalf2AtPtx1433R378, r_PackedHalf2AtPtx794R193);			 // PTX L1437
	r_PtxRegister787 = ShiftLeft(uint32_t(r_PtxRegister377), uint32_t(4));						 // PTX L1440
	r_PtxRegister634 = uint32_t(r_PtxRegister787) + uint32_t(1073496064);						 // PTX L1441
	r_LaneIndexAtPtx1443 = uint32_t((threadIdx.x & 31u));										 // PTX L1443
	r_PackedHalf2AtPtx1446R381 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx678R380, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1446
	r_PackedHalf2AtPtx1450R383 = HalfMax(r_PackedHalf2AtPtx1446R381, r_PackedHalf2AtPtx787R190); // PTX L1450
	r_PtxRegister382 = HalfMin(r_PackedHalf2AtPtx1450R383, r_PackedHalf2AtPtx794R193);			 // PTX L1454
	r_PtxRegister788 = ShiftLeft(uint32_t(r_PtxRegister382), uint32_t(4));						 // PTX L1457
	r_PtxRegister633 = uint32_t(r_PtxRegister788) + uint32_t(1073496064);						 // PTX L1458
	r_LaneIndexAtPtx1460 = uint32_t((threadIdx.x & 31u));										 // PTX L1460
	r_PackedHalf2AtPtx1463R386 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx678R385, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1463
	r_PackedHalf2AtPtx1467R388 = HalfMax(r_PackedHalf2AtPtx1463R386, r_PackedHalf2AtPtx787R190); // PTX L1467
	r_PtxRegister387 = HalfMin(r_PackedHalf2AtPtx1467R388, r_PackedHalf2AtPtx794R193);			 // PTX L1471
	r_PtxRegister789 = ShiftLeft(uint32_t(r_PtxRegister387), uint32_t(4));						 // PTX L1474
	r_PtxRegister635 = uint32_t(r_PtxRegister789) + uint32_t(1073496064);						 // PTX L1475
	r_LaneIndexAtPtx1477 = uint32_t((threadIdx.x & 31u));										 // PTX L1477
	r_PackedHalf2AtPtx1480R391 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx685R390, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1480
	r_PackedHalf2AtPtx1484R393 = HalfMax(r_PackedHalf2AtPtx1480R391, r_PackedHalf2AtPtx787R190); // PTX L1484
	r_PtxRegister392 = HalfMin(r_PackedHalf2AtPtx1484R393, r_PackedHalf2AtPtx794R193);			 // PTX L1488
	r_PtxRegister790 = ShiftLeft(uint32_t(r_PtxRegister392), uint32_t(4));						 // PTX L1491
	r_PtxRegister636 = uint32_t(r_PtxRegister790) + uint32_t(1073496064);						 // PTX L1492
	r_LaneIndexAtPtx1494 = uint32_t((threadIdx.x & 31u));										 // PTX L1494
	r_PackedHalf2AtPtx1497R396 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx685R395, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1497
	r_PackedHalf2AtPtx1501R398 = HalfMax(r_PackedHalf2AtPtx1497R396, r_PackedHalf2AtPtx787R190); // PTX L1501
	r_PtxRegister397 = HalfMin(r_PackedHalf2AtPtx1501R398, r_PackedHalf2AtPtx794R193);			 // PTX L1505
	r_PtxRegister791 = ShiftLeft(uint32_t(r_PtxRegister397), uint32_t(4));						 // PTX L1508
	r_PtxRegister638 = uint32_t(r_PtxRegister791) + uint32_t(1073496064);						 // PTX L1509
	r_LaneIndexAtPtx1511 = uint32_t((threadIdx.x & 31u));										 // PTX L1511
	r_PackedHalf2AtPtx1514R401 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx692R400, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1514
	r_PackedHalf2AtPtx1518R403 = HalfMax(r_PackedHalf2AtPtx1514R401, r_PackedHalf2AtPtx787R190); // PTX L1518
	r_PtxRegister402 = HalfMin(r_PackedHalf2AtPtx1518R403, r_PackedHalf2AtPtx794R193);			 // PTX L1522
	r_PtxRegister792 = ShiftLeft(uint32_t(r_PtxRegister402), uint32_t(4));						 // PTX L1525
	r_PtxRegister637 = uint32_t(r_PtxRegister792) + uint32_t(1073496064);						 // PTX L1526
	r_LaneIndexAtPtx1528 = uint32_t((threadIdx.x & 31u));										 // PTX L1528
	r_PackedHalf2AtPtx1531R406 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx692R405, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1531
	r_PackedHalf2AtPtx1535R408 = HalfMax(r_PackedHalf2AtPtx1531R406, r_PackedHalf2AtPtx787R190); // PTX L1535
	r_PtxRegister407 = HalfMin(r_PackedHalf2AtPtx1535R408, r_PackedHalf2AtPtx794R193);			 // PTX L1539
	r_PtxRegister793 = ShiftLeft(uint32_t(r_PtxRegister407), uint32_t(4));						 // PTX L1542
	r_PtxRegister639 = uint32_t(r_PtxRegister793) + uint32_t(1073496064);						 // PTX L1543
	r_LaneIndexAtPtx1545 = uint32_t((threadIdx.x & 31u));										 // PTX L1545
	r_PackedHalf2AtPtx1548R411 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx699R410, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1548
	r_PackedHalf2AtPtx1552R413 = HalfMax(r_PackedHalf2AtPtx1548R411, r_PackedHalf2AtPtx787R190); // PTX L1552
	r_PtxRegister412 = HalfMin(r_PackedHalf2AtPtx1552R413, r_PackedHalf2AtPtx794R193);			 // PTX L1556
	r_PtxRegister794 = ShiftLeft(uint32_t(r_PtxRegister412), uint32_t(4));						 // PTX L1559
	r_PtxRegister640 = uint32_t(r_PtxRegister794) + uint32_t(1073496064);						 // PTX L1560
	r_LaneIndexAtPtx1562 = uint32_t((threadIdx.x & 31u));										 // PTX L1562
	r_PackedHalf2AtPtx1565R416 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx699R415, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1565
	r_PackedHalf2AtPtx1569R418 = HalfMax(r_PackedHalf2AtPtx1565R416, r_PackedHalf2AtPtx787R190); // PTX L1569
	r_PtxRegister417 = HalfMin(r_PackedHalf2AtPtx1569R418, r_PackedHalf2AtPtx794R193);			 // PTX L1573
	r_PtxRegister795 = ShiftLeft(uint32_t(r_PtxRegister417), uint32_t(4));						 // PTX L1576
	r_PtxRegister642 = uint32_t(r_PtxRegister795) + uint32_t(1073496064);						 // PTX L1577
	r_LaneIndexAtPtx1579 = uint32_t((threadIdx.x & 31u));										 // PTX L1579
	r_PackedHalf2AtPtx1582R421 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx706R420, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1582
	r_PackedHalf2AtPtx1586R423 = HalfMax(r_PackedHalf2AtPtx1582R421, r_PackedHalf2AtPtx787R190); // PTX L1586
	r_PtxRegister422 = HalfMin(r_PackedHalf2AtPtx1586R423, r_PackedHalf2AtPtx794R193);			 // PTX L1590
	r_PtxRegister796 = ShiftLeft(uint32_t(r_PtxRegister422), uint32_t(4));						 // PTX L1593
	r_PtxRegister641 = uint32_t(r_PtxRegister796) + uint32_t(1073496064);						 // PTX L1594
	r_LaneIndexAtPtx1596 = uint32_t((threadIdx.x & 31u));										 // PTX L1596
	r_PackedHalf2AtPtx1599R426 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx706R425, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1599
	r_PackedHalf2AtPtx1603R428 = HalfMax(r_PackedHalf2AtPtx1599R426, r_PackedHalf2AtPtx787R190); // PTX L1603
	r_PtxRegister427 = HalfMin(r_PackedHalf2AtPtx1603R428, r_PackedHalf2AtPtx794R193);			 // PTX L1607
	r_PtxRegister797 = ShiftLeft(uint32_t(r_PtxRegister427), uint32_t(4));						 // PTX L1610
	r_PtxRegister643 = uint32_t(r_PtxRegister797) + uint32_t(1073496064);						 // PTX L1611
	r_LaneIndexAtPtx1613 = uint32_t((threadIdx.x & 31u));										 // PTX L1613
	r_PackedHalf2AtPtx1616R431 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx713R430, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1616
	r_PackedHalf2AtPtx1620R433 = HalfMax(r_PackedHalf2AtPtx1616R431, r_PackedHalf2AtPtx787R190); // PTX L1620
	r_PtxRegister432 = HalfMin(r_PackedHalf2AtPtx1620R433, r_PackedHalf2AtPtx794R193);			 // PTX L1624
	r_PtxRegister798 = ShiftLeft(uint32_t(r_PtxRegister432), uint32_t(4));						 // PTX L1627
	r_PtxRegister644 = uint32_t(r_PtxRegister798) + uint32_t(1073496064);						 // PTX L1628
	r_LaneIndexAtPtx1630 = uint32_t((threadIdx.x & 31u));										 // PTX L1630
	r_PackedHalf2AtPtx1633R436 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx713R435, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1633
	r_PackedHalf2AtPtx1637R438 = HalfMax(r_PackedHalf2AtPtx1633R436, r_PackedHalf2AtPtx787R190); // PTX L1637
	r_PtxRegister437 = HalfMin(r_PackedHalf2AtPtx1637R438, r_PackedHalf2AtPtx794R193);			 // PTX L1641
	r_PtxRegister799 = ShiftLeft(uint32_t(r_PtxRegister437), uint32_t(4));						 // PTX L1644
	r_PtxRegister646 = uint32_t(r_PtxRegister799) + uint32_t(1073496064);						 // PTX L1645
	r_LaneIndexAtPtx1647 = uint32_t((threadIdx.x & 31u));										 // PTX L1647
	r_PackedHalf2AtPtx1650R441 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx720R440, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1650
	r_PackedHalf2AtPtx1654R443 = HalfMax(r_PackedHalf2AtPtx1650R441, r_PackedHalf2AtPtx787R190); // PTX L1654
	r_PtxRegister442 = HalfMin(r_PackedHalf2AtPtx1654R443, r_PackedHalf2AtPtx794R193);			 // PTX L1658
	r_PtxRegister800 = ShiftLeft(uint32_t(r_PtxRegister442), uint32_t(4));						 // PTX L1661
	r_PtxRegister645 = uint32_t(r_PtxRegister800) + uint32_t(1073496064);						 // PTX L1662
	r_LaneIndexAtPtx1664 = uint32_t((threadIdx.x & 31u));										 // PTX L1664
	r_PackedHalf2AtPtx1667R446 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx720R445, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1667
	r_PackedHalf2AtPtx1671R448 = HalfMax(r_PackedHalf2AtPtx1667R446, r_PackedHalf2AtPtx787R190); // PTX L1671
	r_PtxRegister447 = HalfMin(r_PackedHalf2AtPtx1671R448, r_PackedHalf2AtPtx794R193);			 // PTX L1675
	r_PtxRegister801 = ShiftLeft(uint32_t(r_PtxRegister447), uint32_t(4));						 // PTX L1678
	r_PtxRegister647 = uint32_t(r_PtxRegister801) + uint32_t(1073496064);						 // PTX L1679
	r_LaneIndexAtPtx1681 = uint32_t((threadIdx.x & 31u));										 // PTX L1681
	r_PackedHalf2AtPtx1684R451 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx727R450, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1684
	r_PackedHalf2AtPtx1688R453 = HalfMax(r_PackedHalf2AtPtx1684R451, r_PackedHalf2AtPtx787R190); // PTX L1688
	r_PtxRegister452 = HalfMin(r_PackedHalf2AtPtx1688R453, r_PackedHalf2AtPtx794R193);			 // PTX L1692
	r_PtxRegister802 = ShiftLeft(uint32_t(r_PtxRegister452), uint32_t(4));						 // PTX L1695
	r_PtxRegister648 = uint32_t(r_PtxRegister802) + uint32_t(1073496064);						 // PTX L1696
	r_LaneIndexAtPtx1698 = uint32_t((threadIdx.x & 31u));										 // PTX L1698
	r_PackedHalf2AtPtx1701R456 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx727R455, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1701
	r_PackedHalf2AtPtx1705R458 = HalfMax(r_PackedHalf2AtPtx1701R456, r_PackedHalf2AtPtx787R190); // PTX L1705
	r_PtxRegister457 = HalfMin(r_PackedHalf2AtPtx1705R458, r_PackedHalf2AtPtx794R193);			 // PTX L1709
	r_PtxRegister803 = ShiftLeft(uint32_t(r_PtxRegister457), uint32_t(4));						 // PTX L1712
	r_PtxRegister650 = uint32_t(r_PtxRegister803) + uint32_t(1073496064);						 // PTX L1713
	r_LaneIndexAtPtx1715 = uint32_t((threadIdx.x & 31u));										 // PTX L1715
	r_PackedHalf2AtPtx1718R461 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx734R460, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1718
	r_PackedHalf2AtPtx1722R463 = HalfMax(r_PackedHalf2AtPtx1718R461, r_PackedHalf2AtPtx787R190); // PTX L1722
	r_PtxRegister462 = HalfMin(r_PackedHalf2AtPtx1722R463, r_PackedHalf2AtPtx794R193);			 // PTX L1726
	r_PtxRegister804 = ShiftLeft(uint32_t(r_PtxRegister462), uint32_t(4));						 // PTX L1729
	r_PtxRegister649 = uint32_t(r_PtxRegister804) + uint32_t(1073496064);						 // PTX L1730
	r_LaneIndexAtPtx1732 = uint32_t((threadIdx.x & 31u));										 // PTX L1732
	r_PackedHalf2AtPtx1735R466 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx734R465, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1735
	r_PackedHalf2AtPtx1739R468 = HalfMax(r_PackedHalf2AtPtx1735R466, r_PackedHalf2AtPtx787R190); // PTX L1739
	r_PtxRegister467 = HalfMin(r_PackedHalf2AtPtx1739R468, r_PackedHalf2AtPtx794R193);			 // PTX L1743
	r_PtxRegister805 = ShiftLeft(uint32_t(r_PtxRegister467), uint32_t(4));						 // PTX L1746
	r_PtxRegister651 = uint32_t(r_PtxRegister805) + uint32_t(1073496064);						 // PTX L1747
	r_LaneIndexAtPtx1749 = uint32_t((threadIdx.x & 31u));										 // PTX L1749
	r_PackedHalf2AtPtx1752R471 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx741R470, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1752
	r_PackedHalf2AtPtx1756R473 = HalfMax(r_PackedHalf2AtPtx1752R471, r_PackedHalf2AtPtx787R190); // PTX L1756
	r_PtxRegister472 = HalfMin(r_PackedHalf2AtPtx1756R473, r_PackedHalf2AtPtx794R193);			 // PTX L1760
	r_PtxRegister806 = ShiftLeft(uint32_t(r_PtxRegister472), uint32_t(4));						 // PTX L1763
	r_PtxRegister652 = uint32_t(r_PtxRegister806) + uint32_t(1073496064);						 // PTX L1764
	r_LaneIndexAtPtx1766 = uint32_t((threadIdx.x & 31u));										 // PTX L1766
	r_PackedHalf2AtPtx1769R476 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx741R475, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1769
	r_PackedHalf2AtPtx1773R478 = HalfMax(r_PackedHalf2AtPtx1769R476, r_PackedHalf2AtPtx787R190); // PTX L1773
	r_PtxRegister477 = HalfMin(r_PackedHalf2AtPtx1773R478, r_PackedHalf2AtPtx794R193);			 // PTX L1777
	r_PtxRegister807 = ShiftLeft(uint32_t(r_PtxRegister477), uint32_t(4));						 // PTX L1780
	r_PtxRegister654 = uint32_t(r_PtxRegister807) + uint32_t(1073496064);						 // PTX L1781
	r_LaneIndexAtPtx1783 = uint32_t((threadIdx.x & 31u));										 // PTX L1783
	r_PackedHalf2AtPtx1786R481 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx748R480, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1786
	r_PackedHalf2AtPtx1790R483 = HalfMax(r_PackedHalf2AtPtx1786R481, r_PackedHalf2AtPtx787R190); // PTX L1790
	r_PtxRegister482 = HalfMin(r_PackedHalf2AtPtx1790R483, r_PackedHalf2AtPtx794R193);			 // PTX L1794
	r_PtxRegister808 = ShiftLeft(uint32_t(r_PtxRegister482), uint32_t(4));						 // PTX L1797
	r_PtxRegister653 = uint32_t(r_PtxRegister808) + uint32_t(1073496064);						 // PTX L1798
	r_LaneIndexAtPtx1800 = uint32_t((threadIdx.x & 31u));										 // PTX L1800
	r_PackedHalf2AtPtx1803R486 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx748R485, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1803
	r_PackedHalf2AtPtx1807R488 = HalfMax(r_PackedHalf2AtPtx1803R486, r_PackedHalf2AtPtx787R190); // PTX L1807
	r_PtxRegister487 = HalfMin(r_PackedHalf2AtPtx1807R488, r_PackedHalf2AtPtx794R193);			 // PTX L1811
	r_PtxRegister809 = ShiftLeft(uint32_t(r_PtxRegister487), uint32_t(4));						 // PTX L1814
	r_PtxRegister655 = uint32_t(r_PtxRegister809) + uint32_t(1073496064);						 // PTX L1815
	r_LaneIndexAtPtx1817 = uint32_t((threadIdx.x & 31u));										 // PTX L1817
	r_PackedHalf2AtPtx1820R491 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx755R490, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1820
	r_PackedHalf2AtPtx1824R493 = HalfMax(r_PackedHalf2AtPtx1820R491, r_PackedHalf2AtPtx787R190); // PTX L1824
	r_PtxRegister492 = HalfMin(r_PackedHalf2AtPtx1824R493, r_PackedHalf2AtPtx794R193);			 // PTX L1828
	r_PtxRegister810 = ShiftLeft(uint32_t(r_PtxRegister492), uint32_t(4));						 // PTX L1831
	r_PtxRegister656 = uint32_t(r_PtxRegister810) + uint32_t(1073496064);						 // PTX L1832
	r_LaneIndexAtPtx1834 = uint32_t((threadIdx.x & 31u));										 // PTX L1834
	r_PackedHalf2AtPtx1837R496 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx755R495, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1837
	r_PackedHalf2AtPtx1841R498 = HalfMax(r_PackedHalf2AtPtx1837R496, r_PackedHalf2AtPtx787R190); // PTX L1841
	r_PtxRegister497 = HalfMin(r_PackedHalf2AtPtx1841R498, r_PackedHalf2AtPtx794R193);			 // PTX L1845
	r_PtxRegister811 = ShiftLeft(uint32_t(r_PtxRegister497), uint32_t(4));						 // PTX L1848
	r_PtxRegister658 = uint32_t(r_PtxRegister811) + uint32_t(1073496064);						 // PTX L1849
	r_LaneIndexAtPtx1851 = uint32_t((threadIdx.x & 31u));										 // PTX L1851
	r_PackedHalf2AtPtx1854R501 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx762R500, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							 // PTX L1854
	r_PackedHalf2AtPtx1858R503 = HalfMax(r_PackedHalf2AtPtx1854R501, r_PackedHalf2AtPtx787R190); // PTX L1858
	r_PtxRegister502 = HalfMin(r_PackedHalf2AtPtx1858R503, r_PackedHalf2AtPtx794R193);			 // PTX L1862
	r_PtxRegister812 = ShiftLeft(uint32_t(r_PtxRegister502), uint32_t(4));						 // PTX L1865
	r_PtxRegister657 = uint32_t(r_PtxRegister812) + uint32_t(1073496064);						 // PTX L1866
	r_LaneIndexAtPtx1868 = uint32_t((threadIdx.x & 31u));										 // PTX L1868
	r_PackedHalf2AtPtx1871R506 = HalfFma(r_MmaAccumulatorHalf2WordAtPtx762R505, r_PackedHalf2AtPtx773R187,
										 r_PackedHalf2AtPtx780R188);							  // PTX L1871
	r_PackedHalf2AtPtx1875R508 = HalfMax(r_PackedHalf2AtPtx1871R506, r_PackedHalf2AtPtx787R190);  // PTX L1875
	r_PtxRegister507 = HalfMin(r_PackedHalf2AtPtx1875R508, r_PackedHalf2AtPtx794R193);			  // PTX L1879
	r_PtxRegister813 = ShiftLeft(uint32_t(r_PtxRegister507), uint32_t(4));						  // PTX L1882
	r_PtxRegister659 = uint32_t(r_PtxRegister813) + uint32_t(1073496064);						  // PTX L1883
	r_LaneIndexAtPtx1885 = uint32_t((threadIdx.x & 31u));										  // PTX L1885
	r_PackedHalf2AtPtx1888R510 = HalfAdd(r_PtxRegister596, r_PtxRegister597);					  // PTX L1888
	r_PackedHalf2AtPtx1892R511 = HalfAdd(r_PtxRegister600, r_PtxRegister601);					  // PTX L1892
	r_PackedHalf2AtPtx1896R512 = HalfAdd(r_PackedHalf2AtPtx1888R510, r_PackedHalf2AtPtx1892R511); // PTX L1896
	r_PackedHalf2AtPtx1900R513 = HalfAdd(r_PtxRegister604, r_PtxRegister605);					  // PTX L1900
	r_PackedHalf2AtPtx1904R515 = HalfAdd(r_PackedHalf2AtPtx1896R512, r_PackedHalf2AtPtx1900R513); // PTX L1904
	r_PackedHalf2AtPtx1908R516 = HalfAdd(r_PtxRegister608, r_PtxRegister609);					  // PTX L1908
	r_PtxRegister514 = HalfAdd(r_PackedHalf2AtPtx1904R515, r_PackedHalf2AtPtx1908R516);			  // PTX L1912
	r_PackedHalf2AtPtx1916R517 = HalfAdd(r_PtxRegister598, r_PtxRegister599);					  // PTX L1916
	r_PackedHalf2AtPtx1920R518 = HalfAdd(r_PtxRegister602, r_PtxRegister603);					  // PTX L1920
	r_PackedHalf2AtPtx1924R519 = HalfAdd(r_PackedHalf2AtPtx1916R517, r_PackedHalf2AtPtx1920R518); // PTX L1924
	r_PackedHalf2AtPtx1928R520 = HalfAdd(r_PtxRegister606, r_PtxRegister607);					  // PTX L1928
	r_PackedHalf2AtPtx1932R522 = HalfAdd(r_PackedHalf2AtPtx1924R519, r_PackedHalf2AtPtx1928R520); // PTX L1932
	r_PackedHalf2AtPtx1936R523 = HalfAdd(r_PtxRegister610, r_PtxRegister611);					  // PTX L1936
	r_PtxRegister521 = HalfAdd(r_PackedHalf2AtPtx1932R522, r_PackedHalf2AtPtx1936R523);			  // PTX L1940
	r_PackedHalf2AtPtx1944R524 = HalfAdd(r_PtxRegister612, r_PtxRegister613);					  // PTX L1944
	r_PackedHalf2AtPtx1948R525 = HalfAdd(r_PtxRegister616, r_PtxRegister617);					  // PTX L1948
	r_PackedHalf2AtPtx1952R526 = HalfAdd(r_PackedHalf2AtPtx1944R524, r_PackedHalf2AtPtx1948R525); // PTX L1952
	r_PackedHalf2AtPtx1956R527 = HalfAdd(r_PtxRegister620, r_PtxRegister621);					  // PTX L1956
	r_PackedHalf2AtPtx1960R529 = HalfAdd(r_PackedHalf2AtPtx1952R526, r_PackedHalf2AtPtx1956R527); // PTX L1960
	r_PackedHalf2AtPtx1964R530 = HalfAdd(r_PtxRegister624, r_PtxRegister625);					  // PTX L1964
	r_PtxRegister528 = HalfAdd(r_PackedHalf2AtPtx1960R529, r_PackedHalf2AtPtx1964R530);			  // PTX L1968
	r_PackedHalf2AtPtx1972R531 = HalfAdd(r_PtxRegister614, r_PtxRegister615);					  // PTX L1972
	r_PackedHalf2AtPtx1976R532 = HalfAdd(r_PtxRegister618, r_PtxRegister619);					  // PTX L1976
	r_PackedHalf2AtPtx1980R533 = HalfAdd(r_PackedHalf2AtPtx1972R531, r_PackedHalf2AtPtx1976R532); // PTX L1980
	r_PackedHalf2AtPtx1984R534 = HalfAdd(r_PtxRegister622, r_PtxRegister623);					  // PTX L1984
	r_PackedHalf2AtPtx1988R536 = HalfAdd(r_PackedHalf2AtPtx1980R533, r_PackedHalf2AtPtx1984R534); // PTX L1988
	r_PackedHalf2AtPtx1992R537 = HalfAdd(r_PtxRegister626, r_PtxRegister627);					  // PTX L1992
	r_PtxRegister535 = HalfAdd(r_PackedHalf2AtPtx1988R536, r_PackedHalf2AtPtx1992R537);			  // PTX L1996
	r_PtxU16Register77 = uint16_t(r_LaneIndexAtPtx1885);										  // PTX L1999
	r_PtxRegister814 = r_LaneIndexAtPtx1885 & 1;												  // PTX L2000
	r_bPtxPredicate27 = uint32_t(r_PtxRegister814) != uint32_t(0);								  // PTX L2001
	r_PtxRegister815 = r_bPtxPredicate27 ? r_PtxRegister521 : r_PtxRegister514;					  // PTX L2002
	r_PtxRegister816 = r_bPtxPredicate27 ? r_PtxRegister514 : r_PtxRegister521;					  // PTX L2003
	r_PtxRegister817 = r_bPtxPredicate27 ? r_PtxRegister535 : r_PtxRegister528;					  // PTX L2004
	r_PtxRegister818 = r_bPtxPredicate27 ? r_PtxRegister528 : r_PtxRegister535;					  // PTX L2005
	r_PtxU16Register78 = r_PtxU16Register77 & 2;												  // PTX L2006
	r_bPtxPredicate28 = uint16_t(r_PtxU16Register78) == uint16_t(0);							  // PTX L2007
	r_PtxRegister819 = r_bPtxPredicate28 ? r_PtxRegister815 : r_PtxRegister817;					  // PTX L2008
	r_PtxRegister820 = r_bPtxPredicate28 ? r_PtxRegister817 : r_PtxRegister815;					  // PTX L2009
	r_PtxRegister821 = r_bPtxPredicate28 ? r_PtxRegister816 : r_PtxRegister818;					  // PTX L2010
	r_PtxRegister822 = r_bPtxPredicate28 ? r_PtxRegister818 : r_PtxRegister816;					  // PTX L2011
	r_PtxRegister823 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1885), uint32_t(2));					  // PTX L2012
	r_PtxRegister824 = r_PtxRegister823 & 28;													  // PTX L2013
	r_PtxRegister825 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1885), uint32_t(3));			  // PTX L2014
	r_PtxRegister826 = uint32_t(r_PtxRegister824) + uint32_t(r_PtxRegister825);					  // PTX L2015
	r_PtxRegister827 =
		ShuffleIdxPredicate(r_bPtxPredicate29, r_PtxRegister819, r_PtxRegister826, 31, -1); // PTX L2016
	r_PtxRegister828 = r_PtxRegister826 ^ 1;												// PTX L2017
	r_PtxRegister829 =
		ShuffleIdxPredicate(r_bPtxPredicate30, r_PtxRegister821, r_PtxRegister828, 31, -1); // PTX L2018
	r_PtxRegister830 = r_PtxRegister826 ^ 2;												// PTX L2019
	r_PtxRegister831 =
		ShuffleIdxPredicate(r_bPtxPredicate31, r_PtxRegister820, r_PtxRegister830, 31, -1); // PTX L2020
	r_PtxRegister832 = r_PtxRegister826 ^ 3;												// PTX L2021
	r_PtxRegister833 =
		ShuffleIdxPredicate(r_bPtxPredicate32, r_PtxRegister822, r_PtxRegister832, 31, -1); // PTX L2022
	r_PtxU16Register79 = r_PtxU16Register77 & 8;											// PTX L2023
	r_bPtxPredicate33 = uint16_t(r_PtxU16Register79) == uint16_t(0);						// PTX L2024
	r_PtxRegister834 = r_bPtxPredicate33 ? r_PtxRegister827 : r_PtxRegister829;				// PTX L2025
	r_PtxRegister835 = r_bPtxPredicate33 ? r_PtxRegister829 : r_PtxRegister827;				// PTX L2026
	r_PtxRegister836 = r_bPtxPredicate33 ? r_PtxRegister831 : r_PtxRegister833;				// PTX L2027
	r_PtxRegister837 = r_bPtxPredicate33 ? r_PtxRegister833 : r_PtxRegister831;				// PTX L2028
	r_PtxU16Register80 = r_PtxU16Register77 & 16;											// PTX L2029
	r_bPtxPredicate34 = uint16_t(r_PtxU16Register80) == uint16_t(0);						// PTX L2030
	r_PtxRegister538 = r_bPtxPredicate34 ? r_PtxRegister834 : r_PtxRegister836;				// PTX L2031
	r_PtxRegister541 = r_bPtxPredicate34 ? r_PtxRegister836 : r_PtxRegister834;				// PTX L2032
	r_PtxRegister539 = r_bPtxPredicate34 ? r_PtxRegister835 : r_PtxRegister837;				// PTX L2033
	r_PtxRegister544 = r_bPtxPredicate34 ? r_PtxRegister837 : r_PtxRegister835;				// PTX L2034
	r_PackedHalf2AtPtx2036R540 = HalfAdd(r_PtxRegister538, r_PtxRegister539);				// PTX L2036
	r_PackedHalf2AtPtx2040R543 = HalfAdd(r_PackedHalf2AtPtx2036R540, r_PtxRegister541);		// PTX L2040
	r_PtxRegister542 = HalfAdd(r_PackedHalf2AtPtx2040R543, r_PtxRegister544);				// PTX L2044
	r_PtxU16Register81 = uint16_t(r_PtxRegister542);
	r_PtxU16Register82 = uint16_t(r_PtxRegister542 >> 16);										  // PTX L2047
	r_PackedHalf2AtPtx2048R546 = JoinHalfwords(r_PtxU16Register81, r_PtxU16Register81);			  // PTX L2048
	r_PackedHalf2AtPtx2049R547 = JoinHalfwords(r_PtxU16Register82, r_PtxU16Register82);			  // PTX L2049
	r_PtxRegister545 = HalfAdd(r_PackedHalf2AtPtx2048R546, r_PackedHalf2AtPtx2049R547);			  // PTX L2051
	r_PackedHalf2AtPtx2055R548 = HalfAdd(r_PtxRegister628, r_PtxRegister629);					  // PTX L2055
	r_PackedHalf2AtPtx2059R549 = HalfAdd(r_PtxRegister632, r_PtxRegister633);					  // PTX L2059
	r_PackedHalf2AtPtx2063R550 = HalfAdd(r_PackedHalf2AtPtx2055R548, r_PackedHalf2AtPtx2059R549); // PTX L2063
	r_PackedHalf2AtPtx2067R551 = HalfAdd(r_PtxRegister636, r_PtxRegister637);					  // PTX L2067
	r_PackedHalf2AtPtx2071R553 = HalfAdd(r_PackedHalf2AtPtx2063R550, r_PackedHalf2AtPtx2067R551); // PTX L2071
	r_PackedHalf2AtPtx2075R554 = HalfAdd(r_PtxRegister640, r_PtxRegister641);					  // PTX L2075
	r_PtxRegister552 = HalfAdd(r_PackedHalf2AtPtx2071R553, r_PackedHalf2AtPtx2075R554);			  // PTX L2079
	r_PackedHalf2AtPtx2083R555 = HalfAdd(r_PtxRegister630, r_PtxRegister631);					  // PTX L2083
	r_PackedHalf2AtPtx2087R556 = HalfAdd(r_PtxRegister634, r_PtxRegister635);					  // PTX L2087
	r_PackedHalf2AtPtx2091R557 = HalfAdd(r_PackedHalf2AtPtx2083R555, r_PackedHalf2AtPtx2087R556); // PTX L2091
	r_PackedHalf2AtPtx2095R558 = HalfAdd(r_PtxRegister638, r_PtxRegister639);					  // PTX L2095
	r_PackedHalf2AtPtx2099R560 = HalfAdd(r_PackedHalf2AtPtx2091R557, r_PackedHalf2AtPtx2095R558); // PTX L2099
	r_PackedHalf2AtPtx2103R561 = HalfAdd(r_PtxRegister642, r_PtxRegister643);					  // PTX L2103
	r_PtxRegister559 = HalfAdd(r_PackedHalf2AtPtx2099R560, r_PackedHalf2AtPtx2103R561);			  // PTX L2107
	r_PackedHalf2AtPtx2111R562 = HalfAdd(r_PtxRegister644, r_PtxRegister645);					  // PTX L2111
	r_PackedHalf2AtPtx2115R563 = HalfAdd(r_PtxRegister648, r_PtxRegister649);					  // PTX L2115
	r_PackedHalf2AtPtx2119R564 = HalfAdd(r_PackedHalf2AtPtx2111R562, r_PackedHalf2AtPtx2115R563); // PTX L2119
	r_PackedHalf2AtPtx2123R565 = HalfAdd(r_PtxRegister652, r_PtxRegister653);					  // PTX L2123
	r_PackedHalf2AtPtx2127R567 = HalfAdd(r_PackedHalf2AtPtx2119R564, r_PackedHalf2AtPtx2123R565); // PTX L2127
	r_PackedHalf2AtPtx2131R568 = HalfAdd(r_PtxRegister656, r_PtxRegister657);					  // PTX L2131
	r_PtxRegister566 = HalfAdd(r_PackedHalf2AtPtx2127R567, r_PackedHalf2AtPtx2131R568);			  // PTX L2135
	r_PackedHalf2AtPtx2139R569 = HalfAdd(r_PtxRegister646, r_PtxRegister647);					  // PTX L2139
	r_PackedHalf2AtPtx2143R570 = HalfAdd(r_PtxRegister650, r_PtxRegister651);					  // PTX L2143
	r_PackedHalf2AtPtx2147R571 = HalfAdd(r_PackedHalf2AtPtx2139R569, r_PackedHalf2AtPtx2143R570); // PTX L2147
	r_PackedHalf2AtPtx2151R572 = HalfAdd(r_PtxRegister654, r_PtxRegister655);					  // PTX L2151
	r_PackedHalf2AtPtx2155R574 = HalfAdd(r_PackedHalf2AtPtx2147R571, r_PackedHalf2AtPtx2151R572); // PTX L2155
	r_PackedHalf2AtPtx2159R575 = HalfAdd(r_PtxRegister658, r_PtxRegister659);					  // PTX L2159
	r_PtxRegister573 = HalfAdd(r_PackedHalf2AtPtx2155R574, r_PackedHalf2AtPtx2159R575);			  // PTX L2163
	r_PtxRegister838 = r_bPtxPredicate27 ? r_PtxRegister559 : r_PtxRegister552;					  // PTX L2166
	r_PtxRegister839 = r_bPtxPredicate27 ? r_PtxRegister552 : r_PtxRegister559;					  // PTX L2167
	r_PtxRegister840 = r_bPtxPredicate27 ? r_PtxRegister573 : r_PtxRegister566;					  // PTX L2168
	r_PtxRegister841 = r_bPtxPredicate27 ? r_PtxRegister566 : r_PtxRegister573;					  // PTX L2169
	r_PtxRegister842 = r_bPtxPredicate28 ? r_PtxRegister838 : r_PtxRegister840;					  // PTX L2170
	r_PtxRegister843 = r_bPtxPredicate28 ? r_PtxRegister840 : r_PtxRegister838;					  // PTX L2171
	r_PtxRegister844 = r_bPtxPredicate28 ? r_PtxRegister839 : r_PtxRegister841;					  // PTX L2172
	r_PtxRegister845 = r_bPtxPredicate28 ? r_PtxRegister841 : r_PtxRegister839;					  // PTX L2173
	r_PtxRegister846 =
		ShuffleIdxPredicate(r_bPtxPredicate35, r_PtxRegister842, r_PtxRegister826, 31, -1); // PTX L2174
	r_PtxRegister847 =
		ShuffleIdxPredicate(r_bPtxPredicate36, r_PtxRegister844, r_PtxRegister828, 31, -1); // PTX L2175
	r_PtxRegister848 =
		ShuffleIdxPredicate(r_bPtxPredicate37, r_PtxRegister843, r_PtxRegister830, 31, -1); // PTX L2176
	r_PtxRegister849 =
		ShuffleIdxPredicate(r_bPtxPredicate38, r_PtxRegister845, r_PtxRegister832, 31, -1); // PTX L2177
	r_PtxRegister850 = r_bPtxPredicate33 ? r_PtxRegister846 : r_PtxRegister847;				// PTX L2178
	r_PtxRegister851 = r_bPtxPredicate33 ? r_PtxRegister847 : r_PtxRegister846;				// PTX L2179
	r_PtxRegister852 = r_bPtxPredicate33 ? r_PtxRegister848 : r_PtxRegister849;				// PTX L2180
	r_PtxRegister853 = r_bPtxPredicate33 ? r_PtxRegister849 : r_PtxRegister848;				// PTX L2181
	r_PtxRegister576 = r_bPtxPredicate34 ? r_PtxRegister850 : r_PtxRegister852;				// PTX L2182
	r_PtxRegister579 = r_bPtxPredicate34 ? r_PtxRegister852 : r_PtxRegister850;				// PTX L2183
	r_PtxRegister577 = r_bPtxPredicate34 ? r_PtxRegister851 : r_PtxRegister853;				// PTX L2184
	r_PtxRegister582 = r_bPtxPredicate34 ? r_PtxRegister853 : r_PtxRegister851;				// PTX L2185
	r_PackedHalf2AtPtx2187R578 = HalfAdd(r_PtxRegister576, r_PtxRegister577);				// PTX L2187
	r_PackedHalf2AtPtx2191R581 = HalfAdd(r_PackedHalf2AtPtx2187R578, r_PtxRegister579);		// PTX L2191
	r_PtxRegister580 = HalfAdd(r_PackedHalf2AtPtx2191R581, r_PtxRegister582);				// PTX L2195
	r_PtxU16Register83 = uint16_t(r_PtxRegister580);
	r_PtxU16Register84 = uint16_t(r_PtxRegister580 >> 16);								// PTX L2198
	r_PackedHalf2AtPtx2199R584 = JoinHalfwords(r_PtxU16Register83, r_PtxU16Register83); // PTX L2199
	r_PackedHalf2AtPtx2200R585 = JoinHalfwords(r_PtxU16Register84, r_PtxU16Register84); // PTX L2200
	r_PtxRegister583 = HalfAdd(r_PackedHalf2AtPtx2199R584, r_PackedHalf2AtPtx2200R585); // PTX L2202
	r_PtxRegister587 = __byte_perm(r_PtxRegister545, r_PtxRegister583, 0x5410U);		// PTX L2205
	r_LaneIndexAtPtx2207 = uint32_t((threadIdx.x & 31u));								// PTX L2207
	r_PackedHalf2AtPtx434R1441 = HalfAdd(r_PackedHalf2AtPtx434R1441, r_PtxRegister587); // PTX L2210
	r_PtxRegister854 = uint32_t(4096u /* original named shared base */);				// PTX L2213
	r_PtxRegister29 = uint32_t(r_PtxRegister854) + uint32_t(r_PtxRegister741);			// PTX L2214
	r_LaneIndexAtPtx2216 = uint32_t((threadIdx.x & 31u));								// PTX L2216
	r_PtxRegister855 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2216), uint32_t(4));			// PTX L2218
	r_PtxRegister589 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister855);			// PTX L2219
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister589));
		r_MmaBE4x4WordAtPtx2221R660 = r_Value.x;
		r_MmaBE4x4WordAtPtx2221R661 = r_Value.y;
		r_MmaBE4x4WordAtPtx2221R666 = r_Value.z;
		r_MmaBE4x4WordAtPtx2221R667 = r_Value.w;
	} // PTX L2221
	r_LaneIndexAtPtx2224 = uint32_t((threadIdx.x & 31u));					   // PTX L2224
	r_PtxRegister856 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2224), uint32_t(4)); // PTX L2226
	r_PtxRegister857 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister856); // PTX L2227
	r_PtxRegister591 = uint32_t(r_PtxRegister857) + uint32_t(512);			   // PTX L2228
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister591));
		r_MmaBE4x4WordAtPtx2230R680 = r_Value.x;
		r_MmaBE4x4WordAtPtx2230R681 = r_Value.y;
		r_MmaBE4x4WordAtPtx2230R682 = r_Value.z;
		r_MmaBE4x4WordAtPtx2230R683 = r_Value.w;
	} // PTX L2230
	r_LaneIndexAtPtx2233 = uint32_t((threadIdx.x & 31u));					   // PTX L2233
	r_PtxRegister858 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2233), uint32_t(4)); // PTX L2235
	r_PtxRegister859 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister858); // PTX L2236
	r_PtxRegister593 = uint32_t(r_PtxRegister859) + uint32_t(1024);			   // PTX L2237
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister593));
		r_MmaBE4x4WordAtPtx2239R668 = r_Value.x;
		r_MmaBE4x4WordAtPtx2239R669 = r_Value.y;
		r_MmaBE4x4WordAtPtx2239R676 = r_Value.z;
		r_MmaBE4x4WordAtPtx2239R677 = r_Value.w;
	} // PTX L2239
	r_LaneIndexAtPtx2242 = uint32_t((threadIdx.x & 31u));					   // PTX L2242
	r_PtxRegister860 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2242), uint32_t(4)); // PTX L2244
	r_PtxRegister861 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister860); // PTX L2245
	r_PtxRegister595 = uint32_t(r_PtxRegister861) + uint32_t(1536);			   // PTX L2246
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister595));
		r_MmaBE4x4WordAtPtx2248R684 = r_Value.x;
		r_MmaBE4x4WordAtPtx2248R685 = r_Value.y;
		r_MmaBE4x4WordAtPtx2248R688 = r_Value.z;
		r_MmaBE4x4WordAtPtx2248R689 = r_Value.w;
	} // PTX L2248
	r_ConvertedE4PairAtPtx2251Rs13 = PublishE4(r_PtxRegister596); // PTX L2251
	r_ConvertedE4PairAtPtx2254Rs14 = PublishE4(r_PtxRegister597); // PTX L2254
	r_MmaAE4x4WordAtPtx2256R662 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2251Rs13, r_ConvertedE4PairAtPtx2254Rs14); // PTX L2256
	r_ConvertedE4PairAtPtx2258Rs15 = PublishE4(r_PtxRegister598);					   // PTX L2258
	r_ConvertedE4PairAtPtx2261Rs16 = PublishE4(r_PtxRegister599);					   // PTX L2261
	r_MmaAE4x4WordAtPtx2263R663 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2258Rs15, r_ConvertedE4PairAtPtx2261Rs16); // PTX L2263
	r_ConvertedE4PairAtPtx2265Rs17 = PublishE4(r_PtxRegister600);					   // PTX L2265
	r_ConvertedE4PairAtPtx2268Rs18 = PublishE4(r_PtxRegister601);					   // PTX L2268
	r_MmaAE4x4WordAtPtx2270R664 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2265Rs17, r_ConvertedE4PairAtPtx2268Rs18); // PTX L2270
	r_ConvertedE4PairAtPtx2272Rs19 = PublishE4(r_PtxRegister602);					   // PTX L2272
	r_ConvertedE4PairAtPtx2275Rs20 = PublishE4(r_PtxRegister603);					   // PTX L2275
	r_MmaAE4x4WordAtPtx2277R665 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2272Rs19, r_ConvertedE4PairAtPtx2275Rs20); // PTX L2277
	r_ConvertedE4PairAtPtx2279Rs21 = PublishE4(r_PtxRegister604);					   // PTX L2279
	r_ConvertedE4PairAtPtx2282Rs22 = PublishE4(r_PtxRegister605);					   // PTX L2282
	r_MmaAE4x4WordAtPtx2284R672 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2279Rs21, r_ConvertedE4PairAtPtx2282Rs22); // PTX L2284
	r_ConvertedE4PairAtPtx2286Rs23 = PublishE4(r_PtxRegister606);					   // PTX L2286
	r_ConvertedE4PairAtPtx2289Rs24 = PublishE4(r_PtxRegister607);					   // PTX L2289
	r_MmaAE4x4WordAtPtx2291R673 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2286Rs23, r_ConvertedE4PairAtPtx2289Rs24); // PTX L2291
	r_ConvertedE4PairAtPtx2293Rs25 = PublishE4(r_PtxRegister608);					   // PTX L2293
	r_ConvertedE4PairAtPtx2296Rs26 = PublishE4(r_PtxRegister609);					   // PTX L2296
	r_MmaAE4x4WordAtPtx2298R674 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2293Rs25, r_ConvertedE4PairAtPtx2296Rs26); // PTX L2298
	r_ConvertedE4PairAtPtx2300Rs27 = PublishE4(r_PtxRegister610);					   // PTX L2300
	r_ConvertedE4PairAtPtx2303Rs28 = PublishE4(r_PtxRegister611);					   // PTX L2303
	r_MmaAE4x4WordAtPtx2305R675 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2300Rs27, r_ConvertedE4PairAtPtx2303Rs28); // PTX L2305
	r_ConvertedE4PairAtPtx2307Rs29 = PublishE4(r_PtxRegister612);					   // PTX L2307
	r_ConvertedE4PairAtPtx2310Rs30 = PublishE4(r_PtxRegister613);					   // PTX L2310
	r_MmaAE4x4WordAtPtx2312R692 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2307Rs29, r_ConvertedE4PairAtPtx2310Rs30); // PTX L2312
	r_ConvertedE4PairAtPtx2314Rs31 = PublishE4(r_PtxRegister614);					   // PTX L2314
	r_ConvertedE4PairAtPtx2317Rs32 = PublishE4(r_PtxRegister615);					   // PTX L2317
	r_MmaAE4x4WordAtPtx2319R693 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2314Rs31, r_ConvertedE4PairAtPtx2317Rs32); // PTX L2319
	r_ConvertedE4PairAtPtx2321Rs33 = PublishE4(r_PtxRegister616);					   // PTX L2321
	r_ConvertedE4PairAtPtx2324Rs34 = PublishE4(r_PtxRegister617);					   // PTX L2324
	r_MmaAE4x4WordAtPtx2326R694 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2321Rs33, r_ConvertedE4PairAtPtx2324Rs34); // PTX L2326
	r_ConvertedE4PairAtPtx2328Rs35 = PublishE4(r_PtxRegister618);					   // PTX L2328
	r_ConvertedE4PairAtPtx2331Rs36 = PublishE4(r_PtxRegister619);					   // PTX L2331
	r_MmaAE4x4WordAtPtx2333R695 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2328Rs35, r_ConvertedE4PairAtPtx2331Rs36); // PTX L2333
	r_ConvertedE4PairAtPtx2335Rs37 = PublishE4(r_PtxRegister620);					   // PTX L2335
	r_ConvertedE4PairAtPtx2338Rs38 = PublishE4(r_PtxRegister621);					   // PTX L2338
	r_MmaAE4x4WordAtPtx2340R698 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2335Rs37, r_ConvertedE4PairAtPtx2338Rs38); // PTX L2340
	r_ConvertedE4PairAtPtx2342Rs39 = PublishE4(r_PtxRegister622);					   // PTX L2342
	r_ConvertedE4PairAtPtx2345Rs40 = PublishE4(r_PtxRegister623);					   // PTX L2345
	r_MmaAE4x4WordAtPtx2347R699 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2342Rs39, r_ConvertedE4PairAtPtx2345Rs40); // PTX L2347
	r_ConvertedE4PairAtPtx2349Rs41 = PublishE4(r_PtxRegister624);					   // PTX L2349
	r_ConvertedE4PairAtPtx2352Rs42 = PublishE4(r_PtxRegister625);					   // PTX L2352
	r_MmaAE4x4WordAtPtx2354R700 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2349Rs41, r_ConvertedE4PairAtPtx2352Rs42); // PTX L2354
	r_ConvertedE4PairAtPtx2356Rs43 = PublishE4(r_PtxRegister626);					   // PTX L2356
	r_ConvertedE4PairAtPtx2359Rs44 = PublishE4(r_PtxRegister627);					   // PTX L2359
	r_MmaAE4x4WordAtPtx2361R701 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2356Rs43, r_ConvertedE4PairAtPtx2359Rs44); // PTX L2361
	r_ConvertedE4PairAtPtx2363Rs45 = PublishE4(r_PtxRegister628);					   // PTX L2363
	r_ConvertedE4PairAtPtx2366Rs46 = PublishE4(r_PtxRegister629);					   // PTX L2366
	r_MmaAE4x4WordAtPtx2368R708 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2363Rs45, r_ConvertedE4PairAtPtx2366Rs46); // PTX L2368
	r_ConvertedE4PairAtPtx2370Rs47 = PublishE4(r_PtxRegister630);					   // PTX L2370
	r_ConvertedE4PairAtPtx2373Rs48 = PublishE4(r_PtxRegister631);					   // PTX L2373
	r_MmaAE4x4WordAtPtx2375R709 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2370Rs47, r_ConvertedE4PairAtPtx2373Rs48); // PTX L2375
	r_ConvertedE4PairAtPtx2377Rs49 = PublishE4(r_PtxRegister632);					   // PTX L2377
	r_ConvertedE4PairAtPtx2380Rs50 = PublishE4(r_PtxRegister633);					   // PTX L2380
	r_MmaAE4x4WordAtPtx2382R710 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2377Rs49, r_ConvertedE4PairAtPtx2380Rs50); // PTX L2382
	r_ConvertedE4PairAtPtx2384Rs51 = PublishE4(r_PtxRegister634);					   // PTX L2384
	r_ConvertedE4PairAtPtx2387Rs52 = PublishE4(r_PtxRegister635);					   // PTX L2387
	r_MmaAE4x4WordAtPtx2389R711 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2384Rs51, r_ConvertedE4PairAtPtx2387Rs52); // PTX L2389
	r_ConvertedE4PairAtPtx2391Rs53 = PublishE4(r_PtxRegister636);					   // PTX L2391
	r_ConvertedE4PairAtPtx2394Rs54 = PublishE4(r_PtxRegister637);					   // PTX L2394
	r_MmaAE4x4WordAtPtx2396R714 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2391Rs53, r_ConvertedE4PairAtPtx2394Rs54); // PTX L2396
	r_ConvertedE4PairAtPtx2398Rs55 = PublishE4(r_PtxRegister638);					   // PTX L2398
	r_ConvertedE4PairAtPtx2401Rs56 = PublishE4(r_PtxRegister639);					   // PTX L2401
	r_MmaAE4x4WordAtPtx2403R715 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2398Rs55, r_ConvertedE4PairAtPtx2401Rs56); // PTX L2403
	r_ConvertedE4PairAtPtx2405Rs57 = PublishE4(r_PtxRegister640);					   // PTX L2405
	r_ConvertedE4PairAtPtx2408Rs58 = PublishE4(r_PtxRegister641);					   // PTX L2408
	r_MmaAE4x4WordAtPtx2410R716 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2405Rs57, r_ConvertedE4PairAtPtx2408Rs58); // PTX L2410
	r_ConvertedE4PairAtPtx2412Rs59 = PublishE4(r_PtxRegister642);					   // PTX L2412
	r_ConvertedE4PairAtPtx2415Rs60 = PublishE4(r_PtxRegister643);					   // PTX L2415
	r_MmaAE4x4WordAtPtx2417R717 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2412Rs59, r_ConvertedE4PairAtPtx2415Rs60); // PTX L2417
	r_ConvertedE4PairAtPtx2419Rs61 = PublishE4(r_PtxRegister644);					   // PTX L2419
	r_ConvertedE4PairAtPtx2422Rs62 = PublishE4(r_PtxRegister645);					   // PTX L2422
	r_MmaAE4x4WordAtPtx2424R724 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2419Rs61, r_ConvertedE4PairAtPtx2422Rs62); // PTX L2424
	r_ConvertedE4PairAtPtx2426Rs63 = PublishE4(r_PtxRegister646);					   // PTX L2426
	r_ConvertedE4PairAtPtx2429Rs64 = PublishE4(r_PtxRegister647);					   // PTX L2429
	r_MmaAE4x4WordAtPtx2431R725 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2426Rs63, r_ConvertedE4PairAtPtx2429Rs64); // PTX L2431
	r_ConvertedE4PairAtPtx2433Rs65 = PublishE4(r_PtxRegister648);					   // PTX L2433
	r_ConvertedE4PairAtPtx2436Rs66 = PublishE4(r_PtxRegister649);					   // PTX L2436
	r_MmaAE4x4WordAtPtx2438R726 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2433Rs65, r_ConvertedE4PairAtPtx2436Rs66); // PTX L2438
	r_ConvertedE4PairAtPtx2440Rs67 = PublishE4(r_PtxRegister650);					   // PTX L2440
	r_ConvertedE4PairAtPtx2443Rs68 = PublishE4(r_PtxRegister651);					   // PTX L2443
	r_MmaAE4x4WordAtPtx2445R727 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2440Rs67, r_ConvertedE4PairAtPtx2443Rs68); // PTX L2445
	r_ConvertedE4PairAtPtx2447Rs69 = PublishE4(r_PtxRegister652);					   // PTX L2447
	r_ConvertedE4PairAtPtx2450Rs70 = PublishE4(r_PtxRegister653);					   // PTX L2450
	r_MmaAE4x4WordAtPtx2452R730 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2447Rs69, r_ConvertedE4PairAtPtx2450Rs70); // PTX L2452
	r_ConvertedE4PairAtPtx2454Rs71 = PublishE4(r_PtxRegister654);					   // PTX L2454
	r_ConvertedE4PairAtPtx2457Rs72 = PublishE4(r_PtxRegister655);					   // PTX L2457
	r_MmaAE4x4WordAtPtx2459R731 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2454Rs71, r_ConvertedE4PairAtPtx2457Rs72); // PTX L2459
	r_ConvertedE4PairAtPtx2461Rs73 = PublishE4(r_PtxRegister656);					   // PTX L2461
	r_ConvertedE4PairAtPtx2464Rs74 = PublishE4(r_PtxRegister657);					   // PTX L2464
	r_MmaAE4x4WordAtPtx2466R732 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2461Rs73, r_ConvertedE4PairAtPtx2464Rs74); // PTX L2466
	r_ConvertedE4PairAtPtx2468Rs75 = PublishE4(r_PtxRegister658);					   // PTX L2468
	r_ConvertedE4PairAtPtx2471Rs76 = PublishE4(r_PtxRegister659);					   // PTX L2471
	r_MmaAE4x4WordAtPtx2473R733 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2468Rs75, r_ConvertedE4PairAtPtx2471Rs76); // PTX L2473
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2475R670, r_MmaAccumulatorHalf2WordAtPtx2475R671,
		  r_MmaAE4x4WordAtPtx2256R662, r_MmaAE4x4WordAtPtx2263R663, r_MmaAE4x4WordAtPtx2270R664,
		  r_MmaAE4x4WordAtPtx2277R665, r_MmaBE4x4WordAtPtx2221R660, r_MmaBE4x4WordAtPtx2221R661,
		  r_MmaAccumulatorHalf2WordAtPtx435R1409,
		  r_MmaAccumulatorHalf2WordAtPtx436R1410); // PTX L2475
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2482R678, r_MmaAccumulatorHalf2WordAtPtx2482R679,
		  r_MmaAE4x4WordAtPtx2256R662, r_MmaAE4x4WordAtPtx2263R663, r_MmaAE4x4WordAtPtx2270R664,
		  r_MmaAE4x4WordAtPtx2277R665, r_MmaBE4x4WordAtPtx2221R666, r_MmaBE4x4WordAtPtx2221R667,
		  r_MmaAccumulatorHalf2WordAtPtx437R1411,
		  r_MmaAccumulatorHalf2WordAtPtx438R1412); // PTX L2482
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx435R1409, r_MmaAccumulatorHalf2WordAtPtx436R1410,
		  r_MmaAE4x4WordAtPtx2284R672, r_MmaAE4x4WordAtPtx2291R673, r_MmaAE4x4WordAtPtx2298R674,
		  r_MmaAE4x4WordAtPtx2305R675, r_MmaBE4x4WordAtPtx2239R668, r_MmaBE4x4WordAtPtx2239R669,
		  r_MmaAccumulatorHalf2WordAtPtx2475R670,
		  r_MmaAccumulatorHalf2WordAtPtx2475R671); // PTX L2489
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx437R1411, r_MmaAccumulatorHalf2WordAtPtx438R1412,
		  r_MmaAE4x4WordAtPtx2284R672, r_MmaAE4x4WordAtPtx2291R673, r_MmaAE4x4WordAtPtx2298R674,
		  r_MmaAE4x4WordAtPtx2305R675, r_MmaBE4x4WordAtPtx2239R676, r_MmaBE4x4WordAtPtx2239R677,
		  r_MmaAccumulatorHalf2WordAtPtx2482R678,
		  r_MmaAccumulatorHalf2WordAtPtx2482R679); // PTX L2496
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2503R686, r_MmaAccumulatorHalf2WordAtPtx2503R687,
		  r_MmaAE4x4WordAtPtx2256R662, r_MmaAE4x4WordAtPtx2263R663, r_MmaAE4x4WordAtPtx2270R664,
		  r_MmaAE4x4WordAtPtx2277R665, r_MmaBE4x4WordAtPtx2230R680, r_MmaBE4x4WordAtPtx2230R681,
		  r_MmaAccumulatorHalf2WordAtPtx439R1413,
		  r_MmaAccumulatorHalf2WordAtPtx440R1414); // PTX L2503
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2510R690, r_MmaAccumulatorHalf2WordAtPtx2510R691,
		  r_MmaAE4x4WordAtPtx2256R662, r_MmaAE4x4WordAtPtx2263R663, r_MmaAE4x4WordAtPtx2270R664,
		  r_MmaAE4x4WordAtPtx2277R665, r_MmaBE4x4WordAtPtx2230R682, r_MmaBE4x4WordAtPtx2230R683,
		  r_MmaAccumulatorHalf2WordAtPtx441R1415,
		  r_MmaAccumulatorHalf2WordAtPtx442R1416); // PTX L2510
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx439R1413, r_MmaAccumulatorHalf2WordAtPtx440R1414,
		  r_MmaAE4x4WordAtPtx2284R672, r_MmaAE4x4WordAtPtx2291R673, r_MmaAE4x4WordAtPtx2298R674,
		  r_MmaAE4x4WordAtPtx2305R675, r_MmaBE4x4WordAtPtx2248R684, r_MmaBE4x4WordAtPtx2248R685,
		  r_MmaAccumulatorHalf2WordAtPtx2503R686,
		  r_MmaAccumulatorHalf2WordAtPtx2503R687); // PTX L2517
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx441R1415, r_MmaAccumulatorHalf2WordAtPtx442R1416,
		  r_MmaAE4x4WordAtPtx2284R672, r_MmaAE4x4WordAtPtx2291R673, r_MmaAE4x4WordAtPtx2298R674,
		  r_MmaAE4x4WordAtPtx2305R675, r_MmaBE4x4WordAtPtx2248R688, r_MmaBE4x4WordAtPtx2248R689,
		  r_MmaAccumulatorHalf2WordAtPtx2510R690,
		  r_MmaAccumulatorHalf2WordAtPtx2510R691); // PTX L2524
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2531R696, r_MmaAccumulatorHalf2WordAtPtx2531R697,
		  r_MmaAE4x4WordAtPtx2312R692, r_MmaAE4x4WordAtPtx2319R693, r_MmaAE4x4WordAtPtx2326R694,
		  r_MmaAE4x4WordAtPtx2333R695, r_MmaBE4x4WordAtPtx2221R660, r_MmaBE4x4WordAtPtx2221R661,
		  r_MmaAccumulatorHalf2WordAtPtx443R1417,
		  r_MmaAccumulatorHalf2WordAtPtx444R1418); // PTX L2531
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2538R702, r_MmaAccumulatorHalf2WordAtPtx2538R703,
		  r_MmaAE4x4WordAtPtx2312R692, r_MmaAE4x4WordAtPtx2319R693, r_MmaAE4x4WordAtPtx2326R694,
		  r_MmaAE4x4WordAtPtx2333R695, r_MmaBE4x4WordAtPtx2221R666, r_MmaBE4x4WordAtPtx2221R667,
		  r_MmaAccumulatorHalf2WordAtPtx445R1419,
		  r_MmaAccumulatorHalf2WordAtPtx446R1420); // PTX L2538
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx443R1417, r_MmaAccumulatorHalf2WordAtPtx444R1418,
		  r_MmaAE4x4WordAtPtx2340R698, r_MmaAE4x4WordAtPtx2347R699, r_MmaAE4x4WordAtPtx2354R700,
		  r_MmaAE4x4WordAtPtx2361R701, r_MmaBE4x4WordAtPtx2239R668, r_MmaBE4x4WordAtPtx2239R669,
		  r_MmaAccumulatorHalf2WordAtPtx2531R696,
		  r_MmaAccumulatorHalf2WordAtPtx2531R697); // PTX L2545
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx445R1419, r_MmaAccumulatorHalf2WordAtPtx446R1420,
		  r_MmaAE4x4WordAtPtx2340R698, r_MmaAE4x4WordAtPtx2347R699, r_MmaAE4x4WordAtPtx2354R700,
		  r_MmaAE4x4WordAtPtx2361R701, r_MmaBE4x4WordAtPtx2239R676, r_MmaBE4x4WordAtPtx2239R677,
		  r_MmaAccumulatorHalf2WordAtPtx2538R702,
		  r_MmaAccumulatorHalf2WordAtPtx2538R703); // PTX L2552
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2559R704, r_MmaAccumulatorHalf2WordAtPtx2559R705,
		  r_MmaAE4x4WordAtPtx2312R692, r_MmaAE4x4WordAtPtx2319R693, r_MmaAE4x4WordAtPtx2326R694,
		  r_MmaAE4x4WordAtPtx2333R695, r_MmaBE4x4WordAtPtx2230R680, r_MmaBE4x4WordAtPtx2230R681,
		  r_MmaAccumulatorHalf2WordAtPtx447R1421,
		  r_MmaAccumulatorHalf2WordAtPtx448R1422); // PTX L2559
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2566R706, r_MmaAccumulatorHalf2WordAtPtx2566R707,
		  r_MmaAE4x4WordAtPtx2312R692, r_MmaAE4x4WordAtPtx2319R693, r_MmaAE4x4WordAtPtx2326R694,
		  r_MmaAE4x4WordAtPtx2333R695, r_MmaBE4x4WordAtPtx2230R682, r_MmaBE4x4WordAtPtx2230R683,
		  r_MmaAccumulatorHalf2WordAtPtx449R1423,
		  r_MmaAccumulatorHalf2WordAtPtx450R1424); // PTX L2566
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx447R1421, r_MmaAccumulatorHalf2WordAtPtx448R1422,
		  r_MmaAE4x4WordAtPtx2340R698, r_MmaAE4x4WordAtPtx2347R699, r_MmaAE4x4WordAtPtx2354R700,
		  r_MmaAE4x4WordAtPtx2361R701, r_MmaBE4x4WordAtPtx2248R684, r_MmaBE4x4WordAtPtx2248R685,
		  r_MmaAccumulatorHalf2WordAtPtx2559R704,
		  r_MmaAccumulatorHalf2WordAtPtx2559R705); // PTX L2573
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx449R1423, r_MmaAccumulatorHalf2WordAtPtx450R1424,
		  r_MmaAE4x4WordAtPtx2340R698, r_MmaAE4x4WordAtPtx2347R699, r_MmaAE4x4WordAtPtx2354R700,
		  r_MmaAE4x4WordAtPtx2361R701, r_MmaBE4x4WordAtPtx2248R688, r_MmaBE4x4WordAtPtx2248R689,
		  r_MmaAccumulatorHalf2WordAtPtx2566R706,
		  r_MmaAccumulatorHalf2WordAtPtx2566R707); // PTX L2580
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2587R712, r_MmaAccumulatorHalf2WordAtPtx2587R713,
		  r_MmaAE4x4WordAtPtx2368R708, r_MmaAE4x4WordAtPtx2375R709, r_MmaAE4x4WordAtPtx2382R710,
		  r_MmaAE4x4WordAtPtx2389R711, r_MmaBE4x4WordAtPtx2221R660, r_MmaBE4x4WordAtPtx2221R661,
		  r_MmaAccumulatorHalf2WordAtPtx451R1425,
		  r_MmaAccumulatorHalf2WordAtPtx452R1426); // PTX L2587
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2594R718, r_MmaAccumulatorHalf2WordAtPtx2594R719,
		  r_MmaAE4x4WordAtPtx2368R708, r_MmaAE4x4WordAtPtx2375R709, r_MmaAE4x4WordAtPtx2382R710,
		  r_MmaAE4x4WordAtPtx2389R711, r_MmaBE4x4WordAtPtx2221R666, r_MmaBE4x4WordAtPtx2221R667,
		  r_MmaAccumulatorHalf2WordAtPtx453R1427,
		  r_MmaAccumulatorHalf2WordAtPtx454R1428); // PTX L2594
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx451R1425, r_MmaAccumulatorHalf2WordAtPtx452R1426,
		  r_MmaAE4x4WordAtPtx2396R714, r_MmaAE4x4WordAtPtx2403R715, r_MmaAE4x4WordAtPtx2410R716,
		  r_MmaAE4x4WordAtPtx2417R717, r_MmaBE4x4WordAtPtx2239R668, r_MmaBE4x4WordAtPtx2239R669,
		  r_MmaAccumulatorHalf2WordAtPtx2587R712,
		  r_MmaAccumulatorHalf2WordAtPtx2587R713); // PTX L2601
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx453R1427, r_MmaAccumulatorHalf2WordAtPtx454R1428,
		  r_MmaAE4x4WordAtPtx2396R714, r_MmaAE4x4WordAtPtx2403R715, r_MmaAE4x4WordAtPtx2410R716,
		  r_MmaAE4x4WordAtPtx2417R717, r_MmaBE4x4WordAtPtx2239R676, r_MmaBE4x4WordAtPtx2239R677,
		  r_MmaAccumulatorHalf2WordAtPtx2594R718,
		  r_MmaAccumulatorHalf2WordAtPtx2594R719); // PTX L2608
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2615R720, r_MmaAccumulatorHalf2WordAtPtx2615R721,
		  r_MmaAE4x4WordAtPtx2368R708, r_MmaAE4x4WordAtPtx2375R709, r_MmaAE4x4WordAtPtx2382R710,
		  r_MmaAE4x4WordAtPtx2389R711, r_MmaBE4x4WordAtPtx2230R680, r_MmaBE4x4WordAtPtx2230R681,
		  r_MmaAccumulatorHalf2WordAtPtx455R1429,
		  r_MmaAccumulatorHalf2WordAtPtx456R1430); // PTX L2615
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2622R722, r_MmaAccumulatorHalf2WordAtPtx2622R723,
		  r_MmaAE4x4WordAtPtx2368R708, r_MmaAE4x4WordAtPtx2375R709, r_MmaAE4x4WordAtPtx2382R710,
		  r_MmaAE4x4WordAtPtx2389R711, r_MmaBE4x4WordAtPtx2230R682, r_MmaBE4x4WordAtPtx2230R683,
		  r_MmaAccumulatorHalf2WordAtPtx457R1431,
		  r_MmaAccumulatorHalf2WordAtPtx458R1432); // PTX L2622
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx455R1429, r_MmaAccumulatorHalf2WordAtPtx456R1430,
		  r_MmaAE4x4WordAtPtx2396R714, r_MmaAE4x4WordAtPtx2403R715, r_MmaAE4x4WordAtPtx2410R716,
		  r_MmaAE4x4WordAtPtx2417R717, r_MmaBE4x4WordAtPtx2248R684, r_MmaBE4x4WordAtPtx2248R685,
		  r_MmaAccumulatorHalf2WordAtPtx2615R720,
		  r_MmaAccumulatorHalf2WordAtPtx2615R721); // PTX L2629
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx457R1431, r_MmaAccumulatorHalf2WordAtPtx458R1432,
		  r_MmaAE4x4WordAtPtx2396R714, r_MmaAE4x4WordAtPtx2403R715, r_MmaAE4x4WordAtPtx2410R716,
		  r_MmaAE4x4WordAtPtx2417R717, r_MmaBE4x4WordAtPtx2248R688, r_MmaBE4x4WordAtPtx2248R689,
		  r_MmaAccumulatorHalf2WordAtPtx2622R722,
		  r_MmaAccumulatorHalf2WordAtPtx2622R723); // PTX L2636
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2643R728, r_MmaAccumulatorHalf2WordAtPtx2643R729,
		  r_MmaAE4x4WordAtPtx2424R724, r_MmaAE4x4WordAtPtx2431R725, r_MmaAE4x4WordAtPtx2438R726,
		  r_MmaAE4x4WordAtPtx2445R727, r_MmaBE4x4WordAtPtx2221R660, r_MmaBE4x4WordAtPtx2221R661,
		  r_MmaAccumulatorHalf2WordAtPtx459R1433,
		  r_MmaAccumulatorHalf2WordAtPtx460R1434); // PTX L2643
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2650R734, r_MmaAccumulatorHalf2WordAtPtx2650R735,
		  r_MmaAE4x4WordAtPtx2424R724, r_MmaAE4x4WordAtPtx2431R725, r_MmaAE4x4WordAtPtx2438R726,
		  r_MmaAE4x4WordAtPtx2445R727, r_MmaBE4x4WordAtPtx2221R666, r_MmaBE4x4WordAtPtx2221R667,
		  r_MmaAccumulatorHalf2WordAtPtx461R1435,
		  r_MmaAccumulatorHalf2WordAtPtx462R1436); // PTX L2650
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx459R1433, r_MmaAccumulatorHalf2WordAtPtx460R1434,
		  r_MmaAE4x4WordAtPtx2452R730, r_MmaAE4x4WordAtPtx2459R731, r_MmaAE4x4WordAtPtx2466R732,
		  r_MmaAE4x4WordAtPtx2473R733, r_MmaBE4x4WordAtPtx2239R668, r_MmaBE4x4WordAtPtx2239R669,
		  r_MmaAccumulatorHalf2WordAtPtx2643R728,
		  r_MmaAccumulatorHalf2WordAtPtx2643R729); // PTX L2657
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx461R1435, r_MmaAccumulatorHalf2WordAtPtx462R1436,
		  r_MmaAE4x4WordAtPtx2452R730, r_MmaAE4x4WordAtPtx2459R731, r_MmaAE4x4WordAtPtx2466R732,
		  r_MmaAE4x4WordAtPtx2473R733, r_MmaBE4x4WordAtPtx2239R676, r_MmaBE4x4WordAtPtx2239R677,
		  r_MmaAccumulatorHalf2WordAtPtx2650R734,
		  r_MmaAccumulatorHalf2WordAtPtx2650R735); // PTX L2664
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2671R736, r_MmaAccumulatorHalf2WordAtPtx2671R737,
		  r_MmaAE4x4WordAtPtx2424R724, r_MmaAE4x4WordAtPtx2431R725, r_MmaAE4x4WordAtPtx2438R726,
		  r_MmaAE4x4WordAtPtx2445R727, r_MmaBE4x4WordAtPtx2230R680, r_MmaBE4x4WordAtPtx2230R681,
		  r_MmaAccumulatorHalf2WordAtPtx463R1437,
		  r_MmaAccumulatorHalf2WordAtPtx464R1438); // PTX L2671
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2678R738, r_MmaAccumulatorHalf2WordAtPtx2678R739,
		  r_MmaAE4x4WordAtPtx2424R724, r_MmaAE4x4WordAtPtx2431R725, r_MmaAE4x4WordAtPtx2438R726,
		  r_MmaAE4x4WordAtPtx2445R727, r_MmaBE4x4WordAtPtx2230R682, r_MmaBE4x4WordAtPtx2230R683,
		  r_MmaAccumulatorHalf2WordAtPtx465R1439,
		  r_MmaAccumulatorHalf2WordAtPtx466R1440); // PTX L2678
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx463R1437, r_MmaAccumulatorHalf2WordAtPtx464R1438,
		  r_MmaAE4x4WordAtPtx2452R730, r_MmaAE4x4WordAtPtx2459R731, r_MmaAE4x4WordAtPtx2466R732,
		  r_MmaAE4x4WordAtPtx2473R733, r_MmaBE4x4WordAtPtx2248R684, r_MmaBE4x4WordAtPtx2248R685,
		  r_MmaAccumulatorHalf2WordAtPtx2671R736,
		  r_MmaAccumulatorHalf2WordAtPtx2671R737); // PTX L2685
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx465R1439, r_MmaAccumulatorHalf2WordAtPtx466R1440,
		  r_MmaAE4x4WordAtPtx2452R730, r_MmaAE4x4WordAtPtx2459R731, r_MmaAE4x4WordAtPtx2466R732,
		  r_MmaAE4x4WordAtPtx2473R733, r_MmaBE4x4WordAtPtx2248R688, r_MmaBE4x4WordAtPtx2248R689,
		  r_MmaAccumulatorHalf2WordAtPtx2678R738,
		  r_MmaAccumulatorHalf2WordAtPtx2678R739);								// PTX L2692
	r_PtxRegister30 = uint32_t(r_PtxRegister1407) + uint32_t(2);				// PTX L2698
	r_bPtxPredicate39 = int32_t(r_PtxRegister30) >= int32_t(r_PtxRegister1388); // PTX L2699
	if (r_bPtxPredicate39)
	{
		goto L__BB55_59;
	} // PTX L2700
	r_CtaXAtPtx2701 = uint32_t(blockIdx.x);													 // PTX L2701
	r_ThreadXAtPtx2702 = uint32_t(threadIdx.x);												 // PTX L2702
	r_ThreadYAtPtx2703 = uint32_t(threadIdx.y);												 // PTX L2703
	r_PtxRegister863 = r_ThreadXAtPtx2702 | r_ThreadYAtPtx2703;								 // PTX L2704
	r_ThreadZAtPtx2705 = uint32_t(threadIdx.z);												 // PTX L2705
	r_PtxRegister865 = r_PtxRegister863 | r_ThreadZAtPtx2705;								 // PTX L2706
	r_bPtxPredicate40 = uint32_t(r_PtxRegister865) != uint32_t(0);							 // PTX L2707
	r_PtxRegister1408 = ShiftRight(uint32_t(r_PtxRegister30), uint32_t(1));					 // PTX L2708
	r_PtxRegister866 = r_PtxRegister1408 & 33554431;										 // PTX L2709
	r_PtxRegister867 = uint32_t(r_PtxRegister866) + uint32_t(1);							 // PTX L2710
	r_PtxRegister868 = uint32_t(min(int32_t(r_PtxRegister867), int32_t(r_PtxRegister1387))); // PTX L2711
	r_bPtxPredicate41 = int32_t(r_PtxRegister1408) >= int32_t(r_PtxRegister868);			 // PTX L2712
	r_bPtxPredicate42 = r_bPtxPredicate40 | r_bPtxPredicate41;								 // PTX L2713
	if (r_bPtxPredicate42)
	{
		goto L__BB55_51;
	} // PTX L2714
	goto L__BB55_47;																		   // PTX L2715
L__BB55_51:																					   // PTX L2716
	r_PtxRegister33 = ShiftLeft(uint32_t(r_ThreadYAtPtx2703), uint32_t(7));					   // PTX L2717
	__syncthreads();																		   // PTX L2718
	r_PtxRegister873 = ShiftLeft(uint32_t(r_PtxRegister30), uint32_t(2));					   // PTX L2719
	r_PtxRegister874 = uint32_t(r_ThreadYAtPtx2703) + uint32_t(r_PtxRegister873);			   // PTX L2720
	r_bPtxPredicate45 = int32_t(r_PtxRegister874) >= int32_t(r_PtxRegister5);				   // PTX L2721
	r_bPtxPredicate46 = int32_t(r_PtxRegister874) < int32_t(r_PtxRegister5);				   // PTX L2722
	r_PtxRegister875 = ShiftLeft(uint32_t(r_PtxRegister874), uint32_t(5));					   // PTX L2723
	r_PtxRegister876 = uint32_t(r_PtxRegister875) + uint32_t(r_CtaXAtPtx2701);				   // PTX L2724
	r_PtxU64Register44 = uint64_t(int64_t(int32_t(r_PtxRegister876)) * int64_t(int32_t(128))); // PTX L2725
	r_PtxU64Register7 = r_bPtxPredicate46 ? r_PtxU64Register44 : 0;							   // PTX L2726
	r_PtxRegister877 = ShiftLeft(uint32_t(r_PtxRegister27), uint32_t(3));					   // PTX L2727
	r_PtxRegister878 = uint32_t(8192u /* original named shared base */);					   // PTX L2728
	r_PtxRegister913 = uint32_t(r_PtxRegister878) + uint32_t(r_PtxRegister877);				   // PTX L2729
	if (r_bPtxPredicate45)
	{
		goto L__BB55_54;
	} // PTX L2730
	r_PtxRegister888 = uint32_t(-1);							   // PTX L2731
	r_PtxRegister887 = Elected(r_PtxRegister888);				   // PTX L2733
	r_bPtxPredicate47 = uint32_t(r_PtxRegister887) == uint32_t(0); // PTX L2739
	if (r_bPtxPredicate47)
	{
		goto L__BB55_55;
	} // PTX L2740
	r_PtxRegister891 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(2));			  // PTX L2741
	r_PtxRegister889 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister891);		  // PTX L2742
	r_PtxU64Register46 = r_KBits;													  // PTX L2743
	r_PtxU64Register47 = ShiftLeft(uint64_t(r_PtxU64Register7), uint32_t(2));		  // PTX L2744
	r_PtxU64Register45 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register47); // PTX L2745
	r_PtxRegister890 = uint32_t(512);												  // PTX L2746
	CopyBulk(s_SharedStorage, r_PtxRegister889, r_PtxU64Register45, r_PtxRegister890,
			 r_PtxRegister913);													// PTX L2748
	BarrierExpect(s_SharedStorage, r_PtxRegister913, r_PtxRegister890);			// PTX L2751
	goto L__BB55_55;															// PTX L2753
L__BB55_50:																		// PTX L2754
	r_PtxRegister1408 = uint32_t(r_PtxRegister1408) + uint32_t(1);				// PTX L2755
	r_bPtxPredicate44 = int32_t(r_PtxRegister1408) < int32_t(r_PtxRegister868); // PTX L2756
	if (r_bPtxPredicate44)
	{
		goto L__BB55_47;
	} // PTX L2757
	goto L__BB55_51;																		// PTX L2758
L__BB55_47:																					// PTX L2759
	r_PtxRegister869 = ShiftLeft(uint32_t(r_PtxRegister1408), uint32_t(4));					// PTX L2760
	r_PtxRegister870 = ShiftRight(uint32_t(r_CtaXAtPtx2701), uint32_t(1));					// PTX L2761
	r_PtxRegister871 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister870);				// PTX L2762
	r_PtxU64Register42 = uint64_t(uint32_t(r_PtxRegister871)) * uint64_t(uint32_t(4));		// PTX L2763
	r_PtxU64Register43 = uint64_t(r_PredecessorCounterBits) + uint64_t(r_PtxU64Register42); // PTX L2764
L__BB55_48:																					// PTX L2765
	r_PtxRegister872 = CounterLoadRelaxed(r_PtxU64Register43);								// PTX L2767
	r_bPtxPredicate43 = int32_t(r_PtxRegister872) > int32_t(-1);							// PTX L2769
	if (r_bPtxPredicate43)
	{
		goto L__BB55_50;
	} // PTX L2770
	r_PtxRegister1383 = uint32_t(64);														   // PTX L2771
	PollSleep(r_PtxRegister1383);															   // PTX L2773
	goto L__BB55_48;																		   // PTX L2775
L__BB55_54:																					   // PTX L2776
	r_PtxRegister879 = uint32_t(0);															   // PTX L2777
	r_PtxU16Register85 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister879))); // PTX L2779
	r_PackedHalf2AtPtx2782R880 = JoinHalfwords(r_PtxU16Register85, r_PtxU16Register85);		   // PTX L2782
	r_ConvertedE4PairAtPtx2784Rs86 = PublishE4(r_PackedHalf2AtPtx2782R880);					   // PTX L2784
	r_PackedE4WordAtPtx2786R883 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2784Rs86, r_ConvertedE4PairAtPtx2784Rs86); // PTX L2786
	r_LaneIndexAtPtx2788 = uint32_t((threadIdx.x & 31u));							   // PTX L2788
	r_PtxRegister884 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(2));			   // PTX L2790
	r_PtxRegister885 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister884);		   // PTX L2791
	r_PtxRegister886 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2788), uint32_t(4));		   // PTX L2792
	r_PtxRegister882 = uint32_t(r_PtxRegister885) + uint32_t(r_PtxRegister886);		   // PTX L2793
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister882)) =
		make_uint4(r_PackedE4WordAtPtx2786R883, r_PackedE4WordAtPtx2786R883, r_PackedE4WordAtPtx2786R883,
				   r_PackedE4WordAtPtx2786R883);								// PTX L2795
L__BB55_55:																		// PTX L2797
	r_bPtxPredicate48 = uint32_t(r_PtxRegister26) == uint32_t(32);				// PTX L2798
	r_PtxRegister892 = ShiftLeft(uint32_t(r_PtxRegister30), uint32_t(1));		// PTX L2799
	r_PtxRegister893 = ShiftRight(uint32_t(r_ThreadYAtPtx2703), uint32_t(1));	// PTX L2800
	r_PtxRegister894 = uint32_t(r_PtxRegister893) + uint32_t(r_PtxRegister892); // PTX L2801
	r_bPtxPredicate49 = int32_t(r_PtxRegister894) < int32_t(r_PtxRegister6);	// PTX L2802
	r_bPtxPredicate50 = r_bPtxPredicate48 | r_bPtxPredicate49;					// PTX L2803
	r_PtxRegister895 = ShiftLeft(uint32_t(r_PtxRegister894), uint32_t(13));		// PTX L2804
	r_PtxRegister896 = r_bPtxPredicate48 ? 0 : r_PtxRegister895;				// PTX L2805
	r_PtxRegister897 = ShiftLeft(uint32_t(r_CtaXAtPtx2701), uint32_t(8));		// PTX L2806
	r_PtxRegister898 = r_PtxRegister33 & 128;									// PTX L2807
	r_PtxRegister899 = r_PtxRegister897 | r_PtxRegister898;						// PTX L2808
	r_PtxRegister900 = uint32_t(r_PtxRegister896) + uint32_t(r_PtxRegister899); // PTX L2809
	r_PtxU64Register48 = SignExtendWordBits(r_PtxRegister900);					// PTX L2810
	r_PtxU64Register8 = r_bPtxPredicate50 ? r_PtxU64Register48 : 0;				// PTX L2811
	r_bPtxPredicate51 = !r_bPtxPredicate50;										// PTX L2812
	if (r_bPtxPredicate51)
	{
		goto L__BB55_58;
	} // PTX L2813
	r_PtxRegister910 = uint32_t(-1);							   // PTX L2814
	r_PtxRegister909 = Elected(r_PtxRegister910);				   // PTX L2816
	r_bPtxPredicate52 = uint32_t(r_PtxRegister909) == uint32_t(0); // PTX L2822
	if (r_bPtxPredicate52)
	{
		goto L__BB55_59;
	} // PTX L2823
	r_PtxRegister914 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(2));			  // PTX L2824
	r_PtxRegister911 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister914);		  // PTX L2825
	r_PtxU64Register50 = r_VBits;													  // PTX L2826
	r_PtxU64Register51 = ShiftLeft(uint64_t(r_PtxU64Register8), uint32_t(2));		  // PTX L2827
	r_PtxU64Register49 = uint64_t(r_PtxU64Register50) + uint64_t(r_PtxU64Register51); // PTX L2828
	r_PtxRegister912 = uint32_t(512);												  // PTX L2829
	CopyBulk(s_SharedStorage, r_PtxRegister911, r_PtxU64Register49, r_PtxRegister912,
			 r_PtxRegister913);																   // PTX L2831
	BarrierExpect(s_SharedStorage, r_PtxRegister913, r_PtxRegister912);						   // PTX L2834
	goto L__BB55_59;																		   // PTX L2836
L__BB55_58:																					   // PTX L2837
	r_PtxRegister901 = uint32_t(0);															   // PTX L2838
	r_PtxU16Register87 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister901))); // PTX L2840
	r_PackedHalf2AtPtx2843R902 = JoinHalfwords(r_PtxU16Register87, r_PtxU16Register87);		   // PTX L2843
	r_ConvertedE4PairAtPtx2845Rs88 = PublishE4(r_PackedHalf2AtPtx2843R902);					   // PTX L2845
	r_PackedE4WordAtPtx2847R905 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2845Rs88, r_ConvertedE4PairAtPtx2845Rs88); // PTX L2847
	r_LaneIndexAtPtx2849 = uint32_t((threadIdx.x & 31u));							   // PTX L2849
	r_PtxRegister906 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(2));			   // PTX L2851
	r_PtxRegister907 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister906);		   // PTX L2852
	r_PtxRegister908 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2849), uint32_t(4));		   // PTX L2853
	r_PtxRegister904 = uint32_t(r_PtxRegister907) + uint32_t(r_PtxRegister908);		   // PTX L2854
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister904)) =
		make_uint4(r_PackedE4WordAtPtx2847R905, r_PackedE4WordAtPtx2847R905, r_PackedE4WordAtPtx2847R905,
				   r_PackedE4WordAtPtx2847R905);								  // PTX L2856
L__BB55_59:																		  // PTX L2858
	r_PtxRegister1407 = uint32_t(r_PtxRegister1407) + uint32_t(1);				  // PTX L2859
	r_bPtxPredicate53 = int32_t(r_PtxRegister1407) >= int32_t(r_PtxRegister1388); // PTX L2860
	if (r_bPtxPredicate53)
	{
		goto L__BB55_62;
	} // PTX L2861
	r_PtxRegister916 = ShiftLeft(uint32_t(r_PtxRegister1407), uint32_t(3));					 // PTX L2862
	r_PtxRegister917 = r_PtxRegister916 & 8;												 // PTX L2863
	r_PtxRegister918 = uint32_t(8192u /* original named shared base */);					 // PTX L2864
	r_PtxRegister920 = uint32_t(r_PtxRegister918) + uint32_t(r_PtxRegister917);				 // PTX L2865
	r_PtxRegister915 = uint32_t(1);															 // PTX L2866
	r_PtxU64Register52 = BarrierArrive(s_SharedStorage, r_PtxRegister920, r_PtxRegister915); // PTX L2868
L__BB55_61:																					 // PTX L2870
	r_PtxRegister919 = BarrierReady(s_SharedStorage, r_PtxRegister920, r_PtxU64Register52);	 // PTX L2872
	r_bPtxPredicate54 = uint32_t(r_PtxRegister919) == uint32_t(0);							 // PTX L2878
	if (r_bPtxPredicate54)
	{
		goto L__BB55_61;
	} // PTX L2879
L__BB55_62:																			// PTX L2880
	r_bPtxPredicate55 = uint32_t(r_PtxRegister1407) != uint32_t(r_PtxRegister1388); // PTX L2881
	if (r_bPtxPredicate55)
	{
		goto L__BB55_45;
	} // PTX L2882
L__BB55_63:																	 // PTX L2883
	r_PtxRegister921 = ShiftLeft(uint32_t(r_PtxRegister1388), uint32_t(6));	 // PTX L2884
	r_PtxRegister34 = uint32_t(r_PtxRegister921) - uint32_t(r_PtxRegister3); // PTX L2885
	r_bPtxPredicate56 = int32_t(r_PtxRegister34) < int32_t(1);				 // PTX L2886
	if (r_bPtxPredicate56)
	{
		goto L__BB55_65;
	} // PTX L2887
	r_Float32BitsAtPtx2888R922 = uint32_t(1035427960);					   // PTX L2888
	r_PackedHalf2AtPtx2890R927 = FloatToHalf2(r_Float32BitsAtPtx2888R922); // PTX L2890
	r_Float32BitsAtPtx2895R923 = uint32_t(1071303771);					   // PTX L2895
	r_PackedHalf2AtPtx2897R928 = FloatToHalf2(r_Float32BitsAtPtx2895R923); // PTX L2897
	r_Float32BitsAtPtx2902R924 = uint32_t(1069039616);					   // PTX L2902
	r_PackedHalf2AtPtx2904R930 = FloatToHalf2(r_Float32BitsAtPtx2902R924); // PTX L2904
	r_Float32BitsAtPtx2909R925 = uint32_t(1073553408);					   // PTX L2909
	r_PackedHalf2AtPtx2911R933 = FloatToHalf2(r_Float32BitsAtPtx2909R925); // PTX L2911
	r_PackedHalf2AtPtx2917R929 = HalfFma(r_PackedHalf2AtPtx256R926, r_PackedHalf2AtPtx2890R927,
										 r_PackedHalf2AtPtx2897R928);							  // PTX L2917
	r_PackedHalf2AtPtx2921R932 = HalfMax(r_PackedHalf2AtPtx2917R929, r_PackedHalf2AtPtx2904R930); // PTX L2921
	r_PtxRegister931 = HalfMin(r_PackedHalf2AtPtx2921R932, r_PackedHalf2AtPtx2911R933);			  // PTX L2925
	r_PtxU16Register91 = uint16_t(r_PtxRegister931);											  // PTX L2928
	r_PtxU16Register92 = ShiftLeft(uint16_t(r_PtxU16Register91), uint32_t(4));					  // PTX L2929
	r_PtxU16Register89 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register92)) + uint32_t(uint16_t(16384)));			  // PTX L2930
	r_PtxRegister934 = HalfToFloatBits(r_PtxU16Register89);										  // PTX L2932
	r_PtxRegister938 = UintToFloatRnBits(r_PtxRegister34);										  // PTX L2935
	r_PtxRegister935 = FloatMulFtzBits(r_PtxRegister934, r_PtxRegister938);						  // PTX L2936
	r_PtxU16Register90 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister935)));	  // PTX L2938
	r_PackedHalf2AtPtx2941R937 = JoinHalfwords(r_PtxU16Register90, r_PtxU16Register90);			  // PTX L2941
	r_LaneIndexAtPtx2943 = uint32_t((threadIdx.x & 31u));										  // PTX L2943
	r_PackedHalf2AtPtx434R1441 = HalfSub(r_PackedHalf2AtPtx434R1441, r_PackedHalf2AtPtx2941R937); // PTX L2946
L__BB55_65:																						  // PTX L2949
	r_PtxRegister939 = uint32_t(948045311);														  // PTX L2950
	r_PtxU16Register93 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister939)));	  // PTX L2952
	r_PackedHalf2AtPtx2955R941 = JoinHalfwords(r_PtxU16Register93, r_PtxU16Register93);			  // PTX L2955
	r_LaneIndexAtPtx2957 = uint32_t((threadIdx.x & 31u));										  // PTX L2957
	r_PackedHalf2AtPtx2960R944 = HalfMax(r_PackedHalf2AtPtx434R1441, r_PackedHalf2AtPtx2955R941); // PTX L2960
	r_LaneIndexAtPtx2964 = uint32_t((threadIdx.x & 31u));										  // PTX L2964
	r_PtxRegister943 = RcpHalf2(r_PackedHalf2AtPtx2960R944);									  // PTX L2967
	r_LaneIndexAtPtx2980 = uint32_t((threadIdx.x & 31u));										  // PTX L2980
	r_PtxRegister1049 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2980), uint32_t(31));			  // PTX L2982
	r_PtxRegister1050 = ShiftRight(uint32_t(r_PtxRegister1049), uint32_t(30));					  // PTX L2983
	r_PtxRegister1051 = uint32_t(r_LaneIndexAtPtx2980) + uint32_t(r_PtxRegister1050);			  // PTX L2984
	r_PtxRegister1052 = ShiftRightSigned(int32_t(r_PtxRegister1051), uint32_t(2));				  // PTX L2985
	r_PtxRegister1053 = ShiftRightSigned(int32_t(r_PtxRegister1051), uint32_t(31));				  // PTX L2986
	r_PtxRegister1054 = ShiftRight(uint32_t(r_PtxRegister1053), uint32_t(26));					  // PTX L2987
	r_PtxRegister1055 = uint32_t(r_PtxRegister1052) + uint32_t(r_PtxRegister1054);				  // PTX L2988
	r_PtxRegister1056 = r_PtxRegister1055 & 65472;												  // PTX L2989
	r_PtxRegister1057 = uint32_t(r_PtxRegister1052) - uint32_t(r_PtxRegister1056);				  // PTX L2990
	r_PtxU16Register126 = uint16_t(r_PtxRegister1057);											  // PTX L2991
	r_PtxU16Register127 = uint16_t(SignExtendByteBits(r_PtxRegister1057));						  // PTX L2992
	r_PtxU16Register128 = ShiftRight(uint16_t(r_PtxU16Register127), uint32_t(10));				  // PTX L2993
	r_PtxU16Register129 = r_PtxU16Register128 & 31;												  // PTX L2994
	r_PtxU16Register130 = uint16_t(uint32_t(uint16_t(r_PtxU16Register126)) +
								   uint32_t(uint16_t(r_PtxU16Register129)));			 // PTX L2995
	r_PtxU16Register131 = r_PtxU16Register130 & 224;									 // PTX L2996
	r_PtxU16Register132 = uint16_t(r_PtxU16Register126) - uint16_t(r_PtxU16Register131); // PTX L2997
	r_PtxRegister1058 = uint32_t(r_PtxU16Register132);									 // PTX L2998
	r_PtxRegister1059 = SignExtendByteBits(r_PtxRegister1058);							 // PTX L2999
	r_PtxU16Register133 = ShiftRight(uint16_t(r_PtxU16Register130), uint32_t(5));		 // PTX L3000
	r_PtxRegister1060 =
		ShuffleIdxPredicate(r_bPtxPredicate57, r_PtxRegister943, r_PtxRegister1059, 31, -1); // PTX L3001
	r_PtxU16Register134 = r_PtxU16Register133 & 1;											 // PTX L3002
	r_bPtxPredicate58 = uint16_t(r_PtxU16Register134) != uint16_t(0);						 // PTX L3003
	r_PtxU16Register135 = uint16_t(r_PtxRegister1060);
	r_PtxU16Register136 = uint16_t(r_PtxRegister1060 >> 16);							  // PTX L3004
	r_PtxU16Register137 = r_bPtxPredicate58 ? r_PtxU16Register136 : r_PtxU16Register135;  // PTX L3005
	r_PackedHalf2AtPtx3006R954 = JoinHalfwords(r_PtxU16Register137, r_PtxU16Register137); // PTX L3006
	r_PtxRegister1061 = uint32_t(r_PtxRegister1052) + uint32_t(8);						  // PTX L3007
	r_PtxRegister1062 = ShiftRightSigned(int32_t(r_PtxRegister1061), uint32_t(31));		  // PTX L3008
	r_PtxRegister1063 = ShiftRight(uint32_t(r_PtxRegister1062), uint32_t(26));			  // PTX L3009
	r_PtxRegister1064 = uint32_t(r_PtxRegister1061) + uint32_t(r_PtxRegister1063);		  // PTX L3010
	r_PtxRegister1065 = r_PtxRegister1064 & 65472;										  // PTX L3011
	r_PtxRegister1066 = uint32_t(r_PtxRegister1061) - uint32_t(r_PtxRegister1065);		  // PTX L3012
	r_PtxU16Register138 = uint16_t(r_PtxRegister1066);									  // PTX L3013
	r_PtxU16Register139 = uint16_t(SignExtendByteBits(r_PtxRegister1066));				  // PTX L3014
	r_PtxU16Register140 = ShiftRight(uint16_t(r_PtxU16Register139), uint32_t(10));		  // PTX L3015
	r_PtxU16Register141 = r_PtxU16Register140 & 31;										  // PTX L3016
	r_PtxU16Register142 = uint16_t(uint32_t(uint16_t(r_PtxU16Register138)) +
								   uint32_t(uint16_t(r_PtxU16Register141)));			 // PTX L3017
	r_PtxU16Register143 = r_PtxU16Register142 & 224;									 // PTX L3018
	r_PtxU16Register144 = uint16_t(r_PtxU16Register138) - uint16_t(r_PtxU16Register143); // PTX L3019
	r_PtxRegister1067 = uint32_t(r_PtxU16Register144);									 // PTX L3020
	r_PtxRegister1068 = SignExtendByteBits(r_PtxRegister1067);							 // PTX L3021
	r_PtxU16Register145 = ShiftRight(uint16_t(r_PtxU16Register142), uint32_t(5));		 // PTX L3022
	r_PtxRegister1069 =
		ShuffleIdxPredicate(r_bPtxPredicate59, r_PtxRegister943, r_PtxRegister1068, 31, -1); // PTX L3023
	r_PtxU16Register146 = r_PtxU16Register145 & 1;											 // PTX L3024
	r_bPtxPredicate60 = uint16_t(r_PtxU16Register146) != uint16_t(0);						 // PTX L3025
	r_PtxU16Register147 = uint16_t(r_PtxRegister1069);
	r_PtxU16Register148 = uint16_t(r_PtxRegister1069 >> 16);							  // PTX L3026
	r_PtxU16Register149 = r_bPtxPredicate60 ? r_PtxU16Register148 : r_PtxU16Register147;  // PTX L3027
	r_PackedHalf2AtPtx3028R956 = JoinHalfwords(r_PtxU16Register149, r_PtxU16Register149); // PTX L3028
	r_PtxRegister1070 =
		ShuffleIdxPredicate(r_bPtxPredicate61, r_PtxRegister943, r_PtxRegister1059, 31, -1); // PTX L3029
	r_PtxU16Register150 = uint16_t(r_PtxRegister1070);
	r_PtxU16Register151 = uint16_t(r_PtxRegister1070 >> 16);							  // PTX L3030
	r_PtxU16Register152 = r_bPtxPredicate58 ? r_PtxU16Register151 : r_PtxU16Register150;  // PTX L3031
	r_PackedHalf2AtPtx3032R958 = JoinHalfwords(r_PtxU16Register152, r_PtxU16Register152); // PTX L3032
	r_PtxRegister1071 =
		ShuffleIdxPredicate(r_bPtxPredicate62, r_PtxRegister943, r_PtxRegister1068, 31, -1); // PTX L3033
	r_PtxU16Register153 = uint16_t(r_PtxRegister1071);
	r_PtxU16Register154 = uint16_t(r_PtxRegister1071 >> 16);							  // PTX L3034
	r_PtxU16Register155 = r_bPtxPredicate60 ? r_PtxU16Register154 : r_PtxU16Register153;  // PTX L3035
	r_PackedHalf2AtPtx3036R960 = JoinHalfwords(r_PtxU16Register155, r_PtxU16Register155); // PTX L3036
	r_LaneIndexAtPtx3038 = uint32_t((threadIdx.x & 31u));								  // PTX L3038
	r_PtxRegister1072 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3038), uint32_t(31));	  // PTX L3040
	r_PtxRegister1073 = ShiftRight(uint32_t(r_PtxRegister1072), uint32_t(30));			  // PTX L3041
	r_PtxRegister1074 = uint32_t(r_LaneIndexAtPtx3038) + uint32_t(r_PtxRegister1073);	  // PTX L3042
	r_PtxRegister1075 = ShiftRightSigned(int32_t(r_PtxRegister1074), uint32_t(2));		  // PTX L3043
	r_PtxRegister1076 = ShiftRightSigned(int32_t(r_PtxRegister1074), uint32_t(31));		  // PTX L3044
	r_PtxRegister1077 = ShiftRight(uint32_t(r_PtxRegister1076), uint32_t(26));			  // PTX L3045
	r_PtxRegister1078 = uint32_t(r_PtxRegister1075) + uint32_t(r_PtxRegister1077);		  // PTX L3046
	r_PtxRegister1079 = r_PtxRegister1078 & 65472;										  // PTX L3047
	r_PtxRegister1080 = uint32_t(r_PtxRegister1075) - uint32_t(r_PtxRegister1079);		  // PTX L3048
	r_PtxU16Register156 = uint16_t(r_PtxRegister1080);									  // PTX L3049
	r_PtxU16Register157 = uint16_t(SignExtendByteBits(r_PtxRegister1080));				  // PTX L3050
	r_PtxU16Register158 = ShiftRight(uint16_t(r_PtxU16Register157), uint32_t(10));		  // PTX L3051
	r_PtxU16Register159 = r_PtxU16Register158 & 31;										  // PTX L3052
	r_PtxU16Register160 = uint16_t(uint32_t(uint16_t(r_PtxU16Register156)) +
								   uint32_t(uint16_t(r_PtxU16Register159)));			 // PTX L3053
	r_PtxU16Register161 = r_PtxU16Register160 & 224;									 // PTX L3054
	r_PtxU16Register162 = uint16_t(r_PtxU16Register156) - uint16_t(r_PtxU16Register161); // PTX L3055
	r_PtxRegister1081 = uint32_t(r_PtxU16Register162);									 // PTX L3056
	r_PtxRegister1082 = SignExtendByteBits(r_PtxRegister1081);							 // PTX L3057
	r_PtxU16Register163 = ShiftRight(uint16_t(r_PtxU16Register160), uint32_t(5));		 // PTX L3058
	r_PtxRegister1083 =
		ShuffleIdxPredicate(r_bPtxPredicate63, r_PtxRegister943, r_PtxRegister1082, 31, -1); // PTX L3059
	r_PtxU16Register164 = r_PtxU16Register163 & 1;											 // PTX L3060
	r_bPtxPredicate64 = uint16_t(r_PtxU16Register164) != uint16_t(0);						 // PTX L3061
	r_PtxU16Register165 = uint16_t(r_PtxRegister1083);
	r_PtxU16Register166 = uint16_t(r_PtxRegister1083 >> 16);							  // PTX L3062
	r_PtxU16Register167 = r_bPtxPredicate64 ? r_PtxU16Register166 : r_PtxU16Register165;  // PTX L3063
	r_PackedHalf2AtPtx3064R962 = JoinHalfwords(r_PtxU16Register167, r_PtxU16Register167); // PTX L3064
	r_PtxRegister1084 = uint32_t(r_PtxRegister1075) + uint32_t(8);						  // PTX L3065
	r_PtxRegister1085 = ShiftRightSigned(int32_t(r_PtxRegister1084), uint32_t(31));		  // PTX L3066
	r_PtxRegister1086 = ShiftRight(uint32_t(r_PtxRegister1085), uint32_t(26));			  // PTX L3067
	r_PtxRegister1087 = uint32_t(r_PtxRegister1084) + uint32_t(r_PtxRegister1086);		  // PTX L3068
	r_PtxRegister1088 = r_PtxRegister1087 & 65472;										  // PTX L3069
	r_PtxRegister1089 = uint32_t(r_PtxRegister1084) - uint32_t(r_PtxRegister1088);		  // PTX L3070
	r_PtxU16Register168 = uint16_t(r_PtxRegister1089);									  // PTX L3071
	r_PtxU16Register169 = uint16_t(SignExtendByteBits(r_PtxRegister1089));				  // PTX L3072
	r_PtxU16Register170 = ShiftRight(uint16_t(r_PtxU16Register169), uint32_t(10));		  // PTX L3073
	r_PtxU16Register171 = r_PtxU16Register170 & 31;										  // PTX L3074
	r_PtxU16Register172 = uint16_t(uint32_t(uint16_t(r_PtxU16Register168)) +
								   uint32_t(uint16_t(r_PtxU16Register171)));			 // PTX L3075
	r_PtxU16Register173 = r_PtxU16Register172 & 224;									 // PTX L3076
	r_PtxU16Register174 = uint16_t(r_PtxU16Register168) - uint16_t(r_PtxU16Register173); // PTX L3077
	r_PtxRegister1090 = uint32_t(r_PtxU16Register174);									 // PTX L3078
	r_PtxRegister1091 = SignExtendByteBits(r_PtxRegister1090);							 // PTX L3079
	r_PtxU16Register175 = ShiftRight(uint16_t(r_PtxU16Register172), uint32_t(5));		 // PTX L3080
	r_PtxRegister1092 =
		ShuffleIdxPredicate(r_bPtxPredicate65, r_PtxRegister943, r_PtxRegister1091, 31, -1); // PTX L3081
	r_PtxU16Register176 = r_PtxU16Register175 & 1;											 // PTX L3082
	r_bPtxPredicate66 = uint16_t(r_PtxU16Register176) != uint16_t(0);						 // PTX L3083
	r_PtxU16Register177 = uint16_t(r_PtxRegister1092);
	r_PtxU16Register178 = uint16_t(r_PtxRegister1092 >> 16);							  // PTX L3084
	r_PtxU16Register179 = r_bPtxPredicate66 ? r_PtxU16Register178 : r_PtxU16Register177;  // PTX L3085
	r_PackedHalf2AtPtx3086R964 = JoinHalfwords(r_PtxU16Register179, r_PtxU16Register179); // PTX L3086
	r_PtxRegister1093 =
		ShuffleIdxPredicate(r_bPtxPredicate67, r_PtxRegister943, r_PtxRegister1082, 31, -1); // PTX L3087
	r_PtxU16Register180 = uint16_t(r_PtxRegister1093);
	r_PtxU16Register181 = uint16_t(r_PtxRegister1093 >> 16);							  // PTX L3088
	r_PtxU16Register182 = r_bPtxPredicate64 ? r_PtxU16Register181 : r_PtxU16Register180;  // PTX L3089
	r_PackedHalf2AtPtx3090R966 = JoinHalfwords(r_PtxU16Register182, r_PtxU16Register182); // PTX L3090
	r_PtxRegister1094 =
		ShuffleIdxPredicate(r_bPtxPredicate68, r_PtxRegister943, r_PtxRegister1091, 31, -1); // PTX L3091
	r_PtxU16Register183 = uint16_t(r_PtxRegister1094);
	r_PtxU16Register184 = uint16_t(r_PtxRegister1094 >> 16);							  // PTX L3092
	r_PtxU16Register185 = r_bPtxPredicate66 ? r_PtxU16Register184 : r_PtxU16Register183;  // PTX L3093
	r_PackedHalf2AtPtx3094R968 = JoinHalfwords(r_PtxU16Register185, r_PtxU16Register185); // PTX L3094
	r_LaneIndexAtPtx3096 = uint32_t((threadIdx.x & 31u));								  // PTX L3096
	r_PtxRegister1095 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3096), uint32_t(31));	  // PTX L3098
	r_PtxRegister1096 = ShiftRight(uint32_t(r_PtxRegister1095), uint32_t(30));			  // PTX L3099
	r_PtxRegister1097 = uint32_t(r_LaneIndexAtPtx3096) + uint32_t(r_PtxRegister1096);	  // PTX L3100
	r_PtxRegister1098 = ShiftRightSigned(int32_t(r_PtxRegister1097), uint32_t(2));		  // PTX L3101
	r_PtxRegister1099 = uint32_t(r_PtxRegister1098) + uint32_t(16);						  // PTX L3102
	r_PtxRegister1100 = ShiftRightSigned(int32_t(r_PtxRegister1099), uint32_t(31));		  // PTX L3103
	r_PtxRegister1101 = ShiftRight(uint32_t(r_PtxRegister1100), uint32_t(26));			  // PTX L3104
	r_PtxRegister1102 = uint32_t(r_PtxRegister1099) + uint32_t(r_PtxRegister1101);		  // PTX L3105
	r_PtxRegister1103 = r_PtxRegister1102 & 65472;										  // PTX L3106
	r_PtxRegister1104 = uint32_t(r_PtxRegister1099) - uint32_t(r_PtxRegister1103);		  // PTX L3107
	r_PtxU16Register186 = uint16_t(r_PtxRegister1104);									  // PTX L3108
	r_PtxU16Register187 = uint16_t(SignExtendByteBits(r_PtxRegister1104));				  // PTX L3109
	r_PtxU16Register188 = ShiftRight(uint16_t(r_PtxU16Register187), uint32_t(10));		  // PTX L3110
	r_PtxU16Register189 = r_PtxU16Register188 & 31;										  // PTX L3111
	r_PtxU16Register190 = uint16_t(uint32_t(uint16_t(r_PtxU16Register186)) +
								   uint32_t(uint16_t(r_PtxU16Register189)));			 // PTX L3112
	r_PtxU16Register191 = r_PtxU16Register190 & 224;									 // PTX L3113
	r_PtxU16Register192 = uint16_t(r_PtxU16Register186) - uint16_t(r_PtxU16Register191); // PTX L3114
	r_PtxRegister1105 = uint32_t(r_PtxU16Register192);									 // PTX L3115
	r_PtxRegister1106 = SignExtendByteBits(r_PtxRegister1105);							 // PTX L3116
	r_PtxU16Register193 = ShiftRight(uint16_t(r_PtxU16Register190), uint32_t(5));		 // PTX L3117
	r_PtxRegister1107 =
		ShuffleIdxPredicate(r_bPtxPredicate69, r_PtxRegister943, r_PtxRegister1106, 31, -1); // PTX L3118
	r_PtxU16Register194 = r_PtxU16Register193 & 1;											 // PTX L3119
	r_bPtxPredicate70 = uint16_t(r_PtxU16Register194) != uint16_t(0);						 // PTX L3120
	r_PtxU16Register195 = uint16_t(r_PtxRegister1107);
	r_PtxU16Register196 = uint16_t(r_PtxRegister1107 >> 16);							  // PTX L3121
	r_PtxU16Register197 = r_bPtxPredicate70 ? r_PtxU16Register196 : r_PtxU16Register195;  // PTX L3122
	r_PackedHalf2AtPtx3123R970 = JoinHalfwords(r_PtxU16Register197, r_PtxU16Register197); // PTX L3123
	r_PtxRegister1108 = uint32_t(r_PtxRegister1098) + uint32_t(24);						  // PTX L3124
	r_PtxRegister1109 = ShiftRightSigned(int32_t(r_PtxRegister1108), uint32_t(31));		  // PTX L3125
	r_PtxRegister1110 = ShiftRight(uint32_t(r_PtxRegister1109), uint32_t(26));			  // PTX L3126
	r_PtxRegister1111 = uint32_t(r_PtxRegister1108) + uint32_t(r_PtxRegister1110);		  // PTX L3127
	r_PtxRegister1112 = r_PtxRegister1111 & 65472;										  // PTX L3128
	r_PtxRegister1113 = uint32_t(r_PtxRegister1108) - uint32_t(r_PtxRegister1112);		  // PTX L3129
	r_PtxU16Register198 = uint16_t(r_PtxRegister1113);									  // PTX L3130
	r_PtxU16Register199 = uint16_t(SignExtendByteBits(r_PtxRegister1113));				  // PTX L3131
	r_PtxU16Register200 = ShiftRight(uint16_t(r_PtxU16Register199), uint32_t(10));		  // PTX L3132
	r_PtxU16Register201 = r_PtxU16Register200 & 31;										  // PTX L3133
	r_PtxU16Register202 = uint16_t(uint32_t(uint16_t(r_PtxU16Register198)) +
								   uint32_t(uint16_t(r_PtxU16Register201)));			 // PTX L3134
	r_PtxU16Register203 = r_PtxU16Register202 & 224;									 // PTX L3135
	r_PtxU16Register204 = uint16_t(r_PtxU16Register198) - uint16_t(r_PtxU16Register203); // PTX L3136
	r_PtxRegister1114 = uint32_t(r_PtxU16Register204);									 // PTX L3137
	r_PtxRegister1115 = SignExtendByteBits(r_PtxRegister1114);							 // PTX L3138
	r_PtxU16Register205 = ShiftRight(uint16_t(r_PtxU16Register202), uint32_t(5));		 // PTX L3139
	r_PtxRegister1116 =
		ShuffleIdxPredicate(r_bPtxPredicate71, r_PtxRegister943, r_PtxRegister1115, 31, -1); // PTX L3140
	r_PtxU16Register206 = r_PtxU16Register205 & 1;											 // PTX L3141
	r_bPtxPredicate72 = uint16_t(r_PtxU16Register206) != uint16_t(0);						 // PTX L3142
	r_PtxU16Register207 = uint16_t(r_PtxRegister1116);
	r_PtxU16Register208 = uint16_t(r_PtxRegister1116 >> 16);							  // PTX L3143
	r_PtxU16Register209 = r_bPtxPredicate72 ? r_PtxU16Register208 : r_PtxU16Register207;  // PTX L3144
	r_PackedHalf2AtPtx3145R972 = JoinHalfwords(r_PtxU16Register209, r_PtxU16Register209); // PTX L3145
	r_PtxRegister1117 =
		ShuffleIdxPredicate(r_bPtxPredicate73, r_PtxRegister943, r_PtxRegister1106, 31, -1); // PTX L3146
	r_PtxU16Register210 = uint16_t(r_PtxRegister1117);
	r_PtxU16Register211 = uint16_t(r_PtxRegister1117 >> 16);							  // PTX L3147
	r_PtxU16Register212 = r_bPtxPredicate70 ? r_PtxU16Register211 : r_PtxU16Register210;  // PTX L3148
	r_PackedHalf2AtPtx3149R974 = JoinHalfwords(r_PtxU16Register212, r_PtxU16Register212); // PTX L3149
	r_PtxRegister1118 =
		ShuffleIdxPredicate(r_bPtxPredicate74, r_PtxRegister943, r_PtxRegister1115, 31, -1); // PTX L3150
	r_PtxU16Register213 = uint16_t(r_PtxRegister1118);
	r_PtxU16Register214 = uint16_t(r_PtxRegister1118 >> 16);							  // PTX L3151
	r_PtxU16Register215 = r_bPtxPredicate72 ? r_PtxU16Register214 : r_PtxU16Register213;  // PTX L3152
	r_PackedHalf2AtPtx3153R976 = JoinHalfwords(r_PtxU16Register215, r_PtxU16Register215); // PTX L3153
	r_LaneIndexAtPtx3155 = uint32_t((threadIdx.x & 31u));								  // PTX L3155
	r_PtxRegister1119 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3155), uint32_t(31));	  // PTX L3157
	r_PtxRegister1120 = ShiftRight(uint32_t(r_PtxRegister1119), uint32_t(30));			  // PTX L3158
	r_PtxRegister1121 = uint32_t(r_LaneIndexAtPtx3155) + uint32_t(r_PtxRegister1120);	  // PTX L3159
	r_PtxRegister1122 = ShiftRightSigned(int32_t(r_PtxRegister1121), uint32_t(2));		  // PTX L3160
	r_PtxRegister1123 = uint32_t(r_PtxRegister1122) + uint32_t(16);						  // PTX L3161
	r_PtxRegister1124 = ShiftRightSigned(int32_t(r_PtxRegister1123), uint32_t(31));		  // PTX L3162
	r_PtxRegister1125 = ShiftRight(uint32_t(r_PtxRegister1124), uint32_t(26));			  // PTX L3163
	r_PtxRegister1126 = uint32_t(r_PtxRegister1123) + uint32_t(r_PtxRegister1125);		  // PTX L3164
	r_PtxRegister1127 = r_PtxRegister1126 & 65472;										  // PTX L3165
	r_PtxRegister1128 = uint32_t(r_PtxRegister1123) - uint32_t(r_PtxRegister1127);		  // PTX L3166
	r_PtxU16Register216 = uint16_t(r_PtxRegister1128);									  // PTX L3167
	r_PtxU16Register217 = uint16_t(SignExtendByteBits(r_PtxRegister1128));				  // PTX L3168
	r_PtxU16Register218 = ShiftRight(uint16_t(r_PtxU16Register217), uint32_t(10));		  // PTX L3169
	r_PtxU16Register219 = r_PtxU16Register218 & 31;										  // PTX L3170
	r_PtxU16Register220 = uint16_t(uint32_t(uint16_t(r_PtxU16Register216)) +
								   uint32_t(uint16_t(r_PtxU16Register219)));			 // PTX L3171
	r_PtxU16Register221 = r_PtxU16Register220 & 224;									 // PTX L3172
	r_PtxU16Register222 = uint16_t(r_PtxU16Register216) - uint16_t(r_PtxU16Register221); // PTX L3173
	r_PtxRegister1129 = uint32_t(r_PtxU16Register222);									 // PTX L3174
	r_PtxRegister1130 = SignExtendByteBits(r_PtxRegister1129);							 // PTX L3175
	r_PtxU16Register223 = ShiftRight(uint16_t(r_PtxU16Register220), uint32_t(5));		 // PTX L3176
	r_PtxRegister1131 =
		ShuffleIdxPredicate(r_bPtxPredicate75, r_PtxRegister943, r_PtxRegister1130, 31, -1); // PTX L3177
	r_PtxU16Register224 = r_PtxU16Register223 & 1;											 // PTX L3178
	r_bPtxPredicate76 = uint16_t(r_PtxU16Register224) != uint16_t(0);						 // PTX L3179
	r_PtxU16Register225 = uint16_t(r_PtxRegister1131);
	r_PtxU16Register226 = uint16_t(r_PtxRegister1131 >> 16);							  // PTX L3180
	r_PtxU16Register227 = r_bPtxPredicate76 ? r_PtxU16Register226 : r_PtxU16Register225;  // PTX L3181
	r_PackedHalf2AtPtx3182R978 = JoinHalfwords(r_PtxU16Register227, r_PtxU16Register227); // PTX L3182
	r_PtxRegister1132 = uint32_t(r_PtxRegister1122) + uint32_t(24);						  // PTX L3183
	r_PtxRegister1133 = ShiftRightSigned(int32_t(r_PtxRegister1132), uint32_t(31));		  // PTX L3184
	r_PtxRegister1134 = ShiftRight(uint32_t(r_PtxRegister1133), uint32_t(26));			  // PTX L3185
	r_PtxRegister1135 = uint32_t(r_PtxRegister1132) + uint32_t(r_PtxRegister1134);		  // PTX L3186
	r_PtxRegister1136 = r_PtxRegister1135 & 65472;										  // PTX L3187
	r_PtxRegister1137 = uint32_t(r_PtxRegister1132) - uint32_t(r_PtxRegister1136);		  // PTX L3188
	r_PtxU16Register228 = uint16_t(r_PtxRegister1137);									  // PTX L3189
	r_PtxU16Register229 = uint16_t(SignExtendByteBits(r_PtxRegister1137));				  // PTX L3190
	r_PtxU16Register230 = ShiftRight(uint16_t(r_PtxU16Register229), uint32_t(10));		  // PTX L3191
	r_PtxU16Register231 = r_PtxU16Register230 & 31;										  // PTX L3192
	r_PtxU16Register232 = uint16_t(uint32_t(uint16_t(r_PtxU16Register228)) +
								   uint32_t(uint16_t(r_PtxU16Register231)));			 // PTX L3193
	r_PtxU16Register233 = r_PtxU16Register232 & 224;									 // PTX L3194
	r_PtxU16Register234 = uint16_t(r_PtxU16Register228) - uint16_t(r_PtxU16Register233); // PTX L3195
	r_PtxRegister1138 = uint32_t(r_PtxU16Register234);									 // PTX L3196
	r_PtxRegister1139 = SignExtendByteBits(r_PtxRegister1138);							 // PTX L3197
	r_PtxU16Register235 = ShiftRight(uint16_t(r_PtxU16Register232), uint32_t(5));		 // PTX L3198
	r_PtxRegister1140 =
		ShuffleIdxPredicate(r_bPtxPredicate77, r_PtxRegister943, r_PtxRegister1139, 31, -1); // PTX L3199
	r_PtxU16Register236 = r_PtxU16Register235 & 1;											 // PTX L3200
	r_bPtxPredicate78 = uint16_t(r_PtxU16Register236) != uint16_t(0);						 // PTX L3201
	r_PtxU16Register237 = uint16_t(r_PtxRegister1140);
	r_PtxU16Register238 = uint16_t(r_PtxRegister1140 >> 16);							  // PTX L3202
	r_PtxU16Register239 = r_bPtxPredicate78 ? r_PtxU16Register238 : r_PtxU16Register237;  // PTX L3203
	r_PackedHalf2AtPtx3204R980 = JoinHalfwords(r_PtxU16Register239, r_PtxU16Register239); // PTX L3204
	r_PtxRegister1141 =
		ShuffleIdxPredicate(r_bPtxPredicate79, r_PtxRegister943, r_PtxRegister1130, 31, -1); // PTX L3205
	r_PtxU16Register240 = uint16_t(r_PtxRegister1141);
	r_PtxU16Register241 = uint16_t(r_PtxRegister1141 >> 16);							  // PTX L3206
	r_PtxU16Register242 = r_bPtxPredicate76 ? r_PtxU16Register241 : r_PtxU16Register240;  // PTX L3207
	r_PackedHalf2AtPtx3208R982 = JoinHalfwords(r_PtxU16Register242, r_PtxU16Register242); // PTX L3208
	r_PtxRegister1142 =
		ShuffleIdxPredicate(r_bPtxPredicate80, r_PtxRegister943, r_PtxRegister1139, 31, -1); // PTX L3209
	r_PtxU16Register243 = uint16_t(r_PtxRegister1142);
	r_PtxU16Register244 = uint16_t(r_PtxRegister1142 >> 16);							  // PTX L3210
	r_PtxU16Register245 = r_bPtxPredicate78 ? r_PtxU16Register244 : r_PtxU16Register243;  // PTX L3211
	r_PackedHalf2AtPtx3212R984 = JoinHalfwords(r_PtxU16Register245, r_PtxU16Register245); // PTX L3212
	r_LaneIndexAtPtx3214 = uint32_t((threadIdx.x & 31u));								  // PTX L3214
	r_PtxRegister1143 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3214), uint32_t(31));	  // PTX L3216
	r_PtxRegister1144 = ShiftRight(uint32_t(r_PtxRegister1143), uint32_t(30));			  // PTX L3217
	r_PtxRegister1145 = uint32_t(r_LaneIndexAtPtx3214) + uint32_t(r_PtxRegister1144);	  // PTX L3218
	r_PtxRegister1146 = ShiftRightSigned(int32_t(r_PtxRegister1145), uint32_t(2));		  // PTX L3219
	r_PtxRegister1147 = uint32_t(r_PtxRegister1146) + uint32_t(32);						  // PTX L3220
	r_PtxRegister1148 = ShiftRightSigned(int32_t(r_PtxRegister1147), uint32_t(31));		  // PTX L3221
	r_PtxRegister1149 = ShiftRight(uint32_t(r_PtxRegister1148), uint32_t(26));			  // PTX L3222
	r_PtxRegister1150 = uint32_t(r_PtxRegister1147) + uint32_t(r_PtxRegister1149);		  // PTX L3223
	r_PtxRegister1151 = r_PtxRegister1150 & 65472;										  // PTX L3224
	r_PtxRegister1152 = uint32_t(r_PtxRegister1147) - uint32_t(r_PtxRegister1151);		  // PTX L3225
	r_PtxU16Register246 = uint16_t(r_PtxRegister1152);									  // PTX L3226
	r_PtxU16Register247 = uint16_t(SignExtendByteBits(r_PtxRegister1152));				  // PTX L3227
	r_PtxU16Register248 = ShiftRight(uint16_t(r_PtxU16Register247), uint32_t(10));		  // PTX L3228
	r_PtxU16Register249 = r_PtxU16Register248 & 31;										  // PTX L3229
	r_PtxU16Register250 = uint16_t(uint32_t(uint16_t(r_PtxU16Register246)) +
								   uint32_t(uint16_t(r_PtxU16Register249)));			 // PTX L3230
	r_PtxU16Register251 = r_PtxU16Register250 & 224;									 // PTX L3231
	r_PtxU16Register252 = uint16_t(r_PtxU16Register246) - uint16_t(r_PtxU16Register251); // PTX L3232
	r_PtxRegister1153 = uint32_t(r_PtxU16Register252);									 // PTX L3233
	r_PtxRegister1154 = SignExtendByteBits(r_PtxRegister1153);							 // PTX L3234
	r_PtxU16Register253 = ShiftRight(uint16_t(r_PtxU16Register250), uint32_t(5));		 // PTX L3235
	r_PtxRegister1155 =
		ShuffleIdxPredicate(r_bPtxPredicate81, r_PtxRegister943, r_PtxRegister1154, 31, -1); // PTX L3236
	r_PtxU16Register254 = r_PtxU16Register253 & 1;											 // PTX L3237
	r_bPtxPredicate82 = uint16_t(r_PtxU16Register254) != uint16_t(0);						 // PTX L3238
	r_PtxU16Register255 = uint16_t(r_PtxRegister1155);
	r_PtxU16Register256 = uint16_t(r_PtxRegister1155 >> 16);							  // PTX L3239
	r_PtxU16Register257 = r_bPtxPredicate82 ? r_PtxU16Register256 : r_PtxU16Register255;  // PTX L3240
	r_PackedHalf2AtPtx3241R986 = JoinHalfwords(r_PtxU16Register257, r_PtxU16Register257); // PTX L3241
	r_PtxRegister1156 = uint32_t(r_PtxRegister1146) + uint32_t(40);						  // PTX L3242
	r_PtxRegister1157 = ShiftRightSigned(int32_t(r_PtxRegister1156), uint32_t(31));		  // PTX L3243
	r_PtxRegister1158 = ShiftRight(uint32_t(r_PtxRegister1157), uint32_t(26));			  // PTX L3244
	r_PtxRegister1159 = uint32_t(r_PtxRegister1156) + uint32_t(r_PtxRegister1158);		  // PTX L3245
	r_PtxRegister1160 = r_PtxRegister1159 & 65472;										  // PTX L3246
	r_PtxRegister1161 = uint32_t(r_PtxRegister1156) - uint32_t(r_PtxRegister1160);		  // PTX L3247
	r_PtxU16Register258 = uint16_t(r_PtxRegister1161);									  // PTX L3248
	r_PtxU16Register259 = uint16_t(SignExtendByteBits(r_PtxRegister1161));				  // PTX L3249
	r_PtxU16Register260 = ShiftRight(uint16_t(r_PtxU16Register259), uint32_t(10));		  // PTX L3250
	r_PtxU16Register261 = r_PtxU16Register260 & 31;										  // PTX L3251
	r_PtxU16Register262 = uint16_t(uint32_t(uint16_t(r_PtxU16Register258)) +
								   uint32_t(uint16_t(r_PtxU16Register261)));			 // PTX L3252
	r_PtxU16Register263 = r_PtxU16Register262 & 224;									 // PTX L3253
	r_PtxU16Register264 = uint16_t(r_PtxU16Register258) - uint16_t(r_PtxU16Register263); // PTX L3254
	r_PtxRegister1162 = uint32_t(r_PtxU16Register264);									 // PTX L3255
	r_PtxRegister1163 = SignExtendByteBits(r_PtxRegister1162);							 // PTX L3256
	r_PtxU16Register265 = ShiftRight(uint16_t(r_PtxU16Register262), uint32_t(5));		 // PTX L3257
	r_PtxRegister1164 =
		ShuffleIdxPredicate(r_bPtxPredicate83, r_PtxRegister943, r_PtxRegister1163, 31, -1); // PTX L3258
	r_PtxU16Register266 = r_PtxU16Register265 & 1;											 // PTX L3259
	r_bPtxPredicate84 = uint16_t(r_PtxU16Register266) != uint16_t(0);						 // PTX L3260
	r_PtxU16Register267 = uint16_t(r_PtxRegister1164);
	r_PtxU16Register268 = uint16_t(r_PtxRegister1164 >> 16);							  // PTX L3261
	r_PtxU16Register269 = r_bPtxPredicate84 ? r_PtxU16Register268 : r_PtxU16Register267;  // PTX L3262
	r_PackedHalf2AtPtx3263R988 = JoinHalfwords(r_PtxU16Register269, r_PtxU16Register269); // PTX L3263
	r_PtxRegister1165 =
		ShuffleIdxPredicate(r_bPtxPredicate85, r_PtxRegister943, r_PtxRegister1154, 31, -1); // PTX L3264
	r_PtxU16Register270 = uint16_t(r_PtxRegister1165);
	r_PtxU16Register271 = uint16_t(r_PtxRegister1165 >> 16);							  // PTX L3265
	r_PtxU16Register272 = r_bPtxPredicate82 ? r_PtxU16Register271 : r_PtxU16Register270;  // PTX L3266
	r_PackedHalf2AtPtx3267R990 = JoinHalfwords(r_PtxU16Register272, r_PtxU16Register272); // PTX L3267
	r_PtxRegister1166 =
		ShuffleIdxPredicate(r_bPtxPredicate86, r_PtxRegister943, r_PtxRegister1163, 31, -1); // PTX L3268
	r_PtxU16Register273 = uint16_t(r_PtxRegister1166);
	r_PtxU16Register274 = uint16_t(r_PtxRegister1166 >> 16);							  // PTX L3269
	r_PtxU16Register275 = r_bPtxPredicate84 ? r_PtxU16Register274 : r_PtxU16Register273;  // PTX L3270
	r_PackedHalf2AtPtx3271R992 = JoinHalfwords(r_PtxU16Register275, r_PtxU16Register275); // PTX L3271
	r_LaneIndexAtPtx3273 = uint32_t((threadIdx.x & 31u));								  // PTX L3273
	r_PtxRegister1167 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3273), uint32_t(31));	  // PTX L3275
	r_PtxRegister1168 = ShiftRight(uint32_t(r_PtxRegister1167), uint32_t(30));			  // PTX L3276
	r_PtxRegister1169 = uint32_t(r_LaneIndexAtPtx3273) + uint32_t(r_PtxRegister1168);	  // PTX L3277
	r_PtxRegister1170 = ShiftRightSigned(int32_t(r_PtxRegister1169), uint32_t(2));		  // PTX L3278
	r_PtxRegister1171 = uint32_t(r_PtxRegister1170) + uint32_t(32);						  // PTX L3279
	r_PtxRegister1172 = ShiftRightSigned(int32_t(r_PtxRegister1171), uint32_t(31));		  // PTX L3280
	r_PtxRegister1173 = ShiftRight(uint32_t(r_PtxRegister1172), uint32_t(26));			  // PTX L3281
	r_PtxRegister1174 = uint32_t(r_PtxRegister1171) + uint32_t(r_PtxRegister1173);		  // PTX L3282
	r_PtxRegister1175 = r_PtxRegister1174 & 65472;										  // PTX L3283
	r_PtxRegister1176 = uint32_t(r_PtxRegister1171) - uint32_t(r_PtxRegister1175);		  // PTX L3284
	r_PtxU16Register276 = uint16_t(r_PtxRegister1176);									  // PTX L3285
	r_PtxU16Register277 = uint16_t(SignExtendByteBits(r_PtxRegister1176));				  // PTX L3286
	r_PtxU16Register278 = ShiftRight(uint16_t(r_PtxU16Register277), uint32_t(10));		  // PTX L3287
	r_PtxU16Register279 = r_PtxU16Register278 & 31;										  // PTX L3288
	r_PtxU16Register280 = uint16_t(uint32_t(uint16_t(r_PtxU16Register276)) +
								   uint32_t(uint16_t(r_PtxU16Register279)));			 // PTX L3289
	r_PtxU16Register281 = r_PtxU16Register280 & 224;									 // PTX L3290
	r_PtxU16Register282 = uint16_t(r_PtxU16Register276) - uint16_t(r_PtxU16Register281); // PTX L3291
	r_PtxRegister1177 = uint32_t(r_PtxU16Register282);									 // PTX L3292
	r_PtxRegister1178 = SignExtendByteBits(r_PtxRegister1177);							 // PTX L3293
	r_PtxU16Register283 = ShiftRight(uint16_t(r_PtxU16Register280), uint32_t(5));		 // PTX L3294
	r_PtxRegister1179 =
		ShuffleIdxPredicate(r_bPtxPredicate87, r_PtxRegister943, r_PtxRegister1178, 31, -1); // PTX L3295
	r_PtxU16Register284 = r_PtxU16Register283 & 1;											 // PTX L3296
	r_bPtxPredicate88 = uint16_t(r_PtxU16Register284) != uint16_t(0);						 // PTX L3297
	r_PtxU16Register285 = uint16_t(r_PtxRegister1179);
	r_PtxU16Register286 = uint16_t(r_PtxRegister1179 >> 16);							  // PTX L3298
	r_PtxU16Register287 = r_bPtxPredicate88 ? r_PtxU16Register286 : r_PtxU16Register285;  // PTX L3299
	r_PackedHalf2AtPtx3300R994 = JoinHalfwords(r_PtxU16Register287, r_PtxU16Register287); // PTX L3300
	r_PtxRegister1180 = uint32_t(r_PtxRegister1170) + uint32_t(40);						  // PTX L3301
	r_PtxRegister1181 = ShiftRightSigned(int32_t(r_PtxRegister1180), uint32_t(31));		  // PTX L3302
	r_PtxRegister1182 = ShiftRight(uint32_t(r_PtxRegister1181), uint32_t(26));			  // PTX L3303
	r_PtxRegister1183 = uint32_t(r_PtxRegister1180) + uint32_t(r_PtxRegister1182);		  // PTX L3304
	r_PtxRegister1184 = r_PtxRegister1183 & 65472;										  // PTX L3305
	r_PtxRegister1185 = uint32_t(r_PtxRegister1180) - uint32_t(r_PtxRegister1184);		  // PTX L3306
	r_PtxU16Register288 = uint16_t(r_PtxRegister1185);									  // PTX L3307
	r_PtxU16Register289 = uint16_t(SignExtendByteBits(r_PtxRegister1185));				  // PTX L3308
	r_PtxU16Register290 = ShiftRight(uint16_t(r_PtxU16Register289), uint32_t(10));		  // PTX L3309
	r_PtxU16Register291 = r_PtxU16Register290 & 31;										  // PTX L3310
	r_PtxU16Register292 = uint16_t(uint32_t(uint16_t(r_PtxU16Register288)) +
								   uint32_t(uint16_t(r_PtxU16Register291)));			 // PTX L3311
	r_PtxU16Register293 = r_PtxU16Register292 & 224;									 // PTX L3312
	r_PtxU16Register294 = uint16_t(r_PtxU16Register288) - uint16_t(r_PtxU16Register293); // PTX L3313
	r_PtxRegister1186 = uint32_t(r_PtxU16Register294);									 // PTX L3314
	r_PtxRegister1187 = SignExtendByteBits(r_PtxRegister1186);							 // PTX L3315
	r_PtxU16Register295 = ShiftRight(uint16_t(r_PtxU16Register292), uint32_t(5));		 // PTX L3316
	r_PtxRegister1188 =
		ShuffleIdxPredicate(r_bPtxPredicate89, r_PtxRegister943, r_PtxRegister1187, 31, -1); // PTX L3317
	r_PtxU16Register296 = r_PtxU16Register295 & 1;											 // PTX L3318
	r_bPtxPredicate90 = uint16_t(r_PtxU16Register296) != uint16_t(0);						 // PTX L3319
	r_PtxU16Register297 = uint16_t(r_PtxRegister1188);
	r_PtxU16Register298 = uint16_t(r_PtxRegister1188 >> 16);							  // PTX L3320
	r_PtxU16Register299 = r_bPtxPredicate90 ? r_PtxU16Register298 : r_PtxU16Register297;  // PTX L3321
	r_PackedHalf2AtPtx3322R996 = JoinHalfwords(r_PtxU16Register299, r_PtxU16Register299); // PTX L3322
	r_PtxRegister1189 =
		ShuffleIdxPredicate(r_bPtxPredicate91, r_PtxRegister943, r_PtxRegister1178, 31, -1); // PTX L3323
	r_PtxU16Register300 = uint16_t(r_PtxRegister1189);
	r_PtxU16Register301 = uint16_t(r_PtxRegister1189 >> 16);							  // PTX L3324
	r_PtxU16Register302 = r_bPtxPredicate88 ? r_PtxU16Register301 : r_PtxU16Register300;  // PTX L3325
	r_PackedHalf2AtPtx3326R998 = JoinHalfwords(r_PtxU16Register302, r_PtxU16Register302); // PTX L3326
	r_PtxRegister1190 =
		ShuffleIdxPredicate(r_bPtxPredicate92, r_PtxRegister943, r_PtxRegister1187, 31, -1); // PTX L3327
	r_PtxU16Register303 = uint16_t(r_PtxRegister1190);
	r_PtxU16Register304 = uint16_t(r_PtxRegister1190 >> 16);							   // PTX L3328
	r_PtxU16Register305 = r_bPtxPredicate90 ? r_PtxU16Register304 : r_PtxU16Register303;   // PTX L3329
	r_PackedHalf2AtPtx3330R1000 = JoinHalfwords(r_PtxU16Register305, r_PtxU16Register305); // PTX L3330
	r_LaneIndexAtPtx3332 = uint32_t((threadIdx.x & 31u));								   // PTX L3332
	r_PtxRegister1191 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3332), uint32_t(31));	   // PTX L3334
	r_PtxRegister1192 = ShiftRight(uint32_t(r_PtxRegister1191), uint32_t(30));			   // PTX L3335
	r_PtxRegister1193 = uint32_t(r_LaneIndexAtPtx3332) + uint32_t(r_PtxRegister1192);	   // PTX L3336
	r_PtxRegister1194 = ShiftRightSigned(int32_t(r_PtxRegister1193), uint32_t(2));		   // PTX L3337
	r_PtxRegister1195 = uint32_t(r_PtxRegister1194) + uint32_t(48);						   // PTX L3338
	r_PtxRegister1196 = ShiftRightSigned(int32_t(r_PtxRegister1195), uint32_t(31));		   // PTX L3339
	r_PtxRegister1197 = ShiftRight(uint32_t(r_PtxRegister1196), uint32_t(26));			   // PTX L3340
	r_PtxRegister1198 = uint32_t(r_PtxRegister1195) + uint32_t(r_PtxRegister1197);		   // PTX L3341
	r_PtxRegister1199 = r_PtxRegister1198 & 65472;										   // PTX L3342
	r_PtxRegister1200 = uint32_t(r_PtxRegister1195) - uint32_t(r_PtxRegister1199);		   // PTX L3343
	r_PtxU16Register306 = uint16_t(r_PtxRegister1200);									   // PTX L3344
	r_PtxU16Register307 = uint16_t(SignExtendByteBits(r_PtxRegister1200));				   // PTX L3345
	r_PtxU16Register308 = ShiftRight(uint16_t(r_PtxU16Register307), uint32_t(10));		   // PTX L3346
	r_PtxU16Register309 = r_PtxU16Register308 & 31;										   // PTX L3347
	r_PtxU16Register310 = uint16_t(uint32_t(uint16_t(r_PtxU16Register306)) +
								   uint32_t(uint16_t(r_PtxU16Register309)));			 // PTX L3348
	r_PtxU16Register311 = r_PtxU16Register310 & 224;									 // PTX L3349
	r_PtxU16Register312 = uint16_t(r_PtxU16Register306) - uint16_t(r_PtxU16Register311); // PTX L3350
	r_PtxRegister1201 = uint32_t(r_PtxU16Register312);									 // PTX L3351
	r_PtxRegister1202 = SignExtendByteBits(r_PtxRegister1201);							 // PTX L3352
	r_PtxU16Register313 = ShiftRight(uint16_t(r_PtxU16Register310), uint32_t(5));		 // PTX L3353
	r_PtxRegister1203 =
		ShuffleIdxPredicate(r_bPtxPredicate93, r_PtxRegister943, r_PtxRegister1202, 31, -1); // PTX L3354
	r_PtxU16Register314 = r_PtxU16Register313 & 1;											 // PTX L3355
	r_bPtxPredicate94 = uint16_t(r_PtxU16Register314) != uint16_t(0);						 // PTX L3356
	r_PtxU16Register315 = uint16_t(r_PtxRegister1203);
	r_PtxU16Register316 = uint16_t(r_PtxRegister1203 >> 16);							   // PTX L3357
	r_PtxU16Register317 = r_bPtxPredicate94 ? r_PtxU16Register316 : r_PtxU16Register315;   // PTX L3358
	r_PackedHalf2AtPtx3359R1002 = JoinHalfwords(r_PtxU16Register317, r_PtxU16Register317); // PTX L3359
	r_PtxRegister1204 = uint32_t(r_PtxRegister1194) + uint32_t(56);						   // PTX L3360
	r_PtxRegister1205 = ShiftRightSigned(int32_t(r_PtxRegister1204), uint32_t(31));		   // PTX L3361
	r_PtxRegister1206 = ShiftRight(uint32_t(r_PtxRegister1205), uint32_t(26));			   // PTX L3362
	r_PtxRegister1207 = uint32_t(r_PtxRegister1204) + uint32_t(r_PtxRegister1206);		   // PTX L3363
	r_PtxRegister1208 = r_PtxRegister1207 & 65472;										   // PTX L3364
	r_PtxRegister1209 = uint32_t(r_PtxRegister1204) - uint32_t(r_PtxRegister1208);		   // PTX L3365
	r_PtxU16Register318 = uint16_t(r_PtxRegister1209);									   // PTX L3366
	r_PtxU16Register319 = uint16_t(SignExtendByteBits(r_PtxRegister1209));				   // PTX L3367
	r_PtxU16Register320 = ShiftRight(uint16_t(r_PtxU16Register319), uint32_t(10));		   // PTX L3368
	r_PtxU16Register321 = r_PtxU16Register320 & 31;										   // PTX L3369
	r_PtxU16Register322 = uint16_t(uint32_t(uint16_t(r_PtxU16Register318)) +
								   uint32_t(uint16_t(r_PtxU16Register321)));			 // PTX L3370
	r_PtxU16Register323 = r_PtxU16Register322 & 224;									 // PTX L3371
	r_PtxU16Register324 = uint16_t(r_PtxU16Register318) - uint16_t(r_PtxU16Register323); // PTX L3372
	r_PtxRegister1210 = uint32_t(r_PtxU16Register324);									 // PTX L3373
	r_PtxRegister1211 = SignExtendByteBits(r_PtxRegister1210);							 // PTX L3374
	r_PtxU16Register325 = ShiftRight(uint16_t(r_PtxU16Register322), uint32_t(5));		 // PTX L3375
	r_PtxRegister1212 =
		ShuffleIdxPredicate(r_bPtxPredicate95, r_PtxRegister943, r_PtxRegister1211, 31, -1); // PTX L3376
	r_PtxU16Register326 = r_PtxU16Register325 & 1;											 // PTX L3377
	r_bPtxPredicate96 = uint16_t(r_PtxU16Register326) != uint16_t(0);						 // PTX L3378
	r_PtxU16Register327 = uint16_t(r_PtxRegister1212);
	r_PtxU16Register328 = uint16_t(r_PtxRegister1212 >> 16);							   // PTX L3379
	r_PtxU16Register329 = r_bPtxPredicate96 ? r_PtxU16Register328 : r_PtxU16Register327;   // PTX L3380
	r_PackedHalf2AtPtx3381R1004 = JoinHalfwords(r_PtxU16Register329, r_PtxU16Register329); // PTX L3381
	r_PtxRegister1213 =
		ShuffleIdxPredicate(r_bPtxPredicate97, r_PtxRegister943, r_PtxRegister1202, 31, -1); // PTX L3382
	r_PtxU16Register330 = uint16_t(r_PtxRegister1213);
	r_PtxU16Register331 = uint16_t(r_PtxRegister1213 >> 16);							   // PTX L3383
	r_PtxU16Register332 = r_bPtxPredicate94 ? r_PtxU16Register331 : r_PtxU16Register330;   // PTX L3384
	r_PackedHalf2AtPtx3385R1006 = JoinHalfwords(r_PtxU16Register332, r_PtxU16Register332); // PTX L3385
	r_PtxRegister1214 =
		ShuffleIdxPredicate(r_bPtxPredicate98, r_PtxRegister943, r_PtxRegister1211, 31, -1); // PTX L3386
	r_PtxU16Register333 = uint16_t(r_PtxRegister1214);
	r_PtxU16Register334 = uint16_t(r_PtxRegister1214 >> 16);							   // PTX L3387
	r_PtxU16Register335 = r_bPtxPredicate96 ? r_PtxU16Register334 : r_PtxU16Register333;   // PTX L3388
	r_PackedHalf2AtPtx3389R1008 = JoinHalfwords(r_PtxU16Register335, r_PtxU16Register335); // PTX L3389
	r_LaneIndexAtPtx3391 = uint32_t((threadIdx.x & 31u));								   // PTX L3391
	r_PtxRegister1215 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3391), uint32_t(31));	   // PTX L3393
	r_PtxRegister1216 = ShiftRight(uint32_t(r_PtxRegister1215), uint32_t(30));			   // PTX L3394
	r_PtxRegister1217 = uint32_t(r_LaneIndexAtPtx3391) + uint32_t(r_PtxRegister1216);	   // PTX L3395
	r_PtxRegister1218 = ShiftRightSigned(int32_t(r_PtxRegister1217), uint32_t(2));		   // PTX L3396
	r_PtxRegister1219 = uint32_t(r_PtxRegister1218) + uint32_t(48);						   // PTX L3397
	r_PtxRegister1220 = ShiftRightSigned(int32_t(r_PtxRegister1219), uint32_t(31));		   // PTX L3398
	r_PtxRegister1221 = ShiftRight(uint32_t(r_PtxRegister1220), uint32_t(26));			   // PTX L3399
	r_PtxRegister1222 = uint32_t(r_PtxRegister1219) + uint32_t(r_PtxRegister1221);		   // PTX L3400
	r_PtxRegister1223 = r_PtxRegister1222 & 65472;										   // PTX L3401
	r_PtxRegister1224 = uint32_t(r_PtxRegister1219) - uint32_t(r_PtxRegister1223);		   // PTX L3402
	r_PtxU16Register336 = uint16_t(r_PtxRegister1224);									   // PTX L3403
	r_PtxU16Register337 = uint16_t(SignExtendByteBits(r_PtxRegister1224));				   // PTX L3404
	r_PtxU16Register338 = ShiftRight(uint16_t(r_PtxU16Register337), uint32_t(10));		   // PTX L3405
	r_PtxU16Register339 = r_PtxU16Register338 & 31;										   // PTX L3406
	r_PtxU16Register340 = uint16_t(uint32_t(uint16_t(r_PtxU16Register336)) +
								   uint32_t(uint16_t(r_PtxU16Register339)));			 // PTX L3407
	r_PtxU16Register341 = r_PtxU16Register340 & 224;									 // PTX L3408
	r_PtxU16Register342 = uint16_t(r_PtxU16Register336) - uint16_t(r_PtxU16Register341); // PTX L3409
	r_PtxRegister1225 = uint32_t(r_PtxU16Register342);									 // PTX L3410
	r_PtxRegister1226 = SignExtendByteBits(r_PtxRegister1225);							 // PTX L3411
	r_PtxU16Register343 = ShiftRight(uint16_t(r_PtxU16Register340), uint32_t(5));		 // PTX L3412
	r_PtxRegister1227 =
		ShuffleIdxPredicate(r_bPtxPredicate99, r_PtxRegister943, r_PtxRegister1226, 31, -1); // PTX L3413
	r_PtxU16Register344 = r_PtxU16Register343 & 1;											 // PTX L3414
	r_bPtxPredicate100 = uint16_t(r_PtxU16Register344) != uint16_t(0);						 // PTX L3415
	r_PtxU16Register345 = uint16_t(r_PtxRegister1227);
	r_PtxU16Register346 = uint16_t(r_PtxRegister1227 >> 16);							   // PTX L3416
	r_PtxU16Register347 = r_bPtxPredicate100 ? r_PtxU16Register346 : r_PtxU16Register345;  // PTX L3417
	r_PackedHalf2AtPtx3418R1010 = JoinHalfwords(r_PtxU16Register347, r_PtxU16Register347); // PTX L3418
	r_PtxRegister1228 = uint32_t(r_PtxRegister1218) + uint32_t(56);						   // PTX L3419
	r_PtxRegister1229 = ShiftRightSigned(int32_t(r_PtxRegister1228), uint32_t(31));		   // PTX L3420
	r_PtxRegister1230 = ShiftRight(uint32_t(r_PtxRegister1229), uint32_t(26));			   // PTX L3421
	r_PtxRegister1231 = uint32_t(r_PtxRegister1228) + uint32_t(r_PtxRegister1230);		   // PTX L3422
	r_PtxRegister1232 = r_PtxRegister1231 & 65472;										   // PTX L3423
	r_PtxRegister1233 = uint32_t(r_PtxRegister1228) - uint32_t(r_PtxRegister1232);		   // PTX L3424
	r_PtxU16Register348 = uint16_t(r_PtxRegister1233);									   // PTX L3425
	r_PtxU16Register349 = uint16_t(SignExtendByteBits(r_PtxRegister1233));				   // PTX L3426
	r_PtxU16Register350 = ShiftRight(uint16_t(r_PtxU16Register349), uint32_t(10));		   // PTX L3427
	r_PtxU16Register351 = r_PtxU16Register350 & 31;										   // PTX L3428
	r_PtxU16Register352 = uint16_t(uint32_t(uint16_t(r_PtxU16Register348)) +
								   uint32_t(uint16_t(r_PtxU16Register351)));			 // PTX L3429
	r_PtxU16Register353 = r_PtxU16Register352 & 224;									 // PTX L3430
	r_PtxU16Register354 = uint16_t(r_PtxU16Register348) - uint16_t(r_PtxU16Register353); // PTX L3431
	r_PtxRegister1234 = uint32_t(r_PtxU16Register354);									 // PTX L3432
	r_PtxRegister1235 = SignExtendByteBits(r_PtxRegister1234);							 // PTX L3433
	r_PtxU16Register355 = ShiftRight(uint16_t(r_PtxU16Register352), uint32_t(5));		 // PTX L3434
	r_PtxRegister1236 =
		ShuffleIdxPredicate(r_bPtxPredicate101, r_PtxRegister943, r_PtxRegister1235, 31, -1); // PTX L3435
	r_PtxU16Register356 = r_PtxU16Register355 & 1;											  // PTX L3436
	r_bPtxPredicate102 = uint16_t(r_PtxU16Register356) != uint16_t(0);						  // PTX L3437
	r_PtxU16Register357 = uint16_t(r_PtxRegister1236);
	r_PtxU16Register358 = uint16_t(r_PtxRegister1236 >> 16);							   // PTX L3438
	r_PtxU16Register359 = r_bPtxPredicate102 ? r_PtxU16Register358 : r_PtxU16Register357;  // PTX L3439
	r_PackedHalf2AtPtx3440R1012 = JoinHalfwords(r_PtxU16Register359, r_PtxU16Register359); // PTX L3440
	r_PtxRegister1237 =
		ShuffleIdxPredicate(r_bPtxPredicate103, r_PtxRegister943, r_PtxRegister1226, 31, -1); // PTX L3441
	r_PtxU16Register360 = uint16_t(r_PtxRegister1237);
	r_PtxU16Register361 = uint16_t(r_PtxRegister1237 >> 16);							   // PTX L3442
	r_PtxU16Register362 = r_bPtxPredicate100 ? r_PtxU16Register361 : r_PtxU16Register360;  // PTX L3443
	r_PackedHalf2AtPtx3444R1014 = JoinHalfwords(r_PtxU16Register362, r_PtxU16Register362); // PTX L3444
	r_PtxRegister1238 =
		ShuffleIdxPredicate(r_bPtxPredicate104, r_PtxRegister943, r_PtxRegister1235, 31, -1); // PTX L3445
	r_PtxU16Register363 = uint16_t(r_PtxRegister1238);
	r_PtxU16Register364 = uint16_t(r_PtxRegister1238 >> 16);							   // PTX L3446
	r_PtxU16Register365 = r_bPtxPredicate102 ? r_PtxU16Register364 : r_PtxU16Register363;  // PTX L3447
	r_PackedHalf2AtPtx3448R1016 = JoinHalfwords(r_PtxU16Register365, r_PtxU16Register365); // PTX L3448
	r_LaneIndexAtPtx3450 = uint32_t((threadIdx.x & 31u));								   // PTX L3450
	r_PackedHalf2AtPtx3453R1017 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx435R1409, r_PackedHalf2AtPtx3006R954); // PTX L3453
	r_LaneIndexAtPtx3457 = uint32_t((threadIdx.x & 31u));							 // PTX L3457
	r_PackedHalf2AtPtx3460R1019 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx436R1410, r_PackedHalf2AtPtx3028R956); // PTX L3460
	r_LaneIndexAtPtx3464 = uint32_t((threadIdx.x & 31u));							 // PTX L3464
	r_PackedHalf2AtPtx3467R1018 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx437R1411, r_PackedHalf2AtPtx3032R958); // PTX L3467
	r_LaneIndexAtPtx3471 = uint32_t((threadIdx.x & 31u));							 // PTX L3471
	r_PackedHalf2AtPtx3474R1020 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx438R1412, r_PackedHalf2AtPtx3036R960); // PTX L3474
	r_LaneIndexAtPtx3478 = uint32_t((threadIdx.x & 31u));							 // PTX L3478
	r_PackedHalf2AtPtx3481R1021 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx439R1413, r_PackedHalf2AtPtx3064R962); // PTX L3481
	r_LaneIndexAtPtx3485 = uint32_t((threadIdx.x & 31u));							 // PTX L3485
	r_PackedHalf2AtPtx3488R1023 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx440R1414, r_PackedHalf2AtPtx3086R964); // PTX L3488
	r_LaneIndexAtPtx3492 = uint32_t((threadIdx.x & 31u));							 // PTX L3492
	r_PackedHalf2AtPtx3495R1022 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx441R1415, r_PackedHalf2AtPtx3090R966); // PTX L3495
	r_LaneIndexAtPtx3499 = uint32_t((threadIdx.x & 31u));							 // PTX L3499
	r_PackedHalf2AtPtx3502R1024 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx442R1416, r_PackedHalf2AtPtx3094R968); // PTX L3502
	r_LaneIndexAtPtx3506 = uint32_t((threadIdx.x & 31u));							 // PTX L3506
	r_PackedHalf2AtPtx3509R1025 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx443R1417, r_PackedHalf2AtPtx3123R970); // PTX L3509
	r_LaneIndexAtPtx3513 = uint32_t((threadIdx.x & 31u));							 // PTX L3513
	r_PackedHalf2AtPtx3516R1027 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx444R1418, r_PackedHalf2AtPtx3145R972); // PTX L3516
	r_LaneIndexAtPtx3520 = uint32_t((threadIdx.x & 31u));							 // PTX L3520
	r_PackedHalf2AtPtx3523R1026 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx445R1419, r_PackedHalf2AtPtx3149R974); // PTX L3523
	r_LaneIndexAtPtx3527 = uint32_t((threadIdx.x & 31u));							 // PTX L3527
	r_PackedHalf2AtPtx3530R1028 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx446R1420, r_PackedHalf2AtPtx3153R976); // PTX L3530
	r_LaneIndexAtPtx3534 = uint32_t((threadIdx.x & 31u));							 // PTX L3534
	r_PackedHalf2AtPtx3537R1029 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx447R1421, r_PackedHalf2AtPtx3182R978); // PTX L3537
	r_LaneIndexAtPtx3541 = uint32_t((threadIdx.x & 31u));							 // PTX L3541
	r_PackedHalf2AtPtx3544R1031 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx448R1422, r_PackedHalf2AtPtx3204R980); // PTX L3544
	r_LaneIndexAtPtx3548 = uint32_t((threadIdx.x & 31u));							 // PTX L3548
	r_PackedHalf2AtPtx3551R1030 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx449R1423, r_PackedHalf2AtPtx3208R982); // PTX L3551
	r_LaneIndexAtPtx3555 = uint32_t((threadIdx.x & 31u));							 // PTX L3555
	r_PackedHalf2AtPtx3558R1032 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx450R1424, r_PackedHalf2AtPtx3212R984); // PTX L3558
	r_LaneIndexAtPtx3562 = uint32_t((threadIdx.x & 31u));							 // PTX L3562
	r_PackedHalf2AtPtx3565R1033 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx451R1425, r_PackedHalf2AtPtx3241R986); // PTX L3565
	r_LaneIndexAtPtx3569 = uint32_t((threadIdx.x & 31u));							 // PTX L3569
	r_PackedHalf2AtPtx3572R1035 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx452R1426, r_PackedHalf2AtPtx3263R988); // PTX L3572
	r_LaneIndexAtPtx3576 = uint32_t((threadIdx.x & 31u));							 // PTX L3576
	r_PackedHalf2AtPtx3579R1034 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx453R1427, r_PackedHalf2AtPtx3267R990); // PTX L3579
	r_LaneIndexAtPtx3583 = uint32_t((threadIdx.x & 31u));							 // PTX L3583
	r_PackedHalf2AtPtx3586R1036 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx454R1428, r_PackedHalf2AtPtx3271R992); // PTX L3586
	r_LaneIndexAtPtx3590 = uint32_t((threadIdx.x & 31u));							 // PTX L3590
	r_PackedHalf2AtPtx3593R1037 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx455R1429, r_PackedHalf2AtPtx3300R994); // PTX L3593
	r_LaneIndexAtPtx3597 = uint32_t((threadIdx.x & 31u));							 // PTX L3597
	r_PackedHalf2AtPtx3600R1039 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx456R1430, r_PackedHalf2AtPtx3322R996); // PTX L3600
	r_LaneIndexAtPtx3604 = uint32_t((threadIdx.x & 31u));							 // PTX L3604
	r_PackedHalf2AtPtx3607R1038 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx457R1431, r_PackedHalf2AtPtx3326R998); // PTX L3607
	r_LaneIndexAtPtx3611 = uint32_t((threadIdx.x & 31u));							 // PTX L3611
	r_PackedHalf2AtPtx3614R1040 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx458R1432, r_PackedHalf2AtPtx3330R1000); // PTX L3614
	r_LaneIndexAtPtx3618 = uint32_t((threadIdx.x & 31u));							  // PTX L3618
	r_PackedHalf2AtPtx3621R1041 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx459R1433, r_PackedHalf2AtPtx3359R1002); // PTX L3621
	r_LaneIndexAtPtx3625 = uint32_t((threadIdx.x & 31u));							  // PTX L3625
	r_PackedHalf2AtPtx3628R1043 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx460R1434, r_PackedHalf2AtPtx3381R1004); // PTX L3628
	r_LaneIndexAtPtx3632 = uint32_t((threadIdx.x & 31u));							  // PTX L3632
	r_PackedHalf2AtPtx3635R1042 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx461R1435, r_PackedHalf2AtPtx3385R1006); // PTX L3635
	r_LaneIndexAtPtx3639 = uint32_t((threadIdx.x & 31u));							  // PTX L3639
	r_PackedHalf2AtPtx3642R1044 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx462R1436, r_PackedHalf2AtPtx3389R1008); // PTX L3642
	r_LaneIndexAtPtx3646 = uint32_t((threadIdx.x & 31u));							  // PTX L3646
	r_PackedHalf2AtPtx3649R1045 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx463R1437, r_PackedHalf2AtPtx3418R1010); // PTX L3649
	r_LaneIndexAtPtx3653 = uint32_t((threadIdx.x & 31u));							  // PTX L3653
	r_PackedHalf2AtPtx3656R1047 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx464R1438, r_PackedHalf2AtPtx3440R1012); // PTX L3656
	r_LaneIndexAtPtx3660 = uint32_t((threadIdx.x & 31u));							  // PTX L3660
	r_PackedHalf2AtPtx3663R1046 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx465R1439, r_PackedHalf2AtPtx3444R1014); // PTX L3663
	r_LaneIndexAtPtx3667 = uint32_t((threadIdx.x & 31u));							  // PTX L3667
	r_PackedHalf2AtPtx3670R1048 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx466R1440, r_PackedHalf2AtPtx3448R1016);			 // PTX L3670
	r_ConvertedE4PairAtPtx3674Rs94 = PublishE4(r_PackedHalf2AtPtx3453R1017);					 // PTX L3674
	r_ConvertedE4PairAtPtx3677Rs95 = PublishE4(r_PackedHalf2AtPtx3467R1018);					 // PTX L3677
	r_ConvertedE4PairAtPtx3680Rs96 = PublishE4(r_PackedHalf2AtPtx3460R1019);					 // PTX L3680
	r_ConvertedE4PairAtPtx3683Rs97 = PublishE4(r_PackedHalf2AtPtx3474R1020);					 // PTX L3683
	r_ConvertedE4PairAtPtx3686Rs98 = PublishE4(r_PackedHalf2AtPtx3481R1021);					 // PTX L3686
	r_ConvertedE4PairAtPtx3689Rs99 = PublishE4(r_PackedHalf2AtPtx3495R1022);					 // PTX L3689
	r_ConvertedE4PairAtPtx3692Rs100 = PublishE4(r_PackedHalf2AtPtx3488R1023);					 // PTX L3692
	r_ConvertedE4PairAtPtx3695Rs101 = PublishE4(r_PackedHalf2AtPtx3502R1024);					 // PTX L3695
	r_ConvertedE4PairAtPtx3698Rs102 = PublishE4(r_PackedHalf2AtPtx3509R1025);					 // PTX L3698
	r_ConvertedE4PairAtPtx3701Rs103 = PublishE4(r_PackedHalf2AtPtx3523R1026);					 // PTX L3701
	r_ConvertedE4PairAtPtx3704Rs104 = PublishE4(r_PackedHalf2AtPtx3516R1027);					 // PTX L3704
	r_ConvertedE4PairAtPtx3707Rs105 = PublishE4(r_PackedHalf2AtPtx3530R1028);					 // PTX L3707
	r_ConvertedE4PairAtPtx3710Rs106 = PublishE4(r_PackedHalf2AtPtx3537R1029);					 // PTX L3710
	r_ConvertedE4PairAtPtx3713Rs107 = PublishE4(r_PackedHalf2AtPtx3551R1030);					 // PTX L3713
	r_ConvertedE4PairAtPtx3716Rs108 = PublishE4(r_PackedHalf2AtPtx3544R1031);					 // PTX L3716
	r_ConvertedE4PairAtPtx3719Rs109 = PublishE4(r_PackedHalf2AtPtx3558R1032);					 // PTX L3719
	r_ConvertedE4PairAtPtx3722Rs110 = PublishE4(r_PackedHalf2AtPtx3565R1033);					 // PTX L3722
	r_ConvertedE4PairAtPtx3725Rs111 = PublishE4(r_PackedHalf2AtPtx3579R1034);					 // PTX L3725
	r_ConvertedE4PairAtPtx3728Rs112 = PublishE4(r_PackedHalf2AtPtx3572R1035);					 // PTX L3728
	r_ConvertedE4PairAtPtx3731Rs113 = PublishE4(r_PackedHalf2AtPtx3586R1036);					 // PTX L3731
	r_ConvertedE4PairAtPtx3734Rs114 = PublishE4(r_PackedHalf2AtPtx3593R1037);					 // PTX L3734
	r_ConvertedE4PairAtPtx3737Rs115 = PublishE4(r_PackedHalf2AtPtx3607R1038);					 // PTX L3737
	r_ConvertedE4PairAtPtx3740Rs116 = PublishE4(r_PackedHalf2AtPtx3600R1039);					 // PTX L3740
	r_ConvertedE4PairAtPtx3743Rs117 = PublishE4(r_PackedHalf2AtPtx3614R1040);					 // PTX L3743
	r_ConvertedE4PairAtPtx3746Rs118 = PublishE4(r_PackedHalf2AtPtx3621R1041);					 // PTX L3746
	r_ConvertedE4PairAtPtx3749Rs119 = PublishE4(r_PackedHalf2AtPtx3635R1042);					 // PTX L3749
	r_ConvertedE4PairAtPtx3752Rs120 = PublishE4(r_PackedHalf2AtPtx3628R1043);					 // PTX L3752
	r_ConvertedE4PairAtPtx3755Rs121 = PublishE4(r_PackedHalf2AtPtx3642R1044);					 // PTX L3755
	r_ConvertedE4PairAtPtx3758Rs122 = PublishE4(r_PackedHalf2AtPtx3649R1045);					 // PTX L3758
	r_ConvertedE4PairAtPtx3761Rs123 = PublishE4(r_PackedHalf2AtPtx3663R1046);					 // PTX L3761
	r_ConvertedE4PairAtPtx3764Rs124 = PublishE4(r_PackedHalf2AtPtx3656R1047);					 // PTX L3764
	r_ConvertedE4PairAtPtx3767Rs125 = PublishE4(r_PackedHalf2AtPtx3670R1048);					 // PTX L3767
	r_ThreadYAtPtx3769 = uint32_t(threadIdx.y);													 // PTX L3769
	r_PtxRegister1239 = ShiftLeft(uint32_t(r_ThreadYAtPtx3769), uint32_t(2));					 // PTX L3770
	r_CtaYAtPtx3771 = uint32_t(blockIdx.y);														 // PTX L3771
	r_PtxRegister1241 = ShiftLeft(uint32_t(r_CtaYAtPtx3771), uint32_t(4));						 // PTX L3772
	r_PtxRegister1242 = uint32_t(r_PtxRegister1239) + uint32_t(r_PtxRegister1241);				 // PTX L3773
	r_bPtxPredicate105 = int32_t(r_PtxRegister1242) >= int32_t(r_PtxRegister5);					 // PTX L3774
	r_CtaXAtPtx3775 = uint32_t(blockIdx.x);														 // PTX L3775
	r_PtxRegister1243 = ShiftLeft(uint32_t(r_CtaXAtPtx3775), uint32_t(7));						 // PTX L3776
	r_PtxRegister1244 = ShiftLeft(uint32_t(r_PtxRegister1242), uint32_t(12));					 // PTX L3777
	r_PtxRegister1245 = uint32_t(r_PtxRegister1244) + uint32_t(r_PtxRegister1243);				 // PTX L3778
	r_PtxU64Register53 = uint64_t(int64_t(int32_t(r_PtxRegister1245)) * int64_t(int32_t(4)));	 // PTX L3779
	g_OutputByteAddressAtPtx3780 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register53); // PTX L3780
	if (r_bPtxPredicate105)
	{
		goto L__BB55_67;
	} // PTX L3781
	r_PackedE4WordAtPtx3782R1250 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3692Rs100, r_ConvertedE4PairAtPtx3695Rs101); // PTX L3782
	r_PackedE4WordAtPtx3783R1249 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3686Rs98, r_ConvertedE4PairAtPtx3689Rs99); // PTX L3783
	r_PackedE4WordAtPtx3784R1248 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3680Rs96, r_ConvertedE4PairAtPtx3683Rs97); // PTX L3784
	r_PackedE4WordAtPtx3785R1247 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3674Rs94, r_ConvertedE4PairAtPtx3677Rs95);			  // PTX L3785
	r_LaneIndexAtPtx3787 = uint32_t((threadIdx.x & 31u));										  // PTX L3787
	r_PtxU64Register55 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3787)) * int64_t(int32_t(16))); // PTX L3789
	g_OutputByteAddressAtPtx3790 =
		uint64_t(g_OutputByteAddressAtPtx3780) + uint64_t(r_PtxU64Register55); // PTX L3790
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx3790,
					make_uint4(r_PackedE4WordAtPtx3785R1247, r_PackedE4WordAtPtx3784R1248,
							   r_PackedE4WordAtPtx3783R1249,
							   r_PackedE4WordAtPtx3782R1250));					// PTX L3792
L__BB55_67:																		// PTX L3794
	r_PtxRegister1251 = r_PtxRegister1242 | 1;									// PTX L3795
	r_bPtxPredicate106 = int32_t(r_PtxRegister1251) >= int32_t(r_PtxRegister5); // PTX L3796
	if (r_bPtxPredicate106)
	{
		goto L__BB55_69;
	} // PTX L3797
	r_LaneIndexAtPtx3799 = uint32_t((threadIdx.x & 31u));										  // PTX L3799
	r_PtxU64Register57 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3799)) * int64_t(int32_t(16))); // PTX L3801
	g_OutputByteAddressAtPtx3802 =
		uint64_t(g_OutputByteAddressAtPtx3780) + uint64_t(r_PtxU64Register57);				 // PTX L3802
	g_OutputByteAddressAtPtx3803 = uint64_t(g_OutputByteAddressAtPtx3802) + uint64_t(16384); // PTX L3803
	r_PackedE4WordAtPtx3804R1256 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3716Rs108, r_ConvertedE4PairAtPtx3719Rs109); // PTX L3804
	r_PackedE4WordAtPtx3805R1255 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3710Rs106, r_ConvertedE4PairAtPtx3713Rs107); // PTX L3805
	r_PackedE4WordAtPtx3806R1254 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3704Rs104, r_ConvertedE4PairAtPtx3707Rs105); // PTX L3806
	r_PackedE4WordAtPtx3807R1253 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3698Rs102, r_ConvertedE4PairAtPtx3701Rs103); // PTX L3807
	StoreNoAllocate(g_OutputByteAddressAtPtx3803,
					make_uint4(r_PackedE4WordAtPtx3807R1253, r_PackedE4WordAtPtx3806R1254,
							   r_PackedE4WordAtPtx3805R1255,
							   r_PackedE4WordAtPtx3804R1256));					// PTX L3809
L__BB55_69:																		// PTX L3811
	r_PtxRegister1257 = r_PtxRegister1242 | 2;									// PTX L3812
	r_bPtxPredicate107 = int32_t(r_PtxRegister1257) >= int32_t(r_PtxRegister5); // PTX L3813
	if (r_bPtxPredicate107)
	{
		goto L__BB55_71;
	} // PTX L3814
	r_LaneIndexAtPtx3816 = uint32_t((threadIdx.x & 31u));										  // PTX L3816
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3816)) * int64_t(int32_t(16))); // PTX L3818
	g_OutputByteAddressAtPtx3819 =
		uint64_t(g_OutputByteAddressAtPtx3780) + uint64_t(r_PtxU64Register60);				 // PTX L3819
	g_OutputByteAddressAtPtx3820 = uint64_t(g_OutputByteAddressAtPtx3819) + uint64_t(32768); // PTX L3820
	r_PackedE4WordAtPtx3821R1262 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3740Rs116, r_ConvertedE4PairAtPtx3743Rs117); // PTX L3821
	r_PackedE4WordAtPtx3822R1261 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3734Rs114, r_ConvertedE4PairAtPtx3737Rs115); // PTX L3822
	r_PackedE4WordAtPtx3823R1260 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3728Rs112, r_ConvertedE4PairAtPtx3731Rs113); // PTX L3823
	r_PackedE4WordAtPtx3824R1259 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3722Rs110, r_ConvertedE4PairAtPtx3725Rs111); // PTX L3824
	StoreNoAllocate(g_OutputByteAddressAtPtx3820,
					make_uint4(r_PackedE4WordAtPtx3824R1259, r_PackedE4WordAtPtx3823R1260,
							   r_PackedE4WordAtPtx3822R1261,
							   r_PackedE4WordAtPtx3821R1262));					// PTX L3826
L__BB55_71:																		// PTX L3828
	r_PtxRegister1263 = r_PtxRegister1242 | 3;									// PTX L3829
	r_bPtxPredicate108 = int32_t(r_PtxRegister1263) >= int32_t(r_PtxRegister5); // PTX L3830
	if (r_bPtxPredicate108)
	{
		goto L__BB55_73;
	} // PTX L3831
	r_LaneIndexAtPtx3833 = uint32_t((threadIdx.x & 31u));										  // PTX L3833
	r_PtxU64Register63 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3833)) * int64_t(int32_t(16))); // PTX L3835
	g_OutputByteAddressAtPtx3836 =
		uint64_t(g_OutputByteAddressAtPtx3780) + uint64_t(r_PtxU64Register63);				 // PTX L3836
	g_OutputByteAddressAtPtx3837 = uint64_t(g_OutputByteAddressAtPtx3836) + uint64_t(49152); // PTX L3837
	r_PackedE4WordAtPtx3838R1268 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3764Rs124, r_ConvertedE4PairAtPtx3767Rs125); // PTX L3838
	r_PackedE4WordAtPtx3839R1267 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3758Rs122, r_ConvertedE4PairAtPtx3761Rs123); // PTX L3839
	r_PackedE4WordAtPtx3840R1266 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3752Rs120, r_ConvertedE4PairAtPtx3755Rs121); // PTX L3840
	r_PackedE4WordAtPtx3841R1265 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3746Rs118, r_ConvertedE4PairAtPtx3749Rs119); // PTX L3841
	StoreNoAllocate(g_OutputByteAddressAtPtx3837,
					make_uint4(r_PackedE4WordAtPtx3841R1265, r_PackedE4WordAtPtx3840R1266,
							   r_PackedE4WordAtPtx3839R1267,
							   r_PackedE4WordAtPtx3838R1268));	  // PTX L3843
L__BB55_73:														  // PTX L3845
	r_bPtxPredicate109 = uint32_t(r_PtxRegister3) == uint32_t(0); // PTX L3846
	r_PtxRegister1442 = uint32_t(0);							  // PTX L3847
	if (r_bPtxPredicate109)
	{
		goto L__BB55_75;
	} // PTX L3848
	r_PtxRegister1269 = uint32_t(r_PtxRegister3) + uint32_t(-1);					// PTX L3849
	r_PtxRegister1270 = ShiftRightSigned(int32_t(r_PtxRegister1269), uint32_t(31)); // PTX L3850
	r_PtxRegister1271 = ShiftRight(uint32_t(r_PtxRegister1270), uint32_t(27));		// PTX L3851
	r_PtxRegister1272 = uint32_t(r_PtxRegister1269) + uint32_t(r_PtxRegister1271);	// PTX L3852
	r_PtxRegister1273 = r_PtxRegister1272 & -32;									// PTX L3853
	r_PtxRegister1442 = uint32_t(r_PtxRegister1273) + uint32_t(32);					// PTX L3854
L__BB55_75:																			// PTX L3855
	r_bPtxPredicate110 = uint32_t(r_PtxRegister1442) == uint32_t(r_PtxRegister3);	// PTX L3856
	if (r_bPtxPredicate110)
	{
		goto L__BB55_82;
	} // PTX L3857
	__syncthreads();																// PTX L3858
	r_PtxRegister1274 = uint32_t(r_PtxRegister3) + uint32_t(127);					// PTX L3859
	r_PtxRegister1275 = ShiftRightSigned(int32_t(r_PtxRegister1274), uint32_t(31)); // PTX L3860
	r_PtxRegister1276 = ShiftRight(uint32_t(r_PtxRegister1275), uint32_t(25));		// PTX L3861
	r_PtxRegister1277 = uint32_t(r_PtxRegister1274) + uint32_t(r_PtxRegister1276);	// PTX L3862
	r_PtxRegister1278 = ShiftRightSigned(int32_t(r_PtxRegister1277), uint32_t(7));	// PTX L3863
	r_PtxRegister1279 = uint32_t(r_PtxRegister1278) + uint32_t(1);					// PTX L3864
	r_PtxRegister1280 = ShiftRight(uint32_t(r_PtxRegister1279), uint32_t(31));		// PTX L3865
	r_PtxRegister1281 = uint32_t(r_PtxRegister1279) + uint32_t(r_PtxRegister1280);	// PTX L3866
	r_PtxRegister1282 = ShiftRightSigned(int32_t(r_PtxRegister1281), uint32_t(1));	// PTX L3867
	r_PtxRegister1283 = uint32_t(r_PtxRegister1282) + uint32_t(-1);					// PTX L3868
	r_bPtxPredicate111 = uint32_t(r_CtaYAtPtx3771) != uint32_t(r_PtxRegister1283);	// PTX L3869
	if (r_bPtxPredicate111)
	{
		goto L__BB55_82;
	} // PTX L3870
	r_PtxRegister1284 = uint32_t(r_PtxRegister1442) - uint32_t(r_PtxRegister3); // PTX L3871
	r_PtxRegister37 = ShiftLeft(uint32_t(r_PtxRegister1284), uint32_t(3));		// PTX L3872
	r_BlockSizeYAtPtx3873 = uint32_t(blockDim.y);								// PTX L3873
	r_ThreadZAtPtx3874 = uint32_t(threadIdx.z);									// PTX L3874
	r_PtxRegister1285 = uint32_t(r_ThreadZAtPtx3874) * uint32_t(r_BlockSizeYAtPtx3873) +
						uint32_t(r_ThreadYAtPtx3769); // PTX L3875
	r_BlockSizeXAtPtx3876 = uint32_t(blockDim.x);	  // PTX L3876
	r_ThreadXAtPtx3877 = uint32_t(threadIdx.x);		  // PTX L3877
	r_PtxRegister1443 = uint32_t(r_PtxRegister1285) * uint32_t(r_BlockSizeXAtPtx3876) +
						uint32_t(r_ThreadXAtPtx3877);									   // PTX L3878
	r_PtxRegister1286 = uint32_t(r_BlockSizeXAtPtx3876) * uint32_t(r_BlockSizeYAtPtx3873); // PTX L3879
	r_BlockSizeZ = uint32_t(blockDim.z);												   // PTX L3880
	r_PtxRegister43 = uint32_t(r_PtxRegister1286) * uint32_t(r_BlockSizeZ);				   // PTX L3881
	r_bPtxPredicate112 = int32_t(r_PtxRegister1443) >= int32_t(r_PtxRegister37);		   // PTX L3882
	if (r_bPtxPredicate112)
	{
		goto L__BB55_82;
	} // PTX L3883
	r_PtxRegister44 = ShiftLeft(uint32_t(r_CtaXAtPtx3775), uint32_t(5));	   // PTX L3884
	g_OutputByteAddressAtPtx3885 = g_OutputBaseAddress;						   // PTX L3885
	r_PtxRegister1287 = uint32_t(r_ThreadZAtPtx3874) + uint32_t(r_BlockSizeZ); // PTX L3886
	r_PtxRegister1288 = uint32_t(r_BlockSizeYAtPtx3873) * uint32_t(r_PtxRegister1287) +
						uint32_t(r_ThreadYAtPtx3769); // PTX L3887
	r_PtxRegister1289 = uint32_t(r_BlockSizeXAtPtx3876) * uint32_t(r_PtxRegister1288) +
						uint32_t(r_ThreadXAtPtx3877);										 // PTX L3888
	r_PtxRegister1290 = uint32_t(max(int32_t(r_PtxRegister1289), int32_t(r_PtxRegister37))); // PTX L3889
	r_bPtxPredicate113 = int32_t(r_PtxRegister1289) < int32_t(r_PtxRegister37);				 // PTX L3890
	r_PtxRegister1291 = r_bPtxPredicate113 ? 1 : 0;											 // PTX L3891
	r_PtxRegister1292 = uint32_t(r_PtxRegister1289) + uint32_t(r_PtxRegister1291);			 // PTX L3892
	r_PtxRegister1293 = uint32_t(r_PtxRegister1290) - uint32_t(r_PtxRegister1292);			 // PTX L3893
	r_PtxRegister1294 = uint32_t(uint32_t(r_PtxRegister1293) / uint32_t(r_PtxRegister43));	 // PTX L3894
	r_PtxRegister45 = uint32_t(r_PtxRegister1294) + uint32_t(r_PtxRegister1291);			 // PTX L3895
	r_PtxRegister1295 = r_PtxRegister45 & 1;												 // PTX L3896
	r_bPtxPredicate114 = uint32_t(r_PtxRegister1295) != uint32_t(0);						 // PTX L3897
	if (r_bPtxPredicate114)
	{
		goto L__BB55_80;
	} // PTX L3898
	r_PtxRegister1296 = ShiftRight(uint32_t(r_PtxRegister1443), uint32_t(3));		// PTX L3899
	r_PtxRegister1297 = uint32_t(r_PtxRegister1296) + uint32_t(r_PtxRegister3);		// PTX L3900
	r_PtxRegister1298 = ShiftLeft(uint32_t(r_PtxRegister1443), uint32_t(2));		// PTX L3901
	r_PtxRegister1299 = r_PtxRegister1298 & 28;										// PTX L3902
	r_PtxRegister1300 = uint32_t(r_PtxRegister44) + uint32_t(r_PtxRegister1299);	// PTX L3903
	r_PtxRegister1301 = ShiftRightSigned(int32_t(r_PtxRegister1297), uint32_t(31)); // PTX L3904
	r_PtxRegister1302 = ShiftRight(uint32_t(r_PtxRegister1301), uint32_t(28));		// PTX L3905
	r_PtxRegister1303 = uint32_t(r_PtxRegister1297) + uint32_t(r_PtxRegister1302);	// PTX L3906
	r_PtxRegister1304 = r_PtxRegister1303 & 65520;									// PTX L3907
	r_PtxRegister1305 = uint32_t(r_PtxRegister1297) - uint32_t(r_PtxRegister1304);	// PTX L3908
	r_PtxRegister1306 = r_PtxRegister1298 & 12;										// PTX L3909
	r_PtxU16Register366 = uint16_t(r_PtxRegister1305);								// PTX L3910
	r_PtxU16Register367 = uint16_t(SignExtendByteBits(r_PtxRegister1305));			// PTX L3911
	r_PtxU16Register368 = ShiftRight(uint16_t(r_PtxU16Register367), uint32_t(12));	// PTX L3912
	r_PtxU16Register369 = r_PtxU16Register368 & 7;									// PTX L3913
	r_PtxU16Register370 = uint16_t(uint32_t(uint16_t(r_PtxU16Register366)) +
								   uint32_t(uint16_t(r_PtxU16Register369)));			 // PTX L3914
	r_PtxU16Register371 = r_PtxU16Register370 & 248;									 // PTX L3915
	r_PtxU16Register372 = uint16_t(r_PtxU16Register366) - uint16_t(r_PtxU16Register371); // PTX L3916
	r_PtxU16Register373 = uint16_t(SignExtendByteBits(r_PtxU16Register370));			 // PTX L3917
	r_PtxU16Register374 = uint16_t(
		ShiftRightSigned(int32_t(SignExtendHalfBits(r_PtxU16Register373)), uint32_t(3))); // PTX L3918
	r_PtxRegister1307 = SignExtendHalfBits(r_PtxU16Register374);						  // PTX L3919
	r_PtxRegister1308 = ShiftRight(uint32_t(r_PtxRegister1443), uint32_t(1));			  // PTX L3920
	r_PtxRegister1309 = r_PtxRegister1308 & 2;											  // PTX L3921
	r_PtxU16Register375 = uint16_t(SignExtendByteBits(r_PtxU16Register372));			  // PTX L3922
	r_PtxRegister1310 = uint32_t(int64_t(int32_t(SignExtendHalfBits(r_PtxU16Register375))) *
								 int64_t(int32_t(SignExtendHalfBits(16))));					  // PTX L3923
	r_PtxRegister1311 = r_PtxRegister1310 | r_PtxRegister1306;								  // PTX L3924
	r_PtxRegister1312 = ShiftLeft(uint32_t(r_PtxRegister1303), uint32_t(8));				  // PTX L3925
	r_PtxRegister1313 = r_PtxRegister1312 & -4096;											  // PTX L3926
	r_PtxRegister1314 = ShiftLeft(uint32_t(r_PtxRegister1300), uint32_t(2));				  // PTX L3927
	r_PtxRegister1315 = r_PtxRegister1314 & -128;											  // PTX L3928
	r_PtxRegister1316 = uint32_t(r_PtxRegister1313) + uint32_t(r_PtxRegister1315);			  // PTX L3929
	r_PtxRegister1317 = uint32_t(r_PtxRegister1316) + uint32_t(r_PtxRegister1307);			  // PTX L3930
	r_PtxRegister1318 = uint32_t(r_PtxRegister1317) + uint32_t(r_PtxRegister1309);			  // PTX L3931
	r_PtxRegister1319 = uint32_t(r_PtxRegister1318) + uint32_t(r_PtxRegister1311);			  // PTX L3932
	r_PtxU64Register65 = uint64_t(int64_t(int32_t(r_PtxRegister1319)) * int64_t(int32_t(4))); // PTX L3933
	g_OutputByteAddressAtPtx3934 =
		uint64_t(g_OutputByteAddressAtPtx3885) + uint64_t(r_PtxU64Register65);	 // PTX L3934
	*reinterpret_cast<uint32_t*>(g_OutputByteAddressAtPtx3934) = 0;				 // PTX L3935
	r_PtxRegister1443 = uint32_t(r_PtxRegister1443) + uint32_t(r_PtxRegister43); // PTX L3936
L__BB55_80:																		 // PTX L3937
	r_bPtxPredicate115 = uint32_t(r_PtxRegister45) == uint32_t(0);				 // PTX L3938
	if (r_bPtxPredicate115)
	{
		goto L__BB55_82;
	} // PTX L3939
L__BB55_81:																			// PTX L3940
	r_PtxRegister1320 = ShiftRight(uint32_t(r_PtxRegister1443), uint32_t(3));		// PTX L3941
	r_PtxRegister1321 = uint32_t(r_PtxRegister1320) + uint32_t(r_PtxRegister3);		// PTX L3942
	r_PtxRegister1322 = ShiftLeft(uint32_t(r_PtxRegister1443), uint32_t(2));		// PTX L3943
	r_PtxRegister1323 = r_PtxRegister1322 & 28;										// PTX L3944
	r_PtxRegister1324 = uint32_t(r_PtxRegister44) + uint32_t(r_PtxRegister1323);	// PTX L3945
	r_PtxRegister1325 = ShiftRightSigned(int32_t(r_PtxRegister1321), uint32_t(31)); // PTX L3946
	r_PtxRegister1326 = ShiftRight(uint32_t(r_PtxRegister1325), uint32_t(28));		// PTX L3947
	r_PtxRegister1327 = uint32_t(r_PtxRegister1321) + uint32_t(r_PtxRegister1326);	// PTX L3948
	r_PtxRegister1328 = r_PtxRegister1327 & 65520;									// PTX L3949
	r_PtxRegister1329 = uint32_t(r_PtxRegister1321) - uint32_t(r_PtxRegister1328);	// PTX L3950
	r_PtxRegister1330 = r_PtxRegister1322 & 12;										// PTX L3951
	r_PtxU16Register376 = uint16_t(r_PtxRegister1329);								// PTX L3952
	r_PtxU16Register377 = uint16_t(SignExtendByteBits(r_PtxRegister1329));			// PTX L3953
	r_PtxU16Register378 = ShiftRight(uint16_t(r_PtxU16Register377), uint32_t(12));	// PTX L3954
	r_PtxU16Register379 = r_PtxU16Register378 & 7;									// PTX L3955
	r_PtxU16Register380 = uint16_t(uint32_t(uint16_t(r_PtxU16Register376)) +
								   uint32_t(uint16_t(r_PtxU16Register379)));			 // PTX L3956
	r_PtxU16Register381 = r_PtxU16Register380 & 248;									 // PTX L3957
	r_PtxU16Register382 = uint16_t(r_PtxU16Register376) - uint16_t(r_PtxU16Register381); // PTX L3958
	r_PtxU16Register383 = uint16_t(SignExtendByteBits(r_PtxU16Register380));			 // PTX L3959
	r_PtxU16Register384 = uint16_t(
		ShiftRightSigned(int32_t(SignExtendHalfBits(r_PtxU16Register383)), uint32_t(3))); // PTX L3960
	r_PtxRegister1331 = SignExtendHalfBits(r_PtxU16Register384);						  // PTX L3961
	r_PtxRegister1332 = ShiftRight(uint32_t(r_PtxRegister1443), uint32_t(1));			  // PTX L3962
	r_PtxRegister1333 = r_PtxRegister1332 & 2;											  // PTX L3963
	r_PtxU16Register385 = uint16_t(SignExtendByteBits(r_PtxU16Register382));			  // PTX L3964
	r_PtxRegister1334 = uint32_t(int64_t(int32_t(SignExtendHalfBits(r_PtxU16Register385))) *
								 int64_t(int32_t(SignExtendHalfBits(16))));					  // PTX L3965
	r_PtxRegister1335 = r_PtxRegister1334 | r_PtxRegister1330;								  // PTX L3966
	r_PtxRegister1336 = ShiftLeft(uint32_t(r_PtxRegister1327), uint32_t(8));				  // PTX L3967
	r_PtxRegister1337 = r_PtxRegister1336 & -4096;											  // PTX L3968
	r_PtxRegister1338 = ShiftLeft(uint32_t(r_PtxRegister1324), uint32_t(2));				  // PTX L3969
	r_PtxRegister1339 = r_PtxRegister1338 & -128;											  // PTX L3970
	r_PtxRegister1340 = uint32_t(r_PtxRegister1337) + uint32_t(r_PtxRegister1339);			  // PTX L3971
	r_PtxRegister1341 = uint32_t(r_PtxRegister1340) + uint32_t(r_PtxRegister1331);			  // PTX L3972
	r_PtxRegister1342 = uint32_t(r_PtxRegister1341) + uint32_t(r_PtxRegister1333);			  // PTX L3973
	r_PtxRegister1343 = uint32_t(r_PtxRegister1342) + uint32_t(r_PtxRegister1335);			  // PTX L3974
	r_PtxU64Register67 = uint64_t(int64_t(int32_t(r_PtxRegister1343)) * int64_t(int32_t(4))); // PTX L3975
	g_OutputByteAddressAtPtx3976 =
		uint64_t(g_OutputByteAddressAtPtx3885) + uint64_t(r_PtxU64Register67);		// PTX L3976
	*reinterpret_cast<uint32_t*>(g_OutputByteAddressAtPtx3976) = 0;					// PTX L3977
	r_PtxRegister1344 = uint32_t(r_PtxRegister1443) + uint32_t(r_PtxRegister43);	// PTX L3978
	r_PtxRegister1345 = ShiftRight(uint32_t(r_PtxRegister1344), uint32_t(3));		// PTX L3979
	r_PtxRegister1346 = uint32_t(r_PtxRegister1345) + uint32_t(r_PtxRegister3);		// PTX L3980
	r_PtxRegister1347 = ShiftLeft(uint32_t(r_PtxRegister1344), uint32_t(2));		// PTX L3981
	r_PtxRegister1348 = r_PtxRegister1347 & 28;										// PTX L3982
	r_PtxRegister1349 = uint32_t(r_PtxRegister44) + uint32_t(r_PtxRegister1348);	// PTX L3983
	r_PtxRegister1350 = ShiftRightSigned(int32_t(r_PtxRegister1346), uint32_t(31)); // PTX L3984
	r_PtxRegister1351 = ShiftRight(uint32_t(r_PtxRegister1350), uint32_t(28));		// PTX L3985
	r_PtxRegister1352 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister1351);	// PTX L3986
	r_PtxRegister1353 = r_PtxRegister1352 & 65520;									// PTX L3987
	r_PtxRegister1354 = uint32_t(r_PtxRegister1346) - uint32_t(r_PtxRegister1353);	// PTX L3988
	r_PtxRegister1355 = r_PtxRegister1347 & 12;										// PTX L3989
	r_PtxU16Register386 = uint16_t(r_PtxRegister1354);								// PTX L3990
	r_PtxU16Register387 = uint16_t(SignExtendByteBits(r_PtxRegister1354));			// PTX L3991
	r_PtxU16Register388 = ShiftRight(uint16_t(r_PtxU16Register387), uint32_t(12));	// PTX L3992
	r_PtxU16Register389 = r_PtxU16Register388 & 7;									// PTX L3993
	r_PtxU16Register390 = uint16_t(uint32_t(uint16_t(r_PtxU16Register386)) +
								   uint32_t(uint16_t(r_PtxU16Register389)));			 // PTX L3994
	r_PtxU16Register391 = r_PtxU16Register390 & 248;									 // PTX L3995
	r_PtxU16Register392 = uint16_t(r_PtxU16Register386) - uint16_t(r_PtxU16Register391); // PTX L3996
	r_PtxU16Register393 = uint16_t(SignExtendByteBits(r_PtxU16Register390));			 // PTX L3997
	r_PtxU16Register394 = uint16_t(
		ShiftRightSigned(int32_t(SignExtendHalfBits(r_PtxU16Register393)), uint32_t(3))); // PTX L3998
	r_PtxRegister1356 = SignExtendHalfBits(r_PtxU16Register394);						  // PTX L3999
	r_PtxRegister1357 = ShiftRight(uint32_t(r_PtxRegister1344), uint32_t(1));			  // PTX L4000
	r_PtxRegister1358 = r_PtxRegister1357 & 2;											  // PTX L4001
	r_PtxU16Register395 = uint16_t(SignExtendByteBits(r_PtxU16Register392));			  // PTX L4002
	r_PtxRegister1359 = uint32_t(int64_t(int32_t(SignExtendHalfBits(r_PtxU16Register395))) *
								 int64_t(int32_t(SignExtendHalfBits(16))));					  // PTX L4003
	r_PtxRegister1360 = r_PtxRegister1359 | r_PtxRegister1355;								  // PTX L4004
	r_PtxRegister1361 = ShiftLeft(uint32_t(r_PtxRegister1352), uint32_t(8));				  // PTX L4005
	r_PtxRegister1362 = r_PtxRegister1361 & -4096;											  // PTX L4006
	r_PtxRegister1363 = ShiftLeft(uint32_t(r_PtxRegister1349), uint32_t(2));				  // PTX L4007
	r_PtxRegister1364 = r_PtxRegister1363 & -128;											  // PTX L4008
	r_PtxRegister1365 = uint32_t(r_PtxRegister1362) + uint32_t(r_PtxRegister1364);			  // PTX L4009
	r_PtxRegister1366 = uint32_t(r_PtxRegister1365) + uint32_t(r_PtxRegister1356);			  // PTX L4010
	r_PtxRegister1367 = uint32_t(r_PtxRegister1366) + uint32_t(r_PtxRegister1358);			  // PTX L4011
	r_PtxRegister1368 = uint32_t(r_PtxRegister1367) + uint32_t(r_PtxRegister1360);			  // PTX L4012
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_PtxRegister1368)) * int64_t(int32_t(4))); // PTX L4013
	g_OutputByteAddressAtPtx4014 =
		uint64_t(g_OutputByteAddressAtPtx3885) + uint64_t(r_PtxU64Register69);	 // PTX L4014
	*reinterpret_cast<uint32_t*>(g_OutputByteAddressAtPtx4014) = 0;				 // PTX L4015
	r_PtxRegister1443 = uint32_t(r_PtxRegister1344) + uint32_t(r_PtxRegister43); // PTX L4016
	r_bPtxPredicate116 = int32_t(r_PtxRegister1443) < int32_t(r_PtxRegister37);	 // PTX L4017
	if (r_bPtxPredicate116)
	{
		goto L__BB55_81;
	} // PTX L4018
L__BB55_82:																   // PTX L4019
	__syncthreads();													   // PTX L4020
	r_bPtxPredicate117 = uint64_t(r_CompletionCounterBits) == uint64_t(0); // PTX L4021
	if (r_bPtxPredicate117)
	{
		goto L__BB55_88;
	} // PTX L4022
	r_ThreadXAtPtx4023 = uint32_t(threadIdx.x);										// PTX L4023
	r_PtxRegister1370 = r_ThreadXAtPtx4023 | r_ThreadYAtPtx3769;					// PTX L4024
	r_ThreadZAtPtx4025 = uint32_t(threadIdx.z);										// PTX L4025
	r_PtxRegister1372 = r_PtxRegister1370 | r_ThreadZAtPtx4025;						// PTX L4026
	r_bPtxPredicate118 = uint32_t(r_PtxRegister1372) != uint32_t(0);				// PTX L4027
	r_PtxRegister1373 = uint32_t(r_PtxRegister3) + uint32_t(127);					// PTX L4028
	r_PtxRegister1374 = ShiftRightSigned(int32_t(r_PtxRegister1373), uint32_t(31)); // PTX L4029
	r_PtxRegister1375 = ShiftRight(uint32_t(r_PtxRegister1374), uint32_t(25));		// PTX L4030
	r_PtxRegister1376 = uint32_t(r_PtxRegister1373) + uint32_t(r_PtxRegister1375);	// PTX L4031
	r_PtxRegister46 = ShiftRightSigned(int32_t(r_PtxRegister1376), uint32_t(7));	// PTX L4032
	if (r_bPtxPredicate118)
	{
		goto L__BB55_88;
	} // PTX L4033
	r_PtxRegister47 = ShiftLeft(uint32_t(r_CtaYAtPtx3771), uint32_t(1));	   // PTX L4034
	r_bPtxPredicate119 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister46); // PTX L4035
	if (r_bPtxPredicate119)
	{
		goto L__BB55_86;
	} // PTX L4036
	r_PtxRegister1378 = ShiftLeft(uint32_t(r_CtaYAtPtx3771), uint32_t(6));				   // PTX L4037
	r_PtxRegister1379 = uint32_t(r_PtxRegister1378) + uint32_t(r_CtaXAtPtx3775);		   // PTX L4038
	r_PtxU64Register72 = uint64_t(uint32_t(r_PtxRegister1379)) * uint64_t(uint32_t(4));	   // PTX L4039
	r_PtxU64Register71 = uint64_t(r_CompletionCounterBits) + uint64_t(r_PtxU64Register72); // PTX L4040
	r_PtxRegister1377 = uint32_t(0);													   // PTX L4041
	// Phase: ordered_counter_publication. Global counter publication uses the original release operation. Do not move resets, waits or data writes across this boundary.
	CounterStoreRelease(r_PtxU64Register71, r_PtxRegister1377);				   // PTX L4043
L__BB55_86:																	   // PTX L4045
	r_PtxRegister48 = uint32_t(r_PtxRegister47) + uint32_t(1);				   // PTX L4046
	r_bPtxPredicate120 = int32_t(r_PtxRegister48) >= int32_t(r_PtxRegister46); // PTX L4047
	if (r_bPtxPredicate120)
	{
		goto L__BB55_88;
	} // PTX L4048
	r_PtxRegister1381 = ShiftLeft(uint32_t(r_PtxRegister48), uint32_t(5));				   // PTX L4049
	r_PtxRegister1382 = uint32_t(r_PtxRegister1381) + uint32_t(r_CtaXAtPtx3775);		   // PTX L4050
	r_PtxU64Register74 = uint64_t(uint32_t(r_PtxRegister1382)) * uint64_t(uint32_t(4));	   // PTX L4051
	r_PtxU64Register73 = uint64_t(r_CompletionCounterBits) + uint64_t(r_PtxU64Register74); // PTX L4052
	r_PtxRegister1380 = uint32_t(0);													   // PTX L4053
	CounterStoreRelease(r_PtxU64Register73, r_PtxRegister1380);							   // PTX L4055
L__BB55_88:																				   // PTX L4057
	return;																				   // PTX L4058
#endif
}
} // namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8
