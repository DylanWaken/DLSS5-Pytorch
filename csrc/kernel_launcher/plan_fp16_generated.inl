// Generated shared native FP16 schedule. Every resolution uses the same 185 calls.
// Buffer names are shared; the geometry table supplies their actual byte extents.
static const char* BufferNameTable_fp16[] = {
	"input",
	"b1.output",
	"b2.output",
	"b3.output",
	"b4.output",
	"b4.down",
	"b5.output",
	"b6.output",
	"b7.output",
	"b8.output",
	"b8.down",
	"b9.output",
	"b10.output",
	"b11.output",
	"b12.output",
	"b13.output",
	"b14.output",
	"b14.down",
	"b15.output",
	"b16.output",
	"b17.output",
	"b18.output",
	"b19.output",
	"b20.output",
	"b21.output",
	"b22.output",
	"b22.down",
	"b23.branches",
	"b23.ffn",
	"b23.attended",
	"b23.output",
	"b24.branches",
	"b24.ffn",
	"b24.attended",
	"b24.output",
	"b25.branches",
	"b25.ffn",
	"b25.attended",
	"b25.output",
	"b26.branches",
	"b26.ffn",
	"b26.attended",
	"b26.output",
	"b27.branches",
	"b27.ffn",
	"b27.attended",
	"b27.output",
	"b28.branches",
	"b28.ffn",
	"b28.attended",
	"b28.output",
	"b29.branches",
	"b29.ffn",
	"b29.attended",
	"b29.output",
	"b30.branches",
	"b30.ffn",
	"b30.attended",
	"b30.output",
	"b30.pool",
	"b30.down",
	"repack-30-31",
	"b31.expanded",
	"b31.contracted",
	"b31.Q",
	"b31.K",
	"b31.V",
	"b31.attended",
	"b31.output",
	"b31.contract_counter",
	"b31.qkv_counter",
	"b31.attention_counter",
	"b31.projection_counter",
	"b32.expanded",
	"b32.contracted",
	"b32.Q",
	"b32.K",
	"b32.V",
	"b32.attended",
	"b32.output",
	"b32.contract_counter",
	"b32.qkv_counter",
	"b32.attention_counter",
	"b32.projection_counter",
	"b33.expanded",
	"b33.contracted",
	"b33.Q",
	"b33.K",
	"b33.V",
	"b33.attended",
	"b33.output",
	"b33.contract_counter",
	"b33.qkv_counter",
	"b33.attention_counter",
	"b33.projection_counter",
	"b34.expanded",
	"b34.contracted",
	"b34.Q",
	"b34.K",
	"b34.V",
	"b34.attended",
	"b34.output",
	"b34.contract_counter",
	"b34.qkv_counter",
	"b34.attention_counter",
	"b34.projection_counter",
	"b35.expanded",
	"b35.contracted",
	"b35.Q",
	"b35.K",
	"b35.V",
	"b35.attended",
	"b35.output",
	"b35.contract_counter",
	"b35.qkv_counter",
	"b35.attention_counter",
	"b35.projection_counter",
	"b36.expanded",
	"b36.contracted",
	"b36.Q",
	"b36.K",
	"b36.V",
	"b36.attended",
	"b36.output",
	"b36.contract_counter",
	"b36.qkv_counter",
	"b36.attention_counter",
	"b36.projection_counter",
	"b37.expanded",
	"b37.contracted",
	"b37.Q",
	"b37.K",
	"b37.V",
	"b37.attended",
	"b37.output",
	"b37.contract_counter",
	"b37.qkv_counter",
	"b37.attention_counter",
	"b37.projection_counter",
	"b38.expanded",
	"b38.contracted",
	"b38.Q",
	"b38.K",
	"b38.V",
	"b38.attended",
	"b38.output",
	"b38.contract_counter",
	"b38.qkv_counter",
	"b38.attention_counter",
	"b38.projection_counter",
	"repack-38-39",
	"b39.output",
	"b39.up_counter",
	"b39.scratch",
	"b40.branches",
	"b40.ffn",
	"b40.attended",
	"b40.output",
	"b41.branches",
	"b41.ffn",
	"b41.attended",
	"b41.output",
	"b42.branches",
	"b42.ffn",
	"b42.attended",
	"b42.output",
	"b43.branches",
	"b43.ffn",
	"b43.attended",
	"b43.output",
	"b44.branches",
	"b44.ffn",
	"b44.attended",
	"b44.output",
	"b45.branches",
	"b45.ffn",
	"b45.attended",
	"b45.output",
	"b46.branches",
	"b46.ffn",
	"b46.attended",
	"b46.output",
	"b47.branches",
	"b47.ffn",
	"b47.attended",
	"b47.output",
	"b48.output",
	"b49.output",
	"b50.output",
	"b51.output",
	"b52.output",
	"b53.output",
	"b54.output",
	"b55.output",
	"b56.output",
	"b57.output",
	"b58.output",
	"b59.output",
	"b60.output",
	"b61.output",
	"b62.output",
	"b63.output",
	"b64.output",
	"b65.output",
	"b66.output",
	"b67.output",
	"b68.output",
	"b69.output",
};
static const FBufferSpec RecordSpecs_fp16[] = {
	{"block1.layer0.layer", 32960LL},	 {"block2.layer0.layer", 32960LL},
	{"block3.layer0.layer", 32960LL},	 {"block4.layer0.layer", 37056LL},
	{"block5.layer0.layer", 106816LL},	 {"block6.layer0.layer", 106816LL},
	{"block7.layer0.layer", 106816LL},	 {"block8.layer0.layer", 123200LL},
	{"block9.layer0.layer", 361024LL},	 {"block10.layer0.layer", 361024LL},
	{"block11.layer0.layer", 361024LL},	 {"block12.layer0.layer", 361024LL},
	{"block13.layer0.layer", 361024LL},	 {"block14.layer0.layer", 426560LL},
	{"block15.layer0.layer", 1311808LL}, {"block16.layer0.layer", 1311808LL},
	{"block17.layer0.layer", 1311808LL}, {"block18.layer0.layer", 1311808LL},
	{"block19.layer0.layer", 1311808LL}, {"block20.layer0.layer", 1311808LL},
	{"block21.layer0.layer", 1311808LL}, {"block22.layer0.layer", 1573952LL},
	{"block23.layer0.layer", 1048576LL}, {"block23.layer1.layer", 525312LL},
	{"block23.layer2.layer", 1704000LL}, {"block23.layer3.layer", 525312LL},
	{"block24.layer0.layer", 1048576LL}, {"block24.layer1.layer", 525312LL},
	{"block24.layer2.layer", 1704000LL}, {"block24.layer3.layer", 525312LL},
	{"block25.layer0.layer", 1048576LL}, {"block25.layer1.layer", 525312LL},
	{"block25.layer2.layer", 1704000LL}, {"block25.layer3.layer", 525312LL},
	{"block26.layer0.layer", 1048576LL}, {"block26.layer1.layer", 525312LL},
	{"block26.layer2.layer", 1704000LL}, {"block26.layer3.layer", 525312LL},
	{"block27.layer0.layer", 1048576LL}, {"block27.layer1.layer", 525312LL},
	{"block27.layer2.layer", 1704000LL}, {"block27.layer3.layer", 525312LL},
	{"block28.layer0.layer", 1048576LL}, {"block28.layer1.layer", 525312LL},
	{"block28.layer2.layer", 1704000LL}, {"block28.layer3.layer", 525312LL},
	{"block29.layer0.layer", 1048576LL}, {"block29.layer1.layer", 525312LL},
	{"block29.layer2.layer", 1704000LL}, {"block29.layer3.layer", 525312LL},
	{"block30.layer0.layer", 1048576LL}, {"block30.layer1.layer", 525312LL},
	{"block30.layer2.layer", 1704000LL}, {"block30.layer3.layer", 525312LL},
	{"block30.layer4.layer", 1048592LL}, {"block31.layer0.layer", 8388608LL},
	{"block31.layer1.layer", 8390656LL}, {"block31.layer2.layer", 6291584LL},
	{"block31.layer4.layer", 2099200LL}, {"block32.layer0.layer", 8388608LL},
	{"block32.layer1.layer", 8390656LL}, {"block32.layer2.layer", 6291584LL},
	{"block32.layer4.layer", 2099200LL}, {"block33.layer0.layer", 8388608LL},
	{"block33.layer1.layer", 8390656LL}, {"block33.layer2.layer", 6291584LL},
	{"block33.layer4.layer", 2099200LL}, {"block34.layer0.layer", 8388608LL},
	{"block34.layer1.layer", 8390656LL}, {"block34.layer2.layer", 6291584LL},
	{"block34.layer4.layer", 2099200LL}, {"block35.layer0.layer", 8388608LL},
	{"block35.layer1.layer", 8390656LL}, {"block35.layer2.layer", 6291584LL},
	{"block35.layer4.layer", 2099200LL}, {"block36.layer0.layer", 8388608LL},
	{"block36.layer1.layer", 8390656LL}, {"block36.layer2.layer", 6291584LL},
	{"block36.layer4.layer", 2099200LL}, {"block37.layer0.layer", 8388608LL},
	{"block37.layer1.layer", 8390656LL}, {"block37.layer2.layer", 6291584LL},
	{"block37.layer4.layer", 2099200LL}, {"block38.layer0.layer", 8388608LL},
	{"block38.layer1.layer", 8390656LL}, {"block38.layer2.layer", 6291584LL},
	{"block38.layer4.layer", 2099200LL}, {"block39.layer0.layer", 1049600LL},
	{"block40.layer0.layer", 1048576LL}, {"block40.layer1.layer", 525312LL},
	{"block40.layer2.layer", 1704000LL}, {"block40.layer3.layer", 525312LL},
	{"block41.layer0.layer", 1048576LL}, {"block41.layer1.layer", 525312LL},
	{"block41.layer2.layer", 1704000LL}, {"block41.layer3.layer", 525312LL},
	{"block42.layer0.layer", 1048576LL}, {"block42.layer1.layer", 525312LL},
	{"block42.layer2.layer", 1704000LL}, {"block42.layer3.layer", 525312LL},
	{"block43.layer0.layer", 1048576LL}, {"block43.layer1.layer", 525312LL},
	{"block43.layer2.layer", 1704000LL}, {"block43.layer3.layer", 525312LL},
	{"block44.layer0.layer", 1048576LL}, {"block44.layer1.layer", 525312LL},
	{"block44.layer2.layer", 1704000LL}, {"block44.layer3.layer", 525312LL},
	{"block45.layer0.layer", 1048576LL}, {"block45.layer1.layer", 525312LL},
	{"block45.layer2.layer", 1704000LL}, {"block45.layer3.layer", 525312LL},
	{"block46.layer0.layer", 1048576LL}, {"block46.layer1.layer", 525312LL},
	{"block46.layer2.layer", 1704000LL}, {"block46.layer3.layer", 525312LL},
	{"block47.layer0.layer", 1048576LL}, {"block47.layer1.layer", 525312LL},
	{"block47.layer2.layer", 1704000LL}, {"block47.layer3.layer", 525312LL},
	{"block48.layer0.layer", 1574464LL}, {"block49.layer0.layer", 1311808LL},
	{"block50.layer0.layer", 1311808LL}, {"block51.layer0.layer", 1311808LL},
	{"block52.layer0.layer", 1311808LL}, {"block53.layer0.layer", 1311808LL},
	{"block54.layer0.layer", 1311808LL}, {"block55.layer0.layer", 1311808LL},
	{"block56.layer0.layer", 426816LL},	 {"block57.layer0.layer", 361024LL},
	{"block58.layer0.layer", 361024LL},	 {"block59.layer0.layer", 361024LL},
	{"block60.layer0.layer", 361024LL},	 {"block61.layer0.layer", 361024LL},
	{"block62.layer0.layer", 123328LL},	 {"block63.layer0.layer", 106816LL},
	{"block64.layer0.layer", 106816LL},	 {"block65.layer0.layer", 106816LL},
	{"block66.layer0.layer", 37120LL},	 {"block67.layer0.layer", 32960LL},
	{"block68.layer0.layer", 32960LL},	 {"block69.layer0.layer", 32960LL},
};

