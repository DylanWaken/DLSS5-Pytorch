// Readable equivalent of cc_split_swin_16h_ffwd_inpview_512_fp8; not historical source.
#pragma once
#include "window_ffn_input_view_c512_abi_fp8.cuh"

namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp8
{
__global__ __maxnreg__(168) void window_ffn_input_view_c512_fp8(Parameters r_Parameters)
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
	bool r_bPtxPredicate205, r_bPtxPredicate206, r_bPtxPredicate207, r_bPtxPredicate208, r_bPtxPredicate209;
	uint16_t r_ConvertedE4PairAtPtx2516Rs1, r_ConvertedE4PairAtPtx2519Rs2, r_ConvertedE4PairAtPtx2523Rs3,
		r_ConvertedE4PairAtPtx2526Rs4, r_ConvertedE4PairAtPtx2530Rs5, r_ConvertedE4PairAtPtx2533Rs6,
		r_ConvertedE4PairAtPtx2537Rs7, r_ConvertedE4PairAtPtx2540Rs8, r_ConvertedE4PairAtPtx2544Rs9,
		r_ConvertedE4PairAtPtx2547Rs10, r_ConvertedE4PairAtPtx2551Rs11, r_ConvertedE4PairAtPtx2554Rs12;
	uint16_t r_ConvertedE4PairAtPtx2558Rs13, r_ConvertedE4PairAtPtx2561Rs14, r_ConvertedE4PairAtPtx2565Rs15,
		r_ConvertedE4PairAtPtx2568Rs16, r_ConvertedE4PairAtPtx2572Rs17, r_ConvertedE4PairAtPtx2575Rs18,
		r_ConvertedE4PairAtPtx2579Rs19, r_ConvertedE4PairAtPtx2582Rs20, r_ConvertedE4PairAtPtx2586Rs21,
		r_ConvertedE4PairAtPtx2589Rs22, r_ConvertedE4PairAtPtx2593Rs23, r_ConvertedE4PairAtPtx2596Rs24;
	uint16_t r_ConvertedE4PairAtPtx2600Rs25, r_ConvertedE4PairAtPtx2603Rs26, r_ConvertedE4PairAtPtx2607Rs27,
		r_ConvertedE4PairAtPtx2610Rs28, r_ConvertedE4PairAtPtx2614Rs29, r_ConvertedE4PairAtPtx2617Rs30,
		r_ConvertedE4PairAtPtx2621Rs31, r_ConvertedE4PairAtPtx2624Rs32, r_ConvertedE4PairAtPtx2757Rs33,
		r_ConvertedE4PairAtPtx2760Rs34, r_ConvertedE4PairAtPtx2764Rs35, r_ConvertedE4PairAtPtx2767Rs36;
	uint16_t r_ConvertedE4PairAtPtx2771Rs37, r_ConvertedE4PairAtPtx2774Rs38, r_ConvertedE4PairAtPtx2778Rs39,
		r_ConvertedE4PairAtPtx2781Rs40, r_ConvertedE4PairAtPtx2785Rs41, r_ConvertedE4PairAtPtx2788Rs42,
		r_ConvertedE4PairAtPtx2792Rs43, r_ConvertedE4PairAtPtx2795Rs44, r_ConvertedE4PairAtPtx2799Rs45,
		r_ConvertedE4PairAtPtx2802Rs46, r_ConvertedE4PairAtPtx2806Rs47, r_ConvertedE4PairAtPtx2809Rs48;
	uint16_t r_ConvertedE4PairAtPtx2813Rs49, r_ConvertedE4PairAtPtx2816Rs50, r_ConvertedE4PairAtPtx2820Rs51,
		r_ConvertedE4PairAtPtx2823Rs52, r_ConvertedE4PairAtPtx2827Rs53, r_ConvertedE4PairAtPtx2830Rs54,
		r_ConvertedE4PairAtPtx2834Rs55, r_ConvertedE4PairAtPtx2837Rs56, r_ConvertedE4PairAtPtx2841Rs57,
		r_ConvertedE4PairAtPtx2844Rs58, r_ConvertedE4PairAtPtx2848Rs59, r_ConvertedE4PairAtPtx2851Rs60;
	uint16_t r_ConvertedE4PairAtPtx2855Rs61, r_ConvertedE4PairAtPtx2858Rs62, r_ConvertedE4PairAtPtx2862Rs63,
		r_ConvertedE4PairAtPtx2865Rs64, r_ConvertedE4PairAtPtx3915Rs65, r_ConvertedE4PairAtPtx3918Rs66,
		r_ConvertedE4PairAtPtx3922Rs67, r_ConvertedE4PairAtPtx3925Rs68, r_ConvertedE4PairAtPtx3929Rs69,
		r_ConvertedE4PairAtPtx3932Rs70, r_ConvertedE4PairAtPtx3936Rs71, r_ConvertedE4PairAtPtx3939Rs72;
	uint16_t r_ConvertedE4PairAtPtx3943Rs73, r_ConvertedE4PairAtPtx3946Rs74, r_ConvertedE4PairAtPtx3950Rs75,
		r_ConvertedE4PairAtPtx3953Rs76, r_ConvertedE4PairAtPtx3957Rs77, r_ConvertedE4PairAtPtx3960Rs78,
		r_ConvertedE4PairAtPtx3964Rs79, r_ConvertedE4PairAtPtx3967Rs80, r_ConvertedE4PairAtPtx3971Rs81,
		r_ConvertedE4PairAtPtx3974Rs82, r_ConvertedE4PairAtPtx3978Rs83, r_ConvertedE4PairAtPtx3981Rs84;
	uint16_t r_ConvertedE4PairAtPtx3985Rs85, r_ConvertedE4PairAtPtx3988Rs86, r_ConvertedE4PairAtPtx3992Rs87,
		r_ConvertedE4PairAtPtx3995Rs88, r_ConvertedE4PairAtPtx3999Rs89, r_ConvertedE4PairAtPtx4002Rs90,
		r_ConvertedE4PairAtPtx4006Rs91, r_ConvertedE4PairAtPtx4009Rs92, r_ConvertedE4PairAtPtx4013Rs93,
		r_ConvertedE4PairAtPtx4016Rs94, r_ConvertedE4PairAtPtx4020Rs95, r_ConvertedE4PairAtPtx4023Rs96;
	uint16_t r_ConvertedE4PairAtPtx4266Rs97, r_ConvertedE4PairAtPtx4269Rs98, r_ConvertedE4PairAtPtx4272Rs99,
		r_ConvertedE4PairAtPtx4275Rs100, r_ConvertedE4PairAtPtx4278Rs101, r_ConvertedE4PairAtPtx4281Rs102,
		r_ConvertedE4PairAtPtx4284Rs103, r_ConvertedE4PairAtPtx4287Rs104, r_ConvertedE4PairAtPtx4290Rs105,
		r_ConvertedE4PairAtPtx4293Rs106, r_ConvertedE4PairAtPtx4296Rs107, r_ConvertedE4PairAtPtx4299Rs108;
	uint16_t r_ConvertedE4PairAtPtx4302Rs109, r_ConvertedE4PairAtPtx4305Rs110,
		r_ConvertedE4PairAtPtx4308Rs111, r_ConvertedE4PairAtPtx4311Rs112, r_ConvertedE4PairAtPtx4314Rs113,
		r_ConvertedE4PairAtPtx4317Rs114, r_ConvertedE4PairAtPtx4320Rs115, r_ConvertedE4PairAtPtx4323Rs116,
		r_ConvertedE4PairAtPtx4326Rs117, r_ConvertedE4PairAtPtx4329Rs118, r_ConvertedE4PairAtPtx4332Rs119,
		r_ConvertedE4PairAtPtx4335Rs120;
	uint16_t r_ConvertedE4PairAtPtx4338Rs121, r_ConvertedE4PairAtPtx4341Rs122,
		r_ConvertedE4PairAtPtx4344Rs123, r_ConvertedE4PairAtPtx4347Rs124, r_ConvertedE4PairAtPtx4350Rs125,
		r_ConvertedE4PairAtPtx4353Rs126, r_ConvertedE4PairAtPtx4356Rs127, r_ConvertedE4PairAtPtx4359Rs128,
		r_ConvertedE4PairAtPtx4362Rs129, r_ConvertedE4PairAtPtx4365Rs130, r_ConvertedE4PairAtPtx4368Rs131,
		r_ConvertedE4PairAtPtx4371Rs132;
	uint16_t r_ConvertedE4PairAtPtx4374Rs133, r_ConvertedE4PairAtPtx4377Rs134,
		r_ConvertedE4PairAtPtx4380Rs135, r_ConvertedE4PairAtPtx4383Rs136, r_ConvertedE4PairAtPtx4386Rs137,
		r_ConvertedE4PairAtPtx4389Rs138, r_ConvertedE4PairAtPtx4392Rs139, r_ConvertedE4PairAtPtx4395Rs140,
		r_ConvertedE4PairAtPtx4398Rs141, r_ConvertedE4PairAtPtx4401Rs142, r_ConvertedE4PairAtPtx4404Rs143,
		r_ConvertedE4PairAtPtx4407Rs144;
	uint16_t r_ConvertedE4PairAtPtx4410Rs145, r_ConvertedE4PairAtPtx4413Rs146,
		r_ConvertedE4PairAtPtx4416Rs147, r_ConvertedE4PairAtPtx4419Rs148, r_ConvertedE4PairAtPtx4422Rs149,
		r_ConvertedE4PairAtPtx4425Rs150, r_ConvertedE4PairAtPtx4428Rs151, r_ConvertedE4PairAtPtx4431Rs152,
		r_ConvertedE4PairAtPtx4434Rs153, r_ConvertedE4PairAtPtx4437Rs154, r_ConvertedE4PairAtPtx4440Rs155,
		r_ConvertedE4PairAtPtx4443Rs156;
	uint16_t r_ConvertedE4PairAtPtx4446Rs157, r_ConvertedE4PairAtPtx4449Rs158,
		r_ConvertedE4PairAtPtx4452Rs159, r_ConvertedE4PairAtPtx4455Rs160;
	uint32_t r_CtaZ, r_PtxRegister2, r_PtxRegister3, r_ThreadX, r_ThreadY, r_PackedHalf2AtPtx43R6,
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
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_PtxRegister71,
		r_PtxRegister72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_PtxRegister75, r_PtxRegister76, r_HeightDiv4Bits,
		r_WidthDiv4Bits, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82, r_PtxRegister83,
		r_HeightBits;
	uint32_t r_WidthBits, r_CtaXAtPtx18, r_CtaY, r_PtxRegister88, r_PtxRegister89, r_PtxRegister90,
		r_PtxRegister91, r_BlockSizeX, r_BlockSizeY, r_Float32BitsAtPtx41R94, r_LaneIndexAtPtx55,
		r_LaneIndexAtPtx66;
	uint32_t r_LaneIndexAtPtx75, r_LaneIndexAtPtx84, r_LaneIndexAtPtx92, r_LaneIndexAtPtx101,
		r_LaneIndexAtPtx110, r_LaneIndexAtPtx119, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105,
		r_PtxRegister106, r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_PtxRegister118,
		r_PtxRegister119, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PtxRegister135, r_PtxRegister136, r_PtxRegister137,
		r_PtxRegister138, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141, r_PtxRegister142,
		r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160, r_PtxRegister161,
		r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165, r_PtxRegister166,
		r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178,
		r_PtxRegister179, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184, r_PtxRegister185,
		r_PtxRegister186, r_PtxRegister187, r_PtxRegister188, r_PtxRegister189, r_PtxRegister190,
		r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_PtxRegister197,
		r_PtxRegister198, r_PtxRegister199, r_PtxRegister200, r_PtxRegister201, r_PtxRegister202,
		r_PtxRegister203, r_PtxRegister204;
	uint32_t r_PtxRegister205, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_PtxRegister209,
		r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213, r_PtxRegister214,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225, r_PtxRegister226,
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
	uint32_t r_PtxRegister517, r_LaneIndexAtPtx1283, r_PtxRegister519, r_LaneIndexAtPtx1291, r_PtxRegister521,
		r_LaneIndexAtPtx1300, r_PtxRegister523, r_LaneIndexAtPtx1309, r_PtxRegister525, r_LaneIndexAtPtx1318,
		r_PtxRegister527, r_LaneIndexAtPtx1327;
	uint32_t r_PtxRegister529, r_LaneIndexAtPtx1336, r_PtxRegister531, r_LaneIndexAtPtx1345, r_PtxRegister533,
		r_MmaAE4x4WordAtPtx1288R534, r_MmaAE4x4WordAtPtx1288R535, r_MmaAE4x4WordAtPtx1288R536,
		r_MmaAE4x4WordAtPtx1288R537, r_MmaAE4x4WordAtPtx1297R538, r_MmaAE4x4WordAtPtx1297R539,
		r_MmaAE4x4WordAtPtx1297R540;
	uint32_t r_MmaAE4x4WordAtPtx1297R541, r_MmaAccumulatorHalf2WordAtPtx1354R542,
		r_MmaAccumulatorHalf2WordAtPtx1354R543, r_MmaAccumulatorHalf2WordAtPtx1361R544,
		r_MmaAccumulatorHalf2WordAtPtx1361R545, r_MmaAccumulatorHalf2WordAtPtx1382R546,
		r_MmaAccumulatorHalf2WordAtPtx1382R547, r_MmaAccumulatorHalf2WordAtPtx1389R548,
		r_MmaAccumulatorHalf2WordAtPtx1389R549, r_MmaAccumulatorHalf2WordAtPtx1410R550,
		r_MmaAccumulatorHalf2WordAtPtx1410R551, r_MmaAccumulatorHalf2WordAtPtx1417R552;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1417R553, r_MmaAccumulatorHalf2WordAtPtx1438R554,
		r_MmaAccumulatorHalf2WordAtPtx1438R555, r_MmaAccumulatorHalf2WordAtPtx1445R556,
		r_MmaAccumulatorHalf2WordAtPtx1445R557, r_MmaAE4x4WordAtPtx1306R558, r_MmaAE4x4WordAtPtx1306R559,
		r_MmaAE4x4WordAtPtx1306R560, r_MmaAE4x4WordAtPtx1306R561, r_MmaAE4x4WordAtPtx1315R562,
		r_MmaAE4x4WordAtPtx1315R563, r_MmaAE4x4WordAtPtx1315R564;
	uint32_t r_MmaAE4x4WordAtPtx1315R565, r_MmaAccumulatorHalf2WordAtPtx1466R566,
		r_MmaAccumulatorHalf2WordAtPtx1466R567, r_MmaAccumulatorHalf2WordAtPtx1473R568,
		r_MmaAccumulatorHalf2WordAtPtx1473R569, r_MmaAccumulatorHalf2WordAtPtx1494R570,
		r_MmaAccumulatorHalf2WordAtPtx1494R571, r_MmaAccumulatorHalf2WordAtPtx1501R572,
		r_MmaAccumulatorHalf2WordAtPtx1501R573, r_MmaAccumulatorHalf2WordAtPtx1522R574,
		r_MmaAccumulatorHalf2WordAtPtx1522R575, r_MmaAccumulatorHalf2WordAtPtx1529R576;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1529R577, r_MmaAccumulatorHalf2WordAtPtx1550R578,
		r_MmaAccumulatorHalf2WordAtPtx1550R579, r_MmaAccumulatorHalf2WordAtPtx1557R580,
		r_MmaAccumulatorHalf2WordAtPtx1557R581, r_MmaAE4x4WordAtPtx1324R582, r_MmaAE4x4WordAtPtx1324R583,
		r_MmaAE4x4WordAtPtx1324R584, r_MmaAE4x4WordAtPtx1324R585, r_MmaAE4x4WordAtPtx1333R586,
		r_MmaAE4x4WordAtPtx1333R587, r_MmaAE4x4WordAtPtx1333R588;
	uint32_t r_MmaAE4x4WordAtPtx1333R589, r_MmaAccumulatorHalf2WordAtPtx1578R590,
		r_MmaAccumulatorHalf2WordAtPtx1578R591, r_MmaAccumulatorHalf2WordAtPtx1585R592,
		r_MmaAccumulatorHalf2WordAtPtx1585R593, r_MmaAccumulatorHalf2WordAtPtx1606R594,
		r_MmaAccumulatorHalf2WordAtPtx1606R595, r_MmaAccumulatorHalf2WordAtPtx1613R596,
		r_MmaAccumulatorHalf2WordAtPtx1613R597, r_MmaAccumulatorHalf2WordAtPtx1634R598,
		r_MmaAccumulatorHalf2WordAtPtx1634R599, r_MmaAccumulatorHalf2WordAtPtx1641R600;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1641R601, r_MmaAccumulatorHalf2WordAtPtx1662R602,
		r_MmaAccumulatorHalf2WordAtPtx1662R603, r_MmaAccumulatorHalf2WordAtPtx1669R604,
		r_MmaAccumulatorHalf2WordAtPtx1669R605, r_MmaAE4x4WordAtPtx1342R606, r_MmaAE4x4WordAtPtx1342R607,
		r_MmaAE4x4WordAtPtx1342R608, r_MmaAE4x4WordAtPtx1342R609, r_MmaAE4x4WordAtPtx1351R610,
		r_MmaAE4x4WordAtPtx1351R611, r_MmaAE4x4WordAtPtx1351R612;
	uint32_t r_MmaAE4x4WordAtPtx1351R613, r_MmaAccumulatorHalf2WordAtPtx1690R614,
		r_MmaAccumulatorHalf2WordAtPtx1690R615, r_MmaAccumulatorHalf2WordAtPtx1697R616,
		r_MmaAccumulatorHalf2WordAtPtx1697R617, r_MmaAccumulatorHalf2WordAtPtx1718R618,
		r_MmaAccumulatorHalf2WordAtPtx1718R619, r_MmaAccumulatorHalf2WordAtPtx1725R620,
		r_MmaAccumulatorHalf2WordAtPtx1725R621, r_MmaAccumulatorHalf2WordAtPtx1746R622,
		r_MmaAccumulatorHalf2WordAtPtx1746R623, r_MmaAccumulatorHalf2WordAtPtx1753R624;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1753R625, r_MmaAccumulatorHalf2WordAtPtx1774R626,
		r_MmaAccumulatorHalf2WordAtPtx1774R627, r_MmaAccumulatorHalf2WordAtPtx1781R628,
		r_MmaAccumulatorHalf2WordAtPtx1781R629, r_LaneIndexAtPtx1806, r_LaneIndexAtPtx1814,
		r_LaneIndexAtPtx1823, r_LaneIndexAtPtx1832, r_LaneIndexAtPtx1841, r_LaneIndexAtPtx1850,
		r_LaneIndexAtPtx1859;
	uint32_t r_LaneIndexAtPtx1868, r_PtxRegister638, r_PtxRegister639, r_PtxRegister640, r_PtxRegister641,
		r_PtxRegister642, r_PtxRegister643, r_PtxRegister644, r_PtxRegister645, r_PtxRegister646,
		r_PtxRegister647, r_PtxRegister648;
	uint32_t r_PtxRegister649, r_PtxRegister650, r_PtxRegister651, r_PtxRegister652, r_PtxRegister653,
		r_PtxRegister654, r_PtxRegister655, r_PtxRegister656, r_PtxRegister657, r_PtxRegister658,
		r_PtxRegister659, r_PtxRegister660;
	uint32_t r_PtxRegister661, r_LaneIndexAtPtx1901, r_PtxRegister663, r_LaneIndexAtPtx1911, r_PtxRegister665,
		r_LaneIndexAtPtx1920, r_PtxRegister667, r_LaneIndexAtPtx1929, r_PtxRegister669, r_LaneIndexAtPtx1938,
		r_PtxRegister671, r_LaneIndexAtPtx1947;
	uint32_t r_PtxRegister673, r_LaneIndexAtPtx1956, r_PtxRegister675, r_LaneIndexAtPtx1965, r_PtxRegister677,
		r_MmaAE4x4WordAtPtx1908R678, r_MmaAE4x4WordAtPtx1908R679, r_MmaAE4x4WordAtPtx1908R680,
		r_MmaAE4x4WordAtPtx1908R681, r_MmaAE4x4WordAtPtx1917R682, r_MmaAE4x4WordAtPtx1917R683,
		r_MmaAE4x4WordAtPtx1917R684;
	uint32_t r_MmaAE4x4WordAtPtx1917R685, r_MmaAccumulatorHalf2WordAtPtx1974R686,
		r_MmaAccumulatorHalf2WordAtPtx1974R687, r_MmaAccumulatorHalf2WordAtPtx1981R688,
		r_MmaAccumulatorHalf2WordAtPtx1981R689, r_MmaAccumulatorHalf2WordAtPtx2002R690,
		r_MmaAccumulatorHalf2WordAtPtx2002R691, r_MmaAccumulatorHalf2WordAtPtx2009R692,
		r_MmaAccumulatorHalf2WordAtPtx2009R693, r_MmaAccumulatorHalf2WordAtPtx2030R694,
		r_MmaAccumulatorHalf2WordAtPtx2030R695, r_MmaAccumulatorHalf2WordAtPtx2037R696;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2037R697, r_MmaAccumulatorHalf2WordAtPtx2058R698,
		r_MmaAccumulatorHalf2WordAtPtx2058R699, r_MmaAccumulatorHalf2WordAtPtx2065R700,
		r_MmaAccumulatorHalf2WordAtPtx2065R701, r_MmaAE4x4WordAtPtx1926R702, r_MmaAE4x4WordAtPtx1926R703,
		r_MmaAE4x4WordAtPtx1926R704, r_MmaAE4x4WordAtPtx1926R705, r_MmaAE4x4WordAtPtx1935R706,
		r_MmaAE4x4WordAtPtx1935R707, r_MmaAE4x4WordAtPtx1935R708;
	uint32_t r_MmaAE4x4WordAtPtx1935R709, r_MmaAccumulatorHalf2WordAtPtx2086R710,
		r_MmaAccumulatorHalf2WordAtPtx2086R711, r_MmaAccumulatorHalf2WordAtPtx2093R712,
		r_MmaAccumulatorHalf2WordAtPtx2093R713, r_MmaAccumulatorHalf2WordAtPtx2114R714,
		r_MmaAccumulatorHalf2WordAtPtx2114R715, r_MmaAccumulatorHalf2WordAtPtx2121R716,
		r_MmaAccumulatorHalf2WordAtPtx2121R717, r_MmaAccumulatorHalf2WordAtPtx2142R718,
		r_MmaAccumulatorHalf2WordAtPtx2142R719, r_MmaAccumulatorHalf2WordAtPtx2149R720;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2149R721, r_MmaAccumulatorHalf2WordAtPtx2170R722,
		r_MmaAccumulatorHalf2WordAtPtx2170R723, r_MmaAccumulatorHalf2WordAtPtx2177R724,
		r_MmaAccumulatorHalf2WordAtPtx2177R725, r_MmaAE4x4WordAtPtx1944R726, r_MmaAE4x4WordAtPtx1944R727,
		r_MmaAE4x4WordAtPtx1944R728, r_MmaAE4x4WordAtPtx1944R729, r_MmaAE4x4WordAtPtx1953R730,
		r_MmaAE4x4WordAtPtx1953R731, r_MmaAE4x4WordAtPtx1953R732;
	uint32_t r_MmaAE4x4WordAtPtx1953R733, r_MmaAccumulatorHalf2WordAtPtx2198R734,
		r_MmaAccumulatorHalf2WordAtPtx2198R735, r_MmaAccumulatorHalf2WordAtPtx2205R736,
		r_MmaAccumulatorHalf2WordAtPtx2205R737, r_MmaAccumulatorHalf2WordAtPtx2226R738,
		r_MmaAccumulatorHalf2WordAtPtx2226R739, r_MmaAccumulatorHalf2WordAtPtx2233R740,
		r_MmaAccumulatorHalf2WordAtPtx2233R741, r_MmaAccumulatorHalf2WordAtPtx2254R742,
		r_MmaAccumulatorHalf2WordAtPtx2254R743, r_MmaAccumulatorHalf2WordAtPtx2261R744;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2261R745, r_MmaAccumulatorHalf2WordAtPtx2282R746,
		r_MmaAccumulatorHalf2WordAtPtx2282R747, r_MmaAccumulatorHalf2WordAtPtx2289R748,
		r_MmaAccumulatorHalf2WordAtPtx2289R749, r_MmaAE4x4WordAtPtx1962R750, r_MmaAE4x4WordAtPtx1962R751,
		r_MmaAE4x4WordAtPtx1962R752, r_MmaAE4x4WordAtPtx1962R753, r_MmaAE4x4WordAtPtx1971R754,
		r_MmaAE4x4WordAtPtx1971R755, r_MmaAE4x4WordAtPtx1971R756;
	uint32_t r_MmaAE4x4WordAtPtx1971R757, r_MmaAccumulatorHalf2WordAtPtx2310R758,
		r_MmaAccumulatorHalf2WordAtPtx2310R759, r_MmaAccumulatorHalf2WordAtPtx2317R760,
		r_MmaAccumulatorHalf2WordAtPtx2317R761, r_MmaAccumulatorHalf2WordAtPtx2338R762,
		r_MmaAccumulatorHalf2WordAtPtx2338R763, r_MmaAccumulatorHalf2WordAtPtx2345R764,
		r_MmaAccumulatorHalf2WordAtPtx2345R765, r_MmaAccumulatorHalf2WordAtPtx2366R766,
		r_MmaAccumulatorHalf2WordAtPtx2366R767, r_MmaAccumulatorHalf2WordAtPtx2373R768;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2373R769, r_MmaAccumulatorHalf2WordAtPtx2394R770,
		r_MmaAccumulatorHalf2WordAtPtx2394R771, r_MmaAccumulatorHalf2WordAtPtx2401R772,
		r_MmaAccumulatorHalf2WordAtPtx2401R773, r_PtxRegister774, r_PtxRegister775, r_PtxRegister776,
		r_PtxRegister777, r_PtxRegister778, r_PtxRegister779, r_PtxRegister780;
	uint32_t r_PtxRegister781, r_PtxRegister782, r_PtxRegister783, r_PtxRegister784, r_PtxRegister785,
		r_PtxRegister786, r_PtxRegister787, r_PtxRegister788, r_PtxRegister789, r_PtxRegister790,
		r_PtxRegister791, r_PtxRegister792;
	uint32_t r_PtxRegister793, r_PtxRegister794, r_LaneIndexAtPtx2499, r_LaneIndexAtPtx2508,
		r_MmaAccumulatorHalf2WordAtPtx1988R797, r_MmaAccumulatorHalf2WordAtPtx1995R798,
		r_MmaAccumulatorHalf2WordAtPtx1988R799, r_MmaAccumulatorHalf2WordAtPtx1995R800,
		r_MmaAccumulatorHalf2WordAtPtx2016R801, r_MmaAccumulatorHalf2WordAtPtx2023R802,
		r_MmaAccumulatorHalf2WordAtPtx2016R803, r_MmaAccumulatorHalf2WordAtPtx2023R804;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2100R805, r_MmaAccumulatorHalf2WordAtPtx2107R806,
		r_MmaAccumulatorHalf2WordAtPtx2100R807, r_MmaAccumulatorHalf2WordAtPtx2107R808,
		r_MmaAccumulatorHalf2WordAtPtx2128R809, r_MmaAccumulatorHalf2WordAtPtx2135R810,
		r_MmaAccumulatorHalf2WordAtPtx2128R811, r_MmaAccumulatorHalf2WordAtPtx2135R812,
		r_MmaAccumulatorHalf2WordAtPtx2212R813, r_MmaAccumulatorHalf2WordAtPtx2219R814,
		r_MmaAccumulatorHalf2WordAtPtx2212R815, r_MmaAccumulatorHalf2WordAtPtx2219R816;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2240R817, r_MmaAccumulatorHalf2WordAtPtx2247R818,
		r_MmaAccumulatorHalf2WordAtPtx2240R819, r_MmaAccumulatorHalf2WordAtPtx2247R820,
		r_MmaAccumulatorHalf2WordAtPtx2324R821, r_MmaAccumulatorHalf2WordAtPtx2331R822,
		r_MmaAccumulatorHalf2WordAtPtx2324R823, r_MmaAccumulatorHalf2WordAtPtx2331R824,
		r_MmaAccumulatorHalf2WordAtPtx2352R825, r_MmaAccumulatorHalf2WordAtPtx2359R826,
		r_MmaAccumulatorHalf2WordAtPtx2352R827, r_MmaAccumulatorHalf2WordAtPtx2359R828;
	uint32_t r_MmaBE4x4WordAtPtx2505R829, r_MmaBE4x4WordAtPtx2505R830, r_MmaAE4x4WordAtPtx2521R831,
		r_MmaAE4x4WordAtPtx2528R832, r_MmaAE4x4WordAtPtx2535R833, r_MmaAE4x4WordAtPtx2542R834,
		r_MmaBE4x4WordAtPtx2505R835, r_MmaBE4x4WordAtPtx2505R836, r_MmaBE4x4WordAtPtx2513R837,
		r_MmaBE4x4WordAtPtx2513R838, r_MmaBE4x4WordAtPtx2513R839, r_MmaBE4x4WordAtPtx2513R840;
	uint32_t r_MmaAE4x4WordAtPtx2549R841, r_MmaAE4x4WordAtPtx2556R842, r_MmaAE4x4WordAtPtx2563R843,
		r_MmaAE4x4WordAtPtx2570R844, r_MmaAE4x4WordAtPtx2577R845, r_MmaAE4x4WordAtPtx2584R846,
		r_MmaAE4x4WordAtPtx2591R847, r_MmaAE4x4WordAtPtx2598R848, r_MmaAE4x4WordAtPtx2605R849,
		r_MmaAE4x4WordAtPtx2612R850, r_MmaAE4x4WordAtPtx2619R851, r_MmaAE4x4WordAtPtx2626R852;
	uint32_t r_LaneIndexAtPtx2740, r_LaneIndexAtPtx2749, r_MmaAccumulatorHalf2WordAtPtx2044R855,
		r_MmaAccumulatorHalf2WordAtPtx2051R856, r_MmaAccumulatorHalf2WordAtPtx2044R857,
		r_MmaAccumulatorHalf2WordAtPtx2051R858, r_MmaAccumulatorHalf2WordAtPtx2072R859,
		r_MmaAccumulatorHalf2WordAtPtx2079R860, r_MmaAccumulatorHalf2WordAtPtx2072R861,
		r_MmaAccumulatorHalf2WordAtPtx2079R862, r_MmaAccumulatorHalf2WordAtPtx2156R863,
		r_MmaAccumulatorHalf2WordAtPtx2163R864;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2156R865, r_MmaAccumulatorHalf2WordAtPtx2163R866,
		r_MmaAccumulatorHalf2WordAtPtx2184R867, r_MmaAccumulatorHalf2WordAtPtx2191R868,
		r_MmaAccumulatorHalf2WordAtPtx2184R869, r_MmaAccumulatorHalf2WordAtPtx2191R870,
		r_MmaAccumulatorHalf2WordAtPtx2268R871, r_MmaAccumulatorHalf2WordAtPtx2275R872,
		r_MmaAccumulatorHalf2WordAtPtx2268R873, r_MmaAccumulatorHalf2WordAtPtx2275R874,
		r_MmaAccumulatorHalf2WordAtPtx2296R875, r_MmaAccumulatorHalf2WordAtPtx2303R876;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2296R877, r_MmaAccumulatorHalf2WordAtPtx2303R878,
		r_MmaAccumulatorHalf2WordAtPtx2380R879, r_MmaAccumulatorHalf2WordAtPtx2387R880,
		r_MmaAccumulatorHalf2WordAtPtx2380R881, r_MmaAccumulatorHalf2WordAtPtx2387R882,
		r_MmaAccumulatorHalf2WordAtPtx2408R883, r_MmaAccumulatorHalf2WordAtPtx2415R884,
		r_MmaAccumulatorHalf2WordAtPtx2408R885, r_MmaAccumulatorHalf2WordAtPtx2415R886,
		r_MmaBE4x4WordAtPtx2746R887, r_MmaBE4x4WordAtPtx2746R888;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2628R889, r_MmaAccumulatorHalf2WordAtPtx2628R890,
		r_MmaAE4x4WordAtPtx2762R891, r_MmaAE4x4WordAtPtx2769R892, r_MmaAE4x4WordAtPtx2776R893,
		r_MmaAE4x4WordAtPtx2783R894, r_MmaBE4x4WordAtPtx2746R895, r_MmaBE4x4WordAtPtx2746R896,
		r_MmaAccumulatorHalf2WordAtPtx2635R897, r_MmaAccumulatorHalf2WordAtPtx2635R898,
		r_MmaBE4x4WordAtPtx2754R899, r_MmaBE4x4WordAtPtx2754R900;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2642R901, r_MmaAccumulatorHalf2WordAtPtx2642R902,
		r_MmaBE4x4WordAtPtx2754R903, r_MmaBE4x4WordAtPtx2754R904, r_MmaAccumulatorHalf2WordAtPtx2649R905,
		r_MmaAccumulatorHalf2WordAtPtx2649R906, r_MmaAccumulatorHalf2WordAtPtx2656R907,
		r_MmaAccumulatorHalf2WordAtPtx2656R908, r_MmaAE4x4WordAtPtx2790R909, r_MmaAE4x4WordAtPtx2797R910,
		r_MmaAE4x4WordAtPtx2804R911, r_MmaAE4x4WordAtPtx2811R912;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2663R913, r_MmaAccumulatorHalf2WordAtPtx2663R914,
		r_MmaAccumulatorHalf2WordAtPtx2670R915, r_MmaAccumulatorHalf2WordAtPtx2670R916,
		r_MmaAccumulatorHalf2WordAtPtx2677R917, r_MmaAccumulatorHalf2WordAtPtx2677R918,
		r_MmaAccumulatorHalf2WordAtPtx2684R919, r_MmaAccumulatorHalf2WordAtPtx2684R920,
		r_MmaAE4x4WordAtPtx2818R921, r_MmaAE4x4WordAtPtx2825R922, r_MmaAE4x4WordAtPtx2832R923,
		r_MmaAE4x4WordAtPtx2839R924;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2691R925, r_MmaAccumulatorHalf2WordAtPtx2691R926,
		r_MmaAccumulatorHalf2WordAtPtx2698R927, r_MmaAccumulatorHalf2WordAtPtx2698R928,
		r_MmaAccumulatorHalf2WordAtPtx2705R929, r_MmaAccumulatorHalf2WordAtPtx2705R930,
		r_MmaAccumulatorHalf2WordAtPtx2712R931, r_MmaAccumulatorHalf2WordAtPtx2712R932,
		r_MmaAE4x4WordAtPtx2846R933, r_MmaAE4x4WordAtPtx2853R934, r_MmaAE4x4WordAtPtx2860R935,
		r_MmaAE4x4WordAtPtx2867R936;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2719R937, r_MmaAccumulatorHalf2WordAtPtx2719R938,
		r_MmaAccumulatorHalf2WordAtPtx2726R939, r_MmaAccumulatorHalf2WordAtPtx2726R940,
		r_MmaAccumulatorHalf2WordAtPtx2733R941, r_MmaAccumulatorHalf2WordAtPtx2733R942, r_LaneIndexAtPtx2981,
		r_Float32BitsAtPtx2983R944, r_Float32BitsAtPtx2990R945, r_Float32BitsAtPtx2997R946,
		r_Float32BitsAtPtx3004R947, r_Float32BitsAtPtx3011R948;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2869R949, r_PackedHalf2AtPtx2992R950, r_PackedHalf2AtPtx3019R951,
		r_PackedHalf2AtPtx2985R952, r_PackedHalf2AtPtx3023R953, r_PackedHalf2AtPtx3013R954,
		r_PackedHalf2AtPtx3027R955, r_PackedHalf2AtPtx3006R956, r_PackedHalf2AtPtx3031R957,
		r_PackedHalf2AtPtx2999R958, r_PackedHalf2AtPtx3035R959, r_LaneIndexAtPtx3043;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2869R961, r_PackedHalf2AtPtx3046R962, r_PackedHalf2AtPtx3050R963,
		r_PackedHalf2AtPtx3054R964, r_PackedHalf2AtPtx3058R965, r_PackedHalf2AtPtx3062R966,
		r_LaneIndexAtPtx3070, r_MmaAccumulatorHalf2WordAtPtx2876R968, r_PackedHalf2AtPtx3073R969,
		r_PackedHalf2AtPtx3077R970, r_PackedHalf2AtPtx3081R971, r_PackedHalf2AtPtx3085R972;
	uint32_t r_PackedHalf2AtPtx3089R973, r_LaneIndexAtPtx3097, r_MmaAccumulatorHalf2WordAtPtx2876R975,
		r_PackedHalf2AtPtx3100R976, r_PackedHalf2AtPtx3104R977, r_PackedHalf2AtPtx3108R978,
		r_PackedHalf2AtPtx3112R979, r_PackedHalf2AtPtx3116R980, r_LaneIndexAtPtx3124,
		r_MmaAccumulatorHalf2WordAtPtx2883R982, r_PackedHalf2AtPtx3127R983, r_PackedHalf2AtPtx3131R984;
	uint32_t r_PackedHalf2AtPtx3135R985, r_PackedHalf2AtPtx3139R986, r_PackedHalf2AtPtx3143R987,
		r_LaneIndexAtPtx3151, r_MmaAccumulatorHalf2WordAtPtx2883R989, r_PackedHalf2AtPtx3154R990,
		r_PackedHalf2AtPtx3158R991, r_PackedHalf2AtPtx3162R992, r_PackedHalf2AtPtx3166R993,
		r_PackedHalf2AtPtx3170R994, r_LaneIndexAtPtx3178, r_MmaAccumulatorHalf2WordAtPtx2890R996;
	uint32_t r_PackedHalf2AtPtx3181R997, r_PackedHalf2AtPtx3185R998, r_PackedHalf2AtPtx3189R999,
		r_PackedHalf2AtPtx3193R1000, r_PackedHalf2AtPtx3197R1001, r_LaneIndexAtPtx3205,
		r_MmaAccumulatorHalf2WordAtPtx2890R1003, r_PackedHalf2AtPtx3208R1004, r_PackedHalf2AtPtx3212R1005,
		r_PackedHalf2AtPtx3216R1006, r_PackedHalf2AtPtx3220R1007, r_PackedHalf2AtPtx3224R1008;
	uint32_t r_LaneIndexAtPtx3232, r_MmaAccumulatorHalf2WordAtPtx2897R1010, r_PackedHalf2AtPtx3235R1011,
		r_PackedHalf2AtPtx3239R1012, r_PackedHalf2AtPtx3243R1013, r_PackedHalf2AtPtx3247R1014,
		r_PackedHalf2AtPtx3251R1015, r_LaneIndexAtPtx3259, r_MmaAccumulatorHalf2WordAtPtx2897R1017,
		r_PackedHalf2AtPtx3262R1018, r_PackedHalf2AtPtx3266R1019, r_PackedHalf2AtPtx3270R1020;
	uint32_t r_PackedHalf2AtPtx3274R1021, r_PackedHalf2AtPtx3278R1022, r_LaneIndexAtPtx3286,
		r_MmaAccumulatorHalf2WordAtPtx2904R1024, r_PackedHalf2AtPtx3289R1025, r_PackedHalf2AtPtx3293R1026,
		r_PackedHalf2AtPtx3297R1027, r_PackedHalf2AtPtx3301R1028, r_PackedHalf2AtPtx3305R1029,
		r_LaneIndexAtPtx3313, r_MmaAccumulatorHalf2WordAtPtx2904R1031, r_PackedHalf2AtPtx3316R1032;
	uint32_t r_PackedHalf2AtPtx3320R1033, r_PackedHalf2AtPtx3324R1034, r_PackedHalf2AtPtx3328R1035,
		r_PackedHalf2AtPtx3332R1036, r_LaneIndexAtPtx3340, r_MmaAccumulatorHalf2WordAtPtx2911R1038,
		r_PackedHalf2AtPtx3343R1039, r_PackedHalf2AtPtx3347R1040, r_PackedHalf2AtPtx3351R1041,
		r_PackedHalf2AtPtx3355R1042, r_PackedHalf2AtPtx3359R1043, r_LaneIndexAtPtx3367;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2911R1045, r_PackedHalf2AtPtx3370R1046,
		r_PackedHalf2AtPtx3374R1047, r_PackedHalf2AtPtx3378R1048, r_PackedHalf2AtPtx3382R1049,
		r_PackedHalf2AtPtx3386R1050, r_LaneIndexAtPtx3394, r_MmaAccumulatorHalf2WordAtPtx2918R1052,
		r_PackedHalf2AtPtx3397R1053, r_PackedHalf2AtPtx3401R1054, r_PackedHalf2AtPtx3405R1055,
		r_PackedHalf2AtPtx3409R1056;
	uint32_t r_PackedHalf2AtPtx3413R1057, r_LaneIndexAtPtx3421, r_MmaAccumulatorHalf2WordAtPtx2918R1059,
		r_PackedHalf2AtPtx3424R1060, r_PackedHalf2AtPtx3428R1061, r_PackedHalf2AtPtx3432R1062,
		r_PackedHalf2AtPtx3436R1063, r_PackedHalf2AtPtx3440R1064, r_LaneIndexAtPtx3448,
		r_MmaAccumulatorHalf2WordAtPtx2925R1066, r_PackedHalf2AtPtx3451R1067, r_PackedHalf2AtPtx3455R1068;
	uint32_t r_PackedHalf2AtPtx3459R1069, r_PackedHalf2AtPtx3463R1070, r_PackedHalf2AtPtx3467R1071,
		r_LaneIndexAtPtx3475, r_MmaAccumulatorHalf2WordAtPtx2925R1073, r_PackedHalf2AtPtx3478R1074,
		r_PackedHalf2AtPtx3482R1075, r_PackedHalf2AtPtx3486R1076, r_PackedHalf2AtPtx3490R1077,
		r_PackedHalf2AtPtx3494R1078, r_LaneIndexAtPtx3502, r_MmaAccumulatorHalf2WordAtPtx2932R1080;
	uint32_t r_PackedHalf2AtPtx3505R1081, r_PackedHalf2AtPtx3509R1082, r_PackedHalf2AtPtx3513R1083,
		r_PackedHalf2AtPtx3517R1084, r_PackedHalf2AtPtx3521R1085, r_LaneIndexAtPtx3529,
		r_MmaAccumulatorHalf2WordAtPtx2932R1087, r_PackedHalf2AtPtx3532R1088, r_PackedHalf2AtPtx3536R1089,
		r_PackedHalf2AtPtx3540R1090, r_PackedHalf2AtPtx3544R1091, r_PackedHalf2AtPtx3548R1092;
	uint32_t r_LaneIndexAtPtx3556, r_MmaAccumulatorHalf2WordAtPtx2939R1094, r_PackedHalf2AtPtx3559R1095,
		r_PackedHalf2AtPtx3563R1096, r_PackedHalf2AtPtx3567R1097, r_PackedHalf2AtPtx3571R1098,
		r_PackedHalf2AtPtx3575R1099, r_LaneIndexAtPtx3583, r_MmaAccumulatorHalf2WordAtPtx2939R1101,
		r_PackedHalf2AtPtx3586R1102, r_PackedHalf2AtPtx3590R1103, r_PackedHalf2AtPtx3594R1104;
	uint32_t r_PackedHalf2AtPtx3598R1105, r_PackedHalf2AtPtx3602R1106, r_LaneIndexAtPtx3610,
		r_MmaAccumulatorHalf2WordAtPtx2946R1108, r_PackedHalf2AtPtx3613R1109, r_PackedHalf2AtPtx3617R1110,
		r_PackedHalf2AtPtx3621R1111, r_PackedHalf2AtPtx3625R1112, r_PackedHalf2AtPtx3629R1113,
		r_LaneIndexAtPtx3637, r_MmaAccumulatorHalf2WordAtPtx2946R1115, r_PackedHalf2AtPtx3640R1116;
	uint32_t r_PackedHalf2AtPtx3644R1117, r_PackedHalf2AtPtx3648R1118, r_PackedHalf2AtPtx3652R1119,
		r_PackedHalf2AtPtx3656R1120, r_LaneIndexAtPtx3664, r_MmaAccumulatorHalf2WordAtPtx2953R1122,
		r_PackedHalf2AtPtx3667R1123, r_PackedHalf2AtPtx3671R1124, r_PackedHalf2AtPtx3675R1125,
		r_PackedHalf2AtPtx3679R1126, r_PackedHalf2AtPtx3683R1127, r_LaneIndexAtPtx3691;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2953R1129, r_PackedHalf2AtPtx3694R1130,
		r_PackedHalf2AtPtx3698R1131, r_PackedHalf2AtPtx3702R1132, r_PackedHalf2AtPtx3706R1133,
		r_PackedHalf2AtPtx3710R1134, r_LaneIndexAtPtx3718, r_MmaAccumulatorHalf2WordAtPtx2960R1136,
		r_PackedHalf2AtPtx3721R1137, r_PackedHalf2AtPtx3725R1138, r_PackedHalf2AtPtx3729R1139,
		r_PackedHalf2AtPtx3733R1140;
	uint32_t r_PackedHalf2AtPtx3737R1141, r_LaneIndexAtPtx3745, r_MmaAccumulatorHalf2WordAtPtx2960R1143,
		r_PackedHalf2AtPtx3748R1144, r_PackedHalf2AtPtx3752R1145, r_PackedHalf2AtPtx3756R1146,
		r_PackedHalf2AtPtx3760R1147, r_PackedHalf2AtPtx3764R1148, r_LaneIndexAtPtx3772,
		r_MmaAccumulatorHalf2WordAtPtx2967R1150, r_PackedHalf2AtPtx3775R1151, r_PackedHalf2AtPtx3779R1152;
	uint32_t r_PackedHalf2AtPtx3783R1153, r_PackedHalf2AtPtx3787R1154, r_PackedHalf2AtPtx3791R1155,
		r_LaneIndexAtPtx3799, r_MmaAccumulatorHalf2WordAtPtx2967R1157, r_PackedHalf2AtPtx3802R1158,
		r_PackedHalf2AtPtx3806R1159, r_PackedHalf2AtPtx3810R1160, r_PackedHalf2AtPtx3814R1161,
		r_PackedHalf2AtPtx3818R1162, r_LaneIndexAtPtx3826, r_MmaAccumulatorHalf2WordAtPtx2974R1164;
	uint32_t r_PackedHalf2AtPtx3829R1165, r_PackedHalf2AtPtx3833R1166, r_PackedHalf2AtPtx3837R1167,
		r_PackedHalf2AtPtx3841R1168, r_PackedHalf2AtPtx3845R1169, r_LaneIndexAtPtx3853,
		r_MmaAccumulatorHalf2WordAtPtx2974R1171, r_PackedHalf2AtPtx3856R1172, r_PackedHalf2AtPtx3860R1173,
		r_PackedHalf2AtPtx3864R1174, r_PackedHalf2AtPtx3868R1175, r_PackedHalf2AtPtx3872R1176;
	uint32_t r_LaneIndexAtPtx3880, r_LaneIndexAtPtx3889, r_LaneIndexAtPtx3898, r_LaneIndexAtPtx3907,
		r_PackedHalf2AtPtx3039R1181, r_PackedHalf2AtPtx3093R1182, r_PackedHalf2AtPtx3066R1183,
		r_PackedHalf2AtPtx3120R1184, r_PackedHalf2AtPtx3147R1185, r_PackedHalf2AtPtx3201R1186,
		r_PackedHalf2AtPtx3174R1187, r_PackedHalf2AtPtx3228R1188;
	uint32_t r_PackedHalf2AtPtx3255R1189, r_PackedHalf2AtPtx3309R1190, r_PackedHalf2AtPtx3282R1191,
		r_PackedHalf2AtPtx3336R1192, r_PackedHalf2AtPtx3363R1193, r_PackedHalf2AtPtx3417R1194,
		r_PackedHalf2AtPtx3390R1195, r_PackedHalf2AtPtx3444R1196, r_PackedHalf2AtPtx3471R1197,
		r_PackedHalf2AtPtx3525R1198, r_PackedHalf2AtPtx3498R1199, r_PackedHalf2AtPtx3552R1200;
	uint32_t r_PackedHalf2AtPtx3579R1201, r_PackedHalf2AtPtx3633R1202, r_PackedHalf2AtPtx3606R1203,
		r_PackedHalf2AtPtx3660R1204, r_PackedHalf2AtPtx3687R1205, r_PackedHalf2AtPtx3741R1206,
		r_PackedHalf2AtPtx3714R1207, r_PackedHalf2AtPtx3768R1208, r_PackedHalf2AtPtx3795R1209,
		r_PackedHalf2AtPtx3849R1210, r_PackedHalf2AtPtx3822R1211, r_PackedHalf2AtPtx3876R1212;
	uint32_t r_MmaBE4x4WordAtPtx3886R1213, r_MmaBE4x4WordAtPtx3886R1214, r_MmaAE4x4WordAtPtx3920R1215,
		r_MmaAE4x4WordAtPtx3927R1216, r_MmaAE4x4WordAtPtx3934R1217, r_MmaAE4x4WordAtPtx3941R1218,
		r_MmaBE4x4WordAtPtx3886R1219, r_MmaBE4x4WordAtPtx3886R1220, r_MmaBE4x4WordAtPtx3895R1221,
		r_MmaBE4x4WordAtPtx3895R1222, r_MmaBE4x4WordAtPtx3895R1223, r_MmaBE4x4WordAtPtx3895R1224;
	uint32_t r_MmaBE4x4WordAtPtx3904R1225, r_MmaBE4x4WordAtPtx3904R1226, r_MmaBE4x4WordAtPtx3904R1227,
		r_MmaBE4x4WordAtPtx3904R1228, r_MmaBE4x4WordAtPtx3912R1229, r_MmaBE4x4WordAtPtx3912R1230,
		r_MmaBE4x4WordAtPtx3912R1231, r_MmaBE4x4WordAtPtx3912R1232, r_MmaAE4x4WordAtPtx3948R1233,
		r_MmaAE4x4WordAtPtx3955R1234, r_MmaAE4x4WordAtPtx3962R1235, r_MmaAE4x4WordAtPtx3969R1236;
	uint32_t r_MmaAE4x4WordAtPtx3976R1237, r_MmaAE4x4WordAtPtx3983R1238, r_MmaAE4x4WordAtPtx3990R1239,
		r_MmaAE4x4WordAtPtx3997R1240, r_MmaAE4x4WordAtPtx4004R1241, r_MmaAE4x4WordAtPtx4011R1242,
		r_MmaAE4x4WordAtPtx4018R1243, r_MmaAE4x4WordAtPtx4025R1244, r_HeightSignBits, r_HeightDiv4Bias,
		r_HeightBiasedForDiv4, r_WidthSignBits;
	uint32_t r_WidthDiv4Bias, r_WidthBiasedForDiv4, r_CtaXAtPtx4459, r_PtxRegister1252, r_PtxRegister1253,
		r_PtxRegister1254, r_LaneIndexAtPtx4479, r_PackedE4WordAtPtx4477R1256, r_PackedE4WordAtPtx4476R1257,
		r_PackedE4WordAtPtx4475R1258, r_PackedE4WordAtPtx4474R1259, r_LaneIndexAtPtx4487;
	uint32_t r_PackedE4WordAtPtx4473R1261, r_PackedE4WordAtPtx4472R1262, r_PackedE4WordAtPtx4471R1263,
		r_PackedE4WordAtPtx4470R1264, r_LaneIndexAtPtx4502, r_PackedE4WordAtPtx4510R1266,
		r_PackedE4WordAtPtx4509R1267, r_PackedE4WordAtPtx4508R1268, r_PackedE4WordAtPtx4507R1269,
		r_LaneIndexAtPtx4515, r_PackedE4WordAtPtx4523R1271, r_PackedE4WordAtPtx4522R1272;
	uint32_t r_PackedE4WordAtPtx4521R1273, r_PackedE4WordAtPtx4520R1274, r_PtxRegister1275, r_PtxRegister1276,
		r_PtxRegister1277, r_PtxRegister1278, r_LaneIndexAtPtx4540, r_PackedE4WordAtPtx4547R1280,
		r_PackedE4WordAtPtx4546R1281, r_PackedE4WordAtPtx4545R1282, r_PackedE4WordAtPtx4544R1283,
		r_LaneIndexAtPtx4552;
	uint32_t r_PackedE4WordAtPtx4560R1285, r_PackedE4WordAtPtx4559R1286, r_PackedE4WordAtPtx4558R1287,
		r_PackedE4WordAtPtx4557R1288, r_LaneIndexAtPtx4569, r_PackedE4WordAtPtx4577R1290,
		r_PackedE4WordAtPtx4576R1291, r_PackedE4WordAtPtx4575R1292, r_PackedE4WordAtPtx4574R1293,
		r_LaneIndexAtPtx4582, r_PackedE4WordAtPtx4590R1295, r_PackedE4WordAtPtx4589R1296;
	uint32_t r_PackedE4WordAtPtx4588R1297, r_PackedE4WordAtPtx4587R1298,
		r_MmaAccumulatorHalf2WordAtPtx811R1299, r_MmaAccumulatorHalf2WordAtPtx812R1300,
		r_MmaAccumulatorHalf2WordAtPtx813R1301, r_MmaAccumulatorHalf2WordAtPtx814R1302,
		r_MmaAccumulatorHalf2WordAtPtx815R1303, r_MmaAccumulatorHalf2WordAtPtx816R1304,
		r_MmaAccumulatorHalf2WordAtPtx817R1305, r_MmaAccumulatorHalf2WordAtPtx818R1306,
		r_MmaAccumulatorHalf2WordAtPtx819R1307, r_MmaAccumulatorHalf2WordAtPtx820R1308;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx821R1309, r_MmaAccumulatorHalf2WordAtPtx822R1310,
		r_MmaAccumulatorHalf2WordAtPtx823R1311, r_MmaAccumulatorHalf2WordAtPtx824R1312,
		r_MmaAccumulatorHalf2WordAtPtx825R1313, r_MmaAccumulatorHalf2WordAtPtx826R1314,
		r_MmaAccumulatorHalf2WordAtPtx827R1315, r_MmaAccumulatorHalf2WordAtPtx828R1316,
		r_MmaAccumulatorHalf2WordAtPtx829R1317, r_MmaAccumulatorHalf2WordAtPtx830R1318,
		r_MmaAccumulatorHalf2WordAtPtx831R1319, r_MmaAccumulatorHalf2WordAtPtx832R1320;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx833R1321, r_MmaAccumulatorHalf2WordAtPtx834R1322,
		r_MmaAccumulatorHalf2WordAtPtx835R1323, r_MmaAccumulatorHalf2WordAtPtx836R1324,
		r_MmaAccumulatorHalf2WordAtPtx837R1325, r_MmaAccumulatorHalf2WordAtPtx838R1326,
		r_MmaAccumulatorHalf2WordAtPtx839R1327, r_MmaAccumulatorHalf2WordAtPtx840R1328,
		r_MmaAccumulatorHalf2WordAtPtx841R1329, r_MmaAccumulatorHalf2WordAtPtx842R1330,
		r_MmaAccumulatorHalf2WordAtPtx843R1331, r_MmaAccumulatorHalf2WordAtPtx844R1332;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx845R1333, r_MmaAccumulatorHalf2WordAtPtx846R1334,
		r_MmaAccumulatorHalf2WordAtPtx847R1335, r_MmaAccumulatorHalf2WordAtPtx848R1336,
		r_MmaAccumulatorHalf2WordAtPtx849R1337, r_MmaAccumulatorHalf2WordAtPtx850R1338,
		r_MmaAccumulatorHalf2WordAtPtx851R1339, r_MmaAccumulatorHalf2WordAtPtx852R1340,
		r_MmaAccumulatorHalf2WordAtPtx853R1341, r_MmaAccumulatorHalf2WordAtPtx854R1342,
		r_MmaAccumulatorHalf2WordAtPtx855R1343, r_MmaAccumulatorHalf2WordAtPtx856R1344;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx857R1345, r_MmaAccumulatorHalf2WordAtPtx858R1346,
		r_MmaAccumulatorHalf2WordAtPtx859R1347, r_MmaAccumulatorHalf2WordAtPtx860R1348,
		r_MmaAccumulatorHalf2WordAtPtx861R1349, r_MmaAccumulatorHalf2WordAtPtx862R1350,
		r_MmaAccumulatorHalf2WordAtPtx863R1351, r_MmaAccumulatorHalf2WordAtPtx864R1352,
		r_MmaAccumulatorHalf2WordAtPtx865R1353, r_MmaAccumulatorHalf2WordAtPtx866R1354,
		r_MmaAccumulatorHalf2WordAtPtx867R1355, r_MmaAccumulatorHalf2WordAtPtx868R1356;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx869R1357, r_MmaAccumulatorHalf2WordAtPtx870R1358,
		r_MmaAccumulatorHalf2WordAtPtx871R1359, r_MmaAccumulatorHalf2WordAtPtx872R1360,
		r_MmaAccumulatorHalf2WordAtPtx873R1361, r_MmaAccumulatorHalf2WordAtPtx874R1362, r_PtxRegister1363,
		r_MmaBE4x4WordAtPtx60R1364, r_MmaBE4x4WordAtPtx60R1365, r_MmaBE4x4WordAtPtx60R1366,
		r_MmaBE4x4WordAtPtx60R1367, r_MmaBE4x4WordAtPtx71R1368;
	uint32_t r_MmaBE4x4WordAtPtx71R1369, r_MmaBE4x4WordAtPtx71R1370, r_MmaBE4x4WordAtPtx71R1371,
		r_MmaBE4x4WordAtPtx80R1372, r_MmaBE4x4WordAtPtx80R1373, r_MmaBE4x4WordAtPtx80R1374,
		r_MmaBE4x4WordAtPtx80R1375, r_MmaBE4x4WordAtPtx89R1376, r_MmaBE4x4WordAtPtx89R1377,
		r_MmaBE4x4WordAtPtx89R1378, r_MmaBE4x4WordAtPtx89R1379, r_MmaBE4x4WordAtPtx98R1380;
	uint32_t r_MmaBE4x4WordAtPtx98R1381, r_MmaBE4x4WordAtPtx98R1382, r_MmaBE4x4WordAtPtx98R1383,
		r_MmaBE4x4WordAtPtx107R1384, r_MmaBE4x4WordAtPtx107R1385, r_MmaBE4x4WordAtPtx107R1386,
		r_MmaBE4x4WordAtPtx107R1387, r_MmaBE4x4WordAtPtx116R1388, r_MmaBE4x4WordAtPtx116R1389,
		r_MmaBE4x4WordAtPtx116R1390, r_MmaBE4x4WordAtPtx116R1391, r_MmaBE4x4WordAtPtx125R1392;
	uint32_t r_MmaBE4x4WordAtPtx125R1393, r_MmaBE4x4WordAtPtx125R1394, r_MmaBE4x4WordAtPtx125R1395,
		r_MmaAccumulatorHalf2WordAtPtx2433R1396, r_MmaAccumulatorHalf2WordAtPtx2434R1397,
		r_MmaAccumulatorHalf2WordAtPtx2435R1398, r_MmaAccumulatorHalf2WordAtPtx2436R1399,
		r_MmaAccumulatorHalf2WordAtPtx2437R1400, r_MmaAccumulatorHalf2WordAtPtx2438R1401,
		r_MmaAccumulatorHalf2WordAtPtx2439R1402, r_MmaAccumulatorHalf2WordAtPtx2440R1403,
		r_MmaAccumulatorHalf2WordAtPtx2441R1404;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2442R1405, r_MmaAccumulatorHalf2WordAtPtx2443R1406,
		r_MmaAccumulatorHalf2WordAtPtx2444R1407, r_MmaAccumulatorHalf2WordAtPtx2445R1408,
		r_MmaAccumulatorHalf2WordAtPtx2446R1409, r_MmaAccumulatorHalf2WordAtPtx2447R1410,
		r_MmaAccumulatorHalf2WordAtPtx2448R1411, r_MmaAccumulatorHalf2WordAtPtx2449R1412,
		r_MmaAccumulatorHalf2WordAtPtx2450R1413, r_MmaAccumulatorHalf2WordAtPtx2451R1414,
		r_MmaAccumulatorHalf2WordAtPtx2452R1415, r_MmaAccumulatorHalf2WordAtPtx2453R1416;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2454R1417, r_MmaAccumulatorHalf2WordAtPtx2455R1418,
		r_MmaAccumulatorHalf2WordAtPtx2456R1419, r_MmaAccumulatorHalf2WordAtPtx2457R1420,
		r_MmaAccumulatorHalf2WordAtPtx2458R1421, r_MmaAccumulatorHalf2WordAtPtx2459R1422,
		r_MmaAccumulatorHalf2WordAtPtx2460R1423, r_MmaAccumulatorHalf2WordAtPtx2461R1424,
		r_MmaAccumulatorHalf2WordAtPtx2462R1425, r_MmaAccumulatorHalf2WordAtPtx2463R1426,
		r_MmaAccumulatorHalf2WordAtPtx2464R1427, r_MmaAccumulatorHalf2WordAtPtx2465R1428;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2466R1429, r_MmaAccumulatorHalf2WordAtPtx2467R1430,
		r_MmaAccumulatorHalf2WordAtPtx2468R1431, r_MmaAccumulatorHalf2WordAtPtx2469R1432,
		r_MmaAccumulatorHalf2WordAtPtx2470R1433, r_MmaAccumulatorHalf2WordAtPtx2471R1434,
		r_MmaAccumulatorHalf2WordAtPtx2472R1435, r_MmaAccumulatorHalf2WordAtPtx2473R1436,
		r_MmaAccumulatorHalf2WordAtPtx2474R1437, r_MmaAccumulatorHalf2WordAtPtx2475R1438,
		r_MmaAccumulatorHalf2WordAtPtx2476R1439, r_MmaAccumulatorHalf2WordAtPtx2477R1440;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2478R1441, r_MmaAccumulatorHalf2WordAtPtx2479R1442,
		r_MmaAccumulatorHalf2WordAtPtx2480R1443, r_MmaAccumulatorHalf2WordAtPtx2481R1444,
		r_MmaAccumulatorHalf2WordAtPtx2482R1445, r_MmaAccumulatorHalf2WordAtPtx2483R1446,
		r_MmaAccumulatorHalf2WordAtPtx2484R1447, r_MmaAccumulatorHalf2WordAtPtx2485R1448,
		r_MmaAccumulatorHalf2WordAtPtx2486R1449, r_MmaAccumulatorHalf2WordAtPtx2487R1450,
		r_MmaAccumulatorHalf2WordAtPtx2488R1451, r_MmaAccumulatorHalf2WordAtPtx2489R1452;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2490R1453, r_MmaAccumulatorHalf2WordAtPtx2491R1454,
		r_MmaAccumulatorHalf2WordAtPtx2492R1455, r_MmaAccumulatorHalf2WordAtPtx2493R1456,
		r_MmaAccumulatorHalf2WordAtPtx2494R1457, r_MmaAccumulatorHalf2WordAtPtx2495R1458,
		r_MmaAccumulatorHalf2WordAtPtx2496R1459, r_PtxRegister1460;
	uint64_t g_StateBaseAddress, r_PtxU64Register2, r_PtxU64Register3, r_PtxU64Register4, r_PtxU64Register5,
		r_PtxU64Register6, r_PtxU64Register7, r_PtxU64Register8, r_PtxU64Register9, r_PtxU64Register10,
		r_PtxU64Register11, r_PtxU64Register12;
	uint64_t r_PtxU64Register13, r_PtxU64Register14, r_PtxU64Register15, r_PtxU64Register16,
		r_PtxU64Register17, r_PtxU64Register18, g_OutputByteAddressAtPtx4467, g_OutputByteAddressAtPtx4536,
		g_OutputBaseAddress, g_RecordBaseAddress, g_RecordByteAddressAtPtx58, g_RecordByteAddressAtPtx69;
	uint64_t g_RecordByteAddressAtPtx78, g_RecordByteAddressAtPtx87, g_RecordByteAddressAtPtx96,
		g_RecordByteAddressAtPtx105, g_RecordByteAddressAtPtx114, g_RecordByteAddressAtPtx123,
		r_PtxU64Register31, g_RecordByteAddressAtPtx53, r_PtxU64Register33, r_PtxU64Register34,
		g_RecordByteAddressAtPtx64, r_PtxU64Register36;
	uint64_t g_RecordByteAddressAtPtx73, r_PtxU64Register38, g_RecordByteAddressAtPtx82, r_PtxU64Register40,
		r_PtxU64Register41, g_RecordByteAddressAtPtx95, r_PtxU64Register43, g_RecordByteAddressAtPtx104,
		r_PtxU64Register45, g_RecordByteAddressAtPtx113, r_PtxU64Register47, g_RecordByteAddressAtPtx122;
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
		r_PtxU64Register89, r_PtxU64Register90, r_PtxU64Register91, r_PtxU64Register92, r_PtxU64Register93,
		r_PtxU64Register94, r_PtxU64Register95, r_PtxU64Register96;
	uint64_t r_PtxU64Register97, r_PtxU64Register98, r_PtxU64Register99, r_PtxU64Register100,
		r_PtxU64Register101, r_PtxU64Register102, r_PtxU64Register103, r_PtxU64Register104,
		r_PtxU64Register105, r_PtxU64Register106, r_PtxU64Register107, g_RecordByteAddressAtPtx1809;
	uint64_t g_RecordByteAddressAtPtx1818, g_RecordByteAddressAtPtx1827, g_RecordByteAddressAtPtx1836,
		g_RecordByteAddressAtPtx1845, g_RecordByteAddressAtPtx1854, g_RecordByteAddressAtPtx1863,
		g_RecordByteAddressAtPtx1872, r_PtxU64Register116, g_RecordByteAddressAtPtx1804, r_PtxU64Register118,
		r_PtxU64Register119, g_RecordByteAddressAtPtx1817;
	uint64_t r_PtxU64Register121, g_RecordByteAddressAtPtx1826, r_PtxU64Register123,
		g_RecordByteAddressAtPtx1835, r_PtxU64Register125, g_RecordByteAddressAtPtx1844, r_PtxU64Register127,
		g_RecordByteAddressAtPtx1853, r_PtxU64Register129, g_RecordByteAddressAtPtx1862, r_PtxU64Register131,
		g_RecordByteAddressAtPtx1871;
	uint64_t r_PtxU64Register133, r_PtxU64Register134, g_RecordByteAddressAtPtx2426, r_PtxU64Register136,
		g_RecordByteAddressAtPtx2429, r_PtxU64Register138, r_PtxU64Register139, r_PtxU64Register140,
		r_PtxU64Register141, r_PtxU64Register142, r_PtxU64Register143, r_PtxU64Register144;
	uint64_t r_PtxU64Register145, r_PtxU64Register146, r_PtxU64Register147, r_PtxU64Register148,
		r_PtxU64Register149, r_PtxU64Register150, r_PtxU64Register151, r_PtxU64Register152,
		r_PtxU64Register153, r_PtxU64Register154, r_PtxU64Register155, r_PtxU64Register156;
	uint64_t r_PtxU64Register157, r_PtxU64Register158, r_PtxU64Register159, g_OutputByteAddressAtPtx4482,
		g_OutputByteAddressAtPtx4491, r_PtxU64Register162, r_PtxU64Register163, g_OutputByteAddressAtPtx4490,
		g_OutputByteAddressAtPtx4506, g_OutputByteAddressAtPtx4519, r_PtxU64Register167,
		g_OutputByteAddressAtPtx4505;
	uint64_t r_PtxU64Register169, g_OutputByteAddressAtPtx4518, r_PtxU64Register171,
		g_OutputByteAddressAtPtx4543, g_OutputByteAddressAtPtx4556, r_PtxU64Register174, r_PtxU64Register175,
		g_OutputByteAddressAtPtx4555, g_OutputByteAddressAtPtx4573, g_OutputByteAddressAtPtx4586,
		r_PtxU64Register179, g_OutputByteAddressAtPtx4572;
	uint64_t r_PtxU64Register181, g_OutputByteAddressAtPtx4585, r_PtxU64Register183, r_PtxU64Register184,
		r_PtxU64Register185, r_PtxU64Register186, r_PtxU64Register187, r_PtxU64Register188,
		r_PtxU64Register189, r_PtxU64Register190, r_PtxU64Register191, r_PtxU64Register192;
	uint64_t r_PtxU64Register193, r_PtxU64Register194, r_PtxU64Register195, r_PtxU64Register196,
		r_PtxU64Register197, r_PtxU64Register198, r_PtxU64Register199, r_PtxU64Register200,
		r_PtxU64Register201;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	r_HeightBits = uint32_t(r_Parameters.Height);
	r_WidthBits = uint32_t(r_Parameters.Width);						  // PTX L14
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record);			  // PTX L15
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);			  // PTX L16
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);			  // PTX L17
	r_CtaXAtPtx18 = uint32_t(blockIdx.x);							  // PTX L18
	r_CtaY = uint32_t(blockIdx.y);									  // PTX L19
	r_CtaZ = uint32_t(blockIdx.z);									  // PTX L20
	r_PtxRegister2 = ShiftLeft(uint32_t(r_CtaY), uint32_t(3));		  // PTX L21
	r_PtxRegister3 = ShiftLeft(uint32_t(r_CtaXAtPtx18), uint32_t(3)); // PTX L22
	r_ThreadX = uint32_t(threadIdx.x);								  // PTX L23
	r_ThreadY = uint32_t(threadIdx.y);								  // PTX L24
	r_PtxRegister88 = r_ThreadX | r_ThreadY;						  // PTX L25
	r_bPtxPredicate25 = uint32_t(r_PtxRegister88) != uint32_t(0);	  // PTX L26
	if (r_bPtxPredicate25)
	{
		goto L__BB3_2;
	} // PTX L27
	r_BlockSizeX = uint32_t(blockDim.x);									   // PTX L28
	r_BlockSizeY = uint32_t(blockDim.y);									   // PTX L29
	r_PtxRegister90 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);		   // PTX L30
	r_PtxRegister89 = uint32_t(8192u /* exact native shared-region offset */); // PTX L31
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister89, r_PtxRegister90); // PTX L33
	r_PtxRegister91 = uint32_t(r_PtxRegister89) + uint32_t(8);		// PTX L35
	BarrierInit(s_SharedStorage, r_PtxRegister91, r_PtxRegister90); // PTX L37
L__BB3_2:															// PTX L39
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L40
	r_Float32BitsAtPtx41R94 = uint32_t(0);														// PTX L41
	r_PackedHalf2AtPtx43R6 = FloatToHalf2(r_Float32BitsAtPtx41R94);								// PTX L43
	r_PtxRegister103 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L48
	r_PtxRegister104 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(8));								// PTX L49
	r_PtxRegister105 = uint32_t(r_PtxRegister103) + uint32_t(r_PtxRegister104);					// PTX L50
	r_PtxRegister7 = ShiftLeft(uint32_t(r_PtxRegister105), uint32_t(3));						// PTX L51
	r_PtxU64Register31 = uint64_t(uint32_t(r_PtxRegister7)) * uint64_t(uint32_t(4));			// PTX L52
	g_RecordByteAddressAtPtx53 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register31);	// PTX L53
	r_LaneIndexAtPtx55 = uint32_t((threadIdx.x & 31u));											// PTX L55
	r_PtxU64Register33 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx55)) * int64_t(int32_t(16))); // PTX L57
	g_RecordByteAddressAtPtx58 =
		uint64_t(g_RecordByteAddressAtPtx53) + uint64_t(r_PtxU64Register33); // PTX L58
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx58));
		r_MmaBE4x4WordAtPtx60R1364 = r_Value.x;
		r_MmaBE4x4WordAtPtx60R1365 = r_Value.y;
		r_MmaBE4x4WordAtPtx60R1366 = r_Value.z;
		r_MmaBE4x4WordAtPtx60R1367 = r_Value.w;
	} // PTX L60
	r_PtxRegister106 = r_PtxRegister7 | 128;													// PTX L62
	r_PtxU64Register34 = uint64_t(uint32_t(r_PtxRegister106)) * uint64_t(uint32_t(4));			// PTX L63
	g_RecordByteAddressAtPtx64 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register34);	// PTX L64
	r_LaneIndexAtPtx66 = uint32_t((threadIdx.x & 31u));											// PTX L66
	r_PtxU64Register36 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx66)) * int64_t(int32_t(16))); // PTX L68
	g_RecordByteAddressAtPtx69 =
		uint64_t(g_RecordByteAddressAtPtx64) + uint64_t(r_PtxU64Register36); // PTX L69
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx69));
		r_MmaBE4x4WordAtPtx71R1368 = r_Value.x;
		r_MmaBE4x4WordAtPtx71R1369 = r_Value.y;
		r_MmaBE4x4WordAtPtx71R1370 = r_Value.z;
		r_MmaBE4x4WordAtPtx71R1371 = r_Value.w;
	} // PTX L71
	g_RecordByteAddressAtPtx73 = uint64_t(g_RecordByteAddressAtPtx64) + uint64_t(512);			// PTX L73
	r_LaneIndexAtPtx75 = uint32_t((threadIdx.x & 31u));											// PTX L75
	r_PtxU64Register38 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx75)) * int64_t(int32_t(16))); // PTX L77
	g_RecordByteAddressAtPtx78 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register38); // PTX L78
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx78));
		r_MmaBE4x4WordAtPtx80R1372 = r_Value.x;
		r_MmaBE4x4WordAtPtx80R1373 = r_Value.y;
		r_MmaBE4x4WordAtPtx80R1374 = r_Value.z;
		r_MmaBE4x4WordAtPtx80R1375 = r_Value.w;
	} // PTX L80
	g_RecordByteAddressAtPtx82 = uint64_t(g_RecordByteAddressAtPtx64) + uint64_t(1024);			// PTX L82
	r_LaneIndexAtPtx84 = uint32_t((threadIdx.x & 31u));											// PTX L84
	r_PtxU64Register40 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx84)) * int64_t(int32_t(16))); // PTX L86
	g_RecordByteAddressAtPtx87 =
		uint64_t(g_RecordByteAddressAtPtx82) + uint64_t(r_PtxU64Register40); // PTX L87
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx87));
		r_MmaBE4x4WordAtPtx89R1376 = r_Value.x;
		r_MmaBE4x4WordAtPtx89R1377 = r_Value.y;
		r_MmaBE4x4WordAtPtx89R1378 = r_Value.z;
		r_MmaBE4x4WordAtPtx89R1379 = r_Value.w;
	} // PTX L89
	r_LaneIndexAtPtx92 = uint32_t((threadIdx.x & 31u));											// PTX L92
	r_PtxU64Register41 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx92)) * int64_t(int32_t(16))); // PTX L94
	g_RecordByteAddressAtPtx95 =
		uint64_t(g_RecordByteAddressAtPtx53) + uint64_t(r_PtxU64Register41);			 // PTX L95
	g_RecordByteAddressAtPtx96 = uint64_t(g_RecordByteAddressAtPtx95) + uint64_t(16384); // PTX L96
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx96));
		r_MmaBE4x4WordAtPtx98R1380 = r_Value.x;
		r_MmaBE4x4WordAtPtx98R1381 = r_Value.y;
		r_MmaBE4x4WordAtPtx98R1382 = r_Value.z;
		r_MmaBE4x4WordAtPtx98R1383 = r_Value.w;
	} // PTX L98
	r_LaneIndexAtPtx101 = uint32_t((threadIdx.x & 31u));										 // PTX L101
	r_PtxU64Register43 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx101)) * int64_t(int32_t(16))); // PTX L103
	g_RecordByteAddressAtPtx104 =
		uint64_t(g_RecordByteAddressAtPtx64) + uint64_t(r_PtxU64Register43);			   // PTX L104
	g_RecordByteAddressAtPtx105 = uint64_t(g_RecordByteAddressAtPtx104) + uint64_t(16384); // PTX L105
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx105));
		r_MmaBE4x4WordAtPtx107R1384 = r_Value.x;
		r_MmaBE4x4WordAtPtx107R1385 = r_Value.y;
		r_MmaBE4x4WordAtPtx107R1386 = r_Value.z;
		r_MmaBE4x4WordAtPtx107R1387 = r_Value.w;
	} // PTX L107
	r_LaneIndexAtPtx110 = uint32_t((threadIdx.x & 31u));										 // PTX L110
	r_PtxU64Register45 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx110)) * int64_t(int32_t(16))); // PTX L112
	g_RecordByteAddressAtPtx113 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register45);			   // PTX L113
	g_RecordByteAddressAtPtx114 = uint64_t(g_RecordByteAddressAtPtx113) + uint64_t(16384); // PTX L114
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx114));
		r_MmaBE4x4WordAtPtx116R1388 = r_Value.x;
		r_MmaBE4x4WordAtPtx116R1389 = r_Value.y;
		r_MmaBE4x4WordAtPtx116R1390 = r_Value.z;
		r_MmaBE4x4WordAtPtx116R1391 = r_Value.w;
	} // PTX L116
	r_LaneIndexAtPtx119 = uint32_t((threadIdx.x & 31u));										 // PTX L119
	r_PtxU64Register47 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx119)) * int64_t(int32_t(16))); // PTX L121
	g_RecordByteAddressAtPtx122 =
		uint64_t(g_RecordByteAddressAtPtx82) + uint64_t(r_PtxU64Register47);			   // PTX L122
	g_RecordByteAddressAtPtx123 = uint64_t(g_RecordByteAddressAtPtx122) + uint64_t(16384); // PTX L123
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx123));
		r_MmaBE4x4WordAtPtx125R1392 = r_Value.x;
		r_MmaBE4x4WordAtPtx125R1393 = r_Value.y;
		r_MmaBE4x4WordAtPtx125R1394 = r_Value.z;
		r_MmaBE4x4WordAtPtx125R1395 = r_Value.w;
	} // PTX L125
	r_PtxRegister107 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(5));	   // PTX L127
	r_PtxRegister8 = uint32_t(r_PtxRegister107) + uint32_t(r_ThreadX); // PTX L128
	r_bPtxPredicate26 = uint32_t(r_PtxRegister8) > uint32_t(1023);	   // PTX L129
	if (r_bPtxPredicate26)
	{
		goto L__BB3_8;
	} // PTX L130
	r_PtxRegister108 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(7));			   // PTX L131
	r_PtxRegister109 = r_PtxRegister8 & 112;										   // PTX L132
	r_PtxRegister110 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(2));			   // PTX L133
	r_PtxRegister9 = r_PtxRegister110 & 32;											   // PTX L134
	r_PtxRegister111 = ShiftRight(uint32_t(r_PtxRegister109), uint32_t(4));			   // PTX L135
	r_PtxRegister112 = ShiftLeft(uint32_t(r_ThreadX), uint32_t(3));					   // PTX L136
	r_PtxRegister113 = r_PtxRegister112 & 8;										   // PTX L137
	r_PtxRegister114 = r_PtxRegister113 | r_PtxRegister111;							   // PTX L138
	r_PtxRegister115 = r_PtxRegister8 & 1023;										   // PTX L139
	r_PtxU64Register49 = uint64_t(uint32_t(r_PtxRegister115)) * uint64_t(uint32_t(4)); // PTX L140
	r_PtxRegister116 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L141
	r_PtxU64Register50 = uint64_t(r_PtxRegister116);								   // PTX L142
	r_PtxU64Register51 = SharedGeneric(s_SharedStorage, r_PtxU64Register50);		   // PTX L143
	r_PtxU64Register2 = uint64_t(r_PtxU64Register51) + uint64_t(r_PtxU64Register49);   // PTX L144
	r_PtxRegister117 = r_PtxRegister111 & 3;										   // PTX L145
	r_PtxRegister118 = ShiftRight(uint32_t(r_PtxRegister114), uint32_t(2));			   // PTX L146
	r_PtxRegister119 = r_PtxRegister108 & 4;										   // PTX L147
	r_PtxRegister120 = r_PtxRegister119 | r_PtxRegister118;							   // PTX L148
	r_PtxRegister121 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(6));			   // PTX L149
	r_PtxRegister122 = r_PtxRegister121 & 4;										   // PTX L150
	r_PtxRegister123 = r_PtxRegister122 | r_PtxRegister117;							   // PTX L151
	r_PtxRegister124 = uint32_t(r_PtxRegister120) + uint32_t(r_PtxRegister2);		   // PTX L152
	r_PtxRegister125 = uint32_t(r_PtxRegister123) + uint32_t(r_PtxRegister3);		   // PTX L153
	r_bPtxPredicate27 = uint32_t(r_HeightBits) != uint32_t(1);						   // PTX L154
	r_bPtxPredicate28 = int32_t(r_PtxRegister124) >= int32_t(r_HeightBits);			   // PTX L155
	r_PtxRegister10 = r_bPtxPredicate27 ? r_PtxRegister124 : 0;						   // PTX L156
	r_bPtxPredicate29 = r_bPtxPredicate27 & r_bPtxPredicate28;						   // PTX L157
	r_bPtxPredicate30 = uint32_t(r_WidthBits) != uint32_t(1);						   // PTX L158
	r_bPtxPredicate31 = uint32_t(r_WidthBits) == uint32_t(1);						   // PTX L159
	r_bPtxPredicate32 = int32_t(r_PtxRegister125) >= int32_t(r_WidthBits);			   // PTX L160
	r_PtxRegister126 = r_bPtxPredicate31 ? 0 : r_PtxRegister125;					   // PTX L161
	r_bPtxPredicate33 = r_bPtxPredicate30 & r_bPtxPredicate32;						   // PTX L162
	r_PtxRegister11 = r_bPtxPredicate29 ? r_PtxRegister125 : r_PtxRegister126;		   // PTX L163
	r_bPtxPredicate1 = r_bPtxPredicate29 | r_bPtxPredicate33;						   // PTX L164
	r_PtxU64Register183 = uint64_t(0);												   // PTX L165
	if (r_bPtxPredicate1)
	{
		goto L__BB3_5;
	} // PTX L166
	r_PtxRegister127 = r_ThreadX & 12;										  // PTX L167
	r_PtxRegister128 = ShiftRight(uint32_t(r_PtxRegister127), uint32_t(2));	  // PTX L168
	r_PtxRegister129 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(2));	  // PTX L169
	r_PtxRegister130 = r_PtxRegister112 & 16;								  // PTX L170
	r_PtxRegister131 = r_PtxRegister130 | r_PtxRegister127;					  // PTX L171
	r_PtxRegister132 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister131); // PTX L172
	r_PtxRegister133 = ShiftRight(uint32_t(r_PtxRegister132), uint32_t(4));	  // PTX L173
	r_PtxRegister134 =
		uint32_t(r_PtxRegister133) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister10);	 // PTX L174
	r_PtxRegister135 = uint32_t(r_WidthBits) * uint32_t(r_PtxRegister134);					 // PTX L175
	r_PtxRegister136 = ShiftLeft(uint32_t(r_PtxRegister135), uint32_t(2));					 // PTX L176
	r_PtxRegister137 = r_PtxRegister136 | r_PtxRegister128;									 // PTX L177
	r_PtxRegister138 = uint32_t(r_PtxRegister137) + uint32_t(r_PtxRegister129);				 // PTX L178
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_PtxRegister138)) * int64_t(int32_t(4))); // PTX L179
	r_PtxU64Register183 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register52);		 // PTX L180
L__BB3_5:																					 // PTX L181
	if (r_bPtxPredicate1)
	{
		goto L__BB3_7;
	} // PTX L182
	goto L__BB3_6;																				   // PTX L183
L__BB3_7:																						   // PTX L184
	r_PtxRegister140 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register2));				   // PTX L186
	r_PtxRegister141 = uint32_t(0);																   // PTX L188
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister140)) = r_PtxRegister141; // PTX L190
	goto L__BB3_8;																				   // PTX L192
L__BB3_6:																						   // PTX L193
	r_PtxRegister139 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register2));				   // PTX L195
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyAsync4(s_SharedStorage, r_PtxRegister139, r_PtxU64Register183); // PTX L198
L__BB3_8:																// PTX L200
	r_bPtxPredicate34 = uint32_t(r_PtxRegister8) > uint32_t(895);		// PTX L201
	if (r_bPtxPredicate34)
	{
		goto L__BB3_14;
	} // PTX L202
	r_PtxRegister142 = uint32_t(r_PtxRegister8) + uint32_t(128);					   // PTX L203
	r_PtxRegister143 = ShiftRight(uint32_t(r_PtxRegister142), uint32_t(7));			   // PTX L204
	r_PtxRegister144 = r_PtxRegister8 & 127;										   // PTX L205
	r_PtxRegister145 = ShiftRight(uint32_t(r_PtxRegister142), uint32_t(2));			   // PTX L206
	r_PtxRegister12 = r_PtxRegister145 & 32;										   // PTX L207
	r_PtxRegister146 = ShiftRight(uint32_t(r_PtxRegister144), uint32_t(4));			   // PTX L208
	r_PtxRegister147 = ShiftLeft(uint32_t(r_ThreadX), uint32_t(3));					   // PTX L209
	r_PtxRegister148 = r_PtxRegister147 & 8;										   // PTX L210
	r_PtxRegister149 = r_PtxRegister148 | r_PtxRegister146;							   // PTX L211
	r_PtxRegister150 = r_PtxRegister142 & 1920;										   // PTX L212
	r_PtxRegister151 = r_PtxRegister150 | r_PtxRegister144;							   // PTX L213
	r_PtxU64Register53 = uint64_t(uint32_t(r_PtxRegister151)) * uint64_t(uint32_t(4)); // PTX L214
	r_PtxRegister152 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L215
	r_PtxU64Register54 = uint64_t(r_PtxRegister152);								   // PTX L216
	r_PtxU64Register55 = SharedGeneric(s_SharedStorage, r_PtxU64Register54);		   // PTX L217
	r_PtxU64Register3 = uint64_t(r_PtxU64Register55) + uint64_t(r_PtxU64Register53);   // PTX L218
	r_PtxRegister153 = r_PtxRegister146 & 3;										   // PTX L219
	r_PtxRegister154 = ShiftRight(uint32_t(r_PtxRegister149), uint32_t(2));			   // PTX L220
	r_PtxRegister155 = r_PtxRegister143 & 12;										   // PTX L221
	r_PtxRegister156 = r_PtxRegister155 | r_PtxRegister154;							   // PTX L222
	r_PtxRegister157 = ShiftRight(uint32_t(r_PtxRegister142), uint32_t(6));			   // PTX L223
	r_PtxRegister158 = r_PtxRegister157 & 4;										   // PTX L224
	r_PtxRegister159 = r_PtxRegister158 | r_PtxRegister153;							   // PTX L225
	r_PtxRegister160 = uint32_t(r_PtxRegister156) + uint32_t(r_PtxRegister2);		   // PTX L226
	r_PtxRegister161 = uint32_t(r_PtxRegister159) + uint32_t(r_PtxRegister3);		   // PTX L227
	r_bPtxPredicate35 = uint32_t(r_HeightBits) != uint32_t(1);						   // PTX L228
	r_bPtxPredicate36 = int32_t(r_PtxRegister160) >= int32_t(r_HeightBits);			   // PTX L229
	r_PtxRegister13 = r_bPtxPredicate35 ? r_PtxRegister160 : 0;						   // PTX L230
	r_bPtxPredicate37 = r_bPtxPredicate35 & r_bPtxPredicate36;						   // PTX L231
	r_bPtxPredicate38 = uint32_t(r_WidthBits) != uint32_t(1);						   // PTX L232
	r_bPtxPredicate39 = uint32_t(r_WidthBits) == uint32_t(1);						   // PTX L233
	r_bPtxPredicate40 = int32_t(r_PtxRegister161) >= int32_t(r_WidthBits);			   // PTX L234
	r_PtxRegister162 = r_bPtxPredicate39 ? 0 : r_PtxRegister161;					   // PTX L235
	r_bPtxPredicate41 = r_bPtxPredicate38 & r_bPtxPredicate40;						   // PTX L236
	r_PtxRegister14 = r_bPtxPredicate37 ? r_PtxRegister161 : r_PtxRegister162;		   // PTX L237
	r_bPtxPredicate2 = r_bPtxPredicate37 | r_bPtxPredicate41;						   // PTX L238
	r_PtxU64Register184 = uint64_t(0);												   // PTX L239
	if (r_bPtxPredicate2)
	{
		goto L__BB3_11;
	} // PTX L240
	r_PtxRegister163 = r_ThreadX & 12;										   // PTX L241
	r_PtxRegister164 = ShiftRight(uint32_t(r_PtxRegister163), uint32_t(2));	   // PTX L242
	r_PtxRegister165 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));	   // PTX L243
	r_PtxRegister166 = r_PtxRegister147 & 16;								   // PTX L244
	r_PtxRegister167 = r_PtxRegister166 | r_PtxRegister163;					   // PTX L245
	r_PtxRegister168 = uint32_t(r_PtxRegister12) + uint32_t(r_PtxRegister167); // PTX L246
	r_PtxRegister169 = ShiftRight(uint32_t(r_PtxRegister168), uint32_t(4));	   // PTX L247
	r_PtxRegister170 =
		uint32_t(r_PtxRegister169) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister13);	 // PTX L248
	r_PtxRegister171 = uint32_t(r_WidthBits) * uint32_t(r_PtxRegister170);					 // PTX L249
	r_PtxRegister172 = ShiftLeft(uint32_t(r_PtxRegister171), uint32_t(2));					 // PTX L250
	r_PtxRegister173 = r_PtxRegister172 | r_PtxRegister164;									 // PTX L251
	r_PtxRegister174 = uint32_t(r_PtxRegister173) + uint32_t(r_PtxRegister165);				 // PTX L252
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_PtxRegister174)) * int64_t(int32_t(4))); // PTX L253
	r_PtxU64Register184 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register56);		 // PTX L254
L__BB3_11:																					 // PTX L255
	if (r_bPtxPredicate2)
	{
		goto L__BB3_13;
	} // PTX L256
	goto L__BB3_12;																				   // PTX L257
L__BB3_13:																						   // PTX L258
	r_PtxRegister176 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register3));				   // PTX L260
	r_PtxRegister177 = uint32_t(0);																   // PTX L262
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister176)) = r_PtxRegister177; // PTX L264
	goto L__BB3_14;																				   // PTX L266
L__BB3_12:																						   // PTX L267
	r_PtxRegister175 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register3));				   // PTX L269
	CopyAsync4(s_SharedStorage, r_PtxRegister175, r_PtxU64Register184);							   // PTX L272
L__BB3_14:																						   // PTX L274
	r_bPtxPredicate42 = uint32_t(r_PtxRegister8) > uint32_t(767);								   // PTX L275
	if (r_bPtxPredicate42)
	{
		goto L__BB3_20;
	} // PTX L276
	r_PtxRegister178 = uint32_t(r_PtxRegister8) + uint32_t(256);					   // PTX L277
	r_PtxRegister179 = r_PtxRegister8 & 127;										   // PTX L278
	r_PtxRegister180 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(2));			   // PTX L279
	r_PtxRegister15 = r_PtxRegister180 & 32;										   // PTX L280
	r_PtxRegister181 = ShiftRight(uint32_t(r_PtxRegister179), uint32_t(4));			   // PTX L281
	r_PtxRegister182 = ShiftLeft(uint32_t(r_ThreadX), uint32_t(3));					   // PTX L282
	r_PtxRegister183 = r_PtxRegister182 & 8;										   // PTX L283
	r_PtxRegister184 = r_PtxRegister183 | r_PtxRegister181;							   // PTX L284
	r_PtxRegister185 = r_PtxRegister178 & 1792;										   // PTX L285
	r_PtxRegister186 = r_PtxRegister8 & 128;										   // PTX L286
	r_PtxRegister187 = r_PtxRegister185 | r_PtxRegister186;							   // PTX L287
	r_PtxRegister188 = r_PtxRegister187 | r_PtxRegister179;							   // PTX L288
	r_PtxU64Register57 = uint64_t(uint32_t(r_PtxRegister188)) * uint64_t(uint32_t(4)); // PTX L289
	r_PtxRegister189 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L290
	r_PtxU64Register58 = uint64_t(r_PtxRegister189);								   // PTX L291
	r_PtxU64Register59 = SharedGeneric(s_SharedStorage, r_PtxU64Register58);		   // PTX L292
	r_PtxU64Register4 = uint64_t(r_PtxU64Register59) + uint64_t(r_PtxU64Register57);   // PTX L293
	r_PtxRegister190 = r_PtxRegister181 & 3;										   // PTX L294
	r_PtxRegister191 = ShiftRight(uint32_t(r_PtxRegister184), uint32_t(2));			   // PTX L295
	r_PtxRegister192 = ShiftRight(uint32_t(r_PtxRegister178), uint32_t(7));			   // PTX L296
	r_PtxRegister193 = r_PtxRegister192 & 12;										   // PTX L297
	r_PtxRegister194 = r_PtxRegister193 | r_PtxRegister191;							   // PTX L298
	r_PtxRegister195 = ShiftRight(uint32_t(r_PtxRegister178), uint32_t(6));			   // PTX L299
	r_PtxRegister196 = r_PtxRegister195 & 4;										   // PTX L300
	r_PtxRegister197 = r_PtxRegister196 | r_PtxRegister190;							   // PTX L301
	r_PtxRegister198 = uint32_t(r_PtxRegister194) + uint32_t(r_PtxRegister2);		   // PTX L302
	r_PtxRegister199 = uint32_t(r_PtxRegister197) + uint32_t(r_PtxRegister3);		   // PTX L303
	r_bPtxPredicate43 = uint32_t(r_HeightBits) != uint32_t(1);						   // PTX L304
	r_bPtxPredicate44 = int32_t(r_PtxRegister198) >= int32_t(r_HeightBits);			   // PTX L305
	r_PtxRegister16 = r_bPtxPredicate43 ? r_PtxRegister198 : 0;						   // PTX L306
	r_bPtxPredicate45 = r_bPtxPredicate43 & r_bPtxPredicate44;						   // PTX L307
	r_bPtxPredicate46 = uint32_t(r_WidthBits) != uint32_t(1);						   // PTX L308
	r_bPtxPredicate47 = uint32_t(r_WidthBits) == uint32_t(1);						   // PTX L309
	r_bPtxPredicate48 = int32_t(r_PtxRegister199) >= int32_t(r_WidthBits);			   // PTX L310
	r_PtxRegister200 = r_bPtxPredicate47 ? 0 : r_PtxRegister199;					   // PTX L311
	r_bPtxPredicate49 = r_bPtxPredicate46 & r_bPtxPredicate48;						   // PTX L312
	r_PtxRegister17 = r_bPtxPredicate45 ? r_PtxRegister199 : r_PtxRegister200;		   // PTX L313
	r_bPtxPredicate3 = r_bPtxPredicate45 | r_bPtxPredicate49;						   // PTX L314
	r_PtxU64Register185 = uint64_t(0);												   // PTX L315
	if (r_bPtxPredicate3)
	{
		goto L__BB3_17;
	} // PTX L316
	r_PtxRegister201 = r_ThreadX & 12;										   // PTX L317
	r_PtxRegister202 = ShiftRight(uint32_t(r_PtxRegister201), uint32_t(2));	   // PTX L318
	r_PtxRegister203 = ShiftLeft(uint32_t(r_PtxRegister17), uint32_t(2));	   // PTX L319
	r_PtxRegister204 = r_PtxRegister182 & 16;								   // PTX L320
	r_PtxRegister205 = r_PtxRegister204 | r_PtxRegister201;					   // PTX L321
	r_PtxRegister206 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister205); // PTX L322
	r_PtxRegister207 = ShiftRight(uint32_t(r_PtxRegister206), uint32_t(4));	   // PTX L323
	r_PtxRegister208 =
		uint32_t(r_PtxRegister207) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister16);	 // PTX L324
	r_PtxRegister209 = uint32_t(r_WidthBits) * uint32_t(r_PtxRegister208);					 // PTX L325
	r_PtxRegister210 = ShiftLeft(uint32_t(r_PtxRegister209), uint32_t(2));					 // PTX L326
	r_PtxRegister211 = r_PtxRegister210 | r_PtxRegister202;									 // PTX L327
	r_PtxRegister212 = uint32_t(r_PtxRegister211) + uint32_t(r_PtxRegister203);				 // PTX L328
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_PtxRegister212)) * int64_t(int32_t(4))); // PTX L329
	r_PtxU64Register185 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register60);		 // PTX L330
L__BB3_17:																					 // PTX L331
	if (r_bPtxPredicate3)
	{
		goto L__BB3_19;
	} // PTX L332
	goto L__BB3_18;																				   // PTX L333
L__BB3_19:																						   // PTX L334
	r_PtxRegister214 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register4));				   // PTX L336
	r_PtxRegister215 = uint32_t(0);																   // PTX L338
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister214)) = r_PtxRegister215; // PTX L340
	goto L__BB3_20;																				   // PTX L342
L__BB3_18:																						   // PTX L343
	r_PtxRegister213 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register4));				   // PTX L345
	CopyAsync4(s_SharedStorage, r_PtxRegister213, r_PtxU64Register185);							   // PTX L348
L__BB3_20:																						   // PTX L350
	r_bPtxPredicate50 = uint32_t(r_PtxRegister8) > uint32_t(639);								   // PTX L351
	if (r_bPtxPredicate50)
	{
		goto L__BB3_26;
	} // PTX L352
	r_PtxRegister216 = uint32_t(r_PtxRegister8) + uint32_t(384);					   // PTX L353
	r_PtxRegister217 = ShiftRight(uint32_t(r_PtxRegister216), uint32_t(7));			   // PTX L354
	r_PtxRegister218 = r_PtxRegister8 & 127;										   // PTX L355
	r_PtxRegister219 = ShiftRight(uint32_t(r_PtxRegister216), uint32_t(2));			   // PTX L356
	r_PtxRegister18 = r_PtxRegister219 & 32;										   // PTX L357
	r_PtxRegister220 = ShiftRight(uint32_t(r_PtxRegister218), uint32_t(4));			   // PTX L358
	r_PtxRegister221 = ShiftLeft(uint32_t(r_ThreadX), uint32_t(3));					   // PTX L359
	r_PtxRegister222 = r_PtxRegister221 & 8;										   // PTX L360
	r_PtxRegister223 = r_PtxRegister222 | r_PtxRegister220;							   // PTX L361
	r_PtxRegister224 = r_PtxRegister216 & 1920;										   // PTX L362
	r_PtxRegister225 = r_PtxRegister224 | r_PtxRegister218;							   // PTX L363
	r_PtxU64Register61 = uint64_t(uint32_t(r_PtxRegister225)) * uint64_t(uint32_t(4)); // PTX L364
	r_PtxRegister226 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L365
	r_PtxU64Register62 = uint64_t(r_PtxRegister226);								   // PTX L366
	r_PtxU64Register63 = SharedGeneric(s_SharedStorage, r_PtxU64Register62);		   // PTX L367
	r_PtxU64Register5 = uint64_t(r_PtxU64Register63) + uint64_t(r_PtxU64Register61);   // PTX L368
	r_PtxRegister227 = r_PtxRegister220 & 3;										   // PTX L369
	r_PtxRegister228 = ShiftRight(uint32_t(r_PtxRegister223), uint32_t(2));			   // PTX L370
	r_PtxRegister229 = r_PtxRegister217 & 12;										   // PTX L371
	r_PtxRegister230 = r_PtxRegister229 | r_PtxRegister228;							   // PTX L372
	r_PtxRegister231 = ShiftRight(uint32_t(r_PtxRegister216), uint32_t(6));			   // PTX L373
	r_PtxRegister232 = r_PtxRegister231 & 4;										   // PTX L374
	r_PtxRegister233 = r_PtxRegister232 | r_PtxRegister227;							   // PTX L375
	r_PtxRegister234 = uint32_t(r_PtxRegister230) + uint32_t(r_PtxRegister2);		   // PTX L376
	r_PtxRegister235 = uint32_t(r_PtxRegister233) + uint32_t(r_PtxRegister3);		   // PTX L377
	r_bPtxPredicate51 = uint32_t(r_HeightBits) != uint32_t(1);						   // PTX L378
	r_bPtxPredicate52 = int32_t(r_PtxRegister234) >= int32_t(r_HeightBits);			   // PTX L379
	r_PtxRegister19 = r_bPtxPredicate51 ? r_PtxRegister234 : 0;						   // PTX L380
	r_bPtxPredicate53 = r_bPtxPredicate51 & r_bPtxPredicate52;						   // PTX L381
	r_bPtxPredicate54 = uint32_t(r_WidthBits) != uint32_t(1);						   // PTX L382
	r_bPtxPredicate55 = uint32_t(r_WidthBits) == uint32_t(1);						   // PTX L383
	r_bPtxPredicate56 = int32_t(r_PtxRegister235) >= int32_t(r_WidthBits);			   // PTX L384
	r_PtxRegister236 = r_bPtxPredicate55 ? 0 : r_PtxRegister235;					   // PTX L385
	r_bPtxPredicate57 = r_bPtxPredicate54 & r_bPtxPredicate56;						   // PTX L386
	r_PtxRegister20 = r_bPtxPredicate53 ? r_PtxRegister235 : r_PtxRegister236;		   // PTX L387
	r_bPtxPredicate4 = r_bPtxPredicate53 | r_bPtxPredicate57;						   // PTX L388
	r_PtxU64Register186 = uint64_t(0);												   // PTX L389
	if (r_bPtxPredicate4)
	{
		goto L__BB3_23;
	} // PTX L390
	r_PtxRegister237 = r_ThreadX & 12;										   // PTX L391
	r_PtxRegister238 = ShiftRight(uint32_t(r_PtxRegister237), uint32_t(2));	   // PTX L392
	r_PtxRegister239 = ShiftLeft(uint32_t(r_PtxRegister20), uint32_t(2));	   // PTX L393
	r_PtxRegister240 = r_PtxRegister221 & 16;								   // PTX L394
	r_PtxRegister241 = r_PtxRegister240 | r_PtxRegister237;					   // PTX L395
	r_PtxRegister242 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister241); // PTX L396
	r_PtxRegister243 = ShiftRight(uint32_t(r_PtxRegister242), uint32_t(4));	   // PTX L397
	r_PtxRegister244 =
		uint32_t(r_PtxRegister243) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister19);	 // PTX L398
	r_PtxRegister245 = uint32_t(r_WidthBits) * uint32_t(r_PtxRegister244);					 // PTX L399
	r_PtxRegister246 = ShiftLeft(uint32_t(r_PtxRegister245), uint32_t(2));					 // PTX L400
	r_PtxRegister247 = r_PtxRegister246 | r_PtxRegister238;									 // PTX L401
	r_PtxRegister248 = uint32_t(r_PtxRegister247) + uint32_t(r_PtxRegister239);				 // PTX L402
	r_PtxU64Register64 = uint64_t(int64_t(int32_t(r_PtxRegister248)) * int64_t(int32_t(4))); // PTX L403
	r_PtxU64Register186 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register64);		 // PTX L404
L__BB3_23:																					 // PTX L405
	if (r_bPtxPredicate4)
	{
		goto L__BB3_25;
	} // PTX L406
	goto L__BB3_24;																				   // PTX L407
L__BB3_25:																						   // PTX L408
	r_PtxRegister250 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register5));				   // PTX L410
	r_PtxRegister251 = uint32_t(0);																   // PTX L412
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister250)) = r_PtxRegister251; // PTX L414
	goto L__BB3_26;																				   // PTX L416
L__BB3_24:																						   // PTX L417
	r_PtxRegister249 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register5));				   // PTX L419
	CopyAsync4(s_SharedStorage, r_PtxRegister249, r_PtxU64Register186);							   // PTX L422
L__BB3_26:																						   // PTX L424
	r_bPtxPredicate58 = uint32_t(r_PtxRegister8) > uint32_t(511);								   // PTX L425
	if (r_bPtxPredicate58)
	{
		goto L__BB3_32;
	} // PTX L426
	r_PtxRegister252 = r_PtxRegister8 & 112;										   // PTX L427
	r_PtxRegister253 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(2));			   // PTX L428
	r_PtxRegister21 = r_PtxRegister253 & 32;										   // PTX L429
	r_PtxRegister254 = ShiftRight(uint32_t(r_PtxRegister252), uint32_t(4));			   // PTX L430
	r_PtxRegister255 = ShiftLeft(uint32_t(r_ThreadX), uint32_t(3));					   // PTX L431
	r_PtxRegister256 = r_PtxRegister255 & 8;										   // PTX L432
	r_PtxRegister257 = r_PtxRegister256 | r_PtxRegister254;							   // PTX L433
	r_PtxRegister258 = uint32_t(r_PtxRegister8) + uint32_t(512);					   // PTX L434
	r_PtxU64Register65 = uint64_t(uint32_t(r_PtxRegister258)) * uint64_t(uint32_t(4)); // PTX L435
	r_PtxRegister259 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L436
	r_PtxU64Register66 = uint64_t(r_PtxRegister259);								   // PTX L437
	r_PtxU64Register67 = SharedGeneric(s_SharedStorage, r_PtxU64Register66);		   // PTX L438
	r_PtxU64Register6 = uint64_t(r_PtxU64Register67) + uint64_t(r_PtxU64Register65);   // PTX L439
	r_PtxRegister260 = r_PtxRegister254 & 3;										   // PTX L440
	r_PtxRegister261 = ShiftRight(uint32_t(r_PtxRegister257), uint32_t(2));			   // PTX L441
	r_PtxRegister262 = uint32_t(r_PtxRegister261) + uint32_t(r_PtxRegister2);		   // PTX L442
	r_PtxRegister263 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(6));			   // PTX L443
	r_PtxRegister264 = r_PtxRegister263 & 1020;										   // PTX L444
	r_PtxRegister265 = r_PtxRegister264 | r_PtxRegister260;							   // PTX L445
	r_PtxRegister266 = uint32_t(r_PtxRegister262) + uint32_t(4);					   // PTX L446
	r_PtxRegister267 = uint32_t(r_PtxRegister265) + uint32_t(r_PtxRegister3);		   // PTX L447
	r_bPtxPredicate59 = uint32_t(r_HeightBits) != uint32_t(1);						   // PTX L448
	r_bPtxPredicate60 = int32_t(r_PtxRegister266) >= int32_t(r_HeightBits);			   // PTX L449
	r_PtxRegister22 = r_bPtxPredicate59 ? r_PtxRegister266 : 0;						   // PTX L450
	r_bPtxPredicate61 = r_bPtxPredicate59 & r_bPtxPredicate60;						   // PTX L451
	r_bPtxPredicate62 = uint32_t(r_WidthBits) != uint32_t(1);						   // PTX L452
	r_bPtxPredicate63 = uint32_t(r_WidthBits) == uint32_t(1);						   // PTX L453
	r_bPtxPredicate64 = int32_t(r_PtxRegister267) >= int32_t(r_WidthBits);			   // PTX L454
	r_PtxRegister268 = r_bPtxPredicate63 ? 0 : r_PtxRegister267;					   // PTX L455
	r_bPtxPredicate65 = r_bPtxPredicate62 & r_bPtxPredicate64;						   // PTX L456
	r_PtxRegister23 = r_bPtxPredicate61 ? r_PtxRegister267 : r_PtxRegister268;		   // PTX L457
	r_bPtxPredicate5 = r_bPtxPredicate61 | r_bPtxPredicate65;						   // PTX L458
	r_PtxU64Register187 = uint64_t(0);												   // PTX L459
	if (r_bPtxPredicate5)
	{
		goto L__BB3_29;
	} // PTX L460
	r_PtxRegister269 = r_ThreadX & 12;										   // PTX L461
	r_PtxRegister270 = ShiftRight(uint32_t(r_PtxRegister269), uint32_t(2));	   // PTX L462
	r_PtxRegister271 = ShiftLeft(uint32_t(r_PtxRegister23), uint32_t(2));	   // PTX L463
	r_PtxRegister272 = r_PtxRegister255 & 16;								   // PTX L464
	r_PtxRegister273 = r_PtxRegister272 | r_PtxRegister269;					   // PTX L465
	r_PtxRegister274 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister273); // PTX L466
	r_PtxRegister275 = ShiftRight(uint32_t(r_PtxRegister274), uint32_t(4));	   // PTX L467
	r_PtxRegister276 =
		uint32_t(r_PtxRegister275) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister22);	 // PTX L468
	r_PtxRegister277 = uint32_t(r_WidthBits) * uint32_t(r_PtxRegister276);					 // PTX L469
	r_PtxRegister278 = ShiftLeft(uint32_t(r_PtxRegister277), uint32_t(2));					 // PTX L470
	r_PtxRegister279 = r_PtxRegister278 | r_PtxRegister270;									 // PTX L471
	r_PtxRegister280 = uint32_t(r_PtxRegister279) + uint32_t(r_PtxRegister271);				 // PTX L472
	r_PtxU64Register68 = uint64_t(int64_t(int32_t(r_PtxRegister280)) * int64_t(int32_t(4))); // PTX L473
	r_PtxU64Register187 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register68);		 // PTX L474
L__BB3_29:																					 // PTX L475
	if (r_bPtxPredicate5)
	{
		goto L__BB3_31;
	} // PTX L476
	goto L__BB3_30;																				   // PTX L477
L__BB3_31:																						   // PTX L478
	r_PtxRegister282 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register6));				   // PTX L480
	r_PtxRegister283 = uint32_t(0);																   // PTX L482
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister282)) = r_PtxRegister283; // PTX L484
	goto L__BB3_32;																				   // PTX L486
L__BB3_30:																						   // PTX L487
	r_PtxRegister281 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register6));				   // PTX L489
	CopyAsync4(s_SharedStorage, r_PtxRegister281, r_PtxU64Register187);							   // PTX L492
L__BB3_32:																						   // PTX L494
	r_bPtxPredicate66 = uint32_t(r_PtxRegister8) > uint32_t(383);								   // PTX L495
	if (r_bPtxPredicate66)
	{
		goto L__BB3_38;
	} // PTX L496
	r_PtxRegister284 = uint32_t(r_PtxRegister8) + uint32_t(640);					   // PTX L497
	r_PtxRegister285 = r_PtxRegister8 & 127;										   // PTX L498
	r_PtxRegister286 = ShiftRight(uint32_t(r_PtxRegister284), uint32_t(2));			   // PTX L499
	r_PtxRegister24 = r_PtxRegister286 & 32;										   // PTX L500
	r_PtxRegister287 = ShiftRight(uint32_t(r_PtxRegister285), uint32_t(4));			   // PTX L501
	r_PtxRegister288 = ShiftLeft(uint32_t(r_ThreadX), uint32_t(3));					   // PTX L502
	r_PtxRegister289 = r_PtxRegister288 & 8;										   // PTX L503
	r_PtxRegister290 = r_PtxRegister289 | r_PtxRegister287;							   // PTX L504
	r_PtxRegister291 = r_PtxRegister284 & 384;										   // PTX L505
	r_PtxRegister292 = r_PtxRegister291 | r_PtxRegister285;							   // PTX L506
	r_PtxU64Register69 = uint64_t(uint32_t(r_PtxRegister292)) * uint64_t(uint32_t(4)); // PTX L507
	r_PtxRegister293 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L508
	r_PtxU64Register70 = uint64_t(r_PtxRegister293);								   // PTX L509
	r_PtxU64Register71 = SharedGeneric(s_SharedStorage, r_PtxU64Register70);		   // PTX L510
	r_PtxU64Register72 = uint64_t(r_PtxU64Register71) + uint64_t(r_PtxU64Register69);  // PTX L511
	r_PtxU64Register7 = uint64_t(r_PtxU64Register72) + uint64_t(2048);				   // PTX L512
	r_PtxRegister294 = r_PtxRegister287 & 3;										   // PTX L513
	r_PtxRegister295 = ShiftRight(uint32_t(r_PtxRegister290), uint32_t(2));			   // PTX L514
	r_PtxRegister296 = uint32_t(r_PtxRegister295) + uint32_t(r_PtxRegister2);		   // PTX L515
	r_PtxRegister297 = ShiftRight(uint32_t(r_PtxRegister284), uint32_t(6));			   // PTX L516
	r_PtxRegister298 = r_PtxRegister297 & 4;										   // PTX L517
	r_PtxRegister299 = r_PtxRegister298 | r_PtxRegister294;							   // PTX L518
	r_PtxRegister300 = uint32_t(r_PtxRegister296) + uint32_t(4);					   // PTX L519
	r_PtxRegister301 = uint32_t(r_PtxRegister299) + uint32_t(r_PtxRegister3);		   // PTX L520
	r_bPtxPredicate67 = uint32_t(r_HeightBits) != uint32_t(1);						   // PTX L521
	r_bPtxPredicate68 = int32_t(r_PtxRegister300) >= int32_t(r_HeightBits);			   // PTX L522
	r_PtxRegister25 = r_bPtxPredicate67 ? r_PtxRegister300 : 0;						   // PTX L523
	r_bPtxPredicate69 = r_bPtxPredicate67 & r_bPtxPredicate68;						   // PTX L524
	r_bPtxPredicate70 = uint32_t(r_WidthBits) != uint32_t(1);						   // PTX L525
	r_bPtxPredicate71 = uint32_t(r_WidthBits) == uint32_t(1);						   // PTX L526
	r_bPtxPredicate72 = int32_t(r_PtxRegister301) >= int32_t(r_WidthBits);			   // PTX L527
	r_PtxRegister302 = r_bPtxPredicate71 ? 0 : r_PtxRegister301;					   // PTX L528
	r_bPtxPredicate73 = r_bPtxPredicate70 & r_bPtxPredicate72;						   // PTX L529
	r_PtxRegister26 = r_bPtxPredicate69 ? r_PtxRegister301 : r_PtxRegister302;		   // PTX L530
	r_bPtxPredicate6 = r_bPtxPredicate69 | r_bPtxPredicate73;						   // PTX L531
	r_PtxU64Register188 = uint64_t(0);												   // PTX L532
	if (r_bPtxPredicate6)
	{
		goto L__BB3_35;
	} // PTX L533
	r_PtxRegister303 = r_ThreadX & 12;										   // PTX L534
	r_PtxRegister304 = ShiftRight(uint32_t(r_PtxRegister303), uint32_t(2));	   // PTX L535
	r_PtxRegister305 = ShiftLeft(uint32_t(r_PtxRegister26), uint32_t(2));	   // PTX L536
	r_PtxRegister306 = r_PtxRegister288 & 16;								   // PTX L537
	r_PtxRegister307 = r_PtxRegister306 | r_PtxRegister303;					   // PTX L538
	r_PtxRegister308 = uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister307); // PTX L539
	r_PtxRegister309 = ShiftRight(uint32_t(r_PtxRegister308), uint32_t(4));	   // PTX L540
	r_PtxRegister310 =
		uint32_t(r_PtxRegister309) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister25);	 // PTX L541
	r_PtxRegister311 = uint32_t(r_WidthBits) * uint32_t(r_PtxRegister310);					 // PTX L542
	r_PtxRegister312 = ShiftLeft(uint32_t(r_PtxRegister311), uint32_t(2));					 // PTX L543
	r_PtxRegister313 = r_PtxRegister312 | r_PtxRegister304;									 // PTX L544
	r_PtxRegister314 = uint32_t(r_PtxRegister313) + uint32_t(r_PtxRegister305);				 // PTX L545
	r_PtxU64Register73 = uint64_t(int64_t(int32_t(r_PtxRegister314)) * int64_t(int32_t(4))); // PTX L546
	r_PtxU64Register188 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register73);		 // PTX L547
L__BB3_35:																					 // PTX L548
	if (r_bPtxPredicate6)
	{
		goto L__BB3_37;
	} // PTX L549
	goto L__BB3_36;																				   // PTX L550
L__BB3_37:																						   // PTX L551
	r_PtxRegister316 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register7));				   // PTX L553
	r_PtxRegister317 = uint32_t(0);																   // PTX L555
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister316)) = r_PtxRegister317; // PTX L557
	goto L__BB3_38;																				   // PTX L559
L__BB3_36:																						   // PTX L560
	r_PtxRegister315 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register7));				   // PTX L562
	CopyAsync4(s_SharedStorage, r_PtxRegister315, r_PtxU64Register188);							   // PTX L565
L__BB3_38:																						   // PTX L567
	r_bPtxPredicate74 = uint32_t(r_PtxRegister8) > uint32_t(255);								   // PTX L568
	if (r_bPtxPredicate74)
	{
		goto L__BB3_44;
	} // PTX L569
	r_PtxRegister318 = r_PtxRegister8 & 112;										  // PTX L570
	r_PtxRegister319 = ShiftRight(uint32_t(r_PtxRegister318), uint32_t(4));			  // PTX L571
	r_PtxRegister320 = ShiftLeft(uint32_t(r_ThreadX), uint32_t(3));					  // PTX L572
	r_PtxRegister321 = r_PtxRegister320 & 8;										  // PTX L573
	r_PtxRegister322 = r_PtxRegister321 | r_PtxRegister319;							  // PTX L574
	r_PtxRegister323 = uint32_t(0u /* exact native shared-region offset */);		  // PTX L575
	r_PtxU64Register74 = uint64_t(r_PtxRegister323);								  // PTX L576
	r_PtxU64Register75 = SharedGeneric(s_SharedStorage, r_PtxU64Register74);		  // PTX L577
	r_PtxRegister324 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));			  // PTX L578
	r_PtxU64Register76 = uint64_t(r_PtxRegister324);								  // PTX L579
	r_PtxU64Register77 = r_PtxU64Register76 & 1020;									  // PTX L580
	r_PtxU64Register78 = uint64_t(r_PtxU64Register75) + uint64_t(r_PtxU64Register77); // PTX L581
	r_PtxU64Register8 = uint64_t(r_PtxU64Register78) + uint64_t(3072);				  // PTX L582
	r_PtxRegister325 = r_PtxRegister319 & 3;										  // PTX L583
	r_PtxRegister326 = ShiftRight(uint32_t(r_PtxRegister322), uint32_t(2));			  // PTX L584
	r_PtxRegister327 = uint32_t(r_PtxRegister326) + uint32_t(r_PtxRegister2);		  // PTX L585
	r_PtxRegister328 = uint32_t(r_PtxRegister325) + uint32_t(r_PtxRegister3);		  // PTX L586
	r_PtxRegister329 = uint32_t(r_PtxRegister327) + uint32_t(4);					  // PTX L587
	r_PtxRegister330 = uint32_t(r_PtxRegister328) + uint32_t(4);					  // PTX L588
	r_bPtxPredicate75 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L589
	r_bPtxPredicate76 = int32_t(r_PtxRegister329) >= int32_t(r_HeightBits);			  // PTX L590
	r_PtxRegister27 = r_bPtxPredicate75 ? r_PtxRegister329 : 0;						  // PTX L591
	r_bPtxPredicate77 = r_bPtxPredicate75 & r_bPtxPredicate76;						  // PTX L592
	r_bPtxPredicate78 = uint32_t(r_WidthBits) != uint32_t(1);						  // PTX L593
	r_bPtxPredicate79 = uint32_t(r_WidthBits) == uint32_t(1);						  // PTX L594
	r_bPtxPredicate80 = int32_t(r_PtxRegister330) >= int32_t(r_WidthBits);			  // PTX L595
	r_PtxRegister331 = r_bPtxPredicate79 ? 0 : r_PtxRegister330;					  // PTX L596
	r_bPtxPredicate81 = r_bPtxPredicate78 & r_bPtxPredicate80;						  // PTX L597
	r_PtxRegister28 = r_bPtxPredicate77 ? r_PtxRegister330 : r_PtxRegister331;		  // PTX L598
	r_bPtxPredicate7 = r_bPtxPredicate77 | r_bPtxPredicate81;						  // PTX L599
	r_PtxU64Register189 = uint64_t(0);												  // PTX L600
	if (r_bPtxPredicate7)
	{
		goto L__BB3_41;
	} // PTX L601
	r_PtxRegister332 = r_ThreadX & 12;										// PTX L602
	r_PtxRegister333 = ShiftRight(uint32_t(r_PtxRegister332), uint32_t(2)); // PTX L603
	r_PtxRegister334 = ShiftLeft(uint32_t(r_PtxRegister28), uint32_t(2));	// PTX L604
	r_PtxRegister335 = r_PtxRegister320 & 16;								// PTX L605
	r_PtxRegister336 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(2));	// PTX L606
	r_PtxRegister337 = r_PtxRegister336 & 32;								// PTX L607
	r_PtxRegister338 = r_PtxRegister337 | r_PtxRegister335;					// PTX L608
	r_PtxRegister339 = ShiftRight(uint32_t(r_PtxRegister338), uint32_t(4)); // PTX L609
	r_PtxRegister340 =
		uint32_t(r_PtxRegister339) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister27);	 // PTX L610
	r_PtxRegister341 = uint32_t(r_WidthBits) * uint32_t(r_PtxRegister340);					 // PTX L611
	r_PtxRegister342 = ShiftLeft(uint32_t(r_PtxRegister341), uint32_t(2));					 // PTX L612
	r_PtxRegister343 = r_PtxRegister342 | r_PtxRegister333;									 // PTX L613
	r_PtxRegister344 = uint32_t(r_PtxRegister343) + uint32_t(r_PtxRegister334);				 // PTX L614
	r_PtxU64Register79 = uint64_t(int64_t(int32_t(r_PtxRegister344)) * int64_t(int32_t(4))); // PTX L615
	r_PtxU64Register189 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register79);		 // PTX L616
L__BB3_41:																					 // PTX L617
	if (r_bPtxPredicate7)
	{
		goto L__BB3_43;
	} // PTX L618
	goto L__BB3_42;																				   // PTX L619
L__BB3_43:																						   // PTX L620
	r_PtxRegister346 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register8));				   // PTX L622
	r_PtxRegister347 = uint32_t(0);																   // PTX L624
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister346)) = r_PtxRegister347; // PTX L626
	goto L__BB3_44;																				   // PTX L628
L__BB3_42:																						   // PTX L629
	r_PtxRegister345 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register8));				   // PTX L631
	CopyAsync4(s_SharedStorage, r_PtxRegister345, r_PtxU64Register189);							   // PTX L634
L__BB3_44:																						   // PTX L636
	r_bPtxPredicate82 = uint32_t(r_PtxRegister8) > uint32_t(127);								   // PTX L637
	if (r_bPtxPredicate82)
	{
		goto L__BB3_50;
	} // PTX L638
	r_PtxRegister348 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(4));			  // PTX L639
	r_PtxRegister349 = ShiftLeft(uint32_t(r_ThreadX), uint32_t(3));					  // PTX L640
	r_PtxRegister350 = r_PtxRegister349 & 8;										  // PTX L641
	r_PtxRegister351 = uint32_t(r_PtxRegister350) + uint32_t(r_PtxRegister348);		  // PTX L642
	r_PtxU64Register80 = uint64_t(uint32_t(r_PtxRegister8)) * uint64_t(uint32_t(4));  // PTX L643
	r_PtxRegister352 = uint32_t(0u /* exact native shared-region offset */);		  // PTX L644
	r_PtxU64Register81 = uint64_t(r_PtxRegister352);								  // PTX L645
	r_PtxU64Register82 = SharedGeneric(s_SharedStorage, r_PtxU64Register81);		  // PTX L646
	r_PtxU64Register83 = uint64_t(r_PtxU64Register82) + uint64_t(r_PtxU64Register80); // PTX L647
	r_PtxU64Register9 = uint64_t(r_PtxU64Register83) + uint64_t(3584);				  // PTX L648
	r_PtxRegister353 = r_PtxRegister348 & 3;										  // PTX L649
	r_PtxRegister354 = ShiftRight(uint32_t(r_PtxRegister351), uint32_t(2));			  // PTX L650
	r_PtxRegister355 = uint32_t(r_PtxRegister354) + uint32_t(r_PtxRegister2);		  // PTX L651
	r_PtxRegister356 = uint32_t(r_PtxRegister353) + uint32_t(r_PtxRegister3);		  // PTX L652
	r_PtxRegister357 = uint32_t(r_PtxRegister355) + uint32_t(4);					  // PTX L653
	r_PtxRegister358 = uint32_t(r_PtxRegister356) + uint32_t(4);					  // PTX L654
	r_bPtxPredicate83 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L655
	r_bPtxPredicate84 = int32_t(r_PtxRegister357) >= int32_t(r_HeightBits);			  // PTX L656
	r_PtxRegister29 = r_bPtxPredicate83 ? r_PtxRegister357 : 0;						  // PTX L657
	r_bPtxPredicate85 = r_bPtxPredicate83 & r_bPtxPredicate84;						  // PTX L658
	r_bPtxPredicate86 = uint32_t(r_WidthBits) != uint32_t(1);						  // PTX L659
	r_bPtxPredicate87 = uint32_t(r_WidthBits) == uint32_t(1);						  // PTX L660
	r_bPtxPredicate88 = int32_t(r_PtxRegister358) >= int32_t(r_WidthBits);			  // PTX L661
	r_PtxRegister359 = r_bPtxPredicate87 ? 0 : r_PtxRegister358;					  // PTX L662
	r_bPtxPredicate89 = r_bPtxPredicate86 & r_bPtxPredicate88;						  // PTX L663
	r_PtxRegister30 = r_bPtxPredicate85 ? r_PtxRegister358 : r_PtxRegister359;		  // PTX L664
	r_bPtxPredicate8 = r_bPtxPredicate85 | r_bPtxPredicate89;						  // PTX L665
	r_PtxU64Register190 = uint64_t(0);												  // PTX L666
	if (r_bPtxPredicate8)
	{
		goto L__BB3_47;
	} // PTX L667
	r_PtxRegister360 = ShiftRight(uint32_t(r_ThreadX), uint32_t(2));	  // PTX L668
	r_PtxRegister361 = r_PtxRegister360 & 3;							  // PTX L669
	r_PtxRegister362 = ShiftLeft(uint32_t(r_PtxRegister30), uint32_t(2)); // PTX L670
	r_PtxRegister363 = ShiftRight(uint32_t(r_ThreadX), uint32_t(1));	  // PTX L671
	r_PtxRegister364 = r_PtxRegister363 & 1;							  // PTX L672
	r_PtxRegister365 = r_PtxRegister364 | 2;							  // PTX L673
	r_PtxRegister366 =
		uint32_t(r_PtxRegister365) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister29);	 // PTX L674
	r_PtxRegister367 = uint32_t(r_WidthBits) * uint32_t(r_PtxRegister366);					 // PTX L675
	r_PtxRegister368 = ShiftLeft(uint32_t(r_PtxRegister367), uint32_t(2));					 // PTX L676
	r_PtxRegister369 = r_PtxRegister368 | r_PtxRegister361;									 // PTX L677
	r_PtxRegister370 = uint32_t(r_PtxRegister369) + uint32_t(r_PtxRegister362);				 // PTX L678
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_PtxRegister370)) * int64_t(int32_t(4))); // PTX L679
	r_PtxU64Register190 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register84);		 // PTX L680
L__BB3_47:																					 // PTX L681
	if (r_bPtxPredicate8)
	{
		goto L__BB3_49;
	} // PTX L682
	goto L__BB3_48;																				   // PTX L683
L__BB3_49:																						   // PTX L684
	r_PtxRegister372 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register9));				   // PTX L686
	r_PtxRegister373 = uint32_t(0);																   // PTX L688
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister372)) = r_PtxRegister373; // PTX L690
	goto L__BB3_50;																				   // PTX L692
L__BB3_48:																						   // PTX L693
	r_PtxRegister371 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register9));				   // PTX L695
	CopyAsync4(s_SharedStorage, r_PtxRegister371, r_PtxU64Register190);							   // PTX L698
L__BB3_50:																						   // PTX L700
	CopyCommit();																				   // PTX L702
	CopyWait0();																				   // PTX L705
	r_PtxRegister374 = uint32_t(8192u /* exact native shared-region offset */);					   // PTX L707
	r_PtxRegister375 = uint32_t(1);																   // PTX L708
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register85 = BarrierArrive(s_SharedStorage, r_PtxRegister374, r_PtxRegister375); // PTX L710
L__BB3_51:																					 // PTX L712
	r_PtxRegister377 = uint32_t(8192u /* exact native shared-region offset */);				 // PTX L713
	r_PtxRegister376 = BarrierReady(s_SharedStorage, r_PtxRegister377, r_PtxU64Register85);	 // PTX L715
	r_bPtxPredicate90 = uint32_t(r_PtxRegister376) == uint32_t(0);							 // PTX L721
	if (r_bPtxPredicate90)
	{
		goto L__BB3_51;
	} // PTX L722
	r_PtxRegister378 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(7));			  // PTX L723
	r_PtxRegister379 = r_PtxRegister8 & 127;										  // PTX L724
	r_PtxRegister380 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(2));			  // PTX L725
	r_PtxRegister381 = r_PtxRegister380 & 32;										  // PTX L726
	r_PtxRegister382 = r_ThreadX & 12;												  // PTX L727
	r_PtxRegister383 = ShiftRight(uint32_t(r_PtxRegister379), uint32_t(4));			  // PTX L728
	r_PtxRegister384 = ShiftLeft(uint32_t(r_ThreadX), uint32_t(3));					  // PTX L729
	r_PtxRegister385 = r_PtxRegister384 & 8;										  // PTX L730
	r_PtxRegister386 = r_PtxRegister385 | r_PtxRegister383;							  // PTX L731
	r_PtxRegister387 = r_PtxRegister384 & 16;										  // PTX L732
	r_PtxRegister388 = r_PtxRegister381 | r_PtxRegister387;							  // PTX L733
	r_PtxRegister31 = ShiftRight(uint32_t(r_PtxRegister388), uint32_t(4));			  // PTX L734
	r_PtxRegister389 = r_PtxRegister383 & 3;										  // PTX L735
	r_PtxRegister390 = ShiftRight(uint32_t(r_PtxRegister386), uint32_t(2));			  // PTX L736
	r_PtxRegister391 = r_PtxRegister378 & 508;										  // PTX L737
	r_PtxRegister392 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(6));			  // PTX L738
	r_PtxRegister393 = r_PtxRegister392 & 4;										  // PTX L739
	r_PtxRegister32 = ShiftLeft(uint32_t(r_WidthBits), uint32_t(2));				  // PTX L740
	r_PtxRegister394 = uint32_t(r_PtxRegister8) + uint32_t(128);					  // PTX L741
	r_PtxRegister395 = ShiftRight(uint32_t(r_PtxRegister394), uint32_t(7));			  // PTX L742
	r_PtxRegister396 = ShiftRight(uint32_t(r_PtxRegister394), uint32_t(2));			  // PTX L743
	r_PtxRegister397 = r_PtxRegister396 & 32;										  // PTX L744
	r_PtxRegister398 = r_PtxRegister397 | r_PtxRegister387;							  // PTX L745
	r_PtxRegister33 = ShiftRight(uint32_t(r_PtxRegister398), uint32_t(4));			  // PTX L746
	r_PtxRegister399 = r_PtxRegister395 & 1020;										  // PTX L747
	r_PtxRegister400 = ShiftRight(uint32_t(r_PtxRegister394), uint32_t(6));			  // PTX L748
	r_PtxRegister401 = r_PtxRegister400 & 4;										  // PTX L749
	r_PtxRegister402 = uint32_t(r_PtxRegister8) + uint32_t(256);					  // PTX L750
	r_PtxRegister403 = ShiftRight(uint32_t(r_PtxRegister402), uint32_t(7));			  // PTX L751
	r_PtxRegister404 = r_PtxRegister403 & 1020;										  // PTX L752
	r_PtxRegister405 = ShiftRight(uint32_t(r_PtxRegister402), uint32_t(6));			  // PTX L753
	r_PtxRegister406 = r_PtxRegister405 & 4;										  // PTX L754
	r_PtxRegister407 = uint32_t(r_PtxRegister8) + uint32_t(384);					  // PTX L755
	r_PtxRegister408 = ShiftRight(uint32_t(r_PtxRegister407), uint32_t(7));			  // PTX L756
	r_PtxRegister409 = ShiftRight(uint32_t(r_PtxRegister407), uint32_t(2));			  // PTX L757
	r_PtxRegister410 = r_PtxRegister409 & 32;										  // PTX L758
	r_PtxRegister411 = r_PtxRegister410 | r_PtxRegister387;							  // PTX L759
	r_PtxRegister34 = ShiftRight(uint32_t(r_PtxRegister411), uint32_t(4));			  // PTX L760
	r_PtxRegister412 = r_PtxRegister408 & 1020;										  // PTX L761
	r_PtxRegister413 = ShiftRight(uint32_t(r_PtxRegister407), uint32_t(6));			  // PTX L762
	r_PtxRegister414 = r_PtxRegister413 & 4;										  // PTX L763
	r_PtxRegister415 = uint32_t(r_PtxRegister390) + uint32_t(r_PtxRegister2);		  // PTX L764
	r_PtxRegister416 = r_PtxRegister392 & 1020;										  // PTX L765
	r_PtxRegister417 = uint32_t(r_PtxRegister8) + uint32_t(640);					  // PTX L766
	r_PtxRegister418 = ShiftRight(uint32_t(r_PtxRegister417), uint32_t(7));			  // PTX L767
	r_PtxRegister419 = ShiftRight(uint32_t(r_PtxRegister417), uint32_t(2));			  // PTX L768
	r_PtxRegister420 = r_PtxRegister419 & 32;										  // PTX L769
	r_PtxRegister421 = r_PtxRegister420 | r_PtxRegister387;							  // PTX L770
	r_PtxRegister35 = ShiftRight(uint32_t(r_PtxRegister421), uint32_t(4));			  // PTX L771
	r_PtxRegister422 = r_PtxRegister418 & 1020;										  // PTX L772
	r_PtxRegister423 = r_PtxRegister422 | r_PtxRegister390;							  // PTX L773
	r_PtxRegister424 = ShiftRight(uint32_t(r_PtxRegister417), uint32_t(6));			  // PTX L774
	r_PtxRegister425 = r_PtxRegister424 & 4;										  // PTX L775
	r_PtxRegister426 = r_PtxRegister380 & 16352;									  // PTX L776
	r_PtxRegister427 = r_PtxRegister426 | r_PtxRegister387;							  // PTX L777
	r_PtxRegister36 = ShiftRight(uint32_t(r_PtxRegister427), uint32_t(4));			  // PTX L778
	r_PtxRegister428 = uint32_t(r_PtxRegister389) + uint32_t(r_PtxRegister3);		  // PTX L779
	r_PtxRegister429 = ShiftRight(uint32_t(r_PtxRegister8), uint32_t(4));			  // PTX L780
	r_PtxRegister430 = uint32_t(r_PtxRegister385) + uint32_t(r_PtxRegister429);		  // PTX L781
	r_PtxRegister431 = r_PtxRegister429 & 3;										  // PTX L782
	r_PtxRegister432 = ShiftRight(uint32_t(r_PtxRegister430), uint32_t(2));			  // PTX L783
	r_PtxRegister433 = uint32_t(r_PtxRegister432) + uint32_t(r_PtxRegister2);		  // PTX L784
	r_PtxRegister434 = uint32_t(r_PtxRegister431) + uint32_t(r_PtxRegister3);		  // PTX L785
	r_PtxRegister435 = r_PtxRegister8 & 128;										  // PTX L786
	r_PtxRegister37 = uint32_t(r_PtxRegister415) + uint32_t(r_PtxRegister391);		  // PTX L787
	r_PtxRegister38 = uint32_t(r_PtxRegister428) + uint32_t(r_PtxRegister393);		  // PTX L788
	r_PtxRegister39 = ShiftRight(uint32_t(r_PtxRegister382), uint32_t(2));			  // PTX L789
	r_PtxRegister436 = r_PtxRegister394 & 1920;										  // PTX L790
	r_PtxRegister40 = r_PtxRegister436 | r_PtxRegister379;							  // PTX L791
	r_PtxRegister41 = uint32_t(r_PtxRegister415) + uint32_t(r_PtxRegister399);		  // PTX L792
	r_PtxRegister42 = uint32_t(r_PtxRegister428) + uint32_t(r_PtxRegister401);		  // PTX L793
	r_PtxRegister437 = r_PtxRegister402 & 1792;										  // PTX L794
	r_PtxRegister438 = r_PtxRegister437 | r_PtxRegister435;							  // PTX L795
	r_PtxRegister43 = r_PtxRegister438 | r_PtxRegister379;							  // PTX L796
	r_PtxRegister44 = uint32_t(r_PtxRegister415) + uint32_t(r_PtxRegister404);		  // PTX L797
	r_PtxRegister45 = uint32_t(r_PtxRegister428) + uint32_t(r_PtxRegister406);		  // PTX L798
	r_PtxRegister439 = r_PtxRegister407 & 1920;										  // PTX L799
	r_PtxRegister46 = r_PtxRegister439 | r_PtxRegister379;							  // PTX L800
	r_PtxRegister47 = uint32_t(r_PtxRegister415) + uint32_t(r_PtxRegister412);		  // PTX L801
	r_PtxRegister48 = uint32_t(r_PtxRegister428) + uint32_t(r_PtxRegister414);		  // PTX L802
	r_PtxRegister49 = uint32_t(r_PtxRegister415) + uint32_t(4);						  // PTX L803
	r_PtxRegister50 = uint32_t(r_PtxRegister428) + uint32_t(r_PtxRegister416);		  // PTX L804
	r_PtxRegister51 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister2);		  // PTX L805
	r_PtxRegister52 = uint32_t(r_PtxRegister428) + uint32_t(r_PtxRegister425);		  // PTX L806
	r_PtxRegister53 = uint32_t(r_PtxRegister428) + uint32_t(4);						  // PTX L807
	r_PtxRegister54 = uint32_t(r_PtxRegister433) + uint32_t(4);						  // PTX L808
	r_PtxRegister55 = uint32_t(r_PtxRegister434) + uint32_t(4);						  // PTX L809
	r_PtxRegister1363 = uint32_t(0);												  // PTX L810
	r_MmaAccumulatorHalf2WordAtPtx811R1299 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L811
	r_MmaAccumulatorHalf2WordAtPtx812R1300 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L812
	r_MmaAccumulatorHalf2WordAtPtx813R1301 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L813
	r_MmaAccumulatorHalf2WordAtPtx814R1302 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L814
	r_MmaAccumulatorHalf2WordAtPtx815R1303 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L815
	r_MmaAccumulatorHalf2WordAtPtx816R1304 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L816
	r_MmaAccumulatorHalf2WordAtPtx817R1305 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L817
	r_MmaAccumulatorHalf2WordAtPtx818R1306 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L818
	r_MmaAccumulatorHalf2WordAtPtx819R1307 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L819
	r_MmaAccumulatorHalf2WordAtPtx820R1308 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L820
	r_MmaAccumulatorHalf2WordAtPtx821R1309 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L821
	r_MmaAccumulatorHalf2WordAtPtx822R1310 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L822
	r_MmaAccumulatorHalf2WordAtPtx823R1311 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L823
	r_MmaAccumulatorHalf2WordAtPtx824R1312 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L824
	r_MmaAccumulatorHalf2WordAtPtx825R1313 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L825
	r_MmaAccumulatorHalf2WordAtPtx826R1314 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L826
	r_MmaAccumulatorHalf2WordAtPtx827R1315 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L827
	r_MmaAccumulatorHalf2WordAtPtx828R1316 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L828
	r_MmaAccumulatorHalf2WordAtPtx829R1317 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L829
	r_MmaAccumulatorHalf2WordAtPtx830R1318 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L830
	r_MmaAccumulatorHalf2WordAtPtx831R1319 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L831
	r_MmaAccumulatorHalf2WordAtPtx832R1320 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L832
	r_MmaAccumulatorHalf2WordAtPtx833R1321 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L833
	r_MmaAccumulatorHalf2WordAtPtx834R1322 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L834
	r_MmaAccumulatorHalf2WordAtPtx835R1323 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L835
	r_MmaAccumulatorHalf2WordAtPtx836R1324 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L836
	r_MmaAccumulatorHalf2WordAtPtx837R1325 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L837
	r_MmaAccumulatorHalf2WordAtPtx838R1326 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L838
	r_MmaAccumulatorHalf2WordAtPtx839R1327 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L839
	r_MmaAccumulatorHalf2WordAtPtx840R1328 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L840
	r_MmaAccumulatorHalf2WordAtPtx841R1329 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L841
	r_MmaAccumulatorHalf2WordAtPtx842R1330 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L842
	r_MmaAccumulatorHalf2WordAtPtx843R1331 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L843
	r_MmaAccumulatorHalf2WordAtPtx844R1332 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L844
	r_MmaAccumulatorHalf2WordAtPtx845R1333 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L845
	r_MmaAccumulatorHalf2WordAtPtx846R1334 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L846
	r_MmaAccumulatorHalf2WordAtPtx847R1335 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L847
	r_MmaAccumulatorHalf2WordAtPtx848R1336 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L848
	r_MmaAccumulatorHalf2WordAtPtx849R1337 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L849
	r_MmaAccumulatorHalf2WordAtPtx850R1338 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L850
	r_MmaAccumulatorHalf2WordAtPtx851R1339 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L851
	r_MmaAccumulatorHalf2WordAtPtx852R1340 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L852
	r_MmaAccumulatorHalf2WordAtPtx853R1341 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L853
	r_MmaAccumulatorHalf2WordAtPtx854R1342 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L854
	r_MmaAccumulatorHalf2WordAtPtx855R1343 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L855
	r_MmaAccumulatorHalf2WordAtPtx856R1344 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L856
	r_MmaAccumulatorHalf2WordAtPtx857R1345 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L857
	r_MmaAccumulatorHalf2WordAtPtx858R1346 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L858
	r_MmaAccumulatorHalf2WordAtPtx859R1347 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L859
	r_MmaAccumulatorHalf2WordAtPtx860R1348 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L860
	r_MmaAccumulatorHalf2WordAtPtx861R1349 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L861
	r_MmaAccumulatorHalf2WordAtPtx862R1350 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L862
	r_MmaAccumulatorHalf2WordAtPtx863R1351 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L863
	r_MmaAccumulatorHalf2WordAtPtx864R1352 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L864
	r_MmaAccumulatorHalf2WordAtPtx865R1353 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L865
	r_MmaAccumulatorHalf2WordAtPtx866R1354 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L866
	r_MmaAccumulatorHalf2WordAtPtx867R1355 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L867
	r_MmaAccumulatorHalf2WordAtPtx868R1356 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L868
	r_MmaAccumulatorHalf2WordAtPtx869R1357 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L869
	r_MmaAccumulatorHalf2WordAtPtx870R1358 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L870
	r_MmaAccumulatorHalf2WordAtPtx871R1359 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L871
	r_MmaAccumulatorHalf2WordAtPtx872R1360 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L872
	r_MmaAccumulatorHalf2WordAtPtx873R1361 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L873
	r_MmaAccumulatorHalf2WordAtPtx874R1362 = uint32_t(r_PackedHalf2AtPtx43R6);		  // PTX L874
L__BB3_53:																			  // PTX L875
	r_bPtxPredicate91 = uint32_t(r_PtxRegister8) > uint32_t(1023);					  // PTX L876
	r_PtxRegister440 = ShiftRight(uint32_t(r_PtxRegister1363), uint32_t(6));		  // PTX L877
	r_PtxRegister56 = r_PtxRegister440 & 1;											  // PTX L878
	r_PtxRegister57 = uint32_t(r_PtxRegister1363) + uint32_t(64);					  // PTX L879
	r_PtxRegister441 = ShiftLeft(uint32_t(r_PtxRegister1363), uint32_t(6));			  // PTX L880
	r_PtxRegister58 = r_PtxRegister441 & 4096;										  // PTX L881
	r_PtxRegister442 = r_PtxRegister58 ^ 4096;										  // PTX L882
	r_PtxU64Register86 = uint64_t(r_PtxRegister442);								  // PTX L883
	r_PtxRegister443 = uint32_t(0u /* exact native shared-region offset */);		  // PTX L884
	r_PtxU64Register87 = uint64_t(r_PtxRegister443);								  // PTX L885
	r_PtxU64Register88 = SharedGeneric(s_SharedStorage, r_PtxU64Register87);		  // PTX L886
	r_PtxU64Register10 = uint64_t(r_PtxU64Register88) + uint64_t(r_PtxU64Register86); // PTX L887
	r_PtxRegister59 = ShiftRight(uint32_t(r_PtxRegister57), uint32_t(4));			  // PTX L888
	if (r_bPtxPredicate91)
	{
		goto L__BB3_59;
	} // PTX L889
	r_bPtxPredicate92 = int32_t(r_PtxRegister38) < int32_t(r_WidthBits);			   // PTX L890
	r_bPtxPredicate93 = int32_t(r_PtxRegister37) < int32_t(r_HeightBits);			   // PTX L891
	r_PtxRegister444 = r_PtxRegister8 & 1023;										   // PTX L892
	r_bPtxPredicate94 = uint32_t(r_WidthBits) == uint32_t(1);						   // PTX L893
	r_bPtxPredicate95 = uint32_t(r_HeightBits) != uint32_t(1);						   // PTX L894
	r_PtxU64Register89 = uint64_t(uint32_t(r_PtxRegister444)) * uint64_t(uint32_t(4)); // PTX L895
	r_PtxU64Register11 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register89);  // PTX L896
	r_PtxRegister60 = uint32_t(r_PtxRegister31) + uint32_t(r_PtxRegister59);		   // PTX L897
	r_bPtxPredicate96 = uint32_t(r_PtxRegister60) < uint32_t(32);					   // PTX L898
	r_bPtxPredicate97 = r_bPtxPredicate95 & r_bPtxPredicate96;						   // PTX L899
	r_bPtxPredicate98 = r_bPtxPredicate97 ^ r_bPtxPredicate96;						   // PTX L900
	r_PtxRegister61 = r_bPtxPredicate98 ? 0 : r_PtxRegister37;						   // PTX L901
	r_bPtxPredicate99 = !r_bPtxPredicate97;											   // PTX L902
	r_bPtxPredicate100 = r_bPtxPredicate99 | r_bPtxPredicate93;						   // PTX L903
	r_bPtxPredicate101 = r_bPtxPredicate100 & r_bPtxPredicate96;					   // PTX L904
	r_bPtxPredicate102 = r_bPtxPredicate94 | r_bPtxPredicate92;						   // PTX L905
	r_bPtxPredicate9 = r_bPtxPredicate94 & r_bPtxPredicate101;						   // PTX L906
	r_bPtxPredicate10 = r_bPtxPredicate101 & r_bPtxPredicate102;					   // PTX L907
	r_PtxU64Register191 = uint64_t(0);												   // PTX L908
	r_bPtxPredicate103 = !r_bPtxPredicate10;										   // PTX L909
	if (r_bPtxPredicate103)
	{
		goto L__BB3_56;
	} // PTX L910
	r_PtxRegister445 = ShiftLeft(uint32_t(r_PtxRegister38), uint32_t(2)); // PTX L911
	r_PtxRegister446 = r_bPtxPredicate9 ? 0 : r_PtxRegister445;			  // PTX L912
	r_PtxRegister447 =
		uint32_t(r_PtxRegister60) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister61); // PTX L913
	r_PtxRegister448 =
		uint32_t(r_PtxRegister447) * uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister39);	 // PTX L914
	r_PtxRegister449 = uint32_t(r_PtxRegister448) + uint32_t(r_PtxRegister446);				 // PTX L915
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_PtxRegister449)) * int64_t(int32_t(4))); // PTX L916
	r_PtxU64Register191 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register90);		 // PTX L917
L__BB3_56:																					 // PTX L918
	if (r_bPtxPredicate103)
	{
		goto L__BB3_58;
	} // PTX L919
	r_PtxRegister452 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register11));				   // PTX L921
	CopyAsync4(s_SharedStorage, r_PtxRegister452, r_PtxU64Register191);							   // PTX L924
	goto L__BB3_59;																				   // PTX L926
L__BB3_58:																						   // PTX L927
	r_PtxRegister450 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register11));				   // PTX L929
	r_PtxRegister451 = uint32_t(0);																   // PTX L931
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister450)) = r_PtxRegister451; // PTX L933
L__BB3_59:																						   // PTX L935
	r_bPtxPredicate104 = uint32_t(r_PtxRegister8) > uint32_t(895);								   // PTX L936
	if (r_bPtxPredicate104)
	{
		goto L__BB3_65;
	} // PTX L937
	r_bPtxPredicate105 = int32_t(r_PtxRegister42) < int32_t(r_WidthBits);			  // PTX L938
	r_bPtxPredicate106 = int32_t(r_PtxRegister41) < int32_t(r_HeightBits);			  // PTX L939
	r_bPtxPredicate107 = uint32_t(r_WidthBits) == uint32_t(1);						  // PTX L940
	r_bPtxPredicate108 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L941
	r_PtxU64Register91 = uint64_t(uint32_t(r_PtxRegister40)) * uint64_t(uint32_t(4)); // PTX L942
	r_PtxU64Register12 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register91); // PTX L943
	r_PtxRegister62 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister59);		  // PTX L944
	r_bPtxPredicate109 = uint32_t(r_PtxRegister62) < uint32_t(32);					  // PTX L945
	r_bPtxPredicate110 = r_bPtxPredicate108 & r_bPtxPredicate109;					  // PTX L946
	r_bPtxPredicate111 = r_bPtxPredicate110 ^ r_bPtxPredicate109;					  // PTX L947
	r_PtxRegister63 = r_bPtxPredicate111 ? 0 : r_PtxRegister41;						  // PTX L948
	r_bPtxPredicate112 = !r_bPtxPredicate110;										  // PTX L949
	r_bPtxPredicate113 = r_bPtxPredicate112 | r_bPtxPredicate106;					  // PTX L950
	r_bPtxPredicate114 = r_bPtxPredicate113 & r_bPtxPredicate109;					  // PTX L951
	r_bPtxPredicate115 = r_bPtxPredicate107 | r_bPtxPredicate105;					  // PTX L952
	r_bPtxPredicate11 = r_bPtxPredicate107 & r_bPtxPredicate114;					  // PTX L953
	r_bPtxPredicate12 = r_bPtxPredicate114 & r_bPtxPredicate115;					  // PTX L954
	r_PtxU64Register192 = uint64_t(0);												  // PTX L955
	r_bPtxPredicate116 = !r_bPtxPredicate12;										  // PTX L956
	if (r_bPtxPredicate116)
	{
		goto L__BB3_62;
	} // PTX L957
	r_PtxRegister453 = ShiftLeft(uint32_t(r_PtxRegister42), uint32_t(2)); // PTX L958
	r_PtxRegister454 = r_bPtxPredicate11 ? 0 : r_PtxRegister453;		  // PTX L959
	r_PtxRegister455 =
		uint32_t(r_PtxRegister62) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister63); // PTX L960
	r_PtxRegister456 =
		uint32_t(r_PtxRegister455) * uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister39);	 // PTX L961
	r_PtxRegister457 = uint32_t(r_PtxRegister456) + uint32_t(r_PtxRegister454);				 // PTX L962
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_PtxRegister457)) * int64_t(int32_t(4))); // PTX L963
	r_PtxU64Register192 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register92);		 // PTX L964
L__BB3_62:																					 // PTX L965
	if (r_bPtxPredicate116)
	{
		goto L__BB3_64;
	} // PTX L966
	r_PtxRegister460 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register12));				   // PTX L968
	CopyAsync4(s_SharedStorage, r_PtxRegister460, r_PtxU64Register192);							   // PTX L971
	goto L__BB3_65;																				   // PTX L973
L__BB3_64:																						   // PTX L974
	r_PtxRegister458 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register12));				   // PTX L976
	r_PtxRegister459 = uint32_t(0);																   // PTX L978
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister458)) = r_PtxRegister459; // PTX L980
L__BB3_65:																						   // PTX L982
	r_bPtxPredicate117 = uint32_t(r_PtxRegister8) > uint32_t(767);								   // PTX L983
	if (r_bPtxPredicate117)
	{
		goto L__BB3_71;
	} // PTX L984
	r_bPtxPredicate118 = int32_t(r_PtxRegister45) < int32_t(r_WidthBits);			  // PTX L985
	r_bPtxPredicate119 = int32_t(r_PtxRegister44) < int32_t(r_HeightBits);			  // PTX L986
	r_bPtxPredicate120 = uint32_t(r_WidthBits) == uint32_t(1);						  // PTX L987
	r_bPtxPredicate121 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L988
	r_PtxU64Register93 = uint64_t(uint32_t(r_PtxRegister43)) * uint64_t(uint32_t(4)); // PTX L989
	r_PtxU64Register13 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register93); // PTX L990
	r_PtxRegister64 = uint32_t(r_PtxRegister31) + uint32_t(r_PtxRegister59);		  // PTX L991
	r_bPtxPredicate122 = uint32_t(r_PtxRegister64) < uint32_t(32);					  // PTX L992
	r_bPtxPredicate123 = r_bPtxPredicate121 & r_bPtxPredicate122;					  // PTX L993
	r_bPtxPredicate124 = r_bPtxPredicate123 ^ r_bPtxPredicate122;					  // PTX L994
	r_PtxRegister65 = r_bPtxPredicate124 ? 0 : r_PtxRegister44;						  // PTX L995
	r_bPtxPredicate125 = !r_bPtxPredicate123;										  // PTX L996
	r_bPtxPredicate126 = r_bPtxPredicate125 | r_bPtxPredicate119;					  // PTX L997
	r_bPtxPredicate127 = r_bPtxPredicate126 & r_bPtxPredicate122;					  // PTX L998
	r_bPtxPredicate128 = r_bPtxPredicate120 | r_bPtxPredicate118;					  // PTX L999
	r_bPtxPredicate13 = r_bPtxPredicate120 & r_bPtxPredicate127;					  // PTX L1000
	r_bPtxPredicate14 = r_bPtxPredicate127 & r_bPtxPredicate128;					  // PTX L1001
	r_PtxU64Register193 = uint64_t(0);												  // PTX L1002
	r_bPtxPredicate129 = !r_bPtxPredicate14;										  // PTX L1003
	if (r_bPtxPredicate129)
	{
		goto L__BB3_68;
	} // PTX L1004
	r_PtxRegister461 = ShiftLeft(uint32_t(r_PtxRegister45), uint32_t(2)); // PTX L1005
	r_PtxRegister462 = r_bPtxPredicate13 ? 0 : r_PtxRegister461;		  // PTX L1006
	r_PtxRegister463 =
		uint32_t(r_PtxRegister64) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister65); // PTX L1007
	r_PtxRegister464 =
		uint32_t(r_PtxRegister463) * uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister39);	 // PTX L1008
	r_PtxRegister465 = uint32_t(r_PtxRegister464) + uint32_t(r_PtxRegister462);				 // PTX L1009
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_PtxRegister465)) * int64_t(int32_t(4))); // PTX L1010
	r_PtxU64Register193 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register94);		 // PTX L1011
L__BB3_68:																					 // PTX L1012
	if (r_bPtxPredicate129)
	{
		goto L__BB3_70;
	} // PTX L1013
	r_PtxRegister468 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register13)); // PTX L1015
	CopyAsync4(s_SharedStorage, r_PtxRegister468, r_PtxU64Register193);				// PTX L1018
	goto L__BB3_71;																	// PTX L1020
L__BB3_70:																			// PTX L1021
	r_PtxRegister466 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register13)); // PTX L1023
	r_PtxRegister467 = uint32_t(0);													// PTX L1025
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister466)) =
		r_PtxRegister467;										   // PTX L1027
L__BB3_71:														   // PTX L1029
	r_bPtxPredicate130 = uint32_t(r_PtxRegister8) > uint32_t(639); // PTX L1030
	if (r_bPtxPredicate130)
	{
		goto L__BB3_77;
	} // PTX L1031
	r_bPtxPredicate131 = int32_t(r_PtxRegister48) < int32_t(r_WidthBits);			  // PTX L1032
	r_bPtxPredicate132 = int32_t(r_PtxRegister47) < int32_t(r_HeightBits);			  // PTX L1033
	r_bPtxPredicate133 = uint32_t(r_WidthBits) == uint32_t(1);						  // PTX L1034
	r_bPtxPredicate134 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1035
	r_PtxU64Register95 = uint64_t(uint32_t(r_PtxRegister46)) * uint64_t(uint32_t(4)); // PTX L1036
	r_PtxU64Register14 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register95); // PTX L1037
	r_PtxRegister66 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister59);		  // PTX L1038
	r_bPtxPredicate135 = uint32_t(r_PtxRegister66) < uint32_t(32);					  // PTX L1039
	r_bPtxPredicate136 = r_bPtxPredicate134 & r_bPtxPredicate135;					  // PTX L1040
	r_bPtxPredicate137 = r_bPtxPredicate136 ^ r_bPtxPredicate135;					  // PTX L1041
	r_PtxRegister67 = r_bPtxPredicate137 ? 0 : r_PtxRegister47;						  // PTX L1042
	r_bPtxPredicate138 = !r_bPtxPredicate136;										  // PTX L1043
	r_bPtxPredicate139 = r_bPtxPredicate138 | r_bPtxPredicate132;					  // PTX L1044
	r_bPtxPredicate140 = r_bPtxPredicate139 & r_bPtxPredicate135;					  // PTX L1045
	r_bPtxPredicate141 = r_bPtxPredicate133 | r_bPtxPredicate131;					  // PTX L1046
	r_bPtxPredicate15 = r_bPtxPredicate133 & r_bPtxPredicate140;					  // PTX L1047
	r_bPtxPredicate16 = r_bPtxPredicate140 & r_bPtxPredicate141;					  // PTX L1048
	r_PtxU64Register194 = uint64_t(0);												  // PTX L1049
	r_bPtxPredicate142 = !r_bPtxPredicate16;										  // PTX L1050
	if (r_bPtxPredicate142)
	{
		goto L__BB3_74;
	} // PTX L1051
	r_PtxRegister469 = ShiftLeft(uint32_t(r_PtxRegister48), uint32_t(2)); // PTX L1052
	r_PtxRegister470 = r_bPtxPredicate15 ? 0 : r_PtxRegister469;		  // PTX L1053
	r_PtxRegister471 =
		uint32_t(r_PtxRegister66) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister67); // PTX L1054
	r_PtxRegister472 =
		uint32_t(r_PtxRegister471) * uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister39);	 // PTX L1055
	r_PtxRegister473 = uint32_t(r_PtxRegister472) + uint32_t(r_PtxRegister470);				 // PTX L1056
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_PtxRegister473)) * int64_t(int32_t(4))); // PTX L1057
	r_PtxU64Register194 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register96);		 // PTX L1058
L__BB3_74:																					 // PTX L1059
	if (r_bPtxPredicate142)
	{
		goto L__BB3_76;
	} // PTX L1060
	r_PtxRegister476 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register14)); // PTX L1062
	CopyAsync4(s_SharedStorage, r_PtxRegister476, r_PtxU64Register194);				// PTX L1065
	goto L__BB3_77;																	// PTX L1067
L__BB3_76:																			// PTX L1068
	r_PtxRegister474 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register14)); // PTX L1070
	r_PtxRegister475 = uint32_t(0);													// PTX L1072
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister474)) =
		r_PtxRegister475;										   // PTX L1074
L__BB3_77:														   // PTX L1076
	r_bPtxPredicate143 = uint32_t(r_PtxRegister8) > uint32_t(511); // PTX L1077
	if (r_bPtxPredicate143)
	{
		goto L__BB3_83;
	} // PTX L1078
	r_bPtxPredicate144 = int32_t(r_PtxRegister50) < int32_t(r_WidthBits);			   // PTX L1079
	r_bPtxPredicate145 = int32_t(r_PtxRegister49) < int32_t(r_HeightBits);			   // PTX L1080
	r_PtxRegister477 = uint32_t(r_PtxRegister8) + uint32_t(512);					   // PTX L1081
	r_bPtxPredicate146 = uint32_t(r_WidthBits) == uint32_t(1);						   // PTX L1082
	r_bPtxPredicate147 = uint32_t(r_HeightBits) != uint32_t(1);						   // PTX L1083
	r_PtxU64Register97 = uint64_t(uint32_t(r_PtxRegister477)) * uint64_t(uint32_t(4)); // PTX L1084
	r_PtxU64Register15 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register97);  // PTX L1085
	r_PtxRegister68 = uint32_t(r_PtxRegister31) + uint32_t(r_PtxRegister59);		   // PTX L1086
	r_bPtxPredicate148 = uint32_t(r_PtxRegister68) < uint32_t(32);					   // PTX L1087
	r_bPtxPredicate149 = r_bPtxPredicate147 & r_bPtxPredicate148;					   // PTX L1088
	r_bPtxPredicate150 = r_bPtxPredicate149 ^ r_bPtxPredicate148;					   // PTX L1089
	r_PtxRegister69 = r_bPtxPredicate150 ? 0 : r_PtxRegister49;						   // PTX L1090
	r_bPtxPredicate151 = !r_bPtxPredicate149;										   // PTX L1091
	r_bPtxPredicate152 = r_bPtxPredicate151 | r_bPtxPredicate145;					   // PTX L1092
	r_bPtxPredicate153 = r_bPtxPredicate152 & r_bPtxPredicate148;					   // PTX L1093
	r_bPtxPredicate154 = r_bPtxPredicate146 | r_bPtxPredicate144;					   // PTX L1094
	r_bPtxPredicate17 = r_bPtxPredicate146 & r_bPtxPredicate153;					   // PTX L1095
	r_bPtxPredicate18 = r_bPtxPredicate153 & r_bPtxPredicate154;					   // PTX L1096
	r_PtxU64Register195 = uint64_t(0);												   // PTX L1097
	r_bPtxPredicate155 = !r_bPtxPredicate18;										   // PTX L1098
	if (r_bPtxPredicate155)
	{
		goto L__BB3_80;
	} // PTX L1099
	r_PtxRegister478 = ShiftLeft(uint32_t(r_PtxRegister50), uint32_t(2)); // PTX L1100
	r_PtxRegister479 = r_bPtxPredicate17 ? 0 : r_PtxRegister478;		  // PTX L1101
	r_PtxRegister480 =
		uint32_t(r_PtxRegister68) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister69); // PTX L1102
	r_PtxRegister481 =
		uint32_t(r_PtxRegister480) * uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister39);	 // PTX L1103
	r_PtxRegister482 = uint32_t(r_PtxRegister481) + uint32_t(r_PtxRegister479);				 // PTX L1104
	r_PtxU64Register98 = uint64_t(int64_t(int32_t(r_PtxRegister482)) * int64_t(int32_t(4))); // PTX L1105
	r_PtxU64Register195 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register98);		 // PTX L1106
L__BB3_80:																					 // PTX L1107
	if (r_bPtxPredicate155)
	{
		goto L__BB3_82;
	} // PTX L1108
	r_PtxRegister485 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register15)); // PTX L1110
	CopyAsync4(s_SharedStorage, r_PtxRegister485, r_PtxU64Register195);				// PTX L1113
	goto L__BB3_83;																	// PTX L1115
L__BB3_82:																			// PTX L1116
	r_PtxRegister483 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register15)); // PTX L1118
	r_PtxRegister484 = uint32_t(0);													// PTX L1120
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister483)) =
		r_PtxRegister484;										   // PTX L1122
L__BB3_83:														   // PTX L1124
	r_bPtxPredicate156 = uint32_t(r_PtxRegister8) > uint32_t(383); // PTX L1125
	if (r_bPtxPredicate156)
	{
		goto L__BB3_89;
	} // PTX L1126
	r_bPtxPredicate157 = int32_t(r_PtxRegister52) < int32_t(r_WidthBits);			   // PTX L1127
	r_bPtxPredicate158 = int32_t(r_PtxRegister51) < int32_t(r_HeightBits);			   // PTX L1128
	r_PtxRegister486 = r_PtxRegister417 & 1920;										   // PTX L1129
	r_PtxRegister487 = r_PtxRegister486 | r_PtxRegister379;							   // PTX L1130
	r_bPtxPredicate159 = uint32_t(r_WidthBits) == uint32_t(1);						   // PTX L1131
	r_bPtxPredicate160 = uint32_t(r_HeightBits) != uint32_t(1);						   // PTX L1132
	r_PtxU64Register99 = uint64_t(uint32_t(r_PtxRegister487)) * uint64_t(uint32_t(4)); // PTX L1133
	r_PtxU64Register16 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register99);  // PTX L1134
	r_PtxRegister70 = uint32_t(r_PtxRegister35) + uint32_t(r_PtxRegister59);		   // PTX L1135
	r_bPtxPredicate161 = uint32_t(r_PtxRegister70) < uint32_t(32);					   // PTX L1136
	r_bPtxPredicate162 = r_bPtxPredicate160 & r_bPtxPredicate161;					   // PTX L1137
	r_bPtxPredicate163 = r_bPtxPredicate162 ^ r_bPtxPredicate161;					   // PTX L1138
	r_PtxRegister71 = r_bPtxPredicate163 ? 0 : r_PtxRegister51;						   // PTX L1139
	r_bPtxPredicate164 = !r_bPtxPredicate162;										   // PTX L1140
	r_bPtxPredicate165 = r_bPtxPredicate164 | r_bPtxPredicate158;					   // PTX L1141
	r_bPtxPredicate166 = r_bPtxPredicate165 & r_bPtxPredicate161;					   // PTX L1142
	r_bPtxPredicate167 = r_bPtxPredicate159 | r_bPtxPredicate157;					   // PTX L1143
	r_bPtxPredicate19 = r_bPtxPredicate159 & r_bPtxPredicate166;					   // PTX L1144
	r_bPtxPredicate20 = r_bPtxPredicate166 & r_bPtxPredicate167;					   // PTX L1145
	r_PtxU64Register196 = uint64_t(0);												   // PTX L1146
	r_bPtxPredicate168 = !r_bPtxPredicate20;										   // PTX L1147
	if (r_bPtxPredicate168)
	{
		goto L__BB3_86;
	} // PTX L1148
	r_PtxRegister488 = ShiftLeft(uint32_t(r_PtxRegister52), uint32_t(2)); // PTX L1149
	r_PtxRegister489 = r_bPtxPredicate19 ? 0 : r_PtxRegister488;		  // PTX L1150
	r_PtxRegister490 =
		uint32_t(r_PtxRegister70) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister71); // PTX L1151
	r_PtxRegister491 =
		uint32_t(r_PtxRegister490) * uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister39);	  // PTX L1152
	r_PtxRegister492 = uint32_t(r_PtxRegister491) + uint32_t(r_PtxRegister489);				  // PTX L1153
	r_PtxU64Register100 = uint64_t(int64_t(int32_t(r_PtxRegister492)) * int64_t(int32_t(4))); // PTX L1154
	r_PtxU64Register196 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register100);		  // PTX L1155
L__BB3_86:																					  // PTX L1156
	if (r_bPtxPredicate168)
	{
		goto L__BB3_88;
	} // PTX L1157
	r_PtxRegister495 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register16)); // PTX L1159
	CopyAsync4(s_SharedStorage, r_PtxRegister495, r_PtxU64Register196);				// PTX L1162
	goto L__BB3_89;																	// PTX L1164
L__BB3_88:																			// PTX L1165
	r_PtxRegister493 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register16)); // PTX L1167
	r_PtxRegister494 = uint32_t(0);													// PTX L1169
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister493)) =
		r_PtxRegister494;										   // PTX L1171
L__BB3_89:														   // PTX L1173
	r_bPtxPredicate169 = uint32_t(r_PtxRegister8) > uint32_t(255); // PTX L1174
	if (r_bPtxPredicate169)
	{
		goto L__BB3_95;
	} // PTX L1175
	r_bPtxPredicate170 = int32_t(r_PtxRegister53) < int32_t(r_WidthBits);				// PTX L1176
	r_bPtxPredicate171 = int32_t(r_PtxRegister49) < int32_t(r_HeightBits);				// PTX L1177
	r_bPtxPredicate172 = uint32_t(r_WidthBits) == uint32_t(1);							// PTX L1178
	r_bPtxPredicate173 = uint32_t(r_HeightBits) != uint32_t(1);							// PTX L1179
	r_PtxRegister496 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));				// PTX L1180
	r_PtxU64Register101 = uint64_t(r_PtxRegister496);									// PTX L1181
	r_PtxU64Register102 = r_PtxU64Register101 & 1020;									// PTX L1182
	r_PtxU64Register103 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register102); // PTX L1183
	r_PtxU64Register17 = uint64_t(r_PtxU64Register103) + uint64_t(3072);				// PTX L1184
	r_PtxRegister72 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister59);			// PTX L1185
	r_bPtxPredicate174 = uint32_t(r_PtxRegister72) < uint32_t(32);						// PTX L1186
	r_bPtxPredicate175 = r_bPtxPredicate173 & r_bPtxPredicate174;						// PTX L1187
	r_bPtxPredicate176 = r_bPtxPredicate175 ^ r_bPtxPredicate174;						// PTX L1188
	r_PtxRegister73 = r_bPtxPredicate176 ? 0 : r_PtxRegister49;							// PTX L1189
	r_bPtxPredicate177 = !r_bPtxPredicate175;											// PTX L1190
	r_bPtxPredicate178 = r_bPtxPredicate177 | r_bPtxPredicate171;						// PTX L1191
	r_bPtxPredicate179 = r_bPtxPredicate178 & r_bPtxPredicate174;						// PTX L1192
	r_bPtxPredicate180 = r_bPtxPredicate172 | r_bPtxPredicate170;						// PTX L1193
	r_bPtxPredicate21 = r_bPtxPredicate172 & r_bPtxPredicate179;						// PTX L1194
	r_bPtxPredicate22 = r_bPtxPredicate179 & r_bPtxPredicate180;						// PTX L1195
	r_PtxU64Register197 = uint64_t(0);													// PTX L1196
	r_bPtxPredicate181 = !r_bPtxPredicate22;											// PTX L1197
	if (r_bPtxPredicate181)
	{
		goto L__BB3_92;
	} // PTX L1198
	r_PtxRegister497 = ShiftLeft(uint32_t(r_PtxRegister53), uint32_t(2)); // PTX L1199
	r_PtxRegister498 = r_bPtxPredicate21 ? 0 : r_PtxRegister497;		  // PTX L1200
	r_PtxRegister499 =
		uint32_t(r_PtxRegister72) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister73); // PTX L1201
	r_PtxRegister500 =
		uint32_t(r_PtxRegister499) * uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister39);	  // PTX L1202
	r_PtxRegister501 = uint32_t(r_PtxRegister500) + uint32_t(r_PtxRegister498);				  // PTX L1203
	r_PtxU64Register104 = uint64_t(int64_t(int32_t(r_PtxRegister501)) * int64_t(int32_t(4))); // PTX L1204
	r_PtxU64Register197 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register104);		  // PTX L1205
L__BB3_92:																					  // PTX L1206
	if (r_bPtxPredicate181)
	{
		goto L__BB3_94;
	} // PTX L1207
	r_PtxRegister504 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register17)); // PTX L1209
	CopyAsync4(s_SharedStorage, r_PtxRegister504, r_PtxU64Register197);				// PTX L1212
	goto L__BB3_95;																	// PTX L1214
L__BB3_94:																			// PTX L1215
	r_PtxRegister502 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register17)); // PTX L1217
	r_PtxRegister503 = uint32_t(0);													// PTX L1219
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister502)) =
		r_PtxRegister503;										   // PTX L1221
L__BB3_95:														   // PTX L1223
	r_bPtxPredicate182 = uint32_t(r_PtxRegister8) > uint32_t(127); // PTX L1224
	if (r_bPtxPredicate182)
	{
		goto L__BB3_101;
	} // PTX L1225
	r_bPtxPredicate183 = int32_t(r_PtxRegister55) < int32_t(r_WidthBits);				// PTX L1226
	r_bPtxPredicate184 = int32_t(r_PtxRegister54) < int32_t(r_HeightBits);				// PTX L1227
	r_bPtxPredicate185 = uint32_t(r_WidthBits) == uint32_t(1);							// PTX L1228
	r_bPtxPredicate186 = uint32_t(r_HeightBits) != uint32_t(1);							// PTX L1229
	r_PtxU64Register105 = uint64_t(uint32_t(r_PtxRegister8)) * uint64_t(uint32_t(4));	// PTX L1230
	r_PtxU64Register106 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register105); // PTX L1231
	r_PtxU64Register18 = uint64_t(r_PtxU64Register106) + uint64_t(3584);				// PTX L1232
	r_PtxRegister505 = ShiftRight(uint32_t(r_ThreadX), uint32_t(1));					// PTX L1233
	r_PtxRegister506 = r_PtxRegister505 & 1;											// PTX L1234
	r_PtxRegister507 = uint32_t(r_PtxRegister506) + uint32_t(r_PtxRegister59);			// PTX L1235
	r_PtxRegister74 = uint32_t(r_PtxRegister507) + uint32_t(2);							// PTX L1236
	r_bPtxPredicate187 = uint32_t(r_PtxRegister74) < uint32_t(32);						// PTX L1237
	r_bPtxPredicate188 = r_bPtxPredicate186 & r_bPtxPredicate187;						// PTX L1238
	r_bPtxPredicate189 = r_bPtxPredicate188 ^ r_bPtxPredicate187;						// PTX L1239
	r_PtxRegister75 = r_bPtxPredicate189 ? 0 : r_PtxRegister54;							// PTX L1240
	r_bPtxPredicate190 = !r_bPtxPredicate188;											// PTX L1241
	r_bPtxPredicate191 = r_bPtxPredicate190 | r_bPtxPredicate184;						// PTX L1242
	r_bPtxPredicate192 = r_bPtxPredicate191 & r_bPtxPredicate187;						// PTX L1243
	r_bPtxPredicate193 = r_bPtxPredicate185 | r_bPtxPredicate183;						// PTX L1244
	r_bPtxPredicate23 = r_bPtxPredicate185 & r_bPtxPredicate192;						// PTX L1245
	r_bPtxPredicate24 = r_bPtxPredicate192 & r_bPtxPredicate193;						// PTX L1246
	r_PtxU64Register198 = uint64_t(0);													// PTX L1247
	r_bPtxPredicate194 = !r_bPtxPredicate24;											// PTX L1248
	if (r_bPtxPredicate194)
	{
		goto L__BB3_98;
	} // PTX L1249
	r_PtxRegister508 = ShiftLeft(uint32_t(r_PtxRegister55), uint32_t(2)); // PTX L1250
	r_PtxRegister509 = r_bPtxPredicate23 ? 0 : r_PtxRegister508;		  // PTX L1251
	r_PtxRegister510 =
		uint32_t(r_PtxRegister74) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister75); // PTX L1252
	r_PtxRegister511 = ShiftRight(uint32_t(r_ThreadX), uint32_t(2));					// PTX L1253
	r_PtxRegister512 = r_PtxRegister511 & 3;											// PTX L1254
	r_PtxRegister513 =
		uint32_t(r_PtxRegister510) * uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister512);  // PTX L1255
	r_PtxRegister514 = uint32_t(r_PtxRegister513) + uint32_t(r_PtxRegister509);				  // PTX L1256
	r_PtxU64Register107 = uint64_t(int64_t(int32_t(r_PtxRegister514)) * int64_t(int32_t(4))); // PTX L1257
	r_PtxU64Register198 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register107);		  // PTX L1258
L__BB3_98:																					  // PTX L1259
	if (r_bPtxPredicate194)
	{
		goto L__BB3_100;
	} // PTX L1260
	r_PtxRegister517 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register18)); // PTX L1262
	CopyAsync4(s_SharedStorage, r_PtxRegister517, r_PtxU64Register198);				// PTX L1265
	goto L__BB3_101;																// PTX L1267
L__BB3_100:																			// PTX L1268
	r_PtxRegister515 = uint32_t(SharedOffset(s_SharedStorage, r_PtxU64Register18)); // PTX L1270
	r_PtxRegister516 = uint32_t(0);													// PTX L1272
	*reinterpret_cast<uint32_t*>(s_SharedStorage + uint32_t(r_PtxRegister515)) =
		r_PtxRegister516;														// PTX L1274
L__BB3_101:																		// PTX L1276
	CopyCommit();																// PTX L1278
	r_PtxRegister639 = uint32_t(0u /* exact native shared-region offset */);	// PTX L1280
	r_PtxRegister640 = uint32_t(r_PtxRegister639) + uint32_t(r_PtxRegister58);	// PTX L1281
	r_LaneIndexAtPtx1283 = uint32_t((threadIdx.x & 31u));						// PTX L1283
	r_PtxRegister641 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1283), uint32_t(4));	// PTX L1285
	r_PtxRegister519 = uint32_t(r_PtxRegister640) + uint32_t(r_PtxRegister641); // PTX L1286
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister519));
		r_MmaAE4x4WordAtPtx1288R534 = r_Value.x;
		r_MmaAE4x4WordAtPtx1288R535 = r_Value.y;
		r_MmaAE4x4WordAtPtx1288R536 = r_Value.z;
		r_MmaAE4x4WordAtPtx1288R537 = r_Value.w;
	} // PTX L1288
	r_LaneIndexAtPtx1291 = uint32_t((threadIdx.x & 31u));						// PTX L1291
	r_PtxRegister642 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1291), uint32_t(4));	// PTX L1293
	r_PtxRegister643 = uint32_t(r_PtxRegister640) + uint32_t(r_PtxRegister642); // PTX L1294
	r_PtxRegister521 = uint32_t(r_PtxRegister643) + uint32_t(512);				// PTX L1295
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister521));
		r_MmaAE4x4WordAtPtx1297R538 = r_Value.x;
		r_MmaAE4x4WordAtPtx1297R539 = r_Value.y;
		r_MmaAE4x4WordAtPtx1297R540 = r_Value.z;
		r_MmaAE4x4WordAtPtx1297R541 = r_Value.w;
	} // PTX L1297
	r_LaneIndexAtPtx1300 = uint32_t((threadIdx.x & 31u));						// PTX L1300
	r_PtxRegister644 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1300), uint32_t(4));	// PTX L1302
	r_PtxRegister645 = uint32_t(r_PtxRegister640) + uint32_t(r_PtxRegister644); // PTX L1303
	r_PtxRegister523 = uint32_t(r_PtxRegister645) + uint32_t(1024);				// PTX L1304
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister523));
		r_MmaAE4x4WordAtPtx1306R558 = r_Value.x;
		r_MmaAE4x4WordAtPtx1306R559 = r_Value.y;
		r_MmaAE4x4WordAtPtx1306R560 = r_Value.z;
		r_MmaAE4x4WordAtPtx1306R561 = r_Value.w;
	} // PTX L1306
	r_LaneIndexAtPtx1309 = uint32_t((threadIdx.x & 31u));						// PTX L1309
	r_PtxRegister646 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1309), uint32_t(4));	// PTX L1311
	r_PtxRegister647 = uint32_t(r_PtxRegister640) + uint32_t(r_PtxRegister646); // PTX L1312
	r_PtxRegister525 = uint32_t(r_PtxRegister647) + uint32_t(1536);				// PTX L1313
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister525));
		r_MmaAE4x4WordAtPtx1315R562 = r_Value.x;
		r_MmaAE4x4WordAtPtx1315R563 = r_Value.y;
		r_MmaAE4x4WordAtPtx1315R564 = r_Value.z;
		r_MmaAE4x4WordAtPtx1315R565 = r_Value.w;
	} // PTX L1315
	r_LaneIndexAtPtx1318 = uint32_t((threadIdx.x & 31u));						// PTX L1318
	r_PtxRegister648 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1318), uint32_t(4));	// PTX L1320
	r_PtxRegister649 = uint32_t(r_PtxRegister640) + uint32_t(r_PtxRegister648); // PTX L1321
	r_PtxRegister527 = uint32_t(r_PtxRegister649) + uint32_t(2048);				// PTX L1322
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister527));
		r_MmaAE4x4WordAtPtx1324R582 = r_Value.x;
		r_MmaAE4x4WordAtPtx1324R583 = r_Value.y;
		r_MmaAE4x4WordAtPtx1324R584 = r_Value.z;
		r_MmaAE4x4WordAtPtx1324R585 = r_Value.w;
	} // PTX L1324
	r_LaneIndexAtPtx1327 = uint32_t((threadIdx.x & 31u));						// PTX L1327
	r_PtxRegister650 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1327), uint32_t(4));	// PTX L1329
	r_PtxRegister651 = uint32_t(r_PtxRegister640) + uint32_t(r_PtxRegister650); // PTX L1330
	r_PtxRegister529 = uint32_t(r_PtxRegister651) + uint32_t(2560);				// PTX L1331
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister529));
		r_MmaAE4x4WordAtPtx1333R586 = r_Value.x;
		r_MmaAE4x4WordAtPtx1333R587 = r_Value.y;
		r_MmaAE4x4WordAtPtx1333R588 = r_Value.z;
		r_MmaAE4x4WordAtPtx1333R589 = r_Value.w;
	} // PTX L1333
	r_LaneIndexAtPtx1336 = uint32_t((threadIdx.x & 31u));						// PTX L1336
	r_PtxRegister652 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1336), uint32_t(4));	// PTX L1338
	r_PtxRegister653 = uint32_t(r_PtxRegister640) + uint32_t(r_PtxRegister652); // PTX L1339
	r_PtxRegister531 = uint32_t(r_PtxRegister653) + uint32_t(3072);				// PTX L1340
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister531));
		r_MmaAE4x4WordAtPtx1342R606 = r_Value.x;
		r_MmaAE4x4WordAtPtx1342R607 = r_Value.y;
		r_MmaAE4x4WordAtPtx1342R608 = r_Value.z;
		r_MmaAE4x4WordAtPtx1342R609 = r_Value.w;
	} // PTX L1342
	r_LaneIndexAtPtx1345 = uint32_t((threadIdx.x & 31u));						// PTX L1345
	r_PtxRegister654 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1345), uint32_t(4));	// PTX L1347
	r_PtxRegister655 = uint32_t(r_PtxRegister640) + uint32_t(r_PtxRegister654); // PTX L1348
	r_PtxRegister533 = uint32_t(r_PtxRegister655) + uint32_t(3584);				// PTX L1349
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister533));
		r_MmaAE4x4WordAtPtx1351R610 = r_Value.x;
		r_MmaAE4x4WordAtPtx1351R611 = r_Value.y;
		r_MmaAE4x4WordAtPtx1351R612 = r_Value.z;
		r_MmaAE4x4WordAtPtx1351R613 = r_Value.w;
	} // PTX L1351
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1354R542, r_MmaAccumulatorHalf2WordAtPtx1354R543,
		  r_MmaAE4x4WordAtPtx1288R534, r_MmaAE4x4WordAtPtx1288R535, r_MmaAE4x4WordAtPtx1288R536,
		  r_MmaAE4x4WordAtPtx1288R537, r_MmaBE4x4WordAtPtx60R1364, r_MmaBE4x4WordAtPtx60R1365,
		  r_MmaAccumulatorHalf2WordAtPtx874R1362,
		  r_MmaAccumulatorHalf2WordAtPtx873R1361); // PTX L1354
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1361R544, r_MmaAccumulatorHalf2WordAtPtx1361R545,
		  r_MmaAE4x4WordAtPtx1288R534, r_MmaAE4x4WordAtPtx1288R535, r_MmaAE4x4WordAtPtx1288R536,
		  r_MmaAE4x4WordAtPtx1288R537, r_MmaBE4x4WordAtPtx60R1366, r_MmaBE4x4WordAtPtx60R1367,
		  r_MmaAccumulatorHalf2WordAtPtx872R1360,
		  r_MmaAccumulatorHalf2WordAtPtx871R1359); // PTX L1361
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx874R1362, r_MmaAccumulatorHalf2WordAtPtx873R1361,
		  r_MmaAE4x4WordAtPtx1297R538, r_MmaAE4x4WordAtPtx1297R539, r_MmaAE4x4WordAtPtx1297R540,
		  r_MmaAE4x4WordAtPtx1297R541, r_MmaBE4x4WordAtPtx98R1380, r_MmaBE4x4WordAtPtx98R1381,
		  r_MmaAccumulatorHalf2WordAtPtx1354R542,
		  r_MmaAccumulatorHalf2WordAtPtx1354R543); // PTX L1368
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx872R1360, r_MmaAccumulatorHalf2WordAtPtx871R1359,
		  r_MmaAE4x4WordAtPtx1297R538, r_MmaAE4x4WordAtPtx1297R539, r_MmaAE4x4WordAtPtx1297R540,
		  r_MmaAE4x4WordAtPtx1297R541, r_MmaBE4x4WordAtPtx98R1382, r_MmaBE4x4WordAtPtx98R1383,
		  r_MmaAccumulatorHalf2WordAtPtx1361R544,
		  r_MmaAccumulatorHalf2WordAtPtx1361R545); // PTX L1375
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1382R546, r_MmaAccumulatorHalf2WordAtPtx1382R547,
		  r_MmaAE4x4WordAtPtx1288R534, r_MmaAE4x4WordAtPtx1288R535, r_MmaAE4x4WordAtPtx1288R536,
		  r_MmaAE4x4WordAtPtx1288R537, r_MmaBE4x4WordAtPtx71R1368, r_MmaBE4x4WordAtPtx71R1369,
		  r_MmaAccumulatorHalf2WordAtPtx870R1358,
		  r_MmaAccumulatorHalf2WordAtPtx869R1357); // PTX L1382
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1389R548, r_MmaAccumulatorHalf2WordAtPtx1389R549,
		  r_MmaAE4x4WordAtPtx1288R534, r_MmaAE4x4WordAtPtx1288R535, r_MmaAE4x4WordAtPtx1288R536,
		  r_MmaAE4x4WordAtPtx1288R537, r_MmaBE4x4WordAtPtx71R1370, r_MmaBE4x4WordAtPtx71R1371,
		  r_MmaAccumulatorHalf2WordAtPtx868R1356,
		  r_MmaAccumulatorHalf2WordAtPtx867R1355); // PTX L1389
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx870R1358, r_MmaAccumulatorHalf2WordAtPtx869R1357,
		  r_MmaAE4x4WordAtPtx1297R538, r_MmaAE4x4WordAtPtx1297R539, r_MmaAE4x4WordAtPtx1297R540,
		  r_MmaAE4x4WordAtPtx1297R541, r_MmaBE4x4WordAtPtx107R1384, r_MmaBE4x4WordAtPtx107R1385,
		  r_MmaAccumulatorHalf2WordAtPtx1382R546,
		  r_MmaAccumulatorHalf2WordAtPtx1382R547); // PTX L1396
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx868R1356, r_MmaAccumulatorHalf2WordAtPtx867R1355,
		  r_MmaAE4x4WordAtPtx1297R538, r_MmaAE4x4WordAtPtx1297R539, r_MmaAE4x4WordAtPtx1297R540,
		  r_MmaAE4x4WordAtPtx1297R541, r_MmaBE4x4WordAtPtx107R1386, r_MmaBE4x4WordAtPtx107R1387,
		  r_MmaAccumulatorHalf2WordAtPtx1389R548,
		  r_MmaAccumulatorHalf2WordAtPtx1389R549); // PTX L1403
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1410R550, r_MmaAccumulatorHalf2WordAtPtx1410R551,
		  r_MmaAE4x4WordAtPtx1288R534, r_MmaAE4x4WordAtPtx1288R535, r_MmaAE4x4WordAtPtx1288R536,
		  r_MmaAE4x4WordAtPtx1288R537, r_MmaBE4x4WordAtPtx80R1372, r_MmaBE4x4WordAtPtx80R1373,
		  r_MmaAccumulatorHalf2WordAtPtx866R1354,
		  r_MmaAccumulatorHalf2WordAtPtx865R1353); // PTX L1410
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1417R552, r_MmaAccumulatorHalf2WordAtPtx1417R553,
		  r_MmaAE4x4WordAtPtx1288R534, r_MmaAE4x4WordAtPtx1288R535, r_MmaAE4x4WordAtPtx1288R536,
		  r_MmaAE4x4WordAtPtx1288R537, r_MmaBE4x4WordAtPtx80R1374, r_MmaBE4x4WordAtPtx80R1375,
		  r_MmaAccumulatorHalf2WordAtPtx864R1352,
		  r_MmaAccumulatorHalf2WordAtPtx863R1351); // PTX L1417
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx866R1354, r_MmaAccumulatorHalf2WordAtPtx865R1353,
		  r_MmaAE4x4WordAtPtx1297R538, r_MmaAE4x4WordAtPtx1297R539, r_MmaAE4x4WordAtPtx1297R540,
		  r_MmaAE4x4WordAtPtx1297R541, r_MmaBE4x4WordAtPtx116R1388, r_MmaBE4x4WordAtPtx116R1389,
		  r_MmaAccumulatorHalf2WordAtPtx1410R550,
		  r_MmaAccumulatorHalf2WordAtPtx1410R551); // PTX L1424
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx864R1352, r_MmaAccumulatorHalf2WordAtPtx863R1351,
		  r_MmaAE4x4WordAtPtx1297R538, r_MmaAE4x4WordAtPtx1297R539, r_MmaAE4x4WordAtPtx1297R540,
		  r_MmaAE4x4WordAtPtx1297R541, r_MmaBE4x4WordAtPtx116R1390, r_MmaBE4x4WordAtPtx116R1391,
		  r_MmaAccumulatorHalf2WordAtPtx1417R552,
		  r_MmaAccumulatorHalf2WordAtPtx1417R553); // PTX L1431
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1438R554, r_MmaAccumulatorHalf2WordAtPtx1438R555,
		  r_MmaAE4x4WordAtPtx1288R534, r_MmaAE4x4WordAtPtx1288R535, r_MmaAE4x4WordAtPtx1288R536,
		  r_MmaAE4x4WordAtPtx1288R537, r_MmaBE4x4WordAtPtx89R1376, r_MmaBE4x4WordAtPtx89R1377,
		  r_MmaAccumulatorHalf2WordAtPtx862R1350,
		  r_MmaAccumulatorHalf2WordAtPtx861R1349); // PTX L1438
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1445R556, r_MmaAccumulatorHalf2WordAtPtx1445R557,
		  r_MmaAE4x4WordAtPtx1288R534, r_MmaAE4x4WordAtPtx1288R535, r_MmaAE4x4WordAtPtx1288R536,
		  r_MmaAE4x4WordAtPtx1288R537, r_MmaBE4x4WordAtPtx89R1378, r_MmaBE4x4WordAtPtx89R1379,
		  r_MmaAccumulatorHalf2WordAtPtx860R1348,
		  r_MmaAccumulatorHalf2WordAtPtx859R1347); // PTX L1445
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx862R1350, r_MmaAccumulatorHalf2WordAtPtx861R1349,
		  r_MmaAE4x4WordAtPtx1297R538, r_MmaAE4x4WordAtPtx1297R539, r_MmaAE4x4WordAtPtx1297R540,
		  r_MmaAE4x4WordAtPtx1297R541, r_MmaBE4x4WordAtPtx125R1392, r_MmaBE4x4WordAtPtx125R1393,
		  r_MmaAccumulatorHalf2WordAtPtx1438R554,
		  r_MmaAccumulatorHalf2WordAtPtx1438R555); // PTX L1452
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx860R1348, r_MmaAccumulatorHalf2WordAtPtx859R1347,
		  r_MmaAE4x4WordAtPtx1297R538, r_MmaAE4x4WordAtPtx1297R539, r_MmaAE4x4WordAtPtx1297R540,
		  r_MmaAE4x4WordAtPtx1297R541, r_MmaBE4x4WordAtPtx125R1394, r_MmaBE4x4WordAtPtx125R1395,
		  r_MmaAccumulatorHalf2WordAtPtx1445R556,
		  r_MmaAccumulatorHalf2WordAtPtx1445R557); // PTX L1459
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1466R566, r_MmaAccumulatorHalf2WordAtPtx1466R567,
		  r_MmaAE4x4WordAtPtx1306R558, r_MmaAE4x4WordAtPtx1306R559, r_MmaAE4x4WordAtPtx1306R560,
		  r_MmaAE4x4WordAtPtx1306R561, r_MmaBE4x4WordAtPtx60R1364, r_MmaBE4x4WordAtPtx60R1365,
		  r_MmaAccumulatorHalf2WordAtPtx858R1346,
		  r_MmaAccumulatorHalf2WordAtPtx857R1345); // PTX L1466
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1473R568, r_MmaAccumulatorHalf2WordAtPtx1473R569,
		  r_MmaAE4x4WordAtPtx1306R558, r_MmaAE4x4WordAtPtx1306R559, r_MmaAE4x4WordAtPtx1306R560,
		  r_MmaAE4x4WordAtPtx1306R561, r_MmaBE4x4WordAtPtx60R1366, r_MmaBE4x4WordAtPtx60R1367,
		  r_MmaAccumulatorHalf2WordAtPtx856R1344,
		  r_MmaAccumulatorHalf2WordAtPtx855R1343); // PTX L1473
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx858R1346, r_MmaAccumulatorHalf2WordAtPtx857R1345,
		  r_MmaAE4x4WordAtPtx1315R562, r_MmaAE4x4WordAtPtx1315R563, r_MmaAE4x4WordAtPtx1315R564,
		  r_MmaAE4x4WordAtPtx1315R565, r_MmaBE4x4WordAtPtx98R1380, r_MmaBE4x4WordAtPtx98R1381,
		  r_MmaAccumulatorHalf2WordAtPtx1466R566,
		  r_MmaAccumulatorHalf2WordAtPtx1466R567); // PTX L1480
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx856R1344, r_MmaAccumulatorHalf2WordAtPtx855R1343,
		  r_MmaAE4x4WordAtPtx1315R562, r_MmaAE4x4WordAtPtx1315R563, r_MmaAE4x4WordAtPtx1315R564,
		  r_MmaAE4x4WordAtPtx1315R565, r_MmaBE4x4WordAtPtx98R1382, r_MmaBE4x4WordAtPtx98R1383,
		  r_MmaAccumulatorHalf2WordAtPtx1473R568,
		  r_MmaAccumulatorHalf2WordAtPtx1473R569); // PTX L1487
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1494R570, r_MmaAccumulatorHalf2WordAtPtx1494R571,
		  r_MmaAE4x4WordAtPtx1306R558, r_MmaAE4x4WordAtPtx1306R559, r_MmaAE4x4WordAtPtx1306R560,
		  r_MmaAE4x4WordAtPtx1306R561, r_MmaBE4x4WordAtPtx71R1368, r_MmaBE4x4WordAtPtx71R1369,
		  r_MmaAccumulatorHalf2WordAtPtx854R1342,
		  r_MmaAccumulatorHalf2WordAtPtx853R1341); // PTX L1494
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1501R572, r_MmaAccumulatorHalf2WordAtPtx1501R573,
		  r_MmaAE4x4WordAtPtx1306R558, r_MmaAE4x4WordAtPtx1306R559, r_MmaAE4x4WordAtPtx1306R560,
		  r_MmaAE4x4WordAtPtx1306R561, r_MmaBE4x4WordAtPtx71R1370, r_MmaBE4x4WordAtPtx71R1371,
		  r_MmaAccumulatorHalf2WordAtPtx852R1340,
		  r_MmaAccumulatorHalf2WordAtPtx851R1339); // PTX L1501
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx854R1342, r_MmaAccumulatorHalf2WordAtPtx853R1341,
		  r_MmaAE4x4WordAtPtx1315R562, r_MmaAE4x4WordAtPtx1315R563, r_MmaAE4x4WordAtPtx1315R564,
		  r_MmaAE4x4WordAtPtx1315R565, r_MmaBE4x4WordAtPtx107R1384, r_MmaBE4x4WordAtPtx107R1385,
		  r_MmaAccumulatorHalf2WordAtPtx1494R570,
		  r_MmaAccumulatorHalf2WordAtPtx1494R571); // PTX L1508
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx852R1340, r_MmaAccumulatorHalf2WordAtPtx851R1339,
		  r_MmaAE4x4WordAtPtx1315R562, r_MmaAE4x4WordAtPtx1315R563, r_MmaAE4x4WordAtPtx1315R564,
		  r_MmaAE4x4WordAtPtx1315R565, r_MmaBE4x4WordAtPtx107R1386, r_MmaBE4x4WordAtPtx107R1387,
		  r_MmaAccumulatorHalf2WordAtPtx1501R572,
		  r_MmaAccumulatorHalf2WordAtPtx1501R573); // PTX L1515
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1522R574, r_MmaAccumulatorHalf2WordAtPtx1522R575,
		  r_MmaAE4x4WordAtPtx1306R558, r_MmaAE4x4WordAtPtx1306R559, r_MmaAE4x4WordAtPtx1306R560,
		  r_MmaAE4x4WordAtPtx1306R561, r_MmaBE4x4WordAtPtx80R1372, r_MmaBE4x4WordAtPtx80R1373,
		  r_MmaAccumulatorHalf2WordAtPtx850R1338,
		  r_MmaAccumulatorHalf2WordAtPtx849R1337); // PTX L1522
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1529R576, r_MmaAccumulatorHalf2WordAtPtx1529R577,
		  r_MmaAE4x4WordAtPtx1306R558, r_MmaAE4x4WordAtPtx1306R559, r_MmaAE4x4WordAtPtx1306R560,
		  r_MmaAE4x4WordAtPtx1306R561, r_MmaBE4x4WordAtPtx80R1374, r_MmaBE4x4WordAtPtx80R1375,
		  r_MmaAccumulatorHalf2WordAtPtx848R1336,
		  r_MmaAccumulatorHalf2WordAtPtx847R1335); // PTX L1529
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx850R1338, r_MmaAccumulatorHalf2WordAtPtx849R1337,
		  r_MmaAE4x4WordAtPtx1315R562, r_MmaAE4x4WordAtPtx1315R563, r_MmaAE4x4WordAtPtx1315R564,
		  r_MmaAE4x4WordAtPtx1315R565, r_MmaBE4x4WordAtPtx116R1388, r_MmaBE4x4WordAtPtx116R1389,
		  r_MmaAccumulatorHalf2WordAtPtx1522R574,
		  r_MmaAccumulatorHalf2WordAtPtx1522R575); // PTX L1536
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx848R1336, r_MmaAccumulatorHalf2WordAtPtx847R1335,
		  r_MmaAE4x4WordAtPtx1315R562, r_MmaAE4x4WordAtPtx1315R563, r_MmaAE4x4WordAtPtx1315R564,
		  r_MmaAE4x4WordAtPtx1315R565, r_MmaBE4x4WordAtPtx116R1390, r_MmaBE4x4WordAtPtx116R1391,
		  r_MmaAccumulatorHalf2WordAtPtx1529R576,
		  r_MmaAccumulatorHalf2WordAtPtx1529R577); // PTX L1543
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1550R578, r_MmaAccumulatorHalf2WordAtPtx1550R579,
		  r_MmaAE4x4WordAtPtx1306R558, r_MmaAE4x4WordAtPtx1306R559, r_MmaAE4x4WordAtPtx1306R560,
		  r_MmaAE4x4WordAtPtx1306R561, r_MmaBE4x4WordAtPtx89R1376, r_MmaBE4x4WordAtPtx89R1377,
		  r_MmaAccumulatorHalf2WordAtPtx846R1334,
		  r_MmaAccumulatorHalf2WordAtPtx845R1333); // PTX L1550
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1557R580, r_MmaAccumulatorHalf2WordAtPtx1557R581,
		  r_MmaAE4x4WordAtPtx1306R558, r_MmaAE4x4WordAtPtx1306R559, r_MmaAE4x4WordAtPtx1306R560,
		  r_MmaAE4x4WordAtPtx1306R561, r_MmaBE4x4WordAtPtx89R1378, r_MmaBE4x4WordAtPtx89R1379,
		  r_MmaAccumulatorHalf2WordAtPtx844R1332,
		  r_MmaAccumulatorHalf2WordAtPtx843R1331); // PTX L1557
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx846R1334, r_MmaAccumulatorHalf2WordAtPtx845R1333,
		  r_MmaAE4x4WordAtPtx1315R562, r_MmaAE4x4WordAtPtx1315R563, r_MmaAE4x4WordAtPtx1315R564,
		  r_MmaAE4x4WordAtPtx1315R565, r_MmaBE4x4WordAtPtx125R1392, r_MmaBE4x4WordAtPtx125R1393,
		  r_MmaAccumulatorHalf2WordAtPtx1550R578,
		  r_MmaAccumulatorHalf2WordAtPtx1550R579); // PTX L1564
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx844R1332, r_MmaAccumulatorHalf2WordAtPtx843R1331,
		  r_MmaAE4x4WordAtPtx1315R562, r_MmaAE4x4WordAtPtx1315R563, r_MmaAE4x4WordAtPtx1315R564,
		  r_MmaAE4x4WordAtPtx1315R565, r_MmaBE4x4WordAtPtx125R1394, r_MmaBE4x4WordAtPtx125R1395,
		  r_MmaAccumulatorHalf2WordAtPtx1557R580,
		  r_MmaAccumulatorHalf2WordAtPtx1557R581); // PTX L1571
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1578R590, r_MmaAccumulatorHalf2WordAtPtx1578R591,
		  r_MmaAE4x4WordAtPtx1324R582, r_MmaAE4x4WordAtPtx1324R583, r_MmaAE4x4WordAtPtx1324R584,
		  r_MmaAE4x4WordAtPtx1324R585, r_MmaBE4x4WordAtPtx60R1364, r_MmaBE4x4WordAtPtx60R1365,
		  r_MmaAccumulatorHalf2WordAtPtx842R1330,
		  r_MmaAccumulatorHalf2WordAtPtx841R1329); // PTX L1578
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1585R592, r_MmaAccumulatorHalf2WordAtPtx1585R593,
		  r_MmaAE4x4WordAtPtx1324R582, r_MmaAE4x4WordAtPtx1324R583, r_MmaAE4x4WordAtPtx1324R584,
		  r_MmaAE4x4WordAtPtx1324R585, r_MmaBE4x4WordAtPtx60R1366, r_MmaBE4x4WordAtPtx60R1367,
		  r_MmaAccumulatorHalf2WordAtPtx840R1328,
		  r_MmaAccumulatorHalf2WordAtPtx839R1327); // PTX L1585
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx842R1330, r_MmaAccumulatorHalf2WordAtPtx841R1329,
		  r_MmaAE4x4WordAtPtx1333R586, r_MmaAE4x4WordAtPtx1333R587, r_MmaAE4x4WordAtPtx1333R588,
		  r_MmaAE4x4WordAtPtx1333R589, r_MmaBE4x4WordAtPtx98R1380, r_MmaBE4x4WordAtPtx98R1381,
		  r_MmaAccumulatorHalf2WordAtPtx1578R590,
		  r_MmaAccumulatorHalf2WordAtPtx1578R591); // PTX L1592
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx840R1328, r_MmaAccumulatorHalf2WordAtPtx839R1327,
		  r_MmaAE4x4WordAtPtx1333R586, r_MmaAE4x4WordAtPtx1333R587, r_MmaAE4x4WordAtPtx1333R588,
		  r_MmaAE4x4WordAtPtx1333R589, r_MmaBE4x4WordAtPtx98R1382, r_MmaBE4x4WordAtPtx98R1383,
		  r_MmaAccumulatorHalf2WordAtPtx1585R592,
		  r_MmaAccumulatorHalf2WordAtPtx1585R593); // PTX L1599
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1606R594, r_MmaAccumulatorHalf2WordAtPtx1606R595,
		  r_MmaAE4x4WordAtPtx1324R582, r_MmaAE4x4WordAtPtx1324R583, r_MmaAE4x4WordAtPtx1324R584,
		  r_MmaAE4x4WordAtPtx1324R585, r_MmaBE4x4WordAtPtx71R1368, r_MmaBE4x4WordAtPtx71R1369,
		  r_MmaAccumulatorHalf2WordAtPtx838R1326,
		  r_MmaAccumulatorHalf2WordAtPtx837R1325); // PTX L1606
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1613R596, r_MmaAccumulatorHalf2WordAtPtx1613R597,
		  r_MmaAE4x4WordAtPtx1324R582, r_MmaAE4x4WordAtPtx1324R583, r_MmaAE4x4WordAtPtx1324R584,
		  r_MmaAE4x4WordAtPtx1324R585, r_MmaBE4x4WordAtPtx71R1370, r_MmaBE4x4WordAtPtx71R1371,
		  r_MmaAccumulatorHalf2WordAtPtx836R1324,
		  r_MmaAccumulatorHalf2WordAtPtx835R1323); // PTX L1613
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx838R1326, r_MmaAccumulatorHalf2WordAtPtx837R1325,
		  r_MmaAE4x4WordAtPtx1333R586, r_MmaAE4x4WordAtPtx1333R587, r_MmaAE4x4WordAtPtx1333R588,
		  r_MmaAE4x4WordAtPtx1333R589, r_MmaBE4x4WordAtPtx107R1384, r_MmaBE4x4WordAtPtx107R1385,
		  r_MmaAccumulatorHalf2WordAtPtx1606R594,
		  r_MmaAccumulatorHalf2WordAtPtx1606R595); // PTX L1620
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx836R1324, r_MmaAccumulatorHalf2WordAtPtx835R1323,
		  r_MmaAE4x4WordAtPtx1333R586, r_MmaAE4x4WordAtPtx1333R587, r_MmaAE4x4WordAtPtx1333R588,
		  r_MmaAE4x4WordAtPtx1333R589, r_MmaBE4x4WordAtPtx107R1386, r_MmaBE4x4WordAtPtx107R1387,
		  r_MmaAccumulatorHalf2WordAtPtx1613R596,
		  r_MmaAccumulatorHalf2WordAtPtx1613R597); // PTX L1627
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1634R598, r_MmaAccumulatorHalf2WordAtPtx1634R599,
		  r_MmaAE4x4WordAtPtx1324R582, r_MmaAE4x4WordAtPtx1324R583, r_MmaAE4x4WordAtPtx1324R584,
		  r_MmaAE4x4WordAtPtx1324R585, r_MmaBE4x4WordAtPtx80R1372, r_MmaBE4x4WordAtPtx80R1373,
		  r_MmaAccumulatorHalf2WordAtPtx834R1322,
		  r_MmaAccumulatorHalf2WordAtPtx833R1321); // PTX L1634
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1641R600, r_MmaAccumulatorHalf2WordAtPtx1641R601,
		  r_MmaAE4x4WordAtPtx1324R582, r_MmaAE4x4WordAtPtx1324R583, r_MmaAE4x4WordAtPtx1324R584,
		  r_MmaAE4x4WordAtPtx1324R585, r_MmaBE4x4WordAtPtx80R1374, r_MmaBE4x4WordAtPtx80R1375,
		  r_MmaAccumulatorHalf2WordAtPtx832R1320,
		  r_MmaAccumulatorHalf2WordAtPtx831R1319); // PTX L1641
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx834R1322, r_MmaAccumulatorHalf2WordAtPtx833R1321,
		  r_MmaAE4x4WordAtPtx1333R586, r_MmaAE4x4WordAtPtx1333R587, r_MmaAE4x4WordAtPtx1333R588,
		  r_MmaAE4x4WordAtPtx1333R589, r_MmaBE4x4WordAtPtx116R1388, r_MmaBE4x4WordAtPtx116R1389,
		  r_MmaAccumulatorHalf2WordAtPtx1634R598,
		  r_MmaAccumulatorHalf2WordAtPtx1634R599); // PTX L1648
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx832R1320, r_MmaAccumulatorHalf2WordAtPtx831R1319,
		  r_MmaAE4x4WordAtPtx1333R586, r_MmaAE4x4WordAtPtx1333R587, r_MmaAE4x4WordAtPtx1333R588,
		  r_MmaAE4x4WordAtPtx1333R589, r_MmaBE4x4WordAtPtx116R1390, r_MmaBE4x4WordAtPtx116R1391,
		  r_MmaAccumulatorHalf2WordAtPtx1641R600,
		  r_MmaAccumulatorHalf2WordAtPtx1641R601); // PTX L1655
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1662R602, r_MmaAccumulatorHalf2WordAtPtx1662R603,
		  r_MmaAE4x4WordAtPtx1324R582, r_MmaAE4x4WordAtPtx1324R583, r_MmaAE4x4WordAtPtx1324R584,
		  r_MmaAE4x4WordAtPtx1324R585, r_MmaBE4x4WordAtPtx89R1376, r_MmaBE4x4WordAtPtx89R1377,
		  r_MmaAccumulatorHalf2WordAtPtx830R1318,
		  r_MmaAccumulatorHalf2WordAtPtx829R1317); // PTX L1662
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1669R604, r_MmaAccumulatorHalf2WordAtPtx1669R605,
		  r_MmaAE4x4WordAtPtx1324R582, r_MmaAE4x4WordAtPtx1324R583, r_MmaAE4x4WordAtPtx1324R584,
		  r_MmaAE4x4WordAtPtx1324R585, r_MmaBE4x4WordAtPtx89R1378, r_MmaBE4x4WordAtPtx89R1379,
		  r_MmaAccumulatorHalf2WordAtPtx828R1316,
		  r_MmaAccumulatorHalf2WordAtPtx827R1315); // PTX L1669
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx830R1318, r_MmaAccumulatorHalf2WordAtPtx829R1317,
		  r_MmaAE4x4WordAtPtx1333R586, r_MmaAE4x4WordAtPtx1333R587, r_MmaAE4x4WordAtPtx1333R588,
		  r_MmaAE4x4WordAtPtx1333R589, r_MmaBE4x4WordAtPtx125R1392, r_MmaBE4x4WordAtPtx125R1393,
		  r_MmaAccumulatorHalf2WordAtPtx1662R602,
		  r_MmaAccumulatorHalf2WordAtPtx1662R603); // PTX L1676
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx828R1316, r_MmaAccumulatorHalf2WordAtPtx827R1315,
		  r_MmaAE4x4WordAtPtx1333R586, r_MmaAE4x4WordAtPtx1333R587, r_MmaAE4x4WordAtPtx1333R588,
		  r_MmaAE4x4WordAtPtx1333R589, r_MmaBE4x4WordAtPtx125R1394, r_MmaBE4x4WordAtPtx125R1395,
		  r_MmaAccumulatorHalf2WordAtPtx1669R604,
		  r_MmaAccumulatorHalf2WordAtPtx1669R605); // PTX L1683
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1690R614, r_MmaAccumulatorHalf2WordAtPtx1690R615,
		  r_MmaAE4x4WordAtPtx1342R606, r_MmaAE4x4WordAtPtx1342R607, r_MmaAE4x4WordAtPtx1342R608,
		  r_MmaAE4x4WordAtPtx1342R609, r_MmaBE4x4WordAtPtx60R1364, r_MmaBE4x4WordAtPtx60R1365,
		  r_MmaAccumulatorHalf2WordAtPtx826R1314,
		  r_MmaAccumulatorHalf2WordAtPtx825R1313); // PTX L1690
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1697R616, r_MmaAccumulatorHalf2WordAtPtx1697R617,
		  r_MmaAE4x4WordAtPtx1342R606, r_MmaAE4x4WordAtPtx1342R607, r_MmaAE4x4WordAtPtx1342R608,
		  r_MmaAE4x4WordAtPtx1342R609, r_MmaBE4x4WordAtPtx60R1366, r_MmaBE4x4WordAtPtx60R1367,
		  r_MmaAccumulatorHalf2WordAtPtx824R1312,
		  r_MmaAccumulatorHalf2WordAtPtx823R1311); // PTX L1697
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx826R1314, r_MmaAccumulatorHalf2WordAtPtx825R1313,
		  r_MmaAE4x4WordAtPtx1351R610, r_MmaAE4x4WordAtPtx1351R611, r_MmaAE4x4WordAtPtx1351R612,
		  r_MmaAE4x4WordAtPtx1351R613, r_MmaBE4x4WordAtPtx98R1380, r_MmaBE4x4WordAtPtx98R1381,
		  r_MmaAccumulatorHalf2WordAtPtx1690R614,
		  r_MmaAccumulatorHalf2WordAtPtx1690R615); // PTX L1704
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx824R1312, r_MmaAccumulatorHalf2WordAtPtx823R1311,
		  r_MmaAE4x4WordAtPtx1351R610, r_MmaAE4x4WordAtPtx1351R611, r_MmaAE4x4WordAtPtx1351R612,
		  r_MmaAE4x4WordAtPtx1351R613, r_MmaBE4x4WordAtPtx98R1382, r_MmaBE4x4WordAtPtx98R1383,
		  r_MmaAccumulatorHalf2WordAtPtx1697R616,
		  r_MmaAccumulatorHalf2WordAtPtx1697R617); // PTX L1711
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1718R618, r_MmaAccumulatorHalf2WordAtPtx1718R619,
		  r_MmaAE4x4WordAtPtx1342R606, r_MmaAE4x4WordAtPtx1342R607, r_MmaAE4x4WordAtPtx1342R608,
		  r_MmaAE4x4WordAtPtx1342R609, r_MmaBE4x4WordAtPtx71R1368, r_MmaBE4x4WordAtPtx71R1369,
		  r_MmaAccumulatorHalf2WordAtPtx822R1310,
		  r_MmaAccumulatorHalf2WordAtPtx821R1309); // PTX L1718
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1725R620, r_MmaAccumulatorHalf2WordAtPtx1725R621,
		  r_MmaAE4x4WordAtPtx1342R606, r_MmaAE4x4WordAtPtx1342R607, r_MmaAE4x4WordAtPtx1342R608,
		  r_MmaAE4x4WordAtPtx1342R609, r_MmaBE4x4WordAtPtx71R1370, r_MmaBE4x4WordAtPtx71R1371,
		  r_MmaAccumulatorHalf2WordAtPtx820R1308,
		  r_MmaAccumulatorHalf2WordAtPtx819R1307); // PTX L1725
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx822R1310, r_MmaAccumulatorHalf2WordAtPtx821R1309,
		  r_MmaAE4x4WordAtPtx1351R610, r_MmaAE4x4WordAtPtx1351R611, r_MmaAE4x4WordAtPtx1351R612,
		  r_MmaAE4x4WordAtPtx1351R613, r_MmaBE4x4WordAtPtx107R1384, r_MmaBE4x4WordAtPtx107R1385,
		  r_MmaAccumulatorHalf2WordAtPtx1718R618,
		  r_MmaAccumulatorHalf2WordAtPtx1718R619); // PTX L1732
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx820R1308, r_MmaAccumulatorHalf2WordAtPtx819R1307,
		  r_MmaAE4x4WordAtPtx1351R610, r_MmaAE4x4WordAtPtx1351R611, r_MmaAE4x4WordAtPtx1351R612,
		  r_MmaAE4x4WordAtPtx1351R613, r_MmaBE4x4WordAtPtx107R1386, r_MmaBE4x4WordAtPtx107R1387,
		  r_MmaAccumulatorHalf2WordAtPtx1725R620,
		  r_MmaAccumulatorHalf2WordAtPtx1725R621); // PTX L1739
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1746R622, r_MmaAccumulatorHalf2WordAtPtx1746R623,
		  r_MmaAE4x4WordAtPtx1342R606, r_MmaAE4x4WordAtPtx1342R607, r_MmaAE4x4WordAtPtx1342R608,
		  r_MmaAE4x4WordAtPtx1342R609, r_MmaBE4x4WordAtPtx80R1372, r_MmaBE4x4WordAtPtx80R1373,
		  r_MmaAccumulatorHalf2WordAtPtx818R1306,
		  r_MmaAccumulatorHalf2WordAtPtx817R1305); // PTX L1746
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1753R624, r_MmaAccumulatorHalf2WordAtPtx1753R625,
		  r_MmaAE4x4WordAtPtx1342R606, r_MmaAE4x4WordAtPtx1342R607, r_MmaAE4x4WordAtPtx1342R608,
		  r_MmaAE4x4WordAtPtx1342R609, r_MmaBE4x4WordAtPtx80R1374, r_MmaBE4x4WordAtPtx80R1375,
		  r_MmaAccumulatorHalf2WordAtPtx816R1304,
		  r_MmaAccumulatorHalf2WordAtPtx815R1303); // PTX L1753
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx818R1306, r_MmaAccumulatorHalf2WordAtPtx817R1305,
		  r_MmaAE4x4WordAtPtx1351R610, r_MmaAE4x4WordAtPtx1351R611, r_MmaAE4x4WordAtPtx1351R612,
		  r_MmaAE4x4WordAtPtx1351R613, r_MmaBE4x4WordAtPtx116R1388, r_MmaBE4x4WordAtPtx116R1389,
		  r_MmaAccumulatorHalf2WordAtPtx1746R622,
		  r_MmaAccumulatorHalf2WordAtPtx1746R623); // PTX L1760
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx816R1304, r_MmaAccumulatorHalf2WordAtPtx815R1303,
		  r_MmaAE4x4WordAtPtx1351R610, r_MmaAE4x4WordAtPtx1351R611, r_MmaAE4x4WordAtPtx1351R612,
		  r_MmaAE4x4WordAtPtx1351R613, r_MmaBE4x4WordAtPtx116R1390, r_MmaBE4x4WordAtPtx116R1391,
		  r_MmaAccumulatorHalf2WordAtPtx1753R624,
		  r_MmaAccumulatorHalf2WordAtPtx1753R625); // PTX L1767
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1774R626, r_MmaAccumulatorHalf2WordAtPtx1774R627,
		  r_MmaAE4x4WordAtPtx1342R606, r_MmaAE4x4WordAtPtx1342R607, r_MmaAE4x4WordAtPtx1342R608,
		  r_MmaAE4x4WordAtPtx1342R609, r_MmaBE4x4WordAtPtx89R1376, r_MmaBE4x4WordAtPtx89R1377,
		  r_MmaAccumulatorHalf2WordAtPtx814R1302,
		  r_MmaAccumulatorHalf2WordAtPtx813R1301); // PTX L1774
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1781R628, r_MmaAccumulatorHalf2WordAtPtx1781R629,
		  r_MmaAE4x4WordAtPtx1342R606, r_MmaAE4x4WordAtPtx1342R607, r_MmaAE4x4WordAtPtx1342R608,
		  r_MmaAE4x4WordAtPtx1342R609, r_MmaBE4x4WordAtPtx89R1378, r_MmaBE4x4WordAtPtx89R1379,
		  r_MmaAccumulatorHalf2WordAtPtx812R1300,
		  r_MmaAccumulatorHalf2WordAtPtx811R1299); // PTX L1781
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx814R1302, r_MmaAccumulatorHalf2WordAtPtx813R1301,
		  r_MmaAE4x4WordAtPtx1351R610, r_MmaAE4x4WordAtPtx1351R611, r_MmaAE4x4WordAtPtx1351R612,
		  r_MmaAE4x4WordAtPtx1351R613, r_MmaBE4x4WordAtPtx125R1392, r_MmaBE4x4WordAtPtx125R1393,
		  r_MmaAccumulatorHalf2WordAtPtx1774R626,
		  r_MmaAccumulatorHalf2WordAtPtx1774R627); // PTX L1788
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx812R1300, r_MmaAccumulatorHalf2WordAtPtx811R1299,
		  r_MmaAE4x4WordAtPtx1351R610, r_MmaAE4x4WordAtPtx1351R611, r_MmaAE4x4WordAtPtx1351R612,
		  r_MmaAE4x4WordAtPtx1351R613, r_MmaBE4x4WordAtPtx125R1394, r_MmaBE4x4WordAtPtx125R1395,
		  r_MmaAccumulatorHalf2WordAtPtx1781R628,
		  r_MmaAccumulatorHalf2WordAtPtx1781R629);												  // PTX L1795
	r_PtxRegister656 = ShiftLeft(uint32_t(r_PtxRegister57), uint32_t(7));						  // PTX L1801
	r_PtxRegister657 = uint32_t(r_PtxRegister656) + uint32_t(r_PtxRegister7);					  // PTX L1802
	r_PtxU64Register116 = uint64_t(int64_t(int32_t(r_PtxRegister657)) * int64_t(int32_t(4)));	  // PTX L1803
	g_RecordByteAddressAtPtx1804 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register116); // PTX L1804
	r_LaneIndexAtPtx1806 = uint32_t((threadIdx.x & 31u));										  // PTX L1806
	r_PtxU64Register118 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1806)) * int64_t(int32_t(16))); // PTX L1808
	g_RecordByteAddressAtPtx1809 =
		uint64_t(g_RecordByteAddressAtPtx1804) + uint64_t(r_PtxU64Register118); // PTX L1809
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1809));
		r_MmaBE4x4WordAtPtx60R1364 = r_Value.x;
		r_MmaBE4x4WordAtPtx60R1365 = r_Value.y;
		r_MmaBE4x4WordAtPtx60R1366 = r_Value.z;
		r_MmaBE4x4WordAtPtx60R1367 = r_Value.w;
	} // PTX L1811
	r_LaneIndexAtPtx1814 = uint32_t((threadIdx.x & 31u)); // PTX L1814
	r_PtxU64Register119 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1814)) * int64_t(int32_t(16))); // PTX L1816
	g_RecordByteAddressAtPtx1817 =
		uint64_t(g_RecordByteAddressAtPtx1804) + uint64_t(r_PtxU64Register119);			   // PTX L1817
	g_RecordByteAddressAtPtx1818 = uint64_t(g_RecordByteAddressAtPtx1817) + uint64_t(512); // PTX L1818
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1818));
		r_MmaBE4x4WordAtPtx71R1368 = r_Value.x;
		r_MmaBE4x4WordAtPtx71R1369 = r_Value.y;
		r_MmaBE4x4WordAtPtx71R1370 = r_Value.z;
		r_MmaBE4x4WordAtPtx71R1371 = r_Value.w;
	} // PTX L1820
	r_LaneIndexAtPtx1823 = uint32_t((threadIdx.x & 31u)); // PTX L1823
	r_PtxU64Register121 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1823)) * int64_t(int32_t(16))); // PTX L1825
	g_RecordByteAddressAtPtx1826 =
		uint64_t(g_RecordByteAddressAtPtx1804) + uint64_t(r_PtxU64Register121);				// PTX L1826
	g_RecordByteAddressAtPtx1827 = uint64_t(g_RecordByteAddressAtPtx1826) + uint64_t(1024); // PTX L1827
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1827));
		r_MmaBE4x4WordAtPtx80R1372 = r_Value.x;
		r_MmaBE4x4WordAtPtx80R1373 = r_Value.y;
		r_MmaBE4x4WordAtPtx80R1374 = r_Value.z;
		r_MmaBE4x4WordAtPtx80R1375 = r_Value.w;
	} // PTX L1829
	r_LaneIndexAtPtx1832 = uint32_t((threadIdx.x & 31u)); // PTX L1832
	r_PtxU64Register123 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1832)) * int64_t(int32_t(16))); // PTX L1834
	g_RecordByteAddressAtPtx1835 =
		uint64_t(g_RecordByteAddressAtPtx1804) + uint64_t(r_PtxU64Register123);				// PTX L1835
	g_RecordByteAddressAtPtx1836 = uint64_t(g_RecordByteAddressAtPtx1835) + uint64_t(1536); // PTX L1836
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1836));
		r_MmaBE4x4WordAtPtx89R1376 = r_Value.x;
		r_MmaBE4x4WordAtPtx89R1377 = r_Value.y;
		r_MmaBE4x4WordAtPtx89R1378 = r_Value.z;
		r_MmaBE4x4WordAtPtx89R1379 = r_Value.w;
	} // PTX L1838
	r_LaneIndexAtPtx1841 = uint32_t((threadIdx.x & 31u)); // PTX L1841
	r_PtxU64Register125 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1841)) * int64_t(int32_t(16))); // PTX L1843
	g_RecordByteAddressAtPtx1844 =
		uint64_t(g_RecordByteAddressAtPtx1804) + uint64_t(r_PtxU64Register125);				 // PTX L1844
	g_RecordByteAddressAtPtx1845 = uint64_t(g_RecordByteAddressAtPtx1844) + uint64_t(16384); // PTX L1845
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1845));
		r_MmaBE4x4WordAtPtx98R1380 = r_Value.x;
		r_MmaBE4x4WordAtPtx98R1381 = r_Value.y;
		r_MmaBE4x4WordAtPtx98R1382 = r_Value.z;
		r_MmaBE4x4WordAtPtx98R1383 = r_Value.w;
	} // PTX L1847
	r_LaneIndexAtPtx1850 = uint32_t((threadIdx.x & 31u)); // PTX L1850
	r_PtxU64Register127 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1850)) * int64_t(int32_t(16))); // PTX L1852
	g_RecordByteAddressAtPtx1853 =
		uint64_t(g_RecordByteAddressAtPtx1804) + uint64_t(r_PtxU64Register127);				 // PTX L1853
	g_RecordByteAddressAtPtx1854 = uint64_t(g_RecordByteAddressAtPtx1853) + uint64_t(16896); // PTX L1854
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1854));
		r_MmaBE4x4WordAtPtx107R1384 = r_Value.x;
		r_MmaBE4x4WordAtPtx107R1385 = r_Value.y;
		r_MmaBE4x4WordAtPtx107R1386 = r_Value.z;
		r_MmaBE4x4WordAtPtx107R1387 = r_Value.w;
	} // PTX L1856
	r_LaneIndexAtPtx1859 = uint32_t((threadIdx.x & 31u)); // PTX L1859
	r_PtxU64Register129 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1859)) * int64_t(int32_t(16))); // PTX L1861
	g_RecordByteAddressAtPtx1862 =
		uint64_t(g_RecordByteAddressAtPtx1804) + uint64_t(r_PtxU64Register129);				 // PTX L1862
	g_RecordByteAddressAtPtx1863 = uint64_t(g_RecordByteAddressAtPtx1862) + uint64_t(17408); // PTX L1863
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1863));
		r_MmaBE4x4WordAtPtx116R1388 = r_Value.x;
		r_MmaBE4x4WordAtPtx116R1389 = r_Value.y;
		r_MmaBE4x4WordAtPtx116R1390 = r_Value.z;
		r_MmaBE4x4WordAtPtx116R1391 = r_Value.w;
	} // PTX L1865
	r_LaneIndexAtPtx1868 = uint32_t((threadIdx.x & 31u)); // PTX L1868
	r_PtxU64Register131 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1868)) * int64_t(int32_t(16))); // PTX L1870
	g_RecordByteAddressAtPtx1871 =
		uint64_t(g_RecordByteAddressAtPtx1804) + uint64_t(r_PtxU64Register131);				 // PTX L1871
	g_RecordByteAddressAtPtx1872 = uint64_t(g_RecordByteAddressAtPtx1871) + uint64_t(17920); // PTX L1872
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1872));
		r_MmaBE4x4WordAtPtx125R1392 = r_Value.x;
		r_MmaBE4x4WordAtPtx125R1393 = r_Value.y;
		r_MmaBE4x4WordAtPtx125R1394 = r_Value.z;
		r_MmaBE4x4WordAtPtx125R1395 = r_Value.w;
	} // PTX L1874
	CopyWait0();																			  // PTX L1877
	r_bPtxPredicate195 = uint32_t(r_PtxRegister56) == uint32_t(0);							  // PTX L1879
	r_PtxRegister658 = uint32_t(8192u /* exact native shared-region offset */);				  // PTX L1880
	r_PtxRegister659 = uint32_t(r_PtxRegister658) + uint32_t(8);							  // PTX L1881
	r_PtxRegister661 = r_bPtxPredicate195 ? r_PtxRegister659 : r_PtxRegister658;			  // PTX L1882
	r_PtxRegister638 = uint32_t(1);															  // PTX L1883
	r_PtxU64Register133 = BarrierArrive(s_SharedStorage, r_PtxRegister661, r_PtxRegister638); // PTX L1885
L__BB3_102:																					  // PTX L1887
	r_PtxRegister660 = BarrierReady(s_SharedStorage, r_PtxRegister661, r_PtxU64Register133);  // PTX L1889
	r_bPtxPredicate196 = uint32_t(r_PtxRegister660) == uint32_t(0);							  // PTX L1895
	if (r_bPtxPredicate196)
	{
		goto L__BB3_102;
	} // PTX L1896
	r_bPtxPredicate197 = uint32_t(r_PtxRegister1363) < uint32_t(384); // PTX L1897
	r_PtxRegister1363 = uint32_t(r_PtxRegister57);					  // PTX L1898
	if (r_bPtxPredicate197)
	{
		goto L__BB3_53;
	} // PTX L1899
	r_LaneIndexAtPtx1901 = uint32_t((threadIdx.x & 31u));						// PTX L1901
	r_PtxRegister774 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1901), uint32_t(4));	// PTX L1903
	r_PtxRegister775 = uint32_t(0u /* exact native shared-region offset */);	// PTX L1904
	r_PtxRegister776 = uint32_t(r_PtxRegister775) + uint32_t(r_PtxRegister774); // PTX L1905
	r_PtxRegister663 = uint32_t(r_PtxRegister776) + uint32_t(4096);				// PTX L1906
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister663));
		r_MmaAE4x4WordAtPtx1908R678 = r_Value.x;
		r_MmaAE4x4WordAtPtx1908R679 = r_Value.y;
		r_MmaAE4x4WordAtPtx1908R680 = r_Value.z;
		r_MmaAE4x4WordAtPtx1908R681 = r_Value.w;
	} // PTX L1908
	r_LaneIndexAtPtx1911 = uint32_t((threadIdx.x & 31u));						// PTX L1911
	r_PtxRegister777 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1911), uint32_t(4));	// PTX L1913
	r_PtxRegister778 = uint32_t(r_PtxRegister775) + uint32_t(r_PtxRegister777); // PTX L1914
	r_PtxRegister665 = uint32_t(r_PtxRegister778) + uint32_t(4608);				// PTX L1915
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister665));
		r_MmaAE4x4WordAtPtx1917R682 = r_Value.x;
		r_MmaAE4x4WordAtPtx1917R683 = r_Value.y;
		r_MmaAE4x4WordAtPtx1917R684 = r_Value.z;
		r_MmaAE4x4WordAtPtx1917R685 = r_Value.w;
	} // PTX L1917
	r_LaneIndexAtPtx1920 = uint32_t((threadIdx.x & 31u));						// PTX L1920
	r_PtxRegister779 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1920), uint32_t(4));	// PTX L1922
	r_PtxRegister780 = uint32_t(r_PtxRegister775) + uint32_t(r_PtxRegister779); // PTX L1923
	r_PtxRegister667 = uint32_t(r_PtxRegister780) + uint32_t(5120);				// PTX L1924
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister667));
		r_MmaAE4x4WordAtPtx1926R702 = r_Value.x;
		r_MmaAE4x4WordAtPtx1926R703 = r_Value.y;
		r_MmaAE4x4WordAtPtx1926R704 = r_Value.z;
		r_MmaAE4x4WordAtPtx1926R705 = r_Value.w;
	} // PTX L1926
	r_LaneIndexAtPtx1929 = uint32_t((threadIdx.x & 31u));						// PTX L1929
	r_PtxRegister781 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1929), uint32_t(4));	// PTX L1931
	r_PtxRegister782 = uint32_t(r_PtxRegister775) + uint32_t(r_PtxRegister781); // PTX L1932
	r_PtxRegister669 = uint32_t(r_PtxRegister782) + uint32_t(5632);				// PTX L1933
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister669));
		r_MmaAE4x4WordAtPtx1935R706 = r_Value.x;
		r_MmaAE4x4WordAtPtx1935R707 = r_Value.y;
		r_MmaAE4x4WordAtPtx1935R708 = r_Value.z;
		r_MmaAE4x4WordAtPtx1935R709 = r_Value.w;
	} // PTX L1935
	r_LaneIndexAtPtx1938 = uint32_t((threadIdx.x & 31u));						// PTX L1938
	r_PtxRegister783 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1938), uint32_t(4));	// PTX L1940
	r_PtxRegister784 = uint32_t(r_PtxRegister775) + uint32_t(r_PtxRegister783); // PTX L1941
	r_PtxRegister671 = uint32_t(r_PtxRegister784) + uint32_t(6144);				// PTX L1942
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister671));
		r_MmaAE4x4WordAtPtx1944R726 = r_Value.x;
		r_MmaAE4x4WordAtPtx1944R727 = r_Value.y;
		r_MmaAE4x4WordAtPtx1944R728 = r_Value.z;
		r_MmaAE4x4WordAtPtx1944R729 = r_Value.w;
	} // PTX L1944
	r_LaneIndexAtPtx1947 = uint32_t((threadIdx.x & 31u));						// PTX L1947
	r_PtxRegister785 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1947), uint32_t(4));	// PTX L1949
	r_PtxRegister786 = uint32_t(r_PtxRegister775) + uint32_t(r_PtxRegister785); // PTX L1950
	r_PtxRegister673 = uint32_t(r_PtxRegister786) + uint32_t(6656);				// PTX L1951
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister673));
		r_MmaAE4x4WordAtPtx1953R730 = r_Value.x;
		r_MmaAE4x4WordAtPtx1953R731 = r_Value.y;
		r_MmaAE4x4WordAtPtx1953R732 = r_Value.z;
		r_MmaAE4x4WordAtPtx1953R733 = r_Value.w;
	} // PTX L1953
	r_LaneIndexAtPtx1956 = uint32_t((threadIdx.x & 31u));						// PTX L1956
	r_PtxRegister787 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1956), uint32_t(4));	// PTX L1958
	r_PtxRegister788 = uint32_t(r_PtxRegister775) + uint32_t(r_PtxRegister787); // PTX L1959
	r_PtxRegister675 = uint32_t(r_PtxRegister788) + uint32_t(7168);				// PTX L1960
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister675));
		r_MmaAE4x4WordAtPtx1962R750 = r_Value.x;
		r_MmaAE4x4WordAtPtx1962R751 = r_Value.y;
		r_MmaAE4x4WordAtPtx1962R752 = r_Value.z;
		r_MmaAE4x4WordAtPtx1962R753 = r_Value.w;
	} // PTX L1962
	r_LaneIndexAtPtx1965 = uint32_t((threadIdx.x & 31u));						// PTX L1965
	r_PtxRegister789 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1965), uint32_t(4));	// PTX L1967
	r_PtxRegister790 = uint32_t(r_PtxRegister775) + uint32_t(r_PtxRegister789); // PTX L1968
	r_PtxRegister677 = uint32_t(r_PtxRegister790) + uint32_t(7680);				// PTX L1969
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister677));
		r_MmaAE4x4WordAtPtx1971R754 = r_Value.x;
		r_MmaAE4x4WordAtPtx1971R755 = r_Value.y;
		r_MmaAE4x4WordAtPtx1971R756 = r_Value.z;
		r_MmaAE4x4WordAtPtx1971R757 = r_Value.w;
	} // PTX L1971
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1974R686, r_MmaAccumulatorHalf2WordAtPtx1974R687,
		  r_MmaAE4x4WordAtPtx1908R678, r_MmaAE4x4WordAtPtx1908R679, r_MmaAE4x4WordAtPtx1908R680,
		  r_MmaAE4x4WordAtPtx1908R681, r_MmaBE4x4WordAtPtx60R1364, r_MmaBE4x4WordAtPtx60R1365,
		  r_MmaAccumulatorHalf2WordAtPtx874R1362,
		  r_MmaAccumulatorHalf2WordAtPtx873R1361); // PTX L1974
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1981R688, r_MmaAccumulatorHalf2WordAtPtx1981R689,
		  r_MmaAE4x4WordAtPtx1908R678, r_MmaAE4x4WordAtPtx1908R679, r_MmaAE4x4WordAtPtx1908R680,
		  r_MmaAE4x4WordAtPtx1908R681, r_MmaBE4x4WordAtPtx60R1366, r_MmaBE4x4WordAtPtx60R1367,
		  r_MmaAccumulatorHalf2WordAtPtx872R1360,
		  r_MmaAccumulatorHalf2WordAtPtx871R1359); // PTX L1981
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1988R797, r_MmaAccumulatorHalf2WordAtPtx1988R799,
		  r_MmaAE4x4WordAtPtx1917R682, r_MmaAE4x4WordAtPtx1917R683, r_MmaAE4x4WordAtPtx1917R684,
		  r_MmaAE4x4WordAtPtx1917R685, r_MmaBE4x4WordAtPtx98R1380, r_MmaBE4x4WordAtPtx98R1381,
		  r_MmaAccumulatorHalf2WordAtPtx1974R686,
		  r_MmaAccumulatorHalf2WordAtPtx1974R687); // PTX L1988
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1995R798, r_MmaAccumulatorHalf2WordAtPtx1995R800,
		  r_MmaAE4x4WordAtPtx1917R682, r_MmaAE4x4WordAtPtx1917R683, r_MmaAE4x4WordAtPtx1917R684,
		  r_MmaAE4x4WordAtPtx1917R685, r_MmaBE4x4WordAtPtx98R1382, r_MmaBE4x4WordAtPtx98R1383,
		  r_MmaAccumulatorHalf2WordAtPtx1981R688,
		  r_MmaAccumulatorHalf2WordAtPtx1981R689); // PTX L1995
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2002R690, r_MmaAccumulatorHalf2WordAtPtx2002R691,
		  r_MmaAE4x4WordAtPtx1908R678, r_MmaAE4x4WordAtPtx1908R679, r_MmaAE4x4WordAtPtx1908R680,
		  r_MmaAE4x4WordAtPtx1908R681, r_MmaBE4x4WordAtPtx71R1368, r_MmaBE4x4WordAtPtx71R1369,
		  r_MmaAccumulatorHalf2WordAtPtx870R1358,
		  r_MmaAccumulatorHalf2WordAtPtx869R1357); // PTX L2002
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2009R692, r_MmaAccumulatorHalf2WordAtPtx2009R693,
		  r_MmaAE4x4WordAtPtx1908R678, r_MmaAE4x4WordAtPtx1908R679, r_MmaAE4x4WordAtPtx1908R680,
		  r_MmaAE4x4WordAtPtx1908R681, r_MmaBE4x4WordAtPtx71R1370, r_MmaBE4x4WordAtPtx71R1371,
		  r_MmaAccumulatorHalf2WordAtPtx868R1356,
		  r_MmaAccumulatorHalf2WordAtPtx867R1355); // PTX L2009
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2016R801, r_MmaAccumulatorHalf2WordAtPtx2016R803,
		  r_MmaAE4x4WordAtPtx1917R682, r_MmaAE4x4WordAtPtx1917R683, r_MmaAE4x4WordAtPtx1917R684,
		  r_MmaAE4x4WordAtPtx1917R685, r_MmaBE4x4WordAtPtx107R1384, r_MmaBE4x4WordAtPtx107R1385,
		  r_MmaAccumulatorHalf2WordAtPtx2002R690,
		  r_MmaAccumulatorHalf2WordAtPtx2002R691); // PTX L2016
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2023R802, r_MmaAccumulatorHalf2WordAtPtx2023R804,
		  r_MmaAE4x4WordAtPtx1917R682, r_MmaAE4x4WordAtPtx1917R683, r_MmaAE4x4WordAtPtx1917R684,
		  r_MmaAE4x4WordAtPtx1917R685, r_MmaBE4x4WordAtPtx107R1386, r_MmaBE4x4WordAtPtx107R1387,
		  r_MmaAccumulatorHalf2WordAtPtx2009R692,
		  r_MmaAccumulatorHalf2WordAtPtx2009R693); // PTX L2023
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2030R694, r_MmaAccumulatorHalf2WordAtPtx2030R695,
		  r_MmaAE4x4WordAtPtx1908R678, r_MmaAE4x4WordAtPtx1908R679, r_MmaAE4x4WordAtPtx1908R680,
		  r_MmaAE4x4WordAtPtx1908R681, r_MmaBE4x4WordAtPtx80R1372, r_MmaBE4x4WordAtPtx80R1373,
		  r_MmaAccumulatorHalf2WordAtPtx866R1354,
		  r_MmaAccumulatorHalf2WordAtPtx865R1353); // PTX L2030
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2037R696, r_MmaAccumulatorHalf2WordAtPtx2037R697,
		  r_MmaAE4x4WordAtPtx1908R678, r_MmaAE4x4WordAtPtx1908R679, r_MmaAE4x4WordAtPtx1908R680,
		  r_MmaAE4x4WordAtPtx1908R681, r_MmaBE4x4WordAtPtx80R1374, r_MmaBE4x4WordAtPtx80R1375,
		  r_MmaAccumulatorHalf2WordAtPtx864R1352,
		  r_MmaAccumulatorHalf2WordAtPtx863R1351); // PTX L2037
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2044R855, r_MmaAccumulatorHalf2WordAtPtx2044R857,
		  r_MmaAE4x4WordAtPtx1917R682, r_MmaAE4x4WordAtPtx1917R683, r_MmaAE4x4WordAtPtx1917R684,
		  r_MmaAE4x4WordAtPtx1917R685, r_MmaBE4x4WordAtPtx116R1388, r_MmaBE4x4WordAtPtx116R1389,
		  r_MmaAccumulatorHalf2WordAtPtx2030R694,
		  r_MmaAccumulatorHalf2WordAtPtx2030R695); // PTX L2044
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2051R856, r_MmaAccumulatorHalf2WordAtPtx2051R858,
		  r_MmaAE4x4WordAtPtx1917R682, r_MmaAE4x4WordAtPtx1917R683, r_MmaAE4x4WordAtPtx1917R684,
		  r_MmaAE4x4WordAtPtx1917R685, r_MmaBE4x4WordAtPtx116R1390, r_MmaBE4x4WordAtPtx116R1391,
		  r_MmaAccumulatorHalf2WordAtPtx2037R696,
		  r_MmaAccumulatorHalf2WordAtPtx2037R697); // PTX L2051
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2058R698, r_MmaAccumulatorHalf2WordAtPtx2058R699,
		  r_MmaAE4x4WordAtPtx1908R678, r_MmaAE4x4WordAtPtx1908R679, r_MmaAE4x4WordAtPtx1908R680,
		  r_MmaAE4x4WordAtPtx1908R681, r_MmaBE4x4WordAtPtx89R1376, r_MmaBE4x4WordAtPtx89R1377,
		  r_MmaAccumulatorHalf2WordAtPtx862R1350,
		  r_MmaAccumulatorHalf2WordAtPtx861R1349); // PTX L2058
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2065R700, r_MmaAccumulatorHalf2WordAtPtx2065R701,
		  r_MmaAE4x4WordAtPtx1908R678, r_MmaAE4x4WordAtPtx1908R679, r_MmaAE4x4WordAtPtx1908R680,
		  r_MmaAE4x4WordAtPtx1908R681, r_MmaBE4x4WordAtPtx89R1378, r_MmaBE4x4WordAtPtx89R1379,
		  r_MmaAccumulatorHalf2WordAtPtx860R1348,
		  r_MmaAccumulatorHalf2WordAtPtx859R1347); // PTX L2065
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2072R859, r_MmaAccumulatorHalf2WordAtPtx2072R861,
		  r_MmaAE4x4WordAtPtx1917R682, r_MmaAE4x4WordAtPtx1917R683, r_MmaAE4x4WordAtPtx1917R684,
		  r_MmaAE4x4WordAtPtx1917R685, r_MmaBE4x4WordAtPtx125R1392, r_MmaBE4x4WordAtPtx125R1393,
		  r_MmaAccumulatorHalf2WordAtPtx2058R698,
		  r_MmaAccumulatorHalf2WordAtPtx2058R699); // PTX L2072
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2079R860, r_MmaAccumulatorHalf2WordAtPtx2079R862,
		  r_MmaAE4x4WordAtPtx1917R682, r_MmaAE4x4WordAtPtx1917R683, r_MmaAE4x4WordAtPtx1917R684,
		  r_MmaAE4x4WordAtPtx1917R685, r_MmaBE4x4WordAtPtx125R1394, r_MmaBE4x4WordAtPtx125R1395,
		  r_MmaAccumulatorHalf2WordAtPtx2065R700,
		  r_MmaAccumulatorHalf2WordAtPtx2065R701); // PTX L2079
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2086R710, r_MmaAccumulatorHalf2WordAtPtx2086R711,
		  r_MmaAE4x4WordAtPtx1926R702, r_MmaAE4x4WordAtPtx1926R703, r_MmaAE4x4WordAtPtx1926R704,
		  r_MmaAE4x4WordAtPtx1926R705, r_MmaBE4x4WordAtPtx60R1364, r_MmaBE4x4WordAtPtx60R1365,
		  r_MmaAccumulatorHalf2WordAtPtx858R1346,
		  r_MmaAccumulatorHalf2WordAtPtx857R1345); // PTX L2086
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2093R712, r_MmaAccumulatorHalf2WordAtPtx2093R713,
		  r_MmaAE4x4WordAtPtx1926R702, r_MmaAE4x4WordAtPtx1926R703, r_MmaAE4x4WordAtPtx1926R704,
		  r_MmaAE4x4WordAtPtx1926R705, r_MmaBE4x4WordAtPtx60R1366, r_MmaBE4x4WordAtPtx60R1367,
		  r_MmaAccumulatorHalf2WordAtPtx856R1344,
		  r_MmaAccumulatorHalf2WordAtPtx855R1343); // PTX L2093
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2100R805, r_MmaAccumulatorHalf2WordAtPtx2100R807,
		  r_MmaAE4x4WordAtPtx1935R706, r_MmaAE4x4WordAtPtx1935R707, r_MmaAE4x4WordAtPtx1935R708,
		  r_MmaAE4x4WordAtPtx1935R709, r_MmaBE4x4WordAtPtx98R1380, r_MmaBE4x4WordAtPtx98R1381,
		  r_MmaAccumulatorHalf2WordAtPtx2086R710,
		  r_MmaAccumulatorHalf2WordAtPtx2086R711); // PTX L2100
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2107R806, r_MmaAccumulatorHalf2WordAtPtx2107R808,
		  r_MmaAE4x4WordAtPtx1935R706, r_MmaAE4x4WordAtPtx1935R707, r_MmaAE4x4WordAtPtx1935R708,
		  r_MmaAE4x4WordAtPtx1935R709, r_MmaBE4x4WordAtPtx98R1382, r_MmaBE4x4WordAtPtx98R1383,
		  r_MmaAccumulatorHalf2WordAtPtx2093R712,
		  r_MmaAccumulatorHalf2WordAtPtx2093R713); // PTX L2107
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2114R714, r_MmaAccumulatorHalf2WordAtPtx2114R715,
		  r_MmaAE4x4WordAtPtx1926R702, r_MmaAE4x4WordAtPtx1926R703, r_MmaAE4x4WordAtPtx1926R704,
		  r_MmaAE4x4WordAtPtx1926R705, r_MmaBE4x4WordAtPtx71R1368, r_MmaBE4x4WordAtPtx71R1369,
		  r_MmaAccumulatorHalf2WordAtPtx854R1342,
		  r_MmaAccumulatorHalf2WordAtPtx853R1341); // PTX L2114
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2121R716, r_MmaAccumulatorHalf2WordAtPtx2121R717,
		  r_MmaAE4x4WordAtPtx1926R702, r_MmaAE4x4WordAtPtx1926R703, r_MmaAE4x4WordAtPtx1926R704,
		  r_MmaAE4x4WordAtPtx1926R705, r_MmaBE4x4WordAtPtx71R1370, r_MmaBE4x4WordAtPtx71R1371,
		  r_MmaAccumulatorHalf2WordAtPtx852R1340,
		  r_MmaAccumulatorHalf2WordAtPtx851R1339); // PTX L2121
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2128R809, r_MmaAccumulatorHalf2WordAtPtx2128R811,
		  r_MmaAE4x4WordAtPtx1935R706, r_MmaAE4x4WordAtPtx1935R707, r_MmaAE4x4WordAtPtx1935R708,
		  r_MmaAE4x4WordAtPtx1935R709, r_MmaBE4x4WordAtPtx107R1384, r_MmaBE4x4WordAtPtx107R1385,
		  r_MmaAccumulatorHalf2WordAtPtx2114R714,
		  r_MmaAccumulatorHalf2WordAtPtx2114R715); // PTX L2128
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2135R810, r_MmaAccumulatorHalf2WordAtPtx2135R812,
		  r_MmaAE4x4WordAtPtx1935R706, r_MmaAE4x4WordAtPtx1935R707, r_MmaAE4x4WordAtPtx1935R708,
		  r_MmaAE4x4WordAtPtx1935R709, r_MmaBE4x4WordAtPtx107R1386, r_MmaBE4x4WordAtPtx107R1387,
		  r_MmaAccumulatorHalf2WordAtPtx2121R716,
		  r_MmaAccumulatorHalf2WordAtPtx2121R717); // PTX L2135
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2142R718, r_MmaAccumulatorHalf2WordAtPtx2142R719,
		  r_MmaAE4x4WordAtPtx1926R702, r_MmaAE4x4WordAtPtx1926R703, r_MmaAE4x4WordAtPtx1926R704,
		  r_MmaAE4x4WordAtPtx1926R705, r_MmaBE4x4WordAtPtx80R1372, r_MmaBE4x4WordAtPtx80R1373,
		  r_MmaAccumulatorHalf2WordAtPtx850R1338,
		  r_MmaAccumulatorHalf2WordAtPtx849R1337); // PTX L2142
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2149R720, r_MmaAccumulatorHalf2WordAtPtx2149R721,
		  r_MmaAE4x4WordAtPtx1926R702, r_MmaAE4x4WordAtPtx1926R703, r_MmaAE4x4WordAtPtx1926R704,
		  r_MmaAE4x4WordAtPtx1926R705, r_MmaBE4x4WordAtPtx80R1374, r_MmaBE4x4WordAtPtx80R1375,
		  r_MmaAccumulatorHalf2WordAtPtx848R1336,
		  r_MmaAccumulatorHalf2WordAtPtx847R1335); // PTX L2149
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2156R863, r_MmaAccumulatorHalf2WordAtPtx2156R865,
		  r_MmaAE4x4WordAtPtx1935R706, r_MmaAE4x4WordAtPtx1935R707, r_MmaAE4x4WordAtPtx1935R708,
		  r_MmaAE4x4WordAtPtx1935R709, r_MmaBE4x4WordAtPtx116R1388, r_MmaBE4x4WordAtPtx116R1389,
		  r_MmaAccumulatorHalf2WordAtPtx2142R718,
		  r_MmaAccumulatorHalf2WordAtPtx2142R719); // PTX L2156
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2163R864, r_MmaAccumulatorHalf2WordAtPtx2163R866,
		  r_MmaAE4x4WordAtPtx1935R706, r_MmaAE4x4WordAtPtx1935R707, r_MmaAE4x4WordAtPtx1935R708,
		  r_MmaAE4x4WordAtPtx1935R709, r_MmaBE4x4WordAtPtx116R1390, r_MmaBE4x4WordAtPtx116R1391,
		  r_MmaAccumulatorHalf2WordAtPtx2149R720,
		  r_MmaAccumulatorHalf2WordAtPtx2149R721); // PTX L2163
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2170R722, r_MmaAccumulatorHalf2WordAtPtx2170R723,
		  r_MmaAE4x4WordAtPtx1926R702, r_MmaAE4x4WordAtPtx1926R703, r_MmaAE4x4WordAtPtx1926R704,
		  r_MmaAE4x4WordAtPtx1926R705, r_MmaBE4x4WordAtPtx89R1376, r_MmaBE4x4WordAtPtx89R1377,
		  r_MmaAccumulatorHalf2WordAtPtx846R1334,
		  r_MmaAccumulatorHalf2WordAtPtx845R1333); // PTX L2170
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2177R724, r_MmaAccumulatorHalf2WordAtPtx2177R725,
		  r_MmaAE4x4WordAtPtx1926R702, r_MmaAE4x4WordAtPtx1926R703, r_MmaAE4x4WordAtPtx1926R704,
		  r_MmaAE4x4WordAtPtx1926R705, r_MmaBE4x4WordAtPtx89R1378, r_MmaBE4x4WordAtPtx89R1379,
		  r_MmaAccumulatorHalf2WordAtPtx844R1332,
		  r_MmaAccumulatorHalf2WordAtPtx843R1331); // PTX L2177
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2184R867, r_MmaAccumulatorHalf2WordAtPtx2184R869,
		  r_MmaAE4x4WordAtPtx1935R706, r_MmaAE4x4WordAtPtx1935R707, r_MmaAE4x4WordAtPtx1935R708,
		  r_MmaAE4x4WordAtPtx1935R709, r_MmaBE4x4WordAtPtx125R1392, r_MmaBE4x4WordAtPtx125R1393,
		  r_MmaAccumulatorHalf2WordAtPtx2170R722,
		  r_MmaAccumulatorHalf2WordAtPtx2170R723); // PTX L2184
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2191R868, r_MmaAccumulatorHalf2WordAtPtx2191R870,
		  r_MmaAE4x4WordAtPtx1935R706, r_MmaAE4x4WordAtPtx1935R707, r_MmaAE4x4WordAtPtx1935R708,
		  r_MmaAE4x4WordAtPtx1935R709, r_MmaBE4x4WordAtPtx125R1394, r_MmaBE4x4WordAtPtx125R1395,
		  r_MmaAccumulatorHalf2WordAtPtx2177R724,
		  r_MmaAccumulatorHalf2WordAtPtx2177R725); // PTX L2191
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2198R734, r_MmaAccumulatorHalf2WordAtPtx2198R735,
		  r_MmaAE4x4WordAtPtx1944R726, r_MmaAE4x4WordAtPtx1944R727, r_MmaAE4x4WordAtPtx1944R728,
		  r_MmaAE4x4WordAtPtx1944R729, r_MmaBE4x4WordAtPtx60R1364, r_MmaBE4x4WordAtPtx60R1365,
		  r_MmaAccumulatorHalf2WordAtPtx842R1330,
		  r_MmaAccumulatorHalf2WordAtPtx841R1329); // PTX L2198
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2205R736, r_MmaAccumulatorHalf2WordAtPtx2205R737,
		  r_MmaAE4x4WordAtPtx1944R726, r_MmaAE4x4WordAtPtx1944R727, r_MmaAE4x4WordAtPtx1944R728,
		  r_MmaAE4x4WordAtPtx1944R729, r_MmaBE4x4WordAtPtx60R1366, r_MmaBE4x4WordAtPtx60R1367,
		  r_MmaAccumulatorHalf2WordAtPtx840R1328,
		  r_MmaAccumulatorHalf2WordAtPtx839R1327); // PTX L2205
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2212R813, r_MmaAccumulatorHalf2WordAtPtx2212R815,
		  r_MmaAE4x4WordAtPtx1953R730, r_MmaAE4x4WordAtPtx1953R731, r_MmaAE4x4WordAtPtx1953R732,
		  r_MmaAE4x4WordAtPtx1953R733, r_MmaBE4x4WordAtPtx98R1380, r_MmaBE4x4WordAtPtx98R1381,
		  r_MmaAccumulatorHalf2WordAtPtx2198R734,
		  r_MmaAccumulatorHalf2WordAtPtx2198R735); // PTX L2212
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2219R814, r_MmaAccumulatorHalf2WordAtPtx2219R816,
		  r_MmaAE4x4WordAtPtx1953R730, r_MmaAE4x4WordAtPtx1953R731, r_MmaAE4x4WordAtPtx1953R732,
		  r_MmaAE4x4WordAtPtx1953R733, r_MmaBE4x4WordAtPtx98R1382, r_MmaBE4x4WordAtPtx98R1383,
		  r_MmaAccumulatorHalf2WordAtPtx2205R736,
		  r_MmaAccumulatorHalf2WordAtPtx2205R737); // PTX L2219
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2226R738, r_MmaAccumulatorHalf2WordAtPtx2226R739,
		  r_MmaAE4x4WordAtPtx1944R726, r_MmaAE4x4WordAtPtx1944R727, r_MmaAE4x4WordAtPtx1944R728,
		  r_MmaAE4x4WordAtPtx1944R729, r_MmaBE4x4WordAtPtx71R1368, r_MmaBE4x4WordAtPtx71R1369,
		  r_MmaAccumulatorHalf2WordAtPtx838R1326,
		  r_MmaAccumulatorHalf2WordAtPtx837R1325); // PTX L2226
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2233R740, r_MmaAccumulatorHalf2WordAtPtx2233R741,
		  r_MmaAE4x4WordAtPtx1944R726, r_MmaAE4x4WordAtPtx1944R727, r_MmaAE4x4WordAtPtx1944R728,
		  r_MmaAE4x4WordAtPtx1944R729, r_MmaBE4x4WordAtPtx71R1370, r_MmaBE4x4WordAtPtx71R1371,
		  r_MmaAccumulatorHalf2WordAtPtx836R1324,
		  r_MmaAccumulatorHalf2WordAtPtx835R1323); // PTX L2233
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2240R817, r_MmaAccumulatorHalf2WordAtPtx2240R819,
		  r_MmaAE4x4WordAtPtx1953R730, r_MmaAE4x4WordAtPtx1953R731, r_MmaAE4x4WordAtPtx1953R732,
		  r_MmaAE4x4WordAtPtx1953R733, r_MmaBE4x4WordAtPtx107R1384, r_MmaBE4x4WordAtPtx107R1385,
		  r_MmaAccumulatorHalf2WordAtPtx2226R738,
		  r_MmaAccumulatorHalf2WordAtPtx2226R739); // PTX L2240
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2247R818, r_MmaAccumulatorHalf2WordAtPtx2247R820,
		  r_MmaAE4x4WordAtPtx1953R730, r_MmaAE4x4WordAtPtx1953R731, r_MmaAE4x4WordAtPtx1953R732,
		  r_MmaAE4x4WordAtPtx1953R733, r_MmaBE4x4WordAtPtx107R1386, r_MmaBE4x4WordAtPtx107R1387,
		  r_MmaAccumulatorHalf2WordAtPtx2233R740,
		  r_MmaAccumulatorHalf2WordAtPtx2233R741); // PTX L2247
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2254R742, r_MmaAccumulatorHalf2WordAtPtx2254R743,
		  r_MmaAE4x4WordAtPtx1944R726, r_MmaAE4x4WordAtPtx1944R727, r_MmaAE4x4WordAtPtx1944R728,
		  r_MmaAE4x4WordAtPtx1944R729, r_MmaBE4x4WordAtPtx80R1372, r_MmaBE4x4WordAtPtx80R1373,
		  r_MmaAccumulatorHalf2WordAtPtx834R1322,
		  r_MmaAccumulatorHalf2WordAtPtx833R1321); // PTX L2254
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2261R744, r_MmaAccumulatorHalf2WordAtPtx2261R745,
		  r_MmaAE4x4WordAtPtx1944R726, r_MmaAE4x4WordAtPtx1944R727, r_MmaAE4x4WordAtPtx1944R728,
		  r_MmaAE4x4WordAtPtx1944R729, r_MmaBE4x4WordAtPtx80R1374, r_MmaBE4x4WordAtPtx80R1375,
		  r_MmaAccumulatorHalf2WordAtPtx832R1320,
		  r_MmaAccumulatorHalf2WordAtPtx831R1319); // PTX L2261
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2268R871, r_MmaAccumulatorHalf2WordAtPtx2268R873,
		  r_MmaAE4x4WordAtPtx1953R730, r_MmaAE4x4WordAtPtx1953R731, r_MmaAE4x4WordAtPtx1953R732,
		  r_MmaAE4x4WordAtPtx1953R733, r_MmaBE4x4WordAtPtx116R1388, r_MmaBE4x4WordAtPtx116R1389,
		  r_MmaAccumulatorHalf2WordAtPtx2254R742,
		  r_MmaAccumulatorHalf2WordAtPtx2254R743); // PTX L2268
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2275R872, r_MmaAccumulatorHalf2WordAtPtx2275R874,
		  r_MmaAE4x4WordAtPtx1953R730, r_MmaAE4x4WordAtPtx1953R731, r_MmaAE4x4WordAtPtx1953R732,
		  r_MmaAE4x4WordAtPtx1953R733, r_MmaBE4x4WordAtPtx116R1390, r_MmaBE4x4WordAtPtx116R1391,
		  r_MmaAccumulatorHalf2WordAtPtx2261R744,
		  r_MmaAccumulatorHalf2WordAtPtx2261R745); // PTX L2275
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2282R746, r_MmaAccumulatorHalf2WordAtPtx2282R747,
		  r_MmaAE4x4WordAtPtx1944R726, r_MmaAE4x4WordAtPtx1944R727, r_MmaAE4x4WordAtPtx1944R728,
		  r_MmaAE4x4WordAtPtx1944R729, r_MmaBE4x4WordAtPtx89R1376, r_MmaBE4x4WordAtPtx89R1377,
		  r_MmaAccumulatorHalf2WordAtPtx830R1318,
		  r_MmaAccumulatorHalf2WordAtPtx829R1317); // PTX L2282
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2289R748, r_MmaAccumulatorHalf2WordAtPtx2289R749,
		  r_MmaAE4x4WordAtPtx1944R726, r_MmaAE4x4WordAtPtx1944R727, r_MmaAE4x4WordAtPtx1944R728,
		  r_MmaAE4x4WordAtPtx1944R729, r_MmaBE4x4WordAtPtx89R1378, r_MmaBE4x4WordAtPtx89R1379,
		  r_MmaAccumulatorHalf2WordAtPtx828R1316,
		  r_MmaAccumulatorHalf2WordAtPtx827R1315); // PTX L2289
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2296R875, r_MmaAccumulatorHalf2WordAtPtx2296R877,
		  r_MmaAE4x4WordAtPtx1953R730, r_MmaAE4x4WordAtPtx1953R731, r_MmaAE4x4WordAtPtx1953R732,
		  r_MmaAE4x4WordAtPtx1953R733, r_MmaBE4x4WordAtPtx125R1392, r_MmaBE4x4WordAtPtx125R1393,
		  r_MmaAccumulatorHalf2WordAtPtx2282R746,
		  r_MmaAccumulatorHalf2WordAtPtx2282R747); // PTX L2296
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2303R876, r_MmaAccumulatorHalf2WordAtPtx2303R878,
		  r_MmaAE4x4WordAtPtx1953R730, r_MmaAE4x4WordAtPtx1953R731, r_MmaAE4x4WordAtPtx1953R732,
		  r_MmaAE4x4WordAtPtx1953R733, r_MmaBE4x4WordAtPtx125R1394, r_MmaBE4x4WordAtPtx125R1395,
		  r_MmaAccumulatorHalf2WordAtPtx2289R748,
		  r_MmaAccumulatorHalf2WordAtPtx2289R749); // PTX L2303
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2310R758, r_MmaAccumulatorHalf2WordAtPtx2310R759,
		  r_MmaAE4x4WordAtPtx1962R750, r_MmaAE4x4WordAtPtx1962R751, r_MmaAE4x4WordAtPtx1962R752,
		  r_MmaAE4x4WordAtPtx1962R753, r_MmaBE4x4WordAtPtx60R1364, r_MmaBE4x4WordAtPtx60R1365,
		  r_MmaAccumulatorHalf2WordAtPtx826R1314,
		  r_MmaAccumulatorHalf2WordAtPtx825R1313); // PTX L2310
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2317R760, r_MmaAccumulatorHalf2WordAtPtx2317R761,
		  r_MmaAE4x4WordAtPtx1962R750, r_MmaAE4x4WordAtPtx1962R751, r_MmaAE4x4WordAtPtx1962R752,
		  r_MmaAE4x4WordAtPtx1962R753, r_MmaBE4x4WordAtPtx60R1366, r_MmaBE4x4WordAtPtx60R1367,
		  r_MmaAccumulatorHalf2WordAtPtx824R1312,
		  r_MmaAccumulatorHalf2WordAtPtx823R1311); // PTX L2317
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2324R821, r_MmaAccumulatorHalf2WordAtPtx2324R823,
		  r_MmaAE4x4WordAtPtx1971R754, r_MmaAE4x4WordAtPtx1971R755, r_MmaAE4x4WordAtPtx1971R756,
		  r_MmaAE4x4WordAtPtx1971R757, r_MmaBE4x4WordAtPtx98R1380, r_MmaBE4x4WordAtPtx98R1381,
		  r_MmaAccumulatorHalf2WordAtPtx2310R758,
		  r_MmaAccumulatorHalf2WordAtPtx2310R759); // PTX L2324
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2331R822, r_MmaAccumulatorHalf2WordAtPtx2331R824,
		  r_MmaAE4x4WordAtPtx1971R754, r_MmaAE4x4WordAtPtx1971R755, r_MmaAE4x4WordAtPtx1971R756,
		  r_MmaAE4x4WordAtPtx1971R757, r_MmaBE4x4WordAtPtx98R1382, r_MmaBE4x4WordAtPtx98R1383,
		  r_MmaAccumulatorHalf2WordAtPtx2317R760,
		  r_MmaAccumulatorHalf2WordAtPtx2317R761); // PTX L2331
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2338R762, r_MmaAccumulatorHalf2WordAtPtx2338R763,
		  r_MmaAE4x4WordAtPtx1962R750, r_MmaAE4x4WordAtPtx1962R751, r_MmaAE4x4WordAtPtx1962R752,
		  r_MmaAE4x4WordAtPtx1962R753, r_MmaBE4x4WordAtPtx71R1368, r_MmaBE4x4WordAtPtx71R1369,
		  r_MmaAccumulatorHalf2WordAtPtx822R1310,
		  r_MmaAccumulatorHalf2WordAtPtx821R1309); // PTX L2338
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2345R764, r_MmaAccumulatorHalf2WordAtPtx2345R765,
		  r_MmaAE4x4WordAtPtx1962R750, r_MmaAE4x4WordAtPtx1962R751, r_MmaAE4x4WordAtPtx1962R752,
		  r_MmaAE4x4WordAtPtx1962R753, r_MmaBE4x4WordAtPtx71R1370, r_MmaBE4x4WordAtPtx71R1371,
		  r_MmaAccumulatorHalf2WordAtPtx820R1308,
		  r_MmaAccumulatorHalf2WordAtPtx819R1307); // PTX L2345
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2352R825, r_MmaAccumulatorHalf2WordAtPtx2352R827,
		  r_MmaAE4x4WordAtPtx1971R754, r_MmaAE4x4WordAtPtx1971R755, r_MmaAE4x4WordAtPtx1971R756,
		  r_MmaAE4x4WordAtPtx1971R757, r_MmaBE4x4WordAtPtx107R1384, r_MmaBE4x4WordAtPtx107R1385,
		  r_MmaAccumulatorHalf2WordAtPtx2338R762,
		  r_MmaAccumulatorHalf2WordAtPtx2338R763); // PTX L2352
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2359R826, r_MmaAccumulatorHalf2WordAtPtx2359R828,
		  r_MmaAE4x4WordAtPtx1971R754, r_MmaAE4x4WordAtPtx1971R755, r_MmaAE4x4WordAtPtx1971R756,
		  r_MmaAE4x4WordAtPtx1971R757, r_MmaBE4x4WordAtPtx107R1386, r_MmaBE4x4WordAtPtx107R1387,
		  r_MmaAccumulatorHalf2WordAtPtx2345R764,
		  r_MmaAccumulatorHalf2WordAtPtx2345R765); // PTX L2359
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2366R766, r_MmaAccumulatorHalf2WordAtPtx2366R767,
		  r_MmaAE4x4WordAtPtx1962R750, r_MmaAE4x4WordAtPtx1962R751, r_MmaAE4x4WordAtPtx1962R752,
		  r_MmaAE4x4WordAtPtx1962R753, r_MmaBE4x4WordAtPtx80R1372, r_MmaBE4x4WordAtPtx80R1373,
		  r_MmaAccumulatorHalf2WordAtPtx818R1306,
		  r_MmaAccumulatorHalf2WordAtPtx817R1305); // PTX L2366
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2373R768, r_MmaAccumulatorHalf2WordAtPtx2373R769,
		  r_MmaAE4x4WordAtPtx1962R750, r_MmaAE4x4WordAtPtx1962R751, r_MmaAE4x4WordAtPtx1962R752,
		  r_MmaAE4x4WordAtPtx1962R753, r_MmaBE4x4WordAtPtx80R1374, r_MmaBE4x4WordAtPtx80R1375,
		  r_MmaAccumulatorHalf2WordAtPtx816R1304,
		  r_MmaAccumulatorHalf2WordAtPtx815R1303); // PTX L2373
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2380R879, r_MmaAccumulatorHalf2WordAtPtx2380R881,
		  r_MmaAE4x4WordAtPtx1971R754, r_MmaAE4x4WordAtPtx1971R755, r_MmaAE4x4WordAtPtx1971R756,
		  r_MmaAE4x4WordAtPtx1971R757, r_MmaBE4x4WordAtPtx116R1388, r_MmaBE4x4WordAtPtx116R1389,
		  r_MmaAccumulatorHalf2WordAtPtx2366R766,
		  r_MmaAccumulatorHalf2WordAtPtx2366R767); // PTX L2380
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2387R880, r_MmaAccumulatorHalf2WordAtPtx2387R882,
		  r_MmaAE4x4WordAtPtx1971R754, r_MmaAE4x4WordAtPtx1971R755, r_MmaAE4x4WordAtPtx1971R756,
		  r_MmaAE4x4WordAtPtx1971R757, r_MmaBE4x4WordAtPtx116R1390, r_MmaBE4x4WordAtPtx116R1391,
		  r_MmaAccumulatorHalf2WordAtPtx2373R768,
		  r_MmaAccumulatorHalf2WordAtPtx2373R769); // PTX L2387
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2394R770, r_MmaAccumulatorHalf2WordAtPtx2394R771,
		  r_MmaAE4x4WordAtPtx1962R750, r_MmaAE4x4WordAtPtx1962R751, r_MmaAE4x4WordAtPtx1962R752,
		  r_MmaAE4x4WordAtPtx1962R753, r_MmaBE4x4WordAtPtx89R1376, r_MmaBE4x4WordAtPtx89R1377,
		  r_MmaAccumulatorHalf2WordAtPtx814R1302,
		  r_MmaAccumulatorHalf2WordAtPtx813R1301); // PTX L2394
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2401R772, r_MmaAccumulatorHalf2WordAtPtx2401R773,
		  r_MmaAE4x4WordAtPtx1962R750, r_MmaAE4x4WordAtPtx1962R751, r_MmaAE4x4WordAtPtx1962R752,
		  r_MmaAE4x4WordAtPtx1962R753, r_MmaBE4x4WordAtPtx89R1378, r_MmaBE4x4WordAtPtx89R1379,
		  r_MmaAccumulatorHalf2WordAtPtx812R1300,
		  r_MmaAccumulatorHalf2WordAtPtx811R1299); // PTX L2401
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2408R883, r_MmaAccumulatorHalf2WordAtPtx2408R885,
		  r_MmaAE4x4WordAtPtx1971R754, r_MmaAE4x4WordAtPtx1971R755, r_MmaAE4x4WordAtPtx1971R756,
		  r_MmaAE4x4WordAtPtx1971R757, r_MmaBE4x4WordAtPtx125R1392, r_MmaBE4x4WordAtPtx125R1393,
		  r_MmaAccumulatorHalf2WordAtPtx2394R770,
		  r_MmaAccumulatorHalf2WordAtPtx2394R771); // PTX L2408
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2415R884, r_MmaAccumulatorHalf2WordAtPtx2415R886,
		  r_MmaAE4x4WordAtPtx1971R754, r_MmaAE4x4WordAtPtx1971R755, r_MmaAE4x4WordAtPtx1971R756,
		  r_MmaAE4x4WordAtPtx1971R757, r_MmaBE4x4WordAtPtx125R1394, r_MmaBE4x4WordAtPtx125R1395,
		  r_MmaAccumulatorHalf2WordAtPtx2401R772,
		  r_MmaAccumulatorHalf2WordAtPtx2401R773);												  // PTX L2415
	r_PtxRegister791 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(2));								  // PTX L2421
	r_PtxRegister792 = uint32_t(r_ThreadY) + uint32_t(r_PtxRegister791);						  // PTX L2422
	r_PtxRegister793 = ShiftLeft(uint32_t(r_PtxRegister792), uint32_t(12));						  // PTX L2423
	r_PtxRegister794 = ShiftLeft(uint32_t(r_PtxRegister792), uint32_t(5));						  // PTX L2424
	r_PtxU64Register134 = uint64_t(uint32_t(r_PtxRegister794)) * uint64_t(uint32_t(512));		  // PTX L2425
	g_RecordByteAddressAtPtx2426 = uint64_t(r_PtxU64Register134) + uint64_t(g_RecordBaseAddress); // PTX L2426
	r_PtxU64Register201 = uint64_t(g_RecordByteAddressAtPtx2426) + uint64_t(270848);			  // PTX L2427
	r_PtxU64Register136 = uint64_t(uint32_t(r_PtxRegister793)) * uint64_t(uint32_t(4));			  // PTX L2428
	g_RecordByteAddressAtPtx2429 = uint64_t(r_PtxU64Register136) + uint64_t(g_RecordBaseAddress); // PTX L2429
	r_PtxU64Register200 = uint64_t(g_RecordByteAddressAtPtx2429) + uint64_t(394752);			  // PTX L2430
	r_PtxU64Register199 = uint64_t(g_RecordByteAddressAtPtx2429) + uint64_t(262656);			  // PTX L2431
	r_PtxRegister1460 = uint32_t(0);															  // PTX L2432
	r_MmaAccumulatorHalf2WordAtPtx2433R1396 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2433
	r_MmaAccumulatorHalf2WordAtPtx2434R1397 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2434
	r_MmaAccumulatorHalf2WordAtPtx2435R1398 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2435
	r_MmaAccumulatorHalf2WordAtPtx2436R1399 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2436
	r_MmaAccumulatorHalf2WordAtPtx2437R1400 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2437
	r_MmaAccumulatorHalf2WordAtPtx2438R1401 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2438
	r_MmaAccumulatorHalf2WordAtPtx2439R1402 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2439
	r_MmaAccumulatorHalf2WordAtPtx2440R1403 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2440
	r_MmaAccumulatorHalf2WordAtPtx2441R1404 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2441
	r_MmaAccumulatorHalf2WordAtPtx2442R1405 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2442
	r_MmaAccumulatorHalf2WordAtPtx2443R1406 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2443
	r_MmaAccumulatorHalf2WordAtPtx2444R1407 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2444
	r_MmaAccumulatorHalf2WordAtPtx2445R1408 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2445
	r_MmaAccumulatorHalf2WordAtPtx2446R1409 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2446
	r_MmaAccumulatorHalf2WordAtPtx2447R1410 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2447
	r_MmaAccumulatorHalf2WordAtPtx2448R1411 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2448
	r_MmaAccumulatorHalf2WordAtPtx2449R1412 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2449
	r_MmaAccumulatorHalf2WordAtPtx2450R1413 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2450
	r_MmaAccumulatorHalf2WordAtPtx2451R1414 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2451
	r_MmaAccumulatorHalf2WordAtPtx2452R1415 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2452
	r_MmaAccumulatorHalf2WordAtPtx2453R1416 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2453
	r_MmaAccumulatorHalf2WordAtPtx2454R1417 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2454
	r_MmaAccumulatorHalf2WordAtPtx2455R1418 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2455
	r_MmaAccumulatorHalf2WordAtPtx2456R1419 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2456
	r_MmaAccumulatorHalf2WordAtPtx2457R1420 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2457
	r_MmaAccumulatorHalf2WordAtPtx2458R1421 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2458
	r_MmaAccumulatorHalf2WordAtPtx2459R1422 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2459
	r_MmaAccumulatorHalf2WordAtPtx2460R1423 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2460
	r_MmaAccumulatorHalf2WordAtPtx2461R1424 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2461
	r_MmaAccumulatorHalf2WordAtPtx2462R1425 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2462
	r_MmaAccumulatorHalf2WordAtPtx2463R1426 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2463
	r_MmaAccumulatorHalf2WordAtPtx2464R1427 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2464
	r_MmaAccumulatorHalf2WordAtPtx2465R1428 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2465
	r_MmaAccumulatorHalf2WordAtPtx2466R1429 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2466
	r_MmaAccumulatorHalf2WordAtPtx2467R1430 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2467
	r_MmaAccumulatorHalf2WordAtPtx2468R1431 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2468
	r_MmaAccumulatorHalf2WordAtPtx2469R1432 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2469
	r_MmaAccumulatorHalf2WordAtPtx2470R1433 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2470
	r_MmaAccumulatorHalf2WordAtPtx2471R1434 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2471
	r_MmaAccumulatorHalf2WordAtPtx2472R1435 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2472
	r_MmaAccumulatorHalf2WordAtPtx2473R1436 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2473
	r_MmaAccumulatorHalf2WordAtPtx2474R1437 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2474
	r_MmaAccumulatorHalf2WordAtPtx2475R1438 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2475
	r_MmaAccumulatorHalf2WordAtPtx2476R1439 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2476
	r_MmaAccumulatorHalf2WordAtPtx2477R1440 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2477
	r_MmaAccumulatorHalf2WordAtPtx2478R1441 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2478
	r_MmaAccumulatorHalf2WordAtPtx2479R1442 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2479
	r_MmaAccumulatorHalf2WordAtPtx2480R1443 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2480
	r_MmaAccumulatorHalf2WordAtPtx2481R1444 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2481
	r_MmaAccumulatorHalf2WordAtPtx2482R1445 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2482
	r_MmaAccumulatorHalf2WordAtPtx2483R1446 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2483
	r_MmaAccumulatorHalf2WordAtPtx2484R1447 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2484
	r_MmaAccumulatorHalf2WordAtPtx2485R1448 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2485
	r_MmaAccumulatorHalf2WordAtPtx2486R1449 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2486
	r_MmaAccumulatorHalf2WordAtPtx2487R1450 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2487
	r_MmaAccumulatorHalf2WordAtPtx2488R1451 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2488
	r_MmaAccumulatorHalf2WordAtPtx2489R1452 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2489
	r_MmaAccumulatorHalf2WordAtPtx2490R1453 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2490
	r_MmaAccumulatorHalf2WordAtPtx2491R1454 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2491
	r_MmaAccumulatorHalf2WordAtPtx2492R1455 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2492
	r_MmaAccumulatorHalf2WordAtPtx2493R1456 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2493
	r_MmaAccumulatorHalf2WordAtPtx2494R1457 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2494
	r_MmaAccumulatorHalf2WordAtPtx2495R1458 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2495
	r_MmaAccumulatorHalf2WordAtPtx2496R1459 = uint32_t(r_PackedHalf2AtPtx43R6);					  // PTX L2496
L__BB3_105:																						  // PTX L2497
	r_LaneIndexAtPtx2499 = uint32_t((threadIdx.x & 31u));										  // PTX L2499
	r_PtxU64Register146 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2499)) * int64_t(int32_t(16)));		 // PTX L2501
	r_PtxU64Register147 = uint64_t(r_PtxU64Register199) + uint64_t(r_PtxU64Register146); // PTX L2502
	r_PtxU64Register138 = uint64_t(r_PtxU64Register147) + uint64_t(-512);				 // PTX L2503
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register138));
		r_MmaBE4x4WordAtPtx2505R829 = r_Value.x;
		r_MmaBE4x4WordAtPtx2505R830 = r_Value.y;
		r_MmaBE4x4WordAtPtx2505R835 = r_Value.z;
		r_MmaBE4x4WordAtPtx2505R836 = r_Value.w;
	} // PTX L2505
	r_LaneIndexAtPtx2508 = uint32_t((threadIdx.x & 31u)); // PTX L2508
	r_PtxU64Register148 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2508)) * int64_t(int32_t(16)));		 // PTX L2510
	r_PtxU64Register139 = uint64_t(r_PtxU64Register199) + uint64_t(r_PtxU64Register148); // PTX L2511
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register139));
		r_MmaBE4x4WordAtPtx2513R837 = r_Value.x;
		r_MmaBE4x4WordAtPtx2513R838 = r_Value.y;
		r_MmaBE4x4WordAtPtx2513R839 = r_Value.z;
		r_MmaBE4x4WordAtPtx2513R840 = r_Value.w;
	} // PTX L2513
	r_ConvertedE4PairAtPtx2516Rs1 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1988R797); // PTX L2516
	r_ConvertedE4PairAtPtx2519Rs2 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1995R798); // PTX L2519
	r_MmaAE4x4WordAtPtx2521R831 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2516Rs1, r_ConvertedE4PairAtPtx2519Rs2);   // PTX L2521
	r_ConvertedE4PairAtPtx2523Rs3 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1988R799); // PTX L2523
	r_ConvertedE4PairAtPtx2526Rs4 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1995R800); // PTX L2526
	r_MmaAE4x4WordAtPtx2528R832 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2523Rs3, r_ConvertedE4PairAtPtx2526Rs4);   // PTX L2528
	r_ConvertedE4PairAtPtx2530Rs5 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2016R801); // PTX L2530
	r_ConvertedE4PairAtPtx2533Rs6 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2023R802); // PTX L2533
	r_MmaAE4x4WordAtPtx2535R833 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2530Rs5, r_ConvertedE4PairAtPtx2533Rs6);   // PTX L2535
	r_ConvertedE4PairAtPtx2537Rs7 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2016R803); // PTX L2537
	r_ConvertedE4PairAtPtx2540Rs8 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2023R804); // PTX L2540
	r_MmaAE4x4WordAtPtx2542R834 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2537Rs7, r_ConvertedE4PairAtPtx2540Rs8);	// PTX L2542
	r_ConvertedE4PairAtPtx2544Rs9 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2100R805);	// PTX L2544
	r_ConvertedE4PairAtPtx2547Rs10 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2107R806); // PTX L2547
	r_MmaAE4x4WordAtPtx2549R841 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2544Rs9, r_ConvertedE4PairAtPtx2547Rs10);	// PTX L2549
	r_ConvertedE4PairAtPtx2551Rs11 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2100R807); // PTX L2551
	r_ConvertedE4PairAtPtx2554Rs12 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2107R808); // PTX L2554
	r_MmaAE4x4WordAtPtx2556R842 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2551Rs11, r_ConvertedE4PairAtPtx2554Rs12);	// PTX L2556
	r_ConvertedE4PairAtPtx2558Rs13 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2128R809); // PTX L2558
	r_ConvertedE4PairAtPtx2561Rs14 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2135R810); // PTX L2561
	r_MmaAE4x4WordAtPtx2563R843 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2558Rs13, r_ConvertedE4PairAtPtx2561Rs14);	// PTX L2563
	r_ConvertedE4PairAtPtx2565Rs15 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2128R811); // PTX L2565
	r_ConvertedE4PairAtPtx2568Rs16 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2135R812); // PTX L2568
	r_MmaAE4x4WordAtPtx2570R844 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2565Rs15, r_ConvertedE4PairAtPtx2568Rs16);	// PTX L2570
	r_ConvertedE4PairAtPtx2572Rs17 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2212R813); // PTX L2572
	r_ConvertedE4PairAtPtx2575Rs18 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2219R814); // PTX L2575
	r_MmaAE4x4WordAtPtx2577R845 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2572Rs17, r_ConvertedE4PairAtPtx2575Rs18);	// PTX L2577
	r_ConvertedE4PairAtPtx2579Rs19 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2212R815); // PTX L2579
	r_ConvertedE4PairAtPtx2582Rs20 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2219R816); // PTX L2582
	r_MmaAE4x4WordAtPtx2584R846 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2579Rs19, r_ConvertedE4PairAtPtx2582Rs20);	// PTX L2584
	r_ConvertedE4PairAtPtx2586Rs21 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2240R817); // PTX L2586
	r_ConvertedE4PairAtPtx2589Rs22 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2247R818); // PTX L2589
	r_MmaAE4x4WordAtPtx2591R847 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2586Rs21, r_ConvertedE4PairAtPtx2589Rs22);	// PTX L2591
	r_ConvertedE4PairAtPtx2593Rs23 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2240R819); // PTX L2593
	r_ConvertedE4PairAtPtx2596Rs24 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2247R820); // PTX L2596
	r_MmaAE4x4WordAtPtx2598R848 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2593Rs23, r_ConvertedE4PairAtPtx2596Rs24);	// PTX L2598
	r_ConvertedE4PairAtPtx2600Rs25 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2324R821); // PTX L2600
	r_ConvertedE4PairAtPtx2603Rs26 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2331R822); // PTX L2603
	r_MmaAE4x4WordAtPtx2605R849 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2600Rs25, r_ConvertedE4PairAtPtx2603Rs26);	// PTX L2605
	r_ConvertedE4PairAtPtx2607Rs27 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2324R823); // PTX L2607
	r_ConvertedE4PairAtPtx2610Rs28 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2331R824); // PTX L2610
	r_MmaAE4x4WordAtPtx2612R850 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2607Rs27, r_ConvertedE4PairAtPtx2610Rs28);	// PTX L2612
	r_ConvertedE4PairAtPtx2614Rs29 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2352R825); // PTX L2614
	r_ConvertedE4PairAtPtx2617Rs30 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2359R826); // PTX L2617
	r_MmaAE4x4WordAtPtx2619R851 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2614Rs29, r_ConvertedE4PairAtPtx2617Rs30);	// PTX L2619
	r_ConvertedE4PairAtPtx2621Rs31 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2352R827); // PTX L2621
	r_ConvertedE4PairAtPtx2624Rs32 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2359R828); // PTX L2624
	r_MmaAE4x4WordAtPtx2626R852 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2621Rs31, r_ConvertedE4PairAtPtx2624Rs32); // PTX L2626
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2628R889, r_MmaAccumulatorHalf2WordAtPtx2628R890,
		  r_MmaAE4x4WordAtPtx2521R831, r_MmaAE4x4WordAtPtx2528R832, r_MmaAE4x4WordAtPtx2535R833,
		  r_MmaAE4x4WordAtPtx2542R834, r_MmaBE4x4WordAtPtx2505R829, r_MmaBE4x4WordAtPtx2505R830,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2628
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2635R897, r_MmaAccumulatorHalf2WordAtPtx2635R898,
		  r_MmaAE4x4WordAtPtx2521R831, r_MmaAE4x4WordAtPtx2528R832, r_MmaAE4x4WordAtPtx2535R833,
		  r_MmaAE4x4WordAtPtx2542R834, r_MmaBE4x4WordAtPtx2505R835, r_MmaBE4x4WordAtPtx2505R836,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2635
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2642R901, r_MmaAccumulatorHalf2WordAtPtx2642R902,
		  r_MmaAE4x4WordAtPtx2521R831, r_MmaAE4x4WordAtPtx2528R832, r_MmaAE4x4WordAtPtx2535R833,
		  r_MmaAE4x4WordAtPtx2542R834, r_MmaBE4x4WordAtPtx2513R837, r_MmaBE4x4WordAtPtx2513R838,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2642
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2649R905, r_MmaAccumulatorHalf2WordAtPtx2649R906,
		  r_MmaAE4x4WordAtPtx2521R831, r_MmaAE4x4WordAtPtx2528R832, r_MmaAE4x4WordAtPtx2535R833,
		  r_MmaAE4x4WordAtPtx2542R834, r_MmaBE4x4WordAtPtx2513R839, r_MmaBE4x4WordAtPtx2513R840,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2649
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2656R907, r_MmaAccumulatorHalf2WordAtPtx2656R908,
		  r_MmaAE4x4WordAtPtx2549R841, r_MmaAE4x4WordAtPtx2556R842, r_MmaAE4x4WordAtPtx2563R843,
		  r_MmaAE4x4WordAtPtx2570R844, r_MmaBE4x4WordAtPtx2505R829, r_MmaBE4x4WordAtPtx2505R830,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2656
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2663R913, r_MmaAccumulatorHalf2WordAtPtx2663R914,
		  r_MmaAE4x4WordAtPtx2549R841, r_MmaAE4x4WordAtPtx2556R842, r_MmaAE4x4WordAtPtx2563R843,
		  r_MmaAE4x4WordAtPtx2570R844, r_MmaBE4x4WordAtPtx2505R835, r_MmaBE4x4WordAtPtx2505R836,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2663
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2670R915, r_MmaAccumulatorHalf2WordAtPtx2670R916,
		  r_MmaAE4x4WordAtPtx2549R841, r_MmaAE4x4WordAtPtx2556R842, r_MmaAE4x4WordAtPtx2563R843,
		  r_MmaAE4x4WordAtPtx2570R844, r_MmaBE4x4WordAtPtx2513R837, r_MmaBE4x4WordAtPtx2513R838,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2670
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2677R917, r_MmaAccumulatorHalf2WordAtPtx2677R918,
		  r_MmaAE4x4WordAtPtx2549R841, r_MmaAE4x4WordAtPtx2556R842, r_MmaAE4x4WordAtPtx2563R843,
		  r_MmaAE4x4WordAtPtx2570R844, r_MmaBE4x4WordAtPtx2513R839, r_MmaBE4x4WordAtPtx2513R840,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2677
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2684R919, r_MmaAccumulatorHalf2WordAtPtx2684R920,
		  r_MmaAE4x4WordAtPtx2577R845, r_MmaAE4x4WordAtPtx2584R846, r_MmaAE4x4WordAtPtx2591R847,
		  r_MmaAE4x4WordAtPtx2598R848, r_MmaBE4x4WordAtPtx2505R829, r_MmaBE4x4WordAtPtx2505R830,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2684
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2691R925, r_MmaAccumulatorHalf2WordAtPtx2691R926,
		  r_MmaAE4x4WordAtPtx2577R845, r_MmaAE4x4WordAtPtx2584R846, r_MmaAE4x4WordAtPtx2591R847,
		  r_MmaAE4x4WordAtPtx2598R848, r_MmaBE4x4WordAtPtx2505R835, r_MmaBE4x4WordAtPtx2505R836,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2691
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2698R927, r_MmaAccumulatorHalf2WordAtPtx2698R928,
		  r_MmaAE4x4WordAtPtx2577R845, r_MmaAE4x4WordAtPtx2584R846, r_MmaAE4x4WordAtPtx2591R847,
		  r_MmaAE4x4WordAtPtx2598R848, r_MmaBE4x4WordAtPtx2513R837, r_MmaBE4x4WordAtPtx2513R838,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2698
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2705R929, r_MmaAccumulatorHalf2WordAtPtx2705R930,
		  r_MmaAE4x4WordAtPtx2577R845, r_MmaAE4x4WordAtPtx2584R846, r_MmaAE4x4WordAtPtx2591R847,
		  r_MmaAE4x4WordAtPtx2598R848, r_MmaBE4x4WordAtPtx2513R839, r_MmaBE4x4WordAtPtx2513R840,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2705
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2712R931, r_MmaAccumulatorHalf2WordAtPtx2712R932,
		  r_MmaAE4x4WordAtPtx2605R849, r_MmaAE4x4WordAtPtx2612R850, r_MmaAE4x4WordAtPtx2619R851,
		  r_MmaAE4x4WordAtPtx2626R852, r_MmaBE4x4WordAtPtx2505R829, r_MmaBE4x4WordAtPtx2505R830,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2712
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2719R937, r_MmaAccumulatorHalf2WordAtPtx2719R938,
		  r_MmaAE4x4WordAtPtx2605R849, r_MmaAE4x4WordAtPtx2612R850, r_MmaAE4x4WordAtPtx2619R851,
		  r_MmaAE4x4WordAtPtx2626R852, r_MmaBE4x4WordAtPtx2505R835, r_MmaBE4x4WordAtPtx2505R836,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2719
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2726R939, r_MmaAccumulatorHalf2WordAtPtx2726R940,
		  r_MmaAE4x4WordAtPtx2605R849, r_MmaAE4x4WordAtPtx2612R850, r_MmaAE4x4WordAtPtx2619R851,
		  r_MmaAE4x4WordAtPtx2626R852, r_MmaBE4x4WordAtPtx2513R837, r_MmaBE4x4WordAtPtx2513R838,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6); // PTX L2726
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2733R941, r_MmaAccumulatorHalf2WordAtPtx2733R942,
		  r_MmaAE4x4WordAtPtx2605R849, r_MmaAE4x4WordAtPtx2612R850, r_MmaAE4x4WordAtPtx2619R851,
		  r_MmaAE4x4WordAtPtx2626R852, r_MmaBE4x4WordAtPtx2513R839, r_MmaBE4x4WordAtPtx2513R840,
		  r_PackedHalf2AtPtx43R6,
		  r_PackedHalf2AtPtx43R6);						  // PTX L2733
	r_LaneIndexAtPtx2740 = uint32_t((threadIdx.x & 31u)); // PTX L2740
	r_PtxU64Register149 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2740)) * int64_t(int32_t(16)));		 // PTX L2742
	r_PtxU64Register150 = uint64_t(r_PtxU64Register201) + uint64_t(r_PtxU64Register149); // PTX L2743
	r_PtxU64Register140 = uint64_t(r_PtxU64Register150) + uint64_t(-512);				 // PTX L2744
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register140));
		r_MmaBE4x4WordAtPtx2746R887 = r_Value.x;
		r_MmaBE4x4WordAtPtx2746R888 = r_Value.y;
		r_MmaBE4x4WordAtPtx2746R895 = r_Value.z;
		r_MmaBE4x4WordAtPtx2746R896 = r_Value.w;
	} // PTX L2746
	r_LaneIndexAtPtx2749 = uint32_t((threadIdx.x & 31u)); // PTX L2749
	r_PtxU64Register151 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2749)) * int64_t(int32_t(16)));		 // PTX L2751
	r_PtxU64Register141 = uint64_t(r_PtxU64Register201) + uint64_t(r_PtxU64Register151); // PTX L2752
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register141));
		r_MmaBE4x4WordAtPtx2754R899 = r_Value.x;
		r_MmaBE4x4WordAtPtx2754R900 = r_Value.y;
		r_MmaBE4x4WordAtPtx2754R903 = r_Value.z;
		r_MmaBE4x4WordAtPtx2754R904 = r_Value.w;
	} // PTX L2754
	r_ConvertedE4PairAtPtx2757Rs33 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2044R855); // PTX L2757
	r_ConvertedE4PairAtPtx2760Rs34 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2051R856); // PTX L2760
	r_MmaAE4x4WordAtPtx2762R891 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2757Rs33, r_ConvertedE4PairAtPtx2760Rs34);	// PTX L2762
	r_ConvertedE4PairAtPtx2764Rs35 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2044R857); // PTX L2764
	r_ConvertedE4PairAtPtx2767Rs36 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2051R858); // PTX L2767
	r_MmaAE4x4WordAtPtx2769R892 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2764Rs35, r_ConvertedE4PairAtPtx2767Rs36);	// PTX L2769
	r_ConvertedE4PairAtPtx2771Rs37 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2072R859); // PTX L2771
	r_ConvertedE4PairAtPtx2774Rs38 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2079R860); // PTX L2774
	r_MmaAE4x4WordAtPtx2776R893 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2771Rs37, r_ConvertedE4PairAtPtx2774Rs38);	// PTX L2776
	r_ConvertedE4PairAtPtx2778Rs39 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2072R861); // PTX L2778
	r_ConvertedE4PairAtPtx2781Rs40 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2079R862); // PTX L2781
	r_MmaAE4x4WordAtPtx2783R894 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2778Rs39, r_ConvertedE4PairAtPtx2781Rs40);	// PTX L2783
	r_ConvertedE4PairAtPtx2785Rs41 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2156R863); // PTX L2785
	r_ConvertedE4PairAtPtx2788Rs42 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2163R864); // PTX L2788
	r_MmaAE4x4WordAtPtx2790R909 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2785Rs41, r_ConvertedE4PairAtPtx2788Rs42);	// PTX L2790
	r_ConvertedE4PairAtPtx2792Rs43 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2156R865); // PTX L2792
	r_ConvertedE4PairAtPtx2795Rs44 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2163R866); // PTX L2795
	r_MmaAE4x4WordAtPtx2797R910 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2792Rs43, r_ConvertedE4PairAtPtx2795Rs44);	// PTX L2797
	r_ConvertedE4PairAtPtx2799Rs45 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2184R867); // PTX L2799
	r_ConvertedE4PairAtPtx2802Rs46 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2191R868); // PTX L2802
	r_MmaAE4x4WordAtPtx2804R911 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2799Rs45, r_ConvertedE4PairAtPtx2802Rs46);	// PTX L2804
	r_ConvertedE4PairAtPtx2806Rs47 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2184R869); // PTX L2806
	r_ConvertedE4PairAtPtx2809Rs48 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2191R870); // PTX L2809
	r_MmaAE4x4WordAtPtx2811R912 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2806Rs47, r_ConvertedE4PairAtPtx2809Rs48);	// PTX L2811
	r_ConvertedE4PairAtPtx2813Rs49 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2268R871); // PTX L2813
	r_ConvertedE4PairAtPtx2816Rs50 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2275R872); // PTX L2816
	r_MmaAE4x4WordAtPtx2818R921 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2813Rs49, r_ConvertedE4PairAtPtx2816Rs50);	// PTX L2818
	r_ConvertedE4PairAtPtx2820Rs51 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2268R873); // PTX L2820
	r_ConvertedE4PairAtPtx2823Rs52 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2275R874); // PTX L2823
	r_MmaAE4x4WordAtPtx2825R922 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2820Rs51, r_ConvertedE4PairAtPtx2823Rs52);	// PTX L2825
	r_ConvertedE4PairAtPtx2827Rs53 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2296R875); // PTX L2827
	r_ConvertedE4PairAtPtx2830Rs54 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2303R876); // PTX L2830
	r_MmaAE4x4WordAtPtx2832R923 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2827Rs53, r_ConvertedE4PairAtPtx2830Rs54);	// PTX L2832
	r_ConvertedE4PairAtPtx2834Rs55 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2296R877); // PTX L2834
	r_ConvertedE4PairAtPtx2837Rs56 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2303R878); // PTX L2837
	r_MmaAE4x4WordAtPtx2839R924 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2834Rs55, r_ConvertedE4PairAtPtx2837Rs56);	// PTX L2839
	r_ConvertedE4PairAtPtx2841Rs57 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2380R879); // PTX L2841
	r_ConvertedE4PairAtPtx2844Rs58 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2387R880); // PTX L2844
	r_MmaAE4x4WordAtPtx2846R933 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2841Rs57, r_ConvertedE4PairAtPtx2844Rs58);	// PTX L2846
	r_ConvertedE4PairAtPtx2848Rs59 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2380R881); // PTX L2848
	r_ConvertedE4PairAtPtx2851Rs60 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2387R882); // PTX L2851
	r_MmaAE4x4WordAtPtx2853R934 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2848Rs59, r_ConvertedE4PairAtPtx2851Rs60);	// PTX L2853
	r_ConvertedE4PairAtPtx2855Rs61 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2408R883); // PTX L2855
	r_ConvertedE4PairAtPtx2858Rs62 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2415R884); // PTX L2858
	r_MmaAE4x4WordAtPtx2860R935 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2855Rs61, r_ConvertedE4PairAtPtx2858Rs62);	// PTX L2860
	r_ConvertedE4PairAtPtx2862Rs63 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2408R885); // PTX L2862
	r_ConvertedE4PairAtPtx2865Rs64 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2415R886); // PTX L2865
	r_MmaAE4x4WordAtPtx2867R936 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2862Rs63, r_ConvertedE4PairAtPtx2865Rs64); // PTX L2867
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2869R949, r_MmaAccumulatorHalf2WordAtPtx2869R961,
		  r_MmaAE4x4WordAtPtx2762R891, r_MmaAE4x4WordAtPtx2769R892, r_MmaAE4x4WordAtPtx2776R893,
		  r_MmaAE4x4WordAtPtx2783R894, r_MmaBE4x4WordAtPtx2746R887, r_MmaBE4x4WordAtPtx2746R888,
		  r_MmaAccumulatorHalf2WordAtPtx2628R889,
		  r_MmaAccumulatorHalf2WordAtPtx2628R890); // PTX L2869
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2876R968, r_MmaAccumulatorHalf2WordAtPtx2876R975,
		  r_MmaAE4x4WordAtPtx2762R891, r_MmaAE4x4WordAtPtx2769R892, r_MmaAE4x4WordAtPtx2776R893,
		  r_MmaAE4x4WordAtPtx2783R894, r_MmaBE4x4WordAtPtx2746R895, r_MmaBE4x4WordAtPtx2746R896,
		  r_MmaAccumulatorHalf2WordAtPtx2635R897,
		  r_MmaAccumulatorHalf2WordAtPtx2635R898); // PTX L2876
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2883R982, r_MmaAccumulatorHalf2WordAtPtx2883R989,
		  r_MmaAE4x4WordAtPtx2762R891, r_MmaAE4x4WordAtPtx2769R892, r_MmaAE4x4WordAtPtx2776R893,
		  r_MmaAE4x4WordAtPtx2783R894, r_MmaBE4x4WordAtPtx2754R899, r_MmaBE4x4WordAtPtx2754R900,
		  r_MmaAccumulatorHalf2WordAtPtx2642R901,
		  r_MmaAccumulatorHalf2WordAtPtx2642R902); // PTX L2883
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2890R996, r_MmaAccumulatorHalf2WordAtPtx2890R1003,
		  r_MmaAE4x4WordAtPtx2762R891, r_MmaAE4x4WordAtPtx2769R892, r_MmaAE4x4WordAtPtx2776R893,
		  r_MmaAE4x4WordAtPtx2783R894, r_MmaBE4x4WordAtPtx2754R903, r_MmaBE4x4WordAtPtx2754R904,
		  r_MmaAccumulatorHalf2WordAtPtx2649R905,
		  r_MmaAccumulatorHalf2WordAtPtx2649R906); // PTX L2890
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2897R1010, r_MmaAccumulatorHalf2WordAtPtx2897R1017,
		  r_MmaAE4x4WordAtPtx2790R909, r_MmaAE4x4WordAtPtx2797R910, r_MmaAE4x4WordAtPtx2804R911,
		  r_MmaAE4x4WordAtPtx2811R912, r_MmaBE4x4WordAtPtx2746R887, r_MmaBE4x4WordAtPtx2746R888,
		  r_MmaAccumulatorHalf2WordAtPtx2656R907,
		  r_MmaAccumulatorHalf2WordAtPtx2656R908); // PTX L2897
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2904R1024, r_MmaAccumulatorHalf2WordAtPtx2904R1031,
		  r_MmaAE4x4WordAtPtx2790R909, r_MmaAE4x4WordAtPtx2797R910, r_MmaAE4x4WordAtPtx2804R911,
		  r_MmaAE4x4WordAtPtx2811R912, r_MmaBE4x4WordAtPtx2746R895, r_MmaBE4x4WordAtPtx2746R896,
		  r_MmaAccumulatorHalf2WordAtPtx2663R913,
		  r_MmaAccumulatorHalf2WordAtPtx2663R914); // PTX L2904
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2911R1038, r_MmaAccumulatorHalf2WordAtPtx2911R1045,
		  r_MmaAE4x4WordAtPtx2790R909, r_MmaAE4x4WordAtPtx2797R910, r_MmaAE4x4WordAtPtx2804R911,
		  r_MmaAE4x4WordAtPtx2811R912, r_MmaBE4x4WordAtPtx2754R899, r_MmaBE4x4WordAtPtx2754R900,
		  r_MmaAccumulatorHalf2WordAtPtx2670R915,
		  r_MmaAccumulatorHalf2WordAtPtx2670R916); // PTX L2911
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2918R1052, r_MmaAccumulatorHalf2WordAtPtx2918R1059,
		  r_MmaAE4x4WordAtPtx2790R909, r_MmaAE4x4WordAtPtx2797R910, r_MmaAE4x4WordAtPtx2804R911,
		  r_MmaAE4x4WordAtPtx2811R912, r_MmaBE4x4WordAtPtx2754R903, r_MmaBE4x4WordAtPtx2754R904,
		  r_MmaAccumulatorHalf2WordAtPtx2677R917,
		  r_MmaAccumulatorHalf2WordAtPtx2677R918); // PTX L2918
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2925R1066, r_MmaAccumulatorHalf2WordAtPtx2925R1073,
		  r_MmaAE4x4WordAtPtx2818R921, r_MmaAE4x4WordAtPtx2825R922, r_MmaAE4x4WordAtPtx2832R923,
		  r_MmaAE4x4WordAtPtx2839R924, r_MmaBE4x4WordAtPtx2746R887, r_MmaBE4x4WordAtPtx2746R888,
		  r_MmaAccumulatorHalf2WordAtPtx2684R919,
		  r_MmaAccumulatorHalf2WordAtPtx2684R920); // PTX L2925
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2932R1080, r_MmaAccumulatorHalf2WordAtPtx2932R1087,
		  r_MmaAE4x4WordAtPtx2818R921, r_MmaAE4x4WordAtPtx2825R922, r_MmaAE4x4WordAtPtx2832R923,
		  r_MmaAE4x4WordAtPtx2839R924, r_MmaBE4x4WordAtPtx2746R895, r_MmaBE4x4WordAtPtx2746R896,
		  r_MmaAccumulatorHalf2WordAtPtx2691R925,
		  r_MmaAccumulatorHalf2WordAtPtx2691R926); // PTX L2932
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2939R1094, r_MmaAccumulatorHalf2WordAtPtx2939R1101,
		  r_MmaAE4x4WordAtPtx2818R921, r_MmaAE4x4WordAtPtx2825R922, r_MmaAE4x4WordAtPtx2832R923,
		  r_MmaAE4x4WordAtPtx2839R924, r_MmaBE4x4WordAtPtx2754R899, r_MmaBE4x4WordAtPtx2754R900,
		  r_MmaAccumulatorHalf2WordAtPtx2698R927,
		  r_MmaAccumulatorHalf2WordAtPtx2698R928); // PTX L2939
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2946R1108, r_MmaAccumulatorHalf2WordAtPtx2946R1115,
		  r_MmaAE4x4WordAtPtx2818R921, r_MmaAE4x4WordAtPtx2825R922, r_MmaAE4x4WordAtPtx2832R923,
		  r_MmaAE4x4WordAtPtx2839R924, r_MmaBE4x4WordAtPtx2754R903, r_MmaBE4x4WordAtPtx2754R904,
		  r_MmaAccumulatorHalf2WordAtPtx2705R929,
		  r_MmaAccumulatorHalf2WordAtPtx2705R930); // PTX L2946
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2953R1122, r_MmaAccumulatorHalf2WordAtPtx2953R1129,
		  r_MmaAE4x4WordAtPtx2846R933, r_MmaAE4x4WordAtPtx2853R934, r_MmaAE4x4WordAtPtx2860R935,
		  r_MmaAE4x4WordAtPtx2867R936, r_MmaBE4x4WordAtPtx2746R887, r_MmaBE4x4WordAtPtx2746R888,
		  r_MmaAccumulatorHalf2WordAtPtx2712R931,
		  r_MmaAccumulatorHalf2WordAtPtx2712R932); // PTX L2953
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2960R1136, r_MmaAccumulatorHalf2WordAtPtx2960R1143,
		  r_MmaAE4x4WordAtPtx2846R933, r_MmaAE4x4WordAtPtx2853R934, r_MmaAE4x4WordAtPtx2860R935,
		  r_MmaAE4x4WordAtPtx2867R936, r_MmaBE4x4WordAtPtx2746R895, r_MmaBE4x4WordAtPtx2746R896,
		  r_MmaAccumulatorHalf2WordAtPtx2719R937,
		  r_MmaAccumulatorHalf2WordAtPtx2719R938); // PTX L2960
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2967R1150, r_MmaAccumulatorHalf2WordAtPtx2967R1157,
		  r_MmaAE4x4WordAtPtx2846R933, r_MmaAE4x4WordAtPtx2853R934, r_MmaAE4x4WordAtPtx2860R935,
		  r_MmaAE4x4WordAtPtx2867R936, r_MmaBE4x4WordAtPtx2754R899, r_MmaBE4x4WordAtPtx2754R900,
		  r_MmaAccumulatorHalf2WordAtPtx2726R939,
		  r_MmaAccumulatorHalf2WordAtPtx2726R940); // PTX L2967
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2974R1164, r_MmaAccumulatorHalf2WordAtPtx2974R1171,
		  r_MmaAE4x4WordAtPtx2846R933, r_MmaAE4x4WordAtPtx2853R934, r_MmaAE4x4WordAtPtx2860R935,
		  r_MmaAE4x4WordAtPtx2867R936, r_MmaBE4x4WordAtPtx2754R903, r_MmaBE4x4WordAtPtx2754R904,
		  r_MmaAccumulatorHalf2WordAtPtx2733R941,
		  r_MmaAccumulatorHalf2WordAtPtx2733R942);						   // PTX L2974
	r_LaneIndexAtPtx2981 = uint32_t((threadIdx.x & 31u));				   // PTX L2981
	r_Float32BitsAtPtx2983R944 = uint32_t(-1065353216);					   // PTX L2983
	r_PackedHalf2AtPtx2985R952 = FloatToHalf2(r_Float32BitsAtPtx2983R944); // PTX L2985
	r_Float32BitsAtPtx2990R945 = uint32_t(1082130432);					   // PTX L2990
	r_PackedHalf2AtPtx2992R950 = FloatToHalf2(r_Float32BitsAtPtx2990R945); // PTX L2992
	r_Float32BitsAtPtx2997R946 = uint32_t(1063583744);					   // PTX L2997
	r_PackedHalf2AtPtx2999R958 = FloatToHalf2(r_Float32BitsAtPtx2997R946); // PTX L2999
	r_Float32BitsAtPtx3004R947 = uint32_t(1055195136);					   // PTX L3004
	r_PackedHalf2AtPtx3006R956 = FloatToHalf2(r_Float32BitsAtPtx3004R947); // PTX L3006
	r_Float32BitsAtPtx3011R948 = uint32_t(-1117454336);					   // PTX L3011
	r_PackedHalf2AtPtx3013R954 = FloatToHalf2(r_Float32BitsAtPtx3011R948); // PTX L3013
	r_PackedHalf2AtPtx3019R951 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2869R949, r_PackedHalf2AtPtx2992R950);			  // PTX L3019
	r_PackedHalf2AtPtx3023R953 = HalfMax(r_PackedHalf2AtPtx3019R951, r_PackedHalf2AtPtx2985R952); // PTX L3023
	r_PackedHalf2AtPtx3027R955 = HalfAbs(r_PackedHalf2AtPtx3023R953);							  // PTX L3027
	r_PackedHalf2AtPtx3031R957 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3027R955,
										 r_PackedHalf2AtPtx3006R956); // PTX L3031
	r_PackedHalf2AtPtx3035R959 = HalfFma(r_PackedHalf2AtPtx3023R953, r_PackedHalf2AtPtx3031R957,
										 r_PackedHalf2AtPtx2999R958); // PTX L3035
	r_PackedHalf2AtPtx3039R1181 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2869R949, r_PackedHalf2AtPtx3035R959); // PTX L3039
	r_LaneIndexAtPtx3043 = uint32_t((threadIdx.x & 31u));							 // PTX L3043
	r_PackedHalf2AtPtx3046R962 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2869R961, r_PackedHalf2AtPtx2992R950);			  // PTX L3046
	r_PackedHalf2AtPtx3050R963 = HalfMax(r_PackedHalf2AtPtx3046R962, r_PackedHalf2AtPtx2985R952); // PTX L3050
	r_PackedHalf2AtPtx3054R964 = HalfAbs(r_PackedHalf2AtPtx3050R963);							  // PTX L3054
	r_PackedHalf2AtPtx3058R965 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3054R964,
										 r_PackedHalf2AtPtx3006R956); // PTX L3058
	r_PackedHalf2AtPtx3062R966 = HalfFma(r_PackedHalf2AtPtx3050R963, r_PackedHalf2AtPtx3058R965,
										 r_PackedHalf2AtPtx2999R958); // PTX L3062
	r_PackedHalf2AtPtx3066R1183 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2869R961, r_PackedHalf2AtPtx3062R966); // PTX L3066
	r_LaneIndexAtPtx3070 = uint32_t((threadIdx.x & 31u));							 // PTX L3070
	r_PackedHalf2AtPtx3073R969 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2876R968, r_PackedHalf2AtPtx2992R950);			  // PTX L3073
	r_PackedHalf2AtPtx3077R970 = HalfMax(r_PackedHalf2AtPtx3073R969, r_PackedHalf2AtPtx2985R952); // PTX L3077
	r_PackedHalf2AtPtx3081R971 = HalfAbs(r_PackedHalf2AtPtx3077R970);							  // PTX L3081
	r_PackedHalf2AtPtx3085R972 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3081R971,
										 r_PackedHalf2AtPtx3006R956); // PTX L3085
	r_PackedHalf2AtPtx3089R973 = HalfFma(r_PackedHalf2AtPtx3077R970, r_PackedHalf2AtPtx3085R972,
										 r_PackedHalf2AtPtx2999R958); // PTX L3089
	r_PackedHalf2AtPtx3093R1182 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2876R968, r_PackedHalf2AtPtx3089R973); // PTX L3093
	r_LaneIndexAtPtx3097 = uint32_t((threadIdx.x & 31u));							 // PTX L3097
	r_PackedHalf2AtPtx3100R976 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2876R975, r_PackedHalf2AtPtx2992R950);			  // PTX L3100
	r_PackedHalf2AtPtx3104R977 = HalfMax(r_PackedHalf2AtPtx3100R976, r_PackedHalf2AtPtx2985R952); // PTX L3104
	r_PackedHalf2AtPtx3108R978 = HalfAbs(r_PackedHalf2AtPtx3104R977);							  // PTX L3108
	r_PackedHalf2AtPtx3112R979 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3108R978,
										 r_PackedHalf2AtPtx3006R956); // PTX L3112
	r_PackedHalf2AtPtx3116R980 = HalfFma(r_PackedHalf2AtPtx3104R977, r_PackedHalf2AtPtx3112R979,
										 r_PackedHalf2AtPtx2999R958); // PTX L3116
	r_PackedHalf2AtPtx3120R1184 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2876R975, r_PackedHalf2AtPtx3116R980); // PTX L3120
	r_LaneIndexAtPtx3124 = uint32_t((threadIdx.x & 31u));							 // PTX L3124
	r_PackedHalf2AtPtx3127R983 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2883R982, r_PackedHalf2AtPtx2992R950);			  // PTX L3127
	r_PackedHalf2AtPtx3131R984 = HalfMax(r_PackedHalf2AtPtx3127R983, r_PackedHalf2AtPtx2985R952); // PTX L3131
	r_PackedHalf2AtPtx3135R985 = HalfAbs(r_PackedHalf2AtPtx3131R984);							  // PTX L3135
	r_PackedHalf2AtPtx3139R986 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3135R985,
										 r_PackedHalf2AtPtx3006R956); // PTX L3139
	r_PackedHalf2AtPtx3143R987 = HalfFma(r_PackedHalf2AtPtx3131R984, r_PackedHalf2AtPtx3139R986,
										 r_PackedHalf2AtPtx2999R958); // PTX L3143
	r_PackedHalf2AtPtx3147R1185 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2883R982, r_PackedHalf2AtPtx3143R987); // PTX L3147
	r_LaneIndexAtPtx3151 = uint32_t((threadIdx.x & 31u));							 // PTX L3151
	r_PackedHalf2AtPtx3154R990 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2883R989, r_PackedHalf2AtPtx2992R950);			  // PTX L3154
	r_PackedHalf2AtPtx3158R991 = HalfMax(r_PackedHalf2AtPtx3154R990, r_PackedHalf2AtPtx2985R952); // PTX L3158
	r_PackedHalf2AtPtx3162R992 = HalfAbs(r_PackedHalf2AtPtx3158R991);							  // PTX L3162
	r_PackedHalf2AtPtx3166R993 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3162R992,
										 r_PackedHalf2AtPtx3006R956); // PTX L3166
	r_PackedHalf2AtPtx3170R994 = HalfFma(r_PackedHalf2AtPtx3158R991, r_PackedHalf2AtPtx3166R993,
										 r_PackedHalf2AtPtx2999R958); // PTX L3170
	r_PackedHalf2AtPtx3174R1187 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2883R989, r_PackedHalf2AtPtx3170R994); // PTX L3174
	r_LaneIndexAtPtx3178 = uint32_t((threadIdx.x & 31u));							 // PTX L3178
	r_PackedHalf2AtPtx3181R997 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2890R996, r_PackedHalf2AtPtx2992R950);			  // PTX L3181
	r_PackedHalf2AtPtx3185R998 = HalfMax(r_PackedHalf2AtPtx3181R997, r_PackedHalf2AtPtx2985R952); // PTX L3185
	r_PackedHalf2AtPtx3189R999 = HalfAbs(r_PackedHalf2AtPtx3185R998);							  // PTX L3189
	r_PackedHalf2AtPtx3193R1000 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3189R999,
										  r_PackedHalf2AtPtx3006R956); // PTX L3193
	r_PackedHalf2AtPtx3197R1001 = HalfFma(r_PackedHalf2AtPtx3185R998, r_PackedHalf2AtPtx3193R1000,
										  r_PackedHalf2AtPtx2999R958); // PTX L3197
	r_PackedHalf2AtPtx3201R1186 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2890R996, r_PackedHalf2AtPtx3197R1001); // PTX L3201
	r_LaneIndexAtPtx3205 = uint32_t((threadIdx.x & 31u));							  // PTX L3205
	r_PackedHalf2AtPtx3208R1004 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2890R1003, r_PackedHalf2AtPtx2992R950); // PTX L3208
	r_PackedHalf2AtPtx3212R1005 =
		HalfMax(r_PackedHalf2AtPtx3208R1004, r_PackedHalf2AtPtx2985R952); // PTX L3212
	r_PackedHalf2AtPtx3216R1006 = HalfAbs(r_PackedHalf2AtPtx3212R1005);	  // PTX L3216
	r_PackedHalf2AtPtx3220R1007 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3216R1006,
										  r_PackedHalf2AtPtx3006R956); // PTX L3220
	r_PackedHalf2AtPtx3224R1008 = HalfFma(r_PackedHalf2AtPtx3212R1005, r_PackedHalf2AtPtx3220R1007,
										  r_PackedHalf2AtPtx2999R958); // PTX L3224
	r_PackedHalf2AtPtx3228R1188 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2890R1003, r_PackedHalf2AtPtx3224R1008); // PTX L3228
	r_LaneIndexAtPtx3232 = uint32_t((threadIdx.x & 31u));							   // PTX L3232
	r_PackedHalf2AtPtx3235R1011 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2897R1010, r_PackedHalf2AtPtx2992R950); // PTX L3235
	r_PackedHalf2AtPtx3239R1012 =
		HalfMax(r_PackedHalf2AtPtx3235R1011, r_PackedHalf2AtPtx2985R952); // PTX L3239
	r_PackedHalf2AtPtx3243R1013 = HalfAbs(r_PackedHalf2AtPtx3239R1012);	  // PTX L3243
	r_PackedHalf2AtPtx3247R1014 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3243R1013,
										  r_PackedHalf2AtPtx3006R956); // PTX L3247
	r_PackedHalf2AtPtx3251R1015 = HalfFma(r_PackedHalf2AtPtx3239R1012, r_PackedHalf2AtPtx3247R1014,
										  r_PackedHalf2AtPtx2999R958); // PTX L3251
	r_PackedHalf2AtPtx3255R1189 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2897R1010, r_PackedHalf2AtPtx3251R1015); // PTX L3255
	r_LaneIndexAtPtx3259 = uint32_t((threadIdx.x & 31u));							   // PTX L3259
	r_PackedHalf2AtPtx3262R1018 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2897R1017, r_PackedHalf2AtPtx2992R950); // PTX L3262
	r_PackedHalf2AtPtx3266R1019 =
		HalfMax(r_PackedHalf2AtPtx3262R1018, r_PackedHalf2AtPtx2985R952); // PTX L3266
	r_PackedHalf2AtPtx3270R1020 = HalfAbs(r_PackedHalf2AtPtx3266R1019);	  // PTX L3270
	r_PackedHalf2AtPtx3274R1021 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3270R1020,
										  r_PackedHalf2AtPtx3006R956); // PTX L3274
	r_PackedHalf2AtPtx3278R1022 = HalfFma(r_PackedHalf2AtPtx3266R1019, r_PackedHalf2AtPtx3274R1021,
										  r_PackedHalf2AtPtx2999R958); // PTX L3278
	r_PackedHalf2AtPtx3282R1191 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2897R1017, r_PackedHalf2AtPtx3278R1022); // PTX L3282
	r_LaneIndexAtPtx3286 = uint32_t((threadIdx.x & 31u));							   // PTX L3286
	r_PackedHalf2AtPtx3289R1025 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2904R1024, r_PackedHalf2AtPtx2992R950); // PTX L3289
	r_PackedHalf2AtPtx3293R1026 =
		HalfMax(r_PackedHalf2AtPtx3289R1025, r_PackedHalf2AtPtx2985R952); // PTX L3293
	r_PackedHalf2AtPtx3297R1027 = HalfAbs(r_PackedHalf2AtPtx3293R1026);	  // PTX L3297
	r_PackedHalf2AtPtx3301R1028 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3297R1027,
										  r_PackedHalf2AtPtx3006R956); // PTX L3301
	r_PackedHalf2AtPtx3305R1029 = HalfFma(r_PackedHalf2AtPtx3293R1026, r_PackedHalf2AtPtx3301R1028,
										  r_PackedHalf2AtPtx2999R958); // PTX L3305
	r_PackedHalf2AtPtx3309R1190 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2904R1024, r_PackedHalf2AtPtx3305R1029); // PTX L3309
	r_LaneIndexAtPtx3313 = uint32_t((threadIdx.x & 31u));							   // PTX L3313
	r_PackedHalf2AtPtx3316R1032 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2904R1031, r_PackedHalf2AtPtx2992R950); // PTX L3316
	r_PackedHalf2AtPtx3320R1033 =
		HalfMax(r_PackedHalf2AtPtx3316R1032, r_PackedHalf2AtPtx2985R952); // PTX L3320
	r_PackedHalf2AtPtx3324R1034 = HalfAbs(r_PackedHalf2AtPtx3320R1033);	  // PTX L3324
	r_PackedHalf2AtPtx3328R1035 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3324R1034,
										  r_PackedHalf2AtPtx3006R956); // PTX L3328
	r_PackedHalf2AtPtx3332R1036 = HalfFma(r_PackedHalf2AtPtx3320R1033, r_PackedHalf2AtPtx3328R1035,
										  r_PackedHalf2AtPtx2999R958); // PTX L3332
	r_PackedHalf2AtPtx3336R1192 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2904R1031, r_PackedHalf2AtPtx3332R1036); // PTX L3336
	r_LaneIndexAtPtx3340 = uint32_t((threadIdx.x & 31u));							   // PTX L3340
	r_PackedHalf2AtPtx3343R1039 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2911R1038, r_PackedHalf2AtPtx2992R950); // PTX L3343
	r_PackedHalf2AtPtx3347R1040 =
		HalfMax(r_PackedHalf2AtPtx3343R1039, r_PackedHalf2AtPtx2985R952); // PTX L3347
	r_PackedHalf2AtPtx3351R1041 = HalfAbs(r_PackedHalf2AtPtx3347R1040);	  // PTX L3351
	r_PackedHalf2AtPtx3355R1042 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3351R1041,
										  r_PackedHalf2AtPtx3006R956); // PTX L3355
	r_PackedHalf2AtPtx3359R1043 = HalfFma(r_PackedHalf2AtPtx3347R1040, r_PackedHalf2AtPtx3355R1042,
										  r_PackedHalf2AtPtx2999R958); // PTX L3359
	r_PackedHalf2AtPtx3363R1193 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2911R1038, r_PackedHalf2AtPtx3359R1043); // PTX L3363
	r_LaneIndexAtPtx3367 = uint32_t((threadIdx.x & 31u));							   // PTX L3367
	r_PackedHalf2AtPtx3370R1046 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2911R1045, r_PackedHalf2AtPtx2992R950); // PTX L3370
	r_PackedHalf2AtPtx3374R1047 =
		HalfMax(r_PackedHalf2AtPtx3370R1046, r_PackedHalf2AtPtx2985R952); // PTX L3374
	r_PackedHalf2AtPtx3378R1048 = HalfAbs(r_PackedHalf2AtPtx3374R1047);	  // PTX L3378
	r_PackedHalf2AtPtx3382R1049 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3378R1048,
										  r_PackedHalf2AtPtx3006R956); // PTX L3382
	r_PackedHalf2AtPtx3386R1050 = HalfFma(r_PackedHalf2AtPtx3374R1047, r_PackedHalf2AtPtx3382R1049,
										  r_PackedHalf2AtPtx2999R958); // PTX L3386
	r_PackedHalf2AtPtx3390R1195 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2911R1045, r_PackedHalf2AtPtx3386R1050); // PTX L3390
	r_LaneIndexAtPtx3394 = uint32_t((threadIdx.x & 31u));							   // PTX L3394
	r_PackedHalf2AtPtx3397R1053 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2918R1052, r_PackedHalf2AtPtx2992R950); // PTX L3397
	r_PackedHalf2AtPtx3401R1054 =
		HalfMax(r_PackedHalf2AtPtx3397R1053, r_PackedHalf2AtPtx2985R952); // PTX L3401
	r_PackedHalf2AtPtx3405R1055 = HalfAbs(r_PackedHalf2AtPtx3401R1054);	  // PTX L3405
	r_PackedHalf2AtPtx3409R1056 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3405R1055,
										  r_PackedHalf2AtPtx3006R956); // PTX L3409
	r_PackedHalf2AtPtx3413R1057 = HalfFma(r_PackedHalf2AtPtx3401R1054, r_PackedHalf2AtPtx3409R1056,
										  r_PackedHalf2AtPtx2999R958); // PTX L3413
	r_PackedHalf2AtPtx3417R1194 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2918R1052, r_PackedHalf2AtPtx3413R1057); // PTX L3417
	r_LaneIndexAtPtx3421 = uint32_t((threadIdx.x & 31u));							   // PTX L3421
	r_PackedHalf2AtPtx3424R1060 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2918R1059, r_PackedHalf2AtPtx2992R950); // PTX L3424
	r_PackedHalf2AtPtx3428R1061 =
		HalfMax(r_PackedHalf2AtPtx3424R1060, r_PackedHalf2AtPtx2985R952); // PTX L3428
	r_PackedHalf2AtPtx3432R1062 = HalfAbs(r_PackedHalf2AtPtx3428R1061);	  // PTX L3432
	r_PackedHalf2AtPtx3436R1063 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3432R1062,
										  r_PackedHalf2AtPtx3006R956); // PTX L3436
	r_PackedHalf2AtPtx3440R1064 = HalfFma(r_PackedHalf2AtPtx3428R1061, r_PackedHalf2AtPtx3436R1063,
										  r_PackedHalf2AtPtx2999R958); // PTX L3440
	r_PackedHalf2AtPtx3444R1196 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2918R1059, r_PackedHalf2AtPtx3440R1064); // PTX L3444
	r_LaneIndexAtPtx3448 = uint32_t((threadIdx.x & 31u));							   // PTX L3448
	r_PackedHalf2AtPtx3451R1067 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2925R1066, r_PackedHalf2AtPtx2992R950); // PTX L3451
	r_PackedHalf2AtPtx3455R1068 =
		HalfMax(r_PackedHalf2AtPtx3451R1067, r_PackedHalf2AtPtx2985R952); // PTX L3455
	r_PackedHalf2AtPtx3459R1069 = HalfAbs(r_PackedHalf2AtPtx3455R1068);	  // PTX L3459
	r_PackedHalf2AtPtx3463R1070 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3459R1069,
										  r_PackedHalf2AtPtx3006R956); // PTX L3463
	r_PackedHalf2AtPtx3467R1071 = HalfFma(r_PackedHalf2AtPtx3455R1068, r_PackedHalf2AtPtx3463R1070,
										  r_PackedHalf2AtPtx2999R958); // PTX L3467
	r_PackedHalf2AtPtx3471R1197 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2925R1066, r_PackedHalf2AtPtx3467R1071); // PTX L3471
	r_LaneIndexAtPtx3475 = uint32_t((threadIdx.x & 31u));							   // PTX L3475
	r_PackedHalf2AtPtx3478R1074 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2925R1073, r_PackedHalf2AtPtx2992R950); // PTX L3478
	r_PackedHalf2AtPtx3482R1075 =
		HalfMax(r_PackedHalf2AtPtx3478R1074, r_PackedHalf2AtPtx2985R952); // PTX L3482
	r_PackedHalf2AtPtx3486R1076 = HalfAbs(r_PackedHalf2AtPtx3482R1075);	  // PTX L3486
	r_PackedHalf2AtPtx3490R1077 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3486R1076,
										  r_PackedHalf2AtPtx3006R956); // PTX L3490
	r_PackedHalf2AtPtx3494R1078 = HalfFma(r_PackedHalf2AtPtx3482R1075, r_PackedHalf2AtPtx3490R1077,
										  r_PackedHalf2AtPtx2999R958); // PTX L3494
	r_PackedHalf2AtPtx3498R1199 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2925R1073, r_PackedHalf2AtPtx3494R1078); // PTX L3498
	r_LaneIndexAtPtx3502 = uint32_t((threadIdx.x & 31u));							   // PTX L3502
	r_PackedHalf2AtPtx3505R1081 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2932R1080, r_PackedHalf2AtPtx2992R950); // PTX L3505
	r_PackedHalf2AtPtx3509R1082 =
		HalfMax(r_PackedHalf2AtPtx3505R1081, r_PackedHalf2AtPtx2985R952); // PTX L3509
	r_PackedHalf2AtPtx3513R1083 = HalfAbs(r_PackedHalf2AtPtx3509R1082);	  // PTX L3513
	r_PackedHalf2AtPtx3517R1084 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3513R1083,
										  r_PackedHalf2AtPtx3006R956); // PTX L3517
	r_PackedHalf2AtPtx3521R1085 = HalfFma(r_PackedHalf2AtPtx3509R1082, r_PackedHalf2AtPtx3517R1084,
										  r_PackedHalf2AtPtx2999R958); // PTX L3521
	r_PackedHalf2AtPtx3525R1198 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2932R1080, r_PackedHalf2AtPtx3521R1085); // PTX L3525
	r_LaneIndexAtPtx3529 = uint32_t((threadIdx.x & 31u));							   // PTX L3529
	r_PackedHalf2AtPtx3532R1088 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2932R1087, r_PackedHalf2AtPtx2992R950); // PTX L3532
	r_PackedHalf2AtPtx3536R1089 =
		HalfMax(r_PackedHalf2AtPtx3532R1088, r_PackedHalf2AtPtx2985R952); // PTX L3536
	r_PackedHalf2AtPtx3540R1090 = HalfAbs(r_PackedHalf2AtPtx3536R1089);	  // PTX L3540
	r_PackedHalf2AtPtx3544R1091 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3540R1090,
										  r_PackedHalf2AtPtx3006R956); // PTX L3544
	r_PackedHalf2AtPtx3548R1092 = HalfFma(r_PackedHalf2AtPtx3536R1089, r_PackedHalf2AtPtx3544R1091,
										  r_PackedHalf2AtPtx2999R958); // PTX L3548
	r_PackedHalf2AtPtx3552R1200 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2932R1087, r_PackedHalf2AtPtx3548R1092); // PTX L3552
	r_LaneIndexAtPtx3556 = uint32_t((threadIdx.x & 31u));							   // PTX L3556
	r_PackedHalf2AtPtx3559R1095 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2939R1094, r_PackedHalf2AtPtx2992R950); // PTX L3559
	r_PackedHalf2AtPtx3563R1096 =
		HalfMax(r_PackedHalf2AtPtx3559R1095, r_PackedHalf2AtPtx2985R952); // PTX L3563
	r_PackedHalf2AtPtx3567R1097 = HalfAbs(r_PackedHalf2AtPtx3563R1096);	  // PTX L3567
	r_PackedHalf2AtPtx3571R1098 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3567R1097,
										  r_PackedHalf2AtPtx3006R956); // PTX L3571
	r_PackedHalf2AtPtx3575R1099 = HalfFma(r_PackedHalf2AtPtx3563R1096, r_PackedHalf2AtPtx3571R1098,
										  r_PackedHalf2AtPtx2999R958); // PTX L3575
	r_PackedHalf2AtPtx3579R1201 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2939R1094, r_PackedHalf2AtPtx3575R1099); // PTX L3579
	r_LaneIndexAtPtx3583 = uint32_t((threadIdx.x & 31u));							   // PTX L3583
	r_PackedHalf2AtPtx3586R1102 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2939R1101, r_PackedHalf2AtPtx2992R950); // PTX L3586
	r_PackedHalf2AtPtx3590R1103 =
		HalfMax(r_PackedHalf2AtPtx3586R1102, r_PackedHalf2AtPtx2985R952); // PTX L3590
	r_PackedHalf2AtPtx3594R1104 = HalfAbs(r_PackedHalf2AtPtx3590R1103);	  // PTX L3594
	r_PackedHalf2AtPtx3598R1105 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3594R1104,
										  r_PackedHalf2AtPtx3006R956); // PTX L3598
	r_PackedHalf2AtPtx3602R1106 = HalfFma(r_PackedHalf2AtPtx3590R1103, r_PackedHalf2AtPtx3598R1105,
										  r_PackedHalf2AtPtx2999R958); // PTX L3602
	r_PackedHalf2AtPtx3606R1203 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2939R1101, r_PackedHalf2AtPtx3602R1106); // PTX L3606
	r_LaneIndexAtPtx3610 = uint32_t((threadIdx.x & 31u));							   // PTX L3610
	r_PackedHalf2AtPtx3613R1109 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2946R1108, r_PackedHalf2AtPtx2992R950); // PTX L3613
	r_PackedHalf2AtPtx3617R1110 =
		HalfMax(r_PackedHalf2AtPtx3613R1109, r_PackedHalf2AtPtx2985R952); // PTX L3617
	r_PackedHalf2AtPtx3621R1111 = HalfAbs(r_PackedHalf2AtPtx3617R1110);	  // PTX L3621
	r_PackedHalf2AtPtx3625R1112 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3621R1111,
										  r_PackedHalf2AtPtx3006R956); // PTX L3625
	r_PackedHalf2AtPtx3629R1113 = HalfFma(r_PackedHalf2AtPtx3617R1110, r_PackedHalf2AtPtx3625R1112,
										  r_PackedHalf2AtPtx2999R958); // PTX L3629
	r_PackedHalf2AtPtx3633R1202 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2946R1108, r_PackedHalf2AtPtx3629R1113); // PTX L3633
	r_LaneIndexAtPtx3637 = uint32_t((threadIdx.x & 31u));							   // PTX L3637
	r_PackedHalf2AtPtx3640R1116 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2946R1115, r_PackedHalf2AtPtx2992R950); // PTX L3640
	r_PackedHalf2AtPtx3644R1117 =
		HalfMax(r_PackedHalf2AtPtx3640R1116, r_PackedHalf2AtPtx2985R952); // PTX L3644
	r_PackedHalf2AtPtx3648R1118 = HalfAbs(r_PackedHalf2AtPtx3644R1117);	  // PTX L3648
	r_PackedHalf2AtPtx3652R1119 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3648R1118,
										  r_PackedHalf2AtPtx3006R956); // PTX L3652
	r_PackedHalf2AtPtx3656R1120 = HalfFma(r_PackedHalf2AtPtx3644R1117, r_PackedHalf2AtPtx3652R1119,
										  r_PackedHalf2AtPtx2999R958); // PTX L3656
	r_PackedHalf2AtPtx3660R1204 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2946R1115, r_PackedHalf2AtPtx3656R1120); // PTX L3660
	r_LaneIndexAtPtx3664 = uint32_t((threadIdx.x & 31u));							   // PTX L3664
	r_PackedHalf2AtPtx3667R1123 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2953R1122, r_PackedHalf2AtPtx2992R950); // PTX L3667
	r_PackedHalf2AtPtx3671R1124 =
		HalfMax(r_PackedHalf2AtPtx3667R1123, r_PackedHalf2AtPtx2985R952); // PTX L3671
	r_PackedHalf2AtPtx3675R1125 = HalfAbs(r_PackedHalf2AtPtx3671R1124);	  // PTX L3675
	r_PackedHalf2AtPtx3679R1126 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3675R1125,
										  r_PackedHalf2AtPtx3006R956); // PTX L3679
	r_PackedHalf2AtPtx3683R1127 = HalfFma(r_PackedHalf2AtPtx3671R1124, r_PackedHalf2AtPtx3679R1126,
										  r_PackedHalf2AtPtx2999R958); // PTX L3683
	r_PackedHalf2AtPtx3687R1205 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2953R1122, r_PackedHalf2AtPtx3683R1127); // PTX L3687
	r_LaneIndexAtPtx3691 = uint32_t((threadIdx.x & 31u));							   // PTX L3691
	r_PackedHalf2AtPtx3694R1130 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2953R1129, r_PackedHalf2AtPtx2992R950); // PTX L3694
	r_PackedHalf2AtPtx3698R1131 =
		HalfMax(r_PackedHalf2AtPtx3694R1130, r_PackedHalf2AtPtx2985R952); // PTX L3698
	r_PackedHalf2AtPtx3702R1132 = HalfAbs(r_PackedHalf2AtPtx3698R1131);	  // PTX L3702
	r_PackedHalf2AtPtx3706R1133 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3702R1132,
										  r_PackedHalf2AtPtx3006R956); // PTX L3706
	r_PackedHalf2AtPtx3710R1134 = HalfFma(r_PackedHalf2AtPtx3698R1131, r_PackedHalf2AtPtx3706R1133,
										  r_PackedHalf2AtPtx2999R958); // PTX L3710
	r_PackedHalf2AtPtx3714R1207 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2953R1129, r_PackedHalf2AtPtx3710R1134); // PTX L3714
	r_LaneIndexAtPtx3718 = uint32_t((threadIdx.x & 31u));							   // PTX L3718
	r_PackedHalf2AtPtx3721R1137 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2960R1136, r_PackedHalf2AtPtx2992R950); // PTX L3721
	r_PackedHalf2AtPtx3725R1138 =
		HalfMax(r_PackedHalf2AtPtx3721R1137, r_PackedHalf2AtPtx2985R952); // PTX L3725
	r_PackedHalf2AtPtx3729R1139 = HalfAbs(r_PackedHalf2AtPtx3725R1138);	  // PTX L3729
	r_PackedHalf2AtPtx3733R1140 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3729R1139,
										  r_PackedHalf2AtPtx3006R956); // PTX L3733
	r_PackedHalf2AtPtx3737R1141 = HalfFma(r_PackedHalf2AtPtx3725R1138, r_PackedHalf2AtPtx3733R1140,
										  r_PackedHalf2AtPtx2999R958); // PTX L3737
	r_PackedHalf2AtPtx3741R1206 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2960R1136, r_PackedHalf2AtPtx3737R1141); // PTX L3741
	r_LaneIndexAtPtx3745 = uint32_t((threadIdx.x & 31u));							   // PTX L3745
	r_PackedHalf2AtPtx3748R1144 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2960R1143, r_PackedHalf2AtPtx2992R950); // PTX L3748
	r_PackedHalf2AtPtx3752R1145 =
		HalfMax(r_PackedHalf2AtPtx3748R1144, r_PackedHalf2AtPtx2985R952); // PTX L3752
	r_PackedHalf2AtPtx3756R1146 = HalfAbs(r_PackedHalf2AtPtx3752R1145);	  // PTX L3756
	r_PackedHalf2AtPtx3760R1147 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3756R1146,
										  r_PackedHalf2AtPtx3006R956); // PTX L3760
	r_PackedHalf2AtPtx3764R1148 = HalfFma(r_PackedHalf2AtPtx3752R1145, r_PackedHalf2AtPtx3760R1147,
										  r_PackedHalf2AtPtx2999R958); // PTX L3764
	r_PackedHalf2AtPtx3768R1208 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2960R1143, r_PackedHalf2AtPtx3764R1148); // PTX L3768
	r_LaneIndexAtPtx3772 = uint32_t((threadIdx.x & 31u));							   // PTX L3772
	r_PackedHalf2AtPtx3775R1151 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2967R1150, r_PackedHalf2AtPtx2992R950); // PTX L3775
	r_PackedHalf2AtPtx3779R1152 =
		HalfMax(r_PackedHalf2AtPtx3775R1151, r_PackedHalf2AtPtx2985R952); // PTX L3779
	r_PackedHalf2AtPtx3783R1153 = HalfAbs(r_PackedHalf2AtPtx3779R1152);	  // PTX L3783
	r_PackedHalf2AtPtx3787R1154 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3783R1153,
										  r_PackedHalf2AtPtx3006R956); // PTX L3787
	r_PackedHalf2AtPtx3791R1155 = HalfFma(r_PackedHalf2AtPtx3779R1152, r_PackedHalf2AtPtx3787R1154,
										  r_PackedHalf2AtPtx2999R958); // PTX L3791
	r_PackedHalf2AtPtx3795R1209 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2967R1150, r_PackedHalf2AtPtx3791R1155); // PTX L3795
	r_LaneIndexAtPtx3799 = uint32_t((threadIdx.x & 31u));							   // PTX L3799
	r_PackedHalf2AtPtx3802R1158 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2967R1157, r_PackedHalf2AtPtx2992R950); // PTX L3802
	r_PackedHalf2AtPtx3806R1159 =
		HalfMax(r_PackedHalf2AtPtx3802R1158, r_PackedHalf2AtPtx2985R952); // PTX L3806
	r_PackedHalf2AtPtx3810R1160 = HalfAbs(r_PackedHalf2AtPtx3806R1159);	  // PTX L3810
	r_PackedHalf2AtPtx3814R1161 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3810R1160,
										  r_PackedHalf2AtPtx3006R956); // PTX L3814
	r_PackedHalf2AtPtx3818R1162 = HalfFma(r_PackedHalf2AtPtx3806R1159, r_PackedHalf2AtPtx3814R1161,
										  r_PackedHalf2AtPtx2999R958); // PTX L3818
	r_PackedHalf2AtPtx3822R1211 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2967R1157, r_PackedHalf2AtPtx3818R1162); // PTX L3822
	r_LaneIndexAtPtx3826 = uint32_t((threadIdx.x & 31u));							   // PTX L3826
	r_PackedHalf2AtPtx3829R1165 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2974R1164, r_PackedHalf2AtPtx2992R950); // PTX L3829
	r_PackedHalf2AtPtx3833R1166 =
		HalfMax(r_PackedHalf2AtPtx3829R1165, r_PackedHalf2AtPtx2985R952); // PTX L3833
	r_PackedHalf2AtPtx3837R1167 = HalfAbs(r_PackedHalf2AtPtx3833R1166);	  // PTX L3837
	r_PackedHalf2AtPtx3841R1168 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3837R1167,
										  r_PackedHalf2AtPtx3006R956); // PTX L3841
	r_PackedHalf2AtPtx3845R1169 = HalfFma(r_PackedHalf2AtPtx3833R1166, r_PackedHalf2AtPtx3841R1168,
										  r_PackedHalf2AtPtx2999R958); // PTX L3845
	r_PackedHalf2AtPtx3849R1210 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2974R1164, r_PackedHalf2AtPtx3845R1169); // PTX L3849
	r_LaneIndexAtPtx3853 = uint32_t((threadIdx.x & 31u));							   // PTX L3853
	r_PackedHalf2AtPtx3856R1172 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx2974R1171, r_PackedHalf2AtPtx2992R950); // PTX L3856
	r_PackedHalf2AtPtx3860R1173 =
		HalfMax(r_PackedHalf2AtPtx3856R1172, r_PackedHalf2AtPtx2985R952); // PTX L3860
	r_PackedHalf2AtPtx3864R1174 = HalfAbs(r_PackedHalf2AtPtx3860R1173);	  // PTX L3864
	r_PackedHalf2AtPtx3868R1175 = HalfFma(r_PackedHalf2AtPtx3013R954, r_PackedHalf2AtPtx3864R1174,
										  r_PackedHalf2AtPtx3006R956); // PTX L3868
	r_PackedHalf2AtPtx3872R1176 = HalfFma(r_PackedHalf2AtPtx3860R1173, r_PackedHalf2AtPtx3868R1175,
										  r_PackedHalf2AtPtx2999R958); // PTX L3872
	r_PackedHalf2AtPtx3876R1212 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx2974R1171, r_PackedHalf2AtPtx3872R1176); // PTX L3876
	r_LaneIndexAtPtx3880 = uint32_t((threadIdx.x & 31u));							   // PTX L3880
	r_PtxU64Register152 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3880)) * int64_t(int32_t(16)));		 // PTX L3882
	r_PtxU64Register153 = uint64_t(r_PtxU64Register200) + uint64_t(r_PtxU64Register152); // PTX L3883
	r_PtxU64Register142 = uint64_t(r_PtxU64Register153) + uint64_t(-1536);				 // PTX L3884
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register142));
		r_MmaBE4x4WordAtPtx3886R1213 = r_Value.x;
		r_MmaBE4x4WordAtPtx3886R1214 = r_Value.y;
		r_MmaBE4x4WordAtPtx3886R1219 = r_Value.z;
		r_MmaBE4x4WordAtPtx3886R1220 = r_Value.w;
	} // PTX L3886
	r_LaneIndexAtPtx3889 = uint32_t((threadIdx.x & 31u)); // PTX L3889
	r_PtxU64Register154 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3889)) * int64_t(int32_t(16)));		 // PTX L3891
	r_PtxU64Register155 = uint64_t(r_PtxU64Register200) + uint64_t(r_PtxU64Register154); // PTX L3892
	r_PtxU64Register143 = uint64_t(r_PtxU64Register155) + uint64_t(-1024);				 // PTX L3893
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register143));
		r_MmaBE4x4WordAtPtx3895R1221 = r_Value.x;
		r_MmaBE4x4WordAtPtx3895R1222 = r_Value.y;
		r_MmaBE4x4WordAtPtx3895R1223 = r_Value.z;
		r_MmaBE4x4WordAtPtx3895R1224 = r_Value.w;
	} // PTX L3895
	r_LaneIndexAtPtx3898 = uint32_t((threadIdx.x & 31u)); // PTX L3898
	r_PtxU64Register156 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3898)) * int64_t(int32_t(16)));		 // PTX L3900
	r_PtxU64Register157 = uint64_t(r_PtxU64Register200) + uint64_t(r_PtxU64Register156); // PTX L3901
	r_PtxU64Register144 = uint64_t(r_PtxU64Register157) + uint64_t(-512);				 // PTX L3902
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register144));
		r_MmaBE4x4WordAtPtx3904R1225 = r_Value.x;
		r_MmaBE4x4WordAtPtx3904R1226 = r_Value.y;
		r_MmaBE4x4WordAtPtx3904R1227 = r_Value.z;
		r_MmaBE4x4WordAtPtx3904R1228 = r_Value.w;
	} // PTX L3904
	r_LaneIndexAtPtx3907 = uint32_t((threadIdx.x & 31u)); // PTX L3907
	r_PtxU64Register158 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3907)) * int64_t(int32_t(16)));		 // PTX L3909
	r_PtxU64Register145 = uint64_t(r_PtxU64Register200) + uint64_t(r_PtxU64Register158); // PTX L3910
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register145));
		r_MmaBE4x4WordAtPtx3912R1229 = r_Value.x;
		r_MmaBE4x4WordAtPtx3912R1230 = r_Value.y;
		r_MmaBE4x4WordAtPtx3912R1231 = r_Value.z;
		r_MmaBE4x4WordAtPtx3912R1232 = r_Value.w;
	} // PTX L3912
	r_ConvertedE4PairAtPtx3915Rs65 = PublishE4(r_PackedHalf2AtPtx3039R1181); // PTX L3915
	r_ConvertedE4PairAtPtx3918Rs66 = PublishE4(r_PackedHalf2AtPtx3093R1182); // PTX L3918
	r_MmaAE4x4WordAtPtx3920R1215 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3915Rs65, r_ConvertedE4PairAtPtx3918Rs66); // PTX L3920
	r_ConvertedE4PairAtPtx3922Rs67 = PublishE4(r_PackedHalf2AtPtx3066R1183);		   // PTX L3922
	r_ConvertedE4PairAtPtx3925Rs68 = PublishE4(r_PackedHalf2AtPtx3120R1184);		   // PTX L3925
	r_MmaAE4x4WordAtPtx3927R1216 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3922Rs67, r_ConvertedE4PairAtPtx3925Rs68); // PTX L3927
	r_ConvertedE4PairAtPtx3929Rs69 = PublishE4(r_PackedHalf2AtPtx3147R1185);		   // PTX L3929
	r_ConvertedE4PairAtPtx3932Rs70 = PublishE4(r_PackedHalf2AtPtx3201R1186);		   // PTX L3932
	r_MmaAE4x4WordAtPtx3934R1217 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3929Rs69, r_ConvertedE4PairAtPtx3932Rs70); // PTX L3934
	r_ConvertedE4PairAtPtx3936Rs71 = PublishE4(r_PackedHalf2AtPtx3174R1187);		   // PTX L3936
	r_ConvertedE4PairAtPtx3939Rs72 = PublishE4(r_PackedHalf2AtPtx3228R1188);		   // PTX L3939
	r_MmaAE4x4WordAtPtx3941R1218 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3936Rs71, r_ConvertedE4PairAtPtx3939Rs72); // PTX L3941
	r_ConvertedE4PairAtPtx3943Rs73 = PublishE4(r_PackedHalf2AtPtx3255R1189);		   // PTX L3943
	r_ConvertedE4PairAtPtx3946Rs74 = PublishE4(r_PackedHalf2AtPtx3309R1190);		   // PTX L3946
	r_MmaAE4x4WordAtPtx3948R1233 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3943Rs73, r_ConvertedE4PairAtPtx3946Rs74); // PTX L3948
	r_ConvertedE4PairAtPtx3950Rs75 = PublishE4(r_PackedHalf2AtPtx3282R1191);		   // PTX L3950
	r_ConvertedE4PairAtPtx3953Rs76 = PublishE4(r_PackedHalf2AtPtx3336R1192);		   // PTX L3953
	r_MmaAE4x4WordAtPtx3955R1234 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3950Rs75, r_ConvertedE4PairAtPtx3953Rs76); // PTX L3955
	r_ConvertedE4PairAtPtx3957Rs77 = PublishE4(r_PackedHalf2AtPtx3363R1193);		   // PTX L3957
	r_ConvertedE4PairAtPtx3960Rs78 = PublishE4(r_PackedHalf2AtPtx3417R1194);		   // PTX L3960
	r_MmaAE4x4WordAtPtx3962R1235 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3957Rs77, r_ConvertedE4PairAtPtx3960Rs78); // PTX L3962
	r_ConvertedE4PairAtPtx3964Rs79 = PublishE4(r_PackedHalf2AtPtx3390R1195);		   // PTX L3964
	r_ConvertedE4PairAtPtx3967Rs80 = PublishE4(r_PackedHalf2AtPtx3444R1196);		   // PTX L3967
	r_MmaAE4x4WordAtPtx3969R1236 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3964Rs79, r_ConvertedE4PairAtPtx3967Rs80); // PTX L3969
	r_ConvertedE4PairAtPtx3971Rs81 = PublishE4(r_PackedHalf2AtPtx3471R1197);		   // PTX L3971
	r_ConvertedE4PairAtPtx3974Rs82 = PublishE4(r_PackedHalf2AtPtx3525R1198);		   // PTX L3974
	r_MmaAE4x4WordAtPtx3976R1237 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3971Rs81, r_ConvertedE4PairAtPtx3974Rs82); // PTX L3976
	r_ConvertedE4PairAtPtx3978Rs83 = PublishE4(r_PackedHalf2AtPtx3498R1199);		   // PTX L3978
	r_ConvertedE4PairAtPtx3981Rs84 = PublishE4(r_PackedHalf2AtPtx3552R1200);		   // PTX L3981
	r_MmaAE4x4WordAtPtx3983R1238 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3978Rs83, r_ConvertedE4PairAtPtx3981Rs84); // PTX L3983
	r_ConvertedE4PairAtPtx3985Rs85 = PublishE4(r_PackedHalf2AtPtx3579R1201);		   // PTX L3985
	r_ConvertedE4PairAtPtx3988Rs86 = PublishE4(r_PackedHalf2AtPtx3633R1202);		   // PTX L3988
	r_MmaAE4x4WordAtPtx3990R1239 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3985Rs85, r_ConvertedE4PairAtPtx3988Rs86); // PTX L3990
	r_ConvertedE4PairAtPtx3992Rs87 = PublishE4(r_PackedHalf2AtPtx3606R1203);		   // PTX L3992
	r_ConvertedE4PairAtPtx3995Rs88 = PublishE4(r_PackedHalf2AtPtx3660R1204);		   // PTX L3995
	r_MmaAE4x4WordAtPtx3997R1240 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3992Rs87, r_ConvertedE4PairAtPtx3995Rs88); // PTX L3997
	r_ConvertedE4PairAtPtx3999Rs89 = PublishE4(r_PackedHalf2AtPtx3687R1205);		   // PTX L3999
	r_ConvertedE4PairAtPtx4002Rs90 = PublishE4(r_PackedHalf2AtPtx3741R1206);		   // PTX L4002
	r_MmaAE4x4WordAtPtx4004R1241 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3999Rs89, r_ConvertedE4PairAtPtx4002Rs90); // PTX L4004
	r_ConvertedE4PairAtPtx4006Rs91 = PublishE4(r_PackedHalf2AtPtx3714R1207);		   // PTX L4006
	r_ConvertedE4PairAtPtx4009Rs92 = PublishE4(r_PackedHalf2AtPtx3768R1208);		   // PTX L4009
	r_MmaAE4x4WordAtPtx4011R1242 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4006Rs91, r_ConvertedE4PairAtPtx4009Rs92); // PTX L4011
	r_ConvertedE4PairAtPtx4013Rs93 = PublishE4(r_PackedHalf2AtPtx3795R1209);		   // PTX L4013
	r_ConvertedE4PairAtPtx4016Rs94 = PublishE4(r_PackedHalf2AtPtx3849R1210);		   // PTX L4016
	r_MmaAE4x4WordAtPtx4018R1243 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4013Rs93, r_ConvertedE4PairAtPtx4016Rs94); // PTX L4018
	r_ConvertedE4PairAtPtx4020Rs95 = PublishE4(r_PackedHalf2AtPtx3822R1211);		   // PTX L4020
	r_ConvertedE4PairAtPtx4023Rs96 = PublishE4(r_PackedHalf2AtPtx3876R1212);		   // PTX L4023
	r_MmaAE4x4WordAtPtx4025R1244 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4020Rs95, r_ConvertedE4PairAtPtx4023Rs96); // PTX L4025
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2433R1396, r_MmaAccumulatorHalf2WordAtPtx2434R1397,
		  r_MmaAE4x4WordAtPtx3920R1215, r_MmaAE4x4WordAtPtx3927R1216, r_MmaAE4x4WordAtPtx3934R1217,
		  r_MmaAE4x4WordAtPtx3941R1218, r_MmaBE4x4WordAtPtx3886R1213, r_MmaBE4x4WordAtPtx3886R1214,
		  r_MmaAccumulatorHalf2WordAtPtx2433R1396,
		  r_MmaAccumulatorHalf2WordAtPtx2434R1397); // PTX L4027
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2435R1398, r_MmaAccumulatorHalf2WordAtPtx2436R1399,
		  r_MmaAE4x4WordAtPtx3920R1215, r_MmaAE4x4WordAtPtx3927R1216, r_MmaAE4x4WordAtPtx3934R1217,
		  r_MmaAE4x4WordAtPtx3941R1218, r_MmaBE4x4WordAtPtx3886R1219, r_MmaBE4x4WordAtPtx3886R1220,
		  r_MmaAccumulatorHalf2WordAtPtx2435R1398,
		  r_MmaAccumulatorHalf2WordAtPtx2436R1399); // PTX L4034
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2437R1400, r_MmaAccumulatorHalf2WordAtPtx2438R1401,
		  r_MmaAE4x4WordAtPtx3920R1215, r_MmaAE4x4WordAtPtx3927R1216, r_MmaAE4x4WordAtPtx3934R1217,
		  r_MmaAE4x4WordAtPtx3941R1218, r_MmaBE4x4WordAtPtx3895R1221, r_MmaBE4x4WordAtPtx3895R1222,
		  r_MmaAccumulatorHalf2WordAtPtx2437R1400,
		  r_MmaAccumulatorHalf2WordAtPtx2438R1401); // PTX L4041
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2439R1402, r_MmaAccumulatorHalf2WordAtPtx2440R1403,
		  r_MmaAE4x4WordAtPtx3920R1215, r_MmaAE4x4WordAtPtx3927R1216, r_MmaAE4x4WordAtPtx3934R1217,
		  r_MmaAE4x4WordAtPtx3941R1218, r_MmaBE4x4WordAtPtx3895R1223, r_MmaBE4x4WordAtPtx3895R1224,
		  r_MmaAccumulatorHalf2WordAtPtx2439R1402,
		  r_MmaAccumulatorHalf2WordAtPtx2440R1403); // PTX L4048
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2441R1404, r_MmaAccumulatorHalf2WordAtPtx2442R1405,
		  r_MmaAE4x4WordAtPtx3920R1215, r_MmaAE4x4WordAtPtx3927R1216, r_MmaAE4x4WordAtPtx3934R1217,
		  r_MmaAE4x4WordAtPtx3941R1218, r_MmaBE4x4WordAtPtx3904R1225, r_MmaBE4x4WordAtPtx3904R1226,
		  r_MmaAccumulatorHalf2WordAtPtx2441R1404,
		  r_MmaAccumulatorHalf2WordAtPtx2442R1405); // PTX L4055
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2443R1406, r_MmaAccumulatorHalf2WordAtPtx2444R1407,
		  r_MmaAE4x4WordAtPtx3920R1215, r_MmaAE4x4WordAtPtx3927R1216, r_MmaAE4x4WordAtPtx3934R1217,
		  r_MmaAE4x4WordAtPtx3941R1218, r_MmaBE4x4WordAtPtx3904R1227, r_MmaBE4x4WordAtPtx3904R1228,
		  r_MmaAccumulatorHalf2WordAtPtx2443R1406,
		  r_MmaAccumulatorHalf2WordAtPtx2444R1407); // PTX L4062
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2445R1408, r_MmaAccumulatorHalf2WordAtPtx2446R1409,
		  r_MmaAE4x4WordAtPtx3920R1215, r_MmaAE4x4WordAtPtx3927R1216, r_MmaAE4x4WordAtPtx3934R1217,
		  r_MmaAE4x4WordAtPtx3941R1218, r_MmaBE4x4WordAtPtx3912R1229, r_MmaBE4x4WordAtPtx3912R1230,
		  r_MmaAccumulatorHalf2WordAtPtx2445R1408,
		  r_MmaAccumulatorHalf2WordAtPtx2446R1409); // PTX L4069
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2447R1410, r_MmaAccumulatorHalf2WordAtPtx2448R1411,
		  r_MmaAE4x4WordAtPtx3920R1215, r_MmaAE4x4WordAtPtx3927R1216, r_MmaAE4x4WordAtPtx3934R1217,
		  r_MmaAE4x4WordAtPtx3941R1218, r_MmaBE4x4WordAtPtx3912R1231, r_MmaBE4x4WordAtPtx3912R1232,
		  r_MmaAccumulatorHalf2WordAtPtx2447R1410,
		  r_MmaAccumulatorHalf2WordAtPtx2448R1411); // PTX L4076
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2449R1412, r_MmaAccumulatorHalf2WordAtPtx2450R1413,
		  r_MmaAE4x4WordAtPtx3948R1233, r_MmaAE4x4WordAtPtx3955R1234, r_MmaAE4x4WordAtPtx3962R1235,
		  r_MmaAE4x4WordAtPtx3969R1236, r_MmaBE4x4WordAtPtx3886R1213, r_MmaBE4x4WordAtPtx3886R1214,
		  r_MmaAccumulatorHalf2WordAtPtx2449R1412,
		  r_MmaAccumulatorHalf2WordAtPtx2450R1413); // PTX L4083
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2451R1414, r_MmaAccumulatorHalf2WordAtPtx2452R1415,
		  r_MmaAE4x4WordAtPtx3948R1233, r_MmaAE4x4WordAtPtx3955R1234, r_MmaAE4x4WordAtPtx3962R1235,
		  r_MmaAE4x4WordAtPtx3969R1236, r_MmaBE4x4WordAtPtx3886R1219, r_MmaBE4x4WordAtPtx3886R1220,
		  r_MmaAccumulatorHalf2WordAtPtx2451R1414,
		  r_MmaAccumulatorHalf2WordAtPtx2452R1415); // PTX L4090
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2453R1416, r_MmaAccumulatorHalf2WordAtPtx2454R1417,
		  r_MmaAE4x4WordAtPtx3948R1233, r_MmaAE4x4WordAtPtx3955R1234, r_MmaAE4x4WordAtPtx3962R1235,
		  r_MmaAE4x4WordAtPtx3969R1236, r_MmaBE4x4WordAtPtx3895R1221, r_MmaBE4x4WordAtPtx3895R1222,
		  r_MmaAccumulatorHalf2WordAtPtx2453R1416,
		  r_MmaAccumulatorHalf2WordAtPtx2454R1417); // PTX L4097
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2455R1418, r_MmaAccumulatorHalf2WordAtPtx2456R1419,
		  r_MmaAE4x4WordAtPtx3948R1233, r_MmaAE4x4WordAtPtx3955R1234, r_MmaAE4x4WordAtPtx3962R1235,
		  r_MmaAE4x4WordAtPtx3969R1236, r_MmaBE4x4WordAtPtx3895R1223, r_MmaBE4x4WordAtPtx3895R1224,
		  r_MmaAccumulatorHalf2WordAtPtx2455R1418,
		  r_MmaAccumulatorHalf2WordAtPtx2456R1419); // PTX L4104
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2457R1420, r_MmaAccumulatorHalf2WordAtPtx2458R1421,
		  r_MmaAE4x4WordAtPtx3948R1233, r_MmaAE4x4WordAtPtx3955R1234, r_MmaAE4x4WordAtPtx3962R1235,
		  r_MmaAE4x4WordAtPtx3969R1236, r_MmaBE4x4WordAtPtx3904R1225, r_MmaBE4x4WordAtPtx3904R1226,
		  r_MmaAccumulatorHalf2WordAtPtx2457R1420,
		  r_MmaAccumulatorHalf2WordAtPtx2458R1421); // PTX L4111
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2459R1422, r_MmaAccumulatorHalf2WordAtPtx2460R1423,
		  r_MmaAE4x4WordAtPtx3948R1233, r_MmaAE4x4WordAtPtx3955R1234, r_MmaAE4x4WordAtPtx3962R1235,
		  r_MmaAE4x4WordAtPtx3969R1236, r_MmaBE4x4WordAtPtx3904R1227, r_MmaBE4x4WordAtPtx3904R1228,
		  r_MmaAccumulatorHalf2WordAtPtx2459R1422,
		  r_MmaAccumulatorHalf2WordAtPtx2460R1423); // PTX L4118
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2461R1424, r_MmaAccumulatorHalf2WordAtPtx2462R1425,
		  r_MmaAE4x4WordAtPtx3948R1233, r_MmaAE4x4WordAtPtx3955R1234, r_MmaAE4x4WordAtPtx3962R1235,
		  r_MmaAE4x4WordAtPtx3969R1236, r_MmaBE4x4WordAtPtx3912R1229, r_MmaBE4x4WordAtPtx3912R1230,
		  r_MmaAccumulatorHalf2WordAtPtx2461R1424,
		  r_MmaAccumulatorHalf2WordAtPtx2462R1425); // PTX L4125
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2463R1426, r_MmaAccumulatorHalf2WordAtPtx2464R1427,
		  r_MmaAE4x4WordAtPtx3948R1233, r_MmaAE4x4WordAtPtx3955R1234, r_MmaAE4x4WordAtPtx3962R1235,
		  r_MmaAE4x4WordAtPtx3969R1236, r_MmaBE4x4WordAtPtx3912R1231, r_MmaBE4x4WordAtPtx3912R1232,
		  r_MmaAccumulatorHalf2WordAtPtx2463R1426,
		  r_MmaAccumulatorHalf2WordAtPtx2464R1427); // PTX L4132
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2465R1428, r_MmaAccumulatorHalf2WordAtPtx2466R1429,
		  r_MmaAE4x4WordAtPtx3976R1237, r_MmaAE4x4WordAtPtx3983R1238, r_MmaAE4x4WordAtPtx3990R1239,
		  r_MmaAE4x4WordAtPtx3997R1240, r_MmaBE4x4WordAtPtx3886R1213, r_MmaBE4x4WordAtPtx3886R1214,
		  r_MmaAccumulatorHalf2WordAtPtx2465R1428,
		  r_MmaAccumulatorHalf2WordAtPtx2466R1429); // PTX L4139
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2467R1430, r_MmaAccumulatorHalf2WordAtPtx2468R1431,
		  r_MmaAE4x4WordAtPtx3976R1237, r_MmaAE4x4WordAtPtx3983R1238, r_MmaAE4x4WordAtPtx3990R1239,
		  r_MmaAE4x4WordAtPtx3997R1240, r_MmaBE4x4WordAtPtx3886R1219, r_MmaBE4x4WordAtPtx3886R1220,
		  r_MmaAccumulatorHalf2WordAtPtx2467R1430,
		  r_MmaAccumulatorHalf2WordAtPtx2468R1431); // PTX L4146
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2469R1432, r_MmaAccumulatorHalf2WordAtPtx2470R1433,
		  r_MmaAE4x4WordAtPtx3976R1237, r_MmaAE4x4WordAtPtx3983R1238, r_MmaAE4x4WordAtPtx3990R1239,
		  r_MmaAE4x4WordAtPtx3997R1240, r_MmaBE4x4WordAtPtx3895R1221, r_MmaBE4x4WordAtPtx3895R1222,
		  r_MmaAccumulatorHalf2WordAtPtx2469R1432,
		  r_MmaAccumulatorHalf2WordAtPtx2470R1433); // PTX L4153
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2471R1434, r_MmaAccumulatorHalf2WordAtPtx2472R1435,
		  r_MmaAE4x4WordAtPtx3976R1237, r_MmaAE4x4WordAtPtx3983R1238, r_MmaAE4x4WordAtPtx3990R1239,
		  r_MmaAE4x4WordAtPtx3997R1240, r_MmaBE4x4WordAtPtx3895R1223, r_MmaBE4x4WordAtPtx3895R1224,
		  r_MmaAccumulatorHalf2WordAtPtx2471R1434,
		  r_MmaAccumulatorHalf2WordAtPtx2472R1435); // PTX L4160
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2473R1436, r_MmaAccumulatorHalf2WordAtPtx2474R1437,
		  r_MmaAE4x4WordAtPtx3976R1237, r_MmaAE4x4WordAtPtx3983R1238, r_MmaAE4x4WordAtPtx3990R1239,
		  r_MmaAE4x4WordAtPtx3997R1240, r_MmaBE4x4WordAtPtx3904R1225, r_MmaBE4x4WordAtPtx3904R1226,
		  r_MmaAccumulatorHalf2WordAtPtx2473R1436,
		  r_MmaAccumulatorHalf2WordAtPtx2474R1437); // PTX L4167
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2475R1438, r_MmaAccumulatorHalf2WordAtPtx2476R1439,
		  r_MmaAE4x4WordAtPtx3976R1237, r_MmaAE4x4WordAtPtx3983R1238, r_MmaAE4x4WordAtPtx3990R1239,
		  r_MmaAE4x4WordAtPtx3997R1240, r_MmaBE4x4WordAtPtx3904R1227, r_MmaBE4x4WordAtPtx3904R1228,
		  r_MmaAccumulatorHalf2WordAtPtx2475R1438,
		  r_MmaAccumulatorHalf2WordAtPtx2476R1439); // PTX L4174
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2477R1440, r_MmaAccumulatorHalf2WordAtPtx2478R1441,
		  r_MmaAE4x4WordAtPtx3976R1237, r_MmaAE4x4WordAtPtx3983R1238, r_MmaAE4x4WordAtPtx3990R1239,
		  r_MmaAE4x4WordAtPtx3997R1240, r_MmaBE4x4WordAtPtx3912R1229, r_MmaBE4x4WordAtPtx3912R1230,
		  r_MmaAccumulatorHalf2WordAtPtx2477R1440,
		  r_MmaAccumulatorHalf2WordAtPtx2478R1441); // PTX L4181
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2479R1442, r_MmaAccumulatorHalf2WordAtPtx2480R1443,
		  r_MmaAE4x4WordAtPtx3976R1237, r_MmaAE4x4WordAtPtx3983R1238, r_MmaAE4x4WordAtPtx3990R1239,
		  r_MmaAE4x4WordAtPtx3997R1240, r_MmaBE4x4WordAtPtx3912R1231, r_MmaBE4x4WordAtPtx3912R1232,
		  r_MmaAccumulatorHalf2WordAtPtx2479R1442,
		  r_MmaAccumulatorHalf2WordAtPtx2480R1443); // PTX L4188
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2481R1444, r_MmaAccumulatorHalf2WordAtPtx2482R1445,
		  r_MmaAE4x4WordAtPtx4004R1241, r_MmaAE4x4WordAtPtx4011R1242, r_MmaAE4x4WordAtPtx4018R1243,
		  r_MmaAE4x4WordAtPtx4025R1244, r_MmaBE4x4WordAtPtx3886R1213, r_MmaBE4x4WordAtPtx3886R1214,
		  r_MmaAccumulatorHalf2WordAtPtx2481R1444,
		  r_MmaAccumulatorHalf2WordAtPtx2482R1445); // PTX L4195
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2483R1446, r_MmaAccumulatorHalf2WordAtPtx2484R1447,
		  r_MmaAE4x4WordAtPtx4004R1241, r_MmaAE4x4WordAtPtx4011R1242, r_MmaAE4x4WordAtPtx4018R1243,
		  r_MmaAE4x4WordAtPtx4025R1244, r_MmaBE4x4WordAtPtx3886R1219, r_MmaBE4x4WordAtPtx3886R1220,
		  r_MmaAccumulatorHalf2WordAtPtx2483R1446,
		  r_MmaAccumulatorHalf2WordAtPtx2484R1447); // PTX L4202
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2485R1448, r_MmaAccumulatorHalf2WordAtPtx2486R1449,
		  r_MmaAE4x4WordAtPtx4004R1241, r_MmaAE4x4WordAtPtx4011R1242, r_MmaAE4x4WordAtPtx4018R1243,
		  r_MmaAE4x4WordAtPtx4025R1244, r_MmaBE4x4WordAtPtx3895R1221, r_MmaBE4x4WordAtPtx3895R1222,
		  r_MmaAccumulatorHalf2WordAtPtx2485R1448,
		  r_MmaAccumulatorHalf2WordAtPtx2486R1449); // PTX L4209
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2487R1450, r_MmaAccumulatorHalf2WordAtPtx2488R1451,
		  r_MmaAE4x4WordAtPtx4004R1241, r_MmaAE4x4WordAtPtx4011R1242, r_MmaAE4x4WordAtPtx4018R1243,
		  r_MmaAE4x4WordAtPtx4025R1244, r_MmaBE4x4WordAtPtx3895R1223, r_MmaBE4x4WordAtPtx3895R1224,
		  r_MmaAccumulatorHalf2WordAtPtx2487R1450,
		  r_MmaAccumulatorHalf2WordAtPtx2488R1451); // PTX L4216
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2489R1452, r_MmaAccumulatorHalf2WordAtPtx2490R1453,
		  r_MmaAE4x4WordAtPtx4004R1241, r_MmaAE4x4WordAtPtx4011R1242, r_MmaAE4x4WordAtPtx4018R1243,
		  r_MmaAE4x4WordAtPtx4025R1244, r_MmaBE4x4WordAtPtx3904R1225, r_MmaBE4x4WordAtPtx3904R1226,
		  r_MmaAccumulatorHalf2WordAtPtx2489R1452,
		  r_MmaAccumulatorHalf2WordAtPtx2490R1453); // PTX L4223
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2491R1454, r_MmaAccumulatorHalf2WordAtPtx2492R1455,
		  r_MmaAE4x4WordAtPtx4004R1241, r_MmaAE4x4WordAtPtx4011R1242, r_MmaAE4x4WordAtPtx4018R1243,
		  r_MmaAE4x4WordAtPtx4025R1244, r_MmaBE4x4WordAtPtx3904R1227, r_MmaBE4x4WordAtPtx3904R1228,
		  r_MmaAccumulatorHalf2WordAtPtx2491R1454,
		  r_MmaAccumulatorHalf2WordAtPtx2492R1455); // PTX L4230
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2493R1456, r_MmaAccumulatorHalf2WordAtPtx2494R1457,
		  r_MmaAE4x4WordAtPtx4004R1241, r_MmaAE4x4WordAtPtx4011R1242, r_MmaAE4x4WordAtPtx4018R1243,
		  r_MmaAE4x4WordAtPtx4025R1244, r_MmaBE4x4WordAtPtx3912R1229, r_MmaBE4x4WordAtPtx3912R1230,
		  r_MmaAccumulatorHalf2WordAtPtx2493R1456,
		  r_MmaAccumulatorHalf2WordAtPtx2494R1457); // PTX L4237
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2495R1458, r_MmaAccumulatorHalf2WordAtPtx2496R1459,
		  r_MmaAE4x4WordAtPtx4004R1241, r_MmaAE4x4WordAtPtx4011R1242, r_MmaAE4x4WordAtPtx4018R1243,
		  r_MmaAE4x4WordAtPtx4025R1244, r_MmaBE4x4WordAtPtx3912R1231, r_MmaBE4x4WordAtPtx3912R1232,
		  r_MmaAccumulatorHalf2WordAtPtx2495R1458,
		  r_MmaAccumulatorHalf2WordAtPtx2496R1459);						  // PTX L4244
	r_PtxRegister76 = uint32_t(r_PtxRegister1460) + uint32_t(32);		  // PTX L4250
	r_PtxU64Register201 = uint64_t(r_PtxU64Register201) + uint64_t(1024); // PTX L4251
	r_PtxU64Register200 = uint64_t(r_PtxU64Register200) + uint64_t(2048); // PTX L4252
	r_PtxU64Register199 = uint64_t(r_PtxU64Register199) + uint64_t(1024); // PTX L4253
	r_bPtxPredicate198 = uint32_t(r_PtxRegister1460) < uint32_t(224);	  // PTX L4254
	r_PtxRegister1460 = uint32_t(r_PtxRegister76);						  // PTX L4255
	if (r_bPtxPredicate198)
	{
		goto L__BB3_105;
	} // PTX L4256
	r_HeightSignBits = ShiftRightSigned(int32_t(r_HeightBits), uint32_t(31));			  // PTX L4257
	r_HeightDiv4Bias = ShiftRight(uint32_t(r_HeightSignBits), uint32_t(30));			  // PTX L4258
	r_HeightBiasedForDiv4 = uint32_t(r_HeightBits) + uint32_t(r_HeightDiv4Bias);		  // PTX L4259
	r_HeightDiv4Bits = ShiftRightSigned(int32_t(r_HeightBiasedForDiv4), uint32_t(2));	  // PTX L4260
	r_WidthSignBits = ShiftRightSigned(int32_t(r_WidthBits), uint32_t(31));				  // PTX L4261
	r_WidthDiv4Bias = ShiftRight(uint32_t(r_WidthSignBits), uint32_t(30));				  // PTX L4262
	r_WidthBiasedForDiv4 = uint32_t(r_WidthBits) + uint32_t(r_WidthDiv4Bias);			  // PTX L4263
	r_WidthDiv4Bits = ShiftRightSigned(int32_t(r_WidthBiasedForDiv4), uint32_t(2));		  // PTX L4264
	r_ConvertedE4PairAtPtx4266Rs97 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2433R1396);  // PTX L4266
	r_ConvertedE4PairAtPtx4269Rs98 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2435R1398);  // PTX L4269
	r_ConvertedE4PairAtPtx4272Rs99 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2434R1397);  // PTX L4272
	r_ConvertedE4PairAtPtx4275Rs100 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2436R1399); // PTX L4275
	r_ConvertedE4PairAtPtx4278Rs101 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2437R1400); // PTX L4278
	r_ConvertedE4PairAtPtx4281Rs102 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2439R1402); // PTX L4281
	r_ConvertedE4PairAtPtx4284Rs103 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2438R1401); // PTX L4284
	r_ConvertedE4PairAtPtx4287Rs104 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2440R1403); // PTX L4287
	r_ConvertedE4PairAtPtx4290Rs105 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2441R1404); // PTX L4290
	r_ConvertedE4PairAtPtx4293Rs106 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2443R1406); // PTX L4293
	r_ConvertedE4PairAtPtx4296Rs107 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2442R1405); // PTX L4296
	r_ConvertedE4PairAtPtx4299Rs108 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2444R1407); // PTX L4299
	r_ConvertedE4PairAtPtx4302Rs109 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2445R1408); // PTX L4302
	r_ConvertedE4PairAtPtx4305Rs110 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2447R1410); // PTX L4305
	r_ConvertedE4PairAtPtx4308Rs111 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2446R1409); // PTX L4308
	r_ConvertedE4PairAtPtx4311Rs112 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2448R1411); // PTX L4311
	r_ConvertedE4PairAtPtx4314Rs113 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2449R1412); // PTX L4314
	r_ConvertedE4PairAtPtx4317Rs114 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2451R1414); // PTX L4317
	r_ConvertedE4PairAtPtx4320Rs115 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2450R1413); // PTX L4320
	r_ConvertedE4PairAtPtx4323Rs116 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2452R1415); // PTX L4323
	r_ConvertedE4PairAtPtx4326Rs117 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2453R1416); // PTX L4326
	r_ConvertedE4PairAtPtx4329Rs118 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2455R1418); // PTX L4329
	r_ConvertedE4PairAtPtx4332Rs119 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2454R1417); // PTX L4332
	r_ConvertedE4PairAtPtx4335Rs120 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2456R1419); // PTX L4335
	r_ConvertedE4PairAtPtx4338Rs121 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2457R1420); // PTX L4338
	r_ConvertedE4PairAtPtx4341Rs122 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2459R1422); // PTX L4341
	r_ConvertedE4PairAtPtx4344Rs123 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2458R1421); // PTX L4344
	r_ConvertedE4PairAtPtx4347Rs124 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2460R1423); // PTX L4347
	r_ConvertedE4PairAtPtx4350Rs125 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2461R1424); // PTX L4350
	r_ConvertedE4PairAtPtx4353Rs126 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2463R1426); // PTX L4353
	r_ConvertedE4PairAtPtx4356Rs127 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2462R1425); // PTX L4356
	r_ConvertedE4PairAtPtx4359Rs128 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2464R1427); // PTX L4359
	r_ConvertedE4PairAtPtx4362Rs129 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2465R1428); // PTX L4362
	r_ConvertedE4PairAtPtx4365Rs130 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2467R1430); // PTX L4365
	r_ConvertedE4PairAtPtx4368Rs131 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2466R1429); // PTX L4368
	r_ConvertedE4PairAtPtx4371Rs132 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2468R1431); // PTX L4371
	r_ConvertedE4PairAtPtx4374Rs133 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2469R1432); // PTX L4374
	r_ConvertedE4PairAtPtx4377Rs134 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2471R1434); // PTX L4377
	r_ConvertedE4PairAtPtx4380Rs135 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2470R1433); // PTX L4380
	r_ConvertedE4PairAtPtx4383Rs136 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2472R1435); // PTX L4383
	r_ConvertedE4PairAtPtx4386Rs137 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2473R1436); // PTX L4386
	r_ConvertedE4PairAtPtx4389Rs138 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2475R1438); // PTX L4389
	r_ConvertedE4PairAtPtx4392Rs139 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2474R1437); // PTX L4392
	r_ConvertedE4PairAtPtx4395Rs140 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2476R1439); // PTX L4395
	r_ConvertedE4PairAtPtx4398Rs141 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2477R1440); // PTX L4398
	r_ConvertedE4PairAtPtx4401Rs142 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2479R1442); // PTX L4401
	r_ConvertedE4PairAtPtx4404Rs143 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2478R1441); // PTX L4404
	r_ConvertedE4PairAtPtx4407Rs144 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2480R1443); // PTX L4407
	r_ConvertedE4PairAtPtx4410Rs145 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2481R1444); // PTX L4410
	r_ConvertedE4PairAtPtx4413Rs146 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2483R1446); // PTX L4413
	r_ConvertedE4PairAtPtx4416Rs147 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2482R1445); // PTX L4416
	r_ConvertedE4PairAtPtx4419Rs148 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2484R1447); // PTX L4419
	r_ConvertedE4PairAtPtx4422Rs149 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2485R1448); // PTX L4422
	r_ConvertedE4PairAtPtx4425Rs150 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2487R1450); // PTX L4425
	r_ConvertedE4PairAtPtx4428Rs151 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2486R1449); // PTX L4428
	r_ConvertedE4PairAtPtx4431Rs152 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2488R1451); // PTX L4431
	r_ConvertedE4PairAtPtx4434Rs153 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2489R1452); // PTX L4434
	r_ConvertedE4PairAtPtx4437Rs154 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2491R1454); // PTX L4437
	r_ConvertedE4PairAtPtx4440Rs155 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2490R1453); // PTX L4440
	r_ConvertedE4PairAtPtx4443Rs156 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2492R1455); // PTX L4443
	r_ConvertedE4PairAtPtx4446Rs157 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2493R1456); // PTX L4446
	r_ConvertedE4PairAtPtx4449Rs158 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2495R1458); // PTX L4449
	r_ConvertedE4PairAtPtx4452Rs159 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2494R1457); // PTX L4452
	r_ConvertedE4PairAtPtx4455Rs160 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx2496R1459); // PTX L4455
	r_PtxRegister79 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));							  // PTX L4457
	r_bPtxPredicate199 = int32_t(r_PtxRegister79) >= int32_t(r_HeightDiv4Bits);			  // PTX L4458
	r_CtaXAtPtx4459 = uint32_t(blockIdx.x);												  // PTX L4459
	r_PtxRegister80 = ShiftLeft(uint32_t(r_CtaXAtPtx4459), uint32_t(1));				  // PTX L4460
	r_bPtxPredicate200 = int32_t(r_PtxRegister80) >= int32_t(r_WidthDiv4Bits);			  // PTX L4461
	r_PtxRegister1252 =
		uint32_t(r_PtxRegister79) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister80);		  // PTX L4462
	r_PtxRegister81 = ShiftLeft(uint32_t(r_PtxRegister105), uint32_t(2));						  // PTX L4463
	r_PtxRegister1253 = ShiftLeft(uint32_t(r_PtxRegister1252), uint32_t(11));					  // PTX L4464
	r_PtxRegister1254 = uint32_t(r_PtxRegister1253) + uint32_t(r_PtxRegister81);				  // PTX L4465
	r_PtxU64Register159 = uint64_t(int64_t(int32_t(r_PtxRegister1254)) * int64_t(int32_t(4)));	  // PTX L4466
	g_OutputByteAddressAtPtx4467 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register159); // PTX L4467
	r_bPtxPredicate201 = r_bPtxPredicate199 | r_bPtxPredicate200;								  // PTX L4468
	if (r_bPtxPredicate201)
	{
		goto L__BB3_108;
	} // PTX L4469
	r_PackedE4WordAtPtx4470R1264 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4308Rs111, r_ConvertedE4PairAtPtx4311Rs112); // PTX L4470
	r_PackedE4WordAtPtx4471R1263 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4302Rs109, r_ConvertedE4PairAtPtx4305Rs110); // PTX L4471
	r_PackedE4WordAtPtx4472R1262 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4296Rs107, r_ConvertedE4PairAtPtx4299Rs108); // PTX L4472
	r_PackedE4WordAtPtx4473R1261 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4290Rs105, r_ConvertedE4PairAtPtx4293Rs106); // PTX L4473
	r_PackedE4WordAtPtx4474R1259 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4284Rs103, r_ConvertedE4PairAtPtx4287Rs104); // PTX L4474
	r_PackedE4WordAtPtx4475R1258 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4278Rs101, r_ConvertedE4PairAtPtx4281Rs102); // PTX L4475
	r_PackedE4WordAtPtx4476R1257 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4272Rs99, r_ConvertedE4PairAtPtx4275Rs100); // PTX L4476
	r_PackedE4WordAtPtx4477R1256 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4266Rs97, r_ConvertedE4PairAtPtx4269Rs98); // PTX L4477
	r_LaneIndexAtPtx4479 = uint32_t((threadIdx.x & 31u));							   // PTX L4479
	r_PtxU64Register162 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4479)) * int64_t(int32_t(16))); // PTX L4481
	g_OutputByteAddressAtPtx4482 =
		uint64_t(g_OutputByteAddressAtPtx4467) + uint64_t(r_PtxU64Register162); // PTX L4482
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx4482,
					make_uint4(r_PackedE4WordAtPtx4477R1256, r_PackedE4WordAtPtx4476R1257,
							   r_PackedE4WordAtPtx4475R1258,
							   r_PackedE4WordAtPtx4474R1259)); // PTX L4484
	r_LaneIndexAtPtx4487 = uint32_t((threadIdx.x & 31u));	   // PTX L4487
	r_PtxU64Register163 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4487)) * int64_t(int32_t(16))); // PTX L4489
	g_OutputByteAddressAtPtx4490 =
		uint64_t(g_OutputByteAddressAtPtx4467) + uint64_t(r_PtxU64Register163);			   // PTX L4490
	g_OutputByteAddressAtPtx4491 = uint64_t(g_OutputByteAddressAtPtx4490) + uint64_t(512); // PTX L4491
	StoreNoAllocate(g_OutputByteAddressAtPtx4491,
					make_uint4(r_PackedE4WordAtPtx4473R1261, r_PackedE4WordAtPtx4472R1262,
							   r_PackedE4WordAtPtx4471R1263,
							   r_PackedE4WordAtPtx4470R1264));					// PTX L4493
L__BB3_108:																		// PTX L4495
	r_bPtxPredicate202 = int32_t(r_PtxRegister79) >= int32_t(r_HeightDiv4Bits); // PTX L4496
	r_PtxRegister82 = uint32_t(r_PtxRegister80) + uint32_t(1);					// PTX L4497
	r_bPtxPredicate203 = int32_t(r_PtxRegister82) >= int32_t(r_WidthDiv4Bits);	// PTX L4498
	r_bPtxPredicate204 = r_bPtxPredicate202 | r_bPtxPredicate203;				// PTX L4499
	if (r_bPtxPredicate204)
	{
		goto L__BB3_110;
	} // PTX L4500
	r_LaneIndexAtPtx4502 = uint32_t((threadIdx.x & 31u)); // PTX L4502
	r_PtxU64Register167 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4502)) * int64_t(int32_t(16))); // PTX L4504
	g_OutputByteAddressAtPtx4505 =
		uint64_t(g_OutputByteAddressAtPtx4467) + uint64_t(r_PtxU64Register167);				// PTX L4505
	g_OutputByteAddressAtPtx4506 = uint64_t(g_OutputByteAddressAtPtx4505) + uint64_t(8192); // PTX L4506
	r_PackedE4WordAtPtx4507R1269 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4332Rs119, r_ConvertedE4PairAtPtx4335Rs120); // PTX L4507
	r_PackedE4WordAtPtx4508R1268 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4326Rs117, r_ConvertedE4PairAtPtx4329Rs118); // PTX L4508
	r_PackedE4WordAtPtx4509R1267 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4320Rs115, r_ConvertedE4PairAtPtx4323Rs116); // PTX L4509
	r_PackedE4WordAtPtx4510R1266 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4314Rs113, r_ConvertedE4PairAtPtx4317Rs114); // PTX L4510
	StoreNoAllocate(g_OutputByteAddressAtPtx4506,
					make_uint4(r_PackedE4WordAtPtx4510R1266, r_PackedE4WordAtPtx4509R1267,
							   r_PackedE4WordAtPtx4508R1268,
							   r_PackedE4WordAtPtx4507R1269)); // PTX L4512
	r_LaneIndexAtPtx4515 = uint32_t((threadIdx.x & 31u));	   // PTX L4515
	r_PtxU64Register169 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4515)) * int64_t(int32_t(16))); // PTX L4517
	g_OutputByteAddressAtPtx4518 =
		uint64_t(g_OutputByteAddressAtPtx4467) + uint64_t(r_PtxU64Register169);				// PTX L4518
	g_OutputByteAddressAtPtx4519 = uint64_t(g_OutputByteAddressAtPtx4518) + uint64_t(8704); // PTX L4519
	r_PackedE4WordAtPtx4520R1274 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4356Rs127, r_ConvertedE4PairAtPtx4359Rs128); // PTX L4520
	r_PackedE4WordAtPtx4521R1273 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4350Rs125, r_ConvertedE4PairAtPtx4353Rs126); // PTX L4521
	r_PackedE4WordAtPtx4522R1272 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4344Rs123, r_ConvertedE4PairAtPtx4347Rs124); // PTX L4522
	r_PackedE4WordAtPtx4523R1271 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4338Rs121, r_ConvertedE4PairAtPtx4341Rs122); // PTX L4523
	StoreNoAllocate(g_OutputByteAddressAtPtx4519,
					make_uint4(r_PackedE4WordAtPtx4523R1271, r_PackedE4WordAtPtx4522R1272,
							   r_PackedE4WordAtPtx4521R1273,
							   r_PackedE4WordAtPtx4520R1274));					// PTX L4525
L__BB3_110:																		// PTX L4527
	r_bPtxPredicate205 = int32_t(r_PtxRegister80) >= int32_t(r_WidthDiv4Bits);	// PTX L4528
	r_PtxRegister83 = uint32_t(r_PtxRegister79) + uint32_t(1);					// PTX L4529
	r_bPtxPredicate206 = int32_t(r_PtxRegister83) >= int32_t(r_HeightDiv4Bits); // PTX L4530
	r_PtxRegister1275 =
		uint32_t(r_WidthDiv4Bits) * uint32_t(r_PtxRegister79) + uint32_t(r_WidthDiv4Bits);		  // PTX L4531
	r_PtxRegister1276 = uint32_t(r_PtxRegister1275) + uint32_t(r_PtxRegister80);				  // PTX L4532
	r_PtxRegister1277 = ShiftLeft(uint32_t(r_PtxRegister1276), uint32_t(11));					  // PTX L4533
	r_PtxRegister1278 = uint32_t(r_PtxRegister1277) + uint32_t(r_PtxRegister81);				  // PTX L4534
	r_PtxU64Register171 = uint64_t(int64_t(int32_t(r_PtxRegister1278)) * int64_t(int32_t(4)));	  // PTX L4535
	g_OutputByteAddressAtPtx4536 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register171); // PTX L4536
	r_bPtxPredicate207 = r_bPtxPredicate206 | r_bPtxPredicate205;								  // PTX L4537
	if (r_bPtxPredicate207)
	{
		goto L__BB3_112;
	} // PTX L4538
	r_LaneIndexAtPtx4540 = uint32_t((threadIdx.x & 31u)); // PTX L4540
	r_PtxU64Register174 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4540)) * int64_t(int32_t(16))); // PTX L4542
	g_OutputByteAddressAtPtx4543 =
		uint64_t(g_OutputByteAddressAtPtx4536) + uint64_t(r_PtxU64Register174); // PTX L4543
	r_PackedE4WordAtPtx4544R1283 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4380Rs135, r_ConvertedE4PairAtPtx4383Rs136); // PTX L4544
	r_PackedE4WordAtPtx4545R1282 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4374Rs133, r_ConvertedE4PairAtPtx4377Rs134); // PTX L4545
	r_PackedE4WordAtPtx4546R1281 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4368Rs131, r_ConvertedE4PairAtPtx4371Rs132); // PTX L4546
	r_PackedE4WordAtPtx4547R1280 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4362Rs129, r_ConvertedE4PairAtPtx4365Rs130); // PTX L4547
	StoreNoAllocate(g_OutputByteAddressAtPtx4543,
					make_uint4(r_PackedE4WordAtPtx4547R1280, r_PackedE4WordAtPtx4546R1281,
							   r_PackedE4WordAtPtx4545R1282,
							   r_PackedE4WordAtPtx4544R1283)); // PTX L4549
	r_LaneIndexAtPtx4552 = uint32_t((threadIdx.x & 31u));	   // PTX L4552
	r_PtxU64Register175 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4552)) * int64_t(int32_t(16))); // PTX L4554
	g_OutputByteAddressAtPtx4555 =
		uint64_t(g_OutputByteAddressAtPtx4536) + uint64_t(r_PtxU64Register175);			   // PTX L4555
	g_OutputByteAddressAtPtx4556 = uint64_t(g_OutputByteAddressAtPtx4555) + uint64_t(512); // PTX L4556
	r_PackedE4WordAtPtx4557R1288 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4404Rs143, r_ConvertedE4PairAtPtx4407Rs144); // PTX L4557
	r_PackedE4WordAtPtx4558R1287 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4398Rs141, r_ConvertedE4PairAtPtx4401Rs142); // PTX L4558
	r_PackedE4WordAtPtx4559R1286 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4392Rs139, r_ConvertedE4PairAtPtx4395Rs140); // PTX L4559
	r_PackedE4WordAtPtx4560R1285 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4386Rs137, r_ConvertedE4PairAtPtx4389Rs138); // PTX L4560
	StoreNoAllocate(g_OutputByteAddressAtPtx4556,
					make_uint4(r_PackedE4WordAtPtx4560R1285, r_PackedE4WordAtPtx4559R1286,
							   r_PackedE4WordAtPtx4558R1287,
							   r_PackedE4WordAtPtx4557R1288));				   // PTX L4562
L__BB3_112:																	   // PTX L4564
	r_bPtxPredicate208 = int32_t(r_PtxRegister82) >= int32_t(r_WidthDiv4Bits); // PTX L4565
	r_bPtxPredicate209 = r_bPtxPredicate206 | r_bPtxPredicate208;			   // PTX L4566
	if (r_bPtxPredicate209)
	{
		goto L__BB3_114;
	} // PTX L4567
	r_LaneIndexAtPtx4569 = uint32_t((threadIdx.x & 31u)); // PTX L4569
	r_PtxU64Register179 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4569)) * int64_t(int32_t(16))); // PTX L4571
	g_OutputByteAddressAtPtx4572 =
		uint64_t(g_OutputByteAddressAtPtx4536) + uint64_t(r_PtxU64Register179);				// PTX L4572
	g_OutputByteAddressAtPtx4573 = uint64_t(g_OutputByteAddressAtPtx4572) + uint64_t(8192); // PTX L4573
	r_PackedE4WordAtPtx4574R1293 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4428Rs151, r_ConvertedE4PairAtPtx4431Rs152); // PTX L4574
	r_PackedE4WordAtPtx4575R1292 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4422Rs149, r_ConvertedE4PairAtPtx4425Rs150); // PTX L4575
	r_PackedE4WordAtPtx4576R1291 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4416Rs147, r_ConvertedE4PairAtPtx4419Rs148); // PTX L4576
	r_PackedE4WordAtPtx4577R1290 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4410Rs145, r_ConvertedE4PairAtPtx4413Rs146); // PTX L4577
	StoreNoAllocate(g_OutputByteAddressAtPtx4573,
					make_uint4(r_PackedE4WordAtPtx4577R1290, r_PackedE4WordAtPtx4576R1291,
							   r_PackedE4WordAtPtx4575R1292,
							   r_PackedE4WordAtPtx4574R1293)); // PTX L4579
	r_LaneIndexAtPtx4582 = uint32_t((threadIdx.x & 31u));	   // PTX L4582
	r_PtxU64Register181 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4582)) * int64_t(int32_t(16))); // PTX L4584
	g_OutputByteAddressAtPtx4585 =
		uint64_t(g_OutputByteAddressAtPtx4536) + uint64_t(r_PtxU64Register181);				// PTX L4585
	g_OutputByteAddressAtPtx4586 = uint64_t(g_OutputByteAddressAtPtx4585) + uint64_t(8704); // PTX L4586
	r_PackedE4WordAtPtx4587R1298 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4452Rs159, r_ConvertedE4PairAtPtx4455Rs160); // PTX L4587
	r_PackedE4WordAtPtx4588R1297 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4446Rs157, r_ConvertedE4PairAtPtx4449Rs158); // PTX L4588
	r_PackedE4WordAtPtx4589R1296 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4440Rs155, r_ConvertedE4PairAtPtx4443Rs156); // PTX L4589
	r_PackedE4WordAtPtx4590R1295 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4434Rs153, r_ConvertedE4PairAtPtx4437Rs154); // PTX L4590
	StoreNoAllocate(g_OutputByteAddressAtPtx4586,
					make_uint4(r_PackedE4WordAtPtx4590R1295, r_PackedE4WordAtPtx4589R1296,
							   r_PackedE4WordAtPtx4588R1297,
							   r_PackedE4WordAtPtx4587R1298)); // PTX L4592
L__BB3_114:													   // PTX L4594
	return;													   // PTX L4595
#endif
}
} // namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp8