template <> void FDeploymentPlan<true>::BuildCalls()
{
	Calls.reserve(185);
	{ // cc_tinlayout_fused_swin_1h_32_1_inpview
		using FParameters = FWindowBlockC32InputViewFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_input_view_fp16),
							   Geometry->Grids[0], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(0));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(1));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(0));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[0]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[1]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[2]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[3]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[4]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[5]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1
		using FParameters = FWindowBlockC32Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_fp16), Geometry->Grids[1],
							   dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(1));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(2));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(1));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[6]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[7]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[8]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[9]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1
		using FParameters = FWindowBlockC32Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_fp16), Geometry->Grids[2],
							   dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(2));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(3));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(2));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[10]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[11]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[12]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[13]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_ds
		using FParameters = FWindowBlockC32DownsampleFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_downsample_fp16),
							   Geometry->Grids[3], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(3));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(4));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(3));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[14]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[15]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[16]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[17]);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(5));
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[18]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[19]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_inpview
		using FParameters = FWindowBlockC64InputViewFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_input_view_fp16),
							   Geometry->Grids[4], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(5));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(6));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(4));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[20]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[21]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[22]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[23]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[24]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[25]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2
		using FParameters = FWindowBlockC64Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_fp16), Geometry->Grids[5],
							   dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(6));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(7));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(5));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[26]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[27]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[28]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[29]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2
		using FParameters = FWindowBlockC64Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_fp16), Geometry->Grids[6],
							   dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(7));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(8));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(6));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[30]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[31]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[32]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[33]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_ds
		using FParameters = FWindowBlockC64DownsampleFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_downsample_fp16),
							   Geometry->Grids[7], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(8));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(9));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(7));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[34]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[35]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[36]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[37]);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(10));
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[38]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[39]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_inpview
		using FParameters = FWindowBlockC128InputViewFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_input_view_fp16),
							   Geometry->Grids[8], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(10));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(11));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(8));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[40]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[41]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[42]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[43]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[44]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[45]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4
		using FParameters = FWindowBlockC128Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_fp16), Geometry->Grids[9],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(11));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(12));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(9));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[46]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[47]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[48]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[49]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4
		using FParameters = FWindowBlockC128Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_fp16), Geometry->Grids[10],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(12));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(13));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(10));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[50]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[51]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[52]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[53]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4
		using FParameters = FWindowBlockC128Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_fp16), Geometry->Grids[11],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(13));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(14));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(11));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[54]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[55]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[56]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[57]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4
		using FParameters = FWindowBlockC128Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_fp16), Geometry->Grids[12],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(14));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(15));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(12));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[58]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[59]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[60]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[61]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_ds
		using FParameters = FWindowBlockC128DownsampleFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_downsample_fp16),
							   Geometry->Grids[13], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(15));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(16));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(13));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[62]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[63]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[64]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[65]);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(17));
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[66]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[67]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_inpview
		using FParameters = FWindowBlockC256InputViewFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_input_view_fp16),
							   Geometry->Grids[14], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(17));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(18));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(14));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[68]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[69]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[70]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[71]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[72]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[73]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[15],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(18));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(19));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(15));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[74]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[75]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[76]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[77]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[16],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(19));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(20));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(16));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[78]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[79]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[80]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[81]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[17],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(20));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(21));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(17));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[82]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[83]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[84]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[85]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[18],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(21));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(22));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(18));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[86]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[87]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[88]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[89]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[19],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(22));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(23));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(19));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[90]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[91]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[92]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[93]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[20],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(23));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(24));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(20));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[94]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[95]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[96]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[97]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_ds
		using FParameters = FWindowBlockC256DownsampleFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_downsample_fp16),
							   Geometry->Grids[21], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(24));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(25));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(21));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[98]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[99]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[100]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[101]);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(26));
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[102]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[103]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_inpview_512
		using FParameters = FWindowFfnInputViewC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_input_view_c512_fp16),
							   Geometry->Grids[22], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(27));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(22));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(26));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[104]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[105]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[106]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[107]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_inpview_512
		using FParameters = FWindowFfnProjectionInputViewC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_input_view_c512_fp16),
							   Geometry->Grids[23], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(28));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(23));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(26));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(27));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[108]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[109]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[24],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(29));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(24));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(28));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[110]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[111]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[112]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[113]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[25], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(30));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(25));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(28));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(29));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[114]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[115]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[26],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(31));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(26));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(30));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[116]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[117]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[118]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[119]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[27], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(32));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(27));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(30));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(31));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[120]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[121]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[28],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(33));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(28));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(32));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[122]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[123]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[124]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[125]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[29], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(34));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(29));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(32));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(33));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[126]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[127]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[30],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(35));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(30));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(34));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[128]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[129]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[130]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[131]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[31], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(36));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(31));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(34));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(35));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[132]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[133]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[32],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(37));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(32));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(36));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[134]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[135]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[136]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[137]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[33], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(38));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(33));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(36));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(37));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[138]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[139]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[34],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(39));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(34));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(38));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[140]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[141]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[142]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[143]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[35], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(40));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(35));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(38));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(39));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[144]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[145]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[36],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(41));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(36));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(40));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[146]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[147]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[148]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[149]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[37], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(42));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(37));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(40));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(41));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[150]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[151]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[38],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(43));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(38));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(42));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[152]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[153]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[154]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[155]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[39], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(44));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(39));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(42));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(43));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[156]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[157]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[40],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(45));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(40));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(44));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[158]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[159]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[160]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[161]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[41], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(46));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(41));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(44));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(45));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[162]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[163]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[42],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(47));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(42));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(46));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[164]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[165]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[166]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[167]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[43], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(48));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(43));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(46));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(47));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[168]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[169]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[44],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(49));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(44));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(48));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[170]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[171]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[172]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[173]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[45], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(50));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(45));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(48));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(49));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[174]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[175]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[46],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(51));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(46));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(50));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[176]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[177]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[178]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[179]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[47], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(52));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(47));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(50));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(51));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[180]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[181]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[48],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(53));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(48));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(52));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[182]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[183]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[184]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[185]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[49], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(54));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(49));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(52));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(53));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[186]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[187]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[50],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(55));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(50));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(54));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[188]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[189]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[190]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[191]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[51], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(56));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(51));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(54));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(55));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[192]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[193]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[52],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(57));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(52));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(56));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[194]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[195]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[196]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[197]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_pool_512
		using FParameters = FWindowAttentionProjectionPoolC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_pool_c512_fp16),
							   Geometry->Grids[53], dim3(32, 4, 1), 80, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(58));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(59));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(53));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(56));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(57));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[198]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[199]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[200]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[201]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_final_head_512
		using FParameters = FChannelProjectionC512ToC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&channel_projection_c512_to_c1024_fp16),
							   Geometry->Grids[54], dim3(32, 8, 1), 40, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(60));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(54));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(59));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[202]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[203]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_repack_2d_to_1d
		using FParameters = FGlobalRepackParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&repack_2d_to_1d_c1024_fp16),
							   Geometry->Grids[55], dim3(256, 1, 1), 24, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(60));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(61));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[204]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[205]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[56],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(69));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[206]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[57],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(70));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[207]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[58],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(71));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[208]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[59],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(72));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[209]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand
		using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16),
							   Geometry->Grids[60], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(61));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(62));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(55));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[210]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[211]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract
		using FParameters = FGlobalFfnContractC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16),
							   Geometry->Grids[61], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(62));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(61));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(63));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(56));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(69));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[212]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[213]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv
		using FParameters = FGlobalQkvC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[62],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(63));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(64));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(65));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(66));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(57));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(70));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[214]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[215]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained
		using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16),
							   Geometry->Grids[63], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(64));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(65));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(66));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(67));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(70));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(71));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[216]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[217]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection
		using FParameters = FGlobalProjectionC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16),
							   Geometry->Grids[64], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(67));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(63));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(68));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(58));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(72));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[218]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[219]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[65],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(80));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[220]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[66],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(81));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[221]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[67],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(82));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[222]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[68],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(83));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[223]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand
		using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16),
							   Geometry->Grids[69], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(68));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(73));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(59));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[224]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[225]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract
		using FParameters = FGlobalFfnContractC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16),
							   Geometry->Grids[70], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(73));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(68));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(74));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(60));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(80));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[226]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[227]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv
		using FParameters = FGlobalQkvC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[71],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(74));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(75));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(76));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(77));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(61));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(81));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[228]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[229]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained
		using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16),
							   Geometry->Grids[72], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(75));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(76));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(77));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(78));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(81));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(82));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[230]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[231]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection
		using FParameters = FGlobalProjectionC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16),
							   Geometry->Grids[73], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(78));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(74));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(79));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(62));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(83));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[232]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[233]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[74],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(91));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[234]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[75],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(92));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[235]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[76],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(93));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[236]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[77],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(94));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[237]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand
		using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16),
							   Geometry->Grids[78], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(79));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(84));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(63));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[238]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[239]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract
		using FParameters = FGlobalFfnContractC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16),
							   Geometry->Grids[79], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(84));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(79));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(85));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(64));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(91));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[240]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[241]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv
		using FParameters = FGlobalQkvC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[80],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(85));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(86));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(87));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(88));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(65));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(92));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[242]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[243]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained
		using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16),
							   Geometry->Grids[81], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(86));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(87));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(88));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(89));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(92));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(93));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[244]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[245]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection
		using FParameters = FGlobalProjectionC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16),
							   Geometry->Grids[82], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(89));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(85));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(90));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(66));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(94));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[246]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[247]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[83],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(102));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[248]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[84],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(103));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[249]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[85],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(104));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[250]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[86],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(105));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[251]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand
		using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16),
							   Geometry->Grids[87], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(90));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(95));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(67));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[252]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[253]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract
		using FParameters = FGlobalFfnContractC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16),
							   Geometry->Grids[88], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(95));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(90));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(96));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(68));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(102));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[254]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[255]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv
		using FParameters = FGlobalQkvC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[89],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(96));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(97));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(98));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(99));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(69));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(103));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[256]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[257]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained
		using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16),
							   Geometry->Grids[90], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(97));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(98));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(99));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(100));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(103));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(104));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[258]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[259]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection
		using FParameters = FGlobalProjectionC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16),
							   Geometry->Grids[91], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(100));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(96));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(101));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(70));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(105));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[260]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[261]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[92],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(113));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[262]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[93],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(114));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[263]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[94],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(115));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[264]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[95],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(116));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[265]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand
		using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16),
							   Geometry->Grids[96], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(101));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(106));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(71));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[266]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[267]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract
		using FParameters = FGlobalFfnContractC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16),
							   Geometry->Grids[97], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(106));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(101));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(107));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(72));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(113));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[268]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[269]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv
		using FParameters = FGlobalQkvC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[98],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(107));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(108));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(109));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(110));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(73));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(114));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[270]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[271]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained
		using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16),
							   Geometry->Grids[99], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(108));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(109));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(110));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(111));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(114));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(115));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[272]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[273]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection
		using FParameters = FGlobalProjectionC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16),
							   Geometry->Grids[100], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(111));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(107));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(112));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(74));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(116));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[274]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[275]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[101],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(124));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[276]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[102],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(125));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[277]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[103],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(126));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[278]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[104],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(127));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[279]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand
		using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16),
							   Geometry->Grids[105], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(112));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(117));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(75));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[280]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[281]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract
		using FParameters = FGlobalFfnContractC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16),
							   Geometry->Grids[106], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(117));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(112));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(118));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(76));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(124));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[282]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[283]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv
		using FParameters = FGlobalQkvC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[107],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(118));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(119));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(120));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(121));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(77));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(125));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[284]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[285]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained
		using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16),
							   Geometry->Grids[108], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(119));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(120));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(121));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(122));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(125));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(126));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[286]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[287]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection
		using FParameters = FGlobalProjectionC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16),
							   Geometry->Grids[109], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(122));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(118));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(123));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(78));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(127));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[288]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[289]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[110],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(135));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[290]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[111],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(136));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[291]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[112],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(137));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[292]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[113],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(138));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[293]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand
		using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16),
							   Geometry->Grids[114], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(123));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(128));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(79));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[294]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[295]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract
		using FParameters = FGlobalFfnContractC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16),
							   Geometry->Grids[115], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(128));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(123));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(129));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(80));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(135));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[296]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[297]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv
		using FParameters = FGlobalQkvC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[116],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(129));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(130));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(131));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(132));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(81));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(136));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[298]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[299]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained
		using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16),
							   Geometry->Grids[117], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(130));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(131));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(132));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(133));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(136));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(137));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[300]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[301]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection
		using FParameters = FGlobalProjectionC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16),
							   Geometry->Grids[118], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(133));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(129));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(134));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(82));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(138));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[302]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[303]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[119],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(146));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[304]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[120],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(147));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[305]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[121],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(148));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[306]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[122],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(149));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[307]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand
		using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16),
							   Geometry->Grids[123], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(134));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(139));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(83));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[308]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[309]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract
		using FParameters = FGlobalFfnContractC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16),
							   Geometry->Grids[124], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(139));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(134));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(140));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(84));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(146));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[310]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[311]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv
		using FParameters = FGlobalQkvC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[125],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(140));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(141));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(142));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(143));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(85));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(147));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[312]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[313]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained
		using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16),
							   Geometry->Grids[126], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(141));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(142));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(143));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(144));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(147));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(148));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[314]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[315]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection
		using FParameters = FGlobalProjectionC1024Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16),
							   Geometry->Grids[127], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(144));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(140));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(145));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(86));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(149));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[316]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[317]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_repack_1d_to_2d
		using FParameters = FGlobalRepackParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&repack_1d_to_2d_c1024_fp16),
							   Geometry->Grids[128], dim3(256, 1, 1), 24, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(145));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(150));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[318]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[319]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[129],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(152));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[320]);
		Calls.push_back(KernelCall);
	}
	{ // cc_dec_input_upsample_1024_512
		using FParameters = FDecoderUpsampleC1024ToC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&decoder_upsample_c1024_to_c512_fp16),
							   Geometry->Grids[130], dim3(32, 2, 1), 80, true};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(150));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(58));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(151));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(152));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(153));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(87));
		KernelCall.Set<int32_t>(offsetof(FParameters, InputHeight), Geometry->GeometryArguments[321]);
		KernelCall.Set<int32_t>(offsetof(FParameters, InputWidth), Geometry->GeometryArguments[322]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OutputHeight), Geometry->GeometryArguments[323]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OutputWidth), Geometry->GeometryArguments[324]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[131],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(154));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(88));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(151));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[325]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[326]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[327]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[328]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[132], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(155));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(89));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(151));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(154));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[329]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[330]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[133],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(156));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(90));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(155));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[331]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[332]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[333]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[334]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[134], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(157));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(91));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(155));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(156));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[335]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[336]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[135],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(158));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(92));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(157));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[337]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[338]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[339]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[340]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[136], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(159));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(93));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(157));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(158));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[341]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[342]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[137],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(160));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(94));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(159));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[343]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[344]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[345]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[346]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[138], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(161));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(95));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(159));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(160));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[347]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[348]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[139],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(162));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(96));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(161));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[349]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[350]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[351]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[352]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[140], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(163));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(97));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(161));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(162));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[353]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[354]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[141],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(164));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(98));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(163));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[355]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[356]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[357]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[358]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[142], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(165));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(99));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(163));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(164));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[359]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[360]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[143],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(166));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(100));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(165));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[361]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[362]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[363]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[364]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[144], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(167));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(101));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(165));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(166));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[365]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[366]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[145],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(168));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(102));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(167));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[367]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[368]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[369]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[370]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[146], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(169));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(103));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(167));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(168));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[371]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[372]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[147],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(170));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(104));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(169));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[373]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[374]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[375]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[376]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[148], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(171));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(105));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(169));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(170));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[377]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[378]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[149],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(172));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(106));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(171));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[379]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[380]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[381]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[382]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[150], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(173));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(107));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(171));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(172));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[383]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[384]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[151],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(174));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(108));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(173));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[385]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[386]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[387]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[388]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[152], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(175));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(109));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(173));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(174));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[389]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[390]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[153],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(176));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(110));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(175));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[391]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[392]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[393]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[394]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[154], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(177));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(111));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(175));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(176));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[395]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[396]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[155],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(178));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(112));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(177));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[397]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[398]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[399]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[400]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[156], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(179));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(113));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(177));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(178));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[401]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[402]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[157],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(180));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(114));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(179));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[403]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[404]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[405]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[406]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512
		using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_c512_fp16),
							   Geometry->Grids[158], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(181));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(115));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(179));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(180));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[407]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[408]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512
		using FParameters = FWindowFfnC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[159],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(182));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(116));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(181));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[409]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[410]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[411]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[412]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512
		using FParameters = FWindowFfnProjectionC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_c512_fp16),
							   Geometry->Grids[160], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(183));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(117));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(181));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(182));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[413]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[414]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512
		using FParameters = FWindowQkvC512Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[161],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(184));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(118));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(183));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[415]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[416]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[417]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[418]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_outview
		using FParameters = FWindowAttentionProjectionOutputViewC512Fp16Parameters;
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&window_attention_projection_output_view_c512_fp16),
			Geometry->Grids[162], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(185));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(119));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(183));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(184));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[419]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[420]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_upsample
		using FParameters = FWindowBlockC256UpsampleFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_upsample_fp16),
							   Geometry->Grids[163], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(185));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(186));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(120));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[421]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[422]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[423]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[424]);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(25));
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[164],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(186));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(187));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(121));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[425]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[426]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[427]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[428]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[165],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(187));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(188));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(122));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[429]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[430]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[431]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[432]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[166],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(188));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(189));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(123));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[433]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[434]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[435]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[436]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[167],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(189));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(190));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(124));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[437]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[438]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[439]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[440]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[168],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(190));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(191));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(125));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[441]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[442]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[443]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[444]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8
		using FParameters = FWindowBlockC256Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_fp16), Geometry->Grids[169],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(191));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(192));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(126));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[445]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[446]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[447]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[448]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_outview
		using FParameters = FWindowBlockC256OutputViewFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c256_output_view_fp16),
							   Geometry->Grids[170], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(192));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(193));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(127));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[449]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[450]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[451]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[452]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[453]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[454]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_upsample
		using FParameters = FWindowBlockC128UpsampleFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_upsample_fp16),
							   Geometry->Grids[171], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(193));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(194));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(128));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[455]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[456]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[457]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[458]);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(16));
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4
		using FParameters = FWindowBlockC128Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_fp16), Geometry->Grids[172],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(194));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(195));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(129));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[459]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[460]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[461]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[462]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4
		using FParameters = FWindowBlockC128Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_fp16), Geometry->Grids[173],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(195));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(196));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(130));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[463]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[464]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[465]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[466]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4
		using FParameters = FWindowBlockC128Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_fp16), Geometry->Grids[174],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(196));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(197));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(131));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[467]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[468]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[469]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[470]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4
		using FParameters = FWindowBlockC128Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_fp16), Geometry->Grids[175],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(197));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(198));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(132));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[471]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[472]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[473]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[474]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_outview
		using FParameters = FWindowBlockC128OutputViewFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c128_output_view_fp16),
							   Geometry->Grids[176], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(198));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(199));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(133));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[475]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[476]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[477]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[478]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[479]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[480]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_upsample
		using FParameters = FWindowBlockC64UpsampleFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_upsample_fp16),
							   Geometry->Grids[177], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(199));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(200));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(134));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[481]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[482]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[483]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[484]);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(9));
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2
		using FParameters = FWindowBlockC64Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_fp16), Geometry->Grids[178],
							   dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(200));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(201));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(135));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[485]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[486]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[487]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[488]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2
		using FParameters = FWindowBlockC64Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_fp16), Geometry->Grids[179],
							   dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(201));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(202));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(136));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[489]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[490]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[491]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[492]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_outview
		using FParameters = FWindowBlockC64OutputViewFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_output_view_fp16),
							   Geometry->Grids[180], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(202));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(203));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(137));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[493]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[494]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[495]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[496]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[497]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[498]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_upsample
		using FParameters = FWindowBlockC32UpsampleFp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_upsample_fp16),
							   Geometry->Grids[181], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(203));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(204));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(138));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[499]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[500]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[501]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[502]);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(4));
		KernelCall.Set<int32_t>(offsetof(FParameters, ResidualHeight), Geometry->GeometryArguments[503]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ResidualWidth), Geometry->GeometryArguments[504]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1
		using FParameters = FWindowBlockC32Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_fp16), Geometry->Grids[182],
							   dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(204));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(205));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(139));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[505]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[506]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[507]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[508]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1
		using FParameters = FWindowBlockC32Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_fp16), Geometry->Grids[183],
							   dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(205));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(206));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(140));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[509]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[510]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[511]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[512]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1
		using FParameters = FWindowBlockC32Fp16Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_fp16), Geometry->Grids[184],
							   dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(206));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(207));
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(141));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[513]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[514]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[515]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[516]);
		Calls.push_back(KernelCall);
	}
}
