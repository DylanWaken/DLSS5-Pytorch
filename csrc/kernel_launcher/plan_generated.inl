// Generated shared native FP8 schedule. Every resolution uses the same 185 calls.
// Buffer names are shared; the geometry table supplies their actual byte extents.
static const char* BufferNameTable_fp8[] = {
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
	"b31.contract_scratch",
	"b31.qkv_counter",
	"b31.qkv_scratch",
	"b31.attention_counter",
	"b31.projection_counter",
	"b31.projection_scratch",
	"b32.expanded",
	"b32.contracted",
	"b32.Q",
	"b32.K",
	"b32.V",
	"b32.attended",
	"b32.output",
	"b32.contract_counter",
	"b32.contract_scratch",
	"b32.qkv_counter",
	"b32.qkv_scratch",
	"b32.attention_counter",
	"b32.projection_counter",
	"b32.projection_scratch",
	"b33.expanded",
	"b33.contracted",
	"b33.Q",
	"b33.K",
	"b33.V",
	"b33.attended",
	"b33.output",
	"b33.contract_counter",
	"b33.contract_scratch",
	"b33.qkv_counter",
	"b33.qkv_scratch",
	"b33.attention_counter",
	"b33.projection_counter",
	"b33.projection_scratch",
	"b34.expanded",
	"b34.contracted",
	"b34.Q",
	"b34.K",
	"b34.V",
	"b34.attended",
	"b34.output",
	"b34.contract_counter",
	"b34.contract_scratch",
	"b34.qkv_counter",
	"b34.qkv_scratch",
	"b34.attention_counter",
	"b34.projection_counter",
	"b34.projection_scratch",
	"b35.expanded",
	"b35.contracted",
	"b35.Q",
	"b35.K",
	"b35.V",
	"b35.attended",
	"b35.output",
	"b35.contract_counter",
	"b35.contract_scratch",
	"b35.qkv_counter",
	"b35.qkv_scratch",
	"b35.attention_counter",
	"b35.projection_counter",
	"b35.projection_scratch",
	"b36.expanded",
	"b36.contracted",
	"b36.Q",
	"b36.K",
	"b36.V",
	"b36.attended",
	"b36.output",
	"b36.contract_counter",
	"b36.contract_scratch",
	"b36.qkv_counter",
	"b36.qkv_scratch",
	"b36.attention_counter",
	"b36.projection_counter",
	"b36.projection_scratch",
	"b37.expanded",
	"b37.contracted",
	"b37.Q",
	"b37.K",
	"b37.V",
	"b37.attended",
	"b37.output",
	"b37.contract_counter",
	"b37.contract_scratch",
	"b37.qkv_counter",
	"b37.qkv_scratch",
	"b37.attention_counter",
	"b37.projection_counter",
	"b37.projection_scratch",
	"b38.expanded",
	"b38.contracted",
	"b38.Q",
	"b38.K",
	"b38.V",
	"b38.attended",
	"b38.output",
	"b38.contract_counter",
	"b38.contract_scratch",
	"b38.qkv_counter",
	"b38.qkv_scratch",
	"b38.attention_counter",
	"b38.projection_counter",
	"b38.projection_scratch",
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
static const FBufferSpec RecordSpecs_fp8[] = {
	{"block1.layer0.layer", 20672LL},	 {"block2.layer0.layer", 20672LL},
	{"block3.layer0.layer", 20672LL},	 {"block4.layer0.layer", 22720LL},
	{"block5.layer0.layer", 61760LL},	 {"block6.layer0.layer", 61760LL},
	{"block7.layer0.layer", 61760LL},	 {"block8.layer0.layer", 69936LL},
	{"block9.layer0.layer", 197184LL},	 {"block10.layer0.layer", 197184LL},
	{"block11.layer0.layer", 197184LL},	 {"block12.layer0.layer", 197184LL},
	{"block13.layer0.layer", 197184LL},	 {"block14.layer0.layer", 229936LL},
	{"block15.layer0.layer", 689232LL},	 {"block16.layer0.layer", 689232LL},
	{"block17.layer0.layer", 689232LL},	 {"block18.layer0.layer", 689232LL},
	{"block19.layer0.layer", 689232LL},	 {"block20.layer0.layer", 689232LL},
	{"block21.layer0.layer", 689232LL},	 {"block22.layer0.layer", 820288LL},
	{"block23.layer0.layer", 524288LL},	 {"block23.layer1.layer", 263168LL},
	{"block23.layer2.layer", 917568LL},	 {"block23.layer3.layer", 263168LL},
	{"block24.layer0.layer", 524288LL},	 {"block24.layer1.layer", 263168LL},
	{"block24.layer2.layer", 917568LL},	 {"block24.layer3.layer", 263168LL},
	{"block25.layer0.layer", 524288LL},	 {"block25.layer1.layer", 263168LL},
	{"block25.layer2.layer", 917568LL},	 {"block25.layer3.layer", 263168LL},
	{"block26.layer0.layer", 524288LL},	 {"block26.layer1.layer", 263168LL},
	{"block26.layer2.layer", 917568LL},	 {"block26.layer3.layer", 263168LL},
	{"block27.layer0.layer", 524288LL},	 {"block27.layer1.layer", 263168LL},
	{"block27.layer2.layer", 917568LL},	 {"block27.layer3.layer", 263168LL},
	{"block28.layer0.layer", 524288LL},	 {"block28.layer1.layer", 263168LL},
	{"block28.layer2.layer", 917568LL},	 {"block28.layer3.layer", 263168LL},
	{"block29.layer0.layer", 524288LL},	 {"block29.layer1.layer", 263168LL},
	{"block29.layer2.layer", 917568LL},	 {"block29.layer3.layer", 263168LL},
	{"block30.layer0.layer", 524288LL},	 {"block30.layer1.layer", 263168LL},
	{"block30.layer2.layer", 917568LL},	 {"block30.layer3.layer", 263168LL},
	{"block30.layer4.layer", 524304LL},	 {"block31.layer0.layer", 4194320LL},
	{"block31.layer1.layer", 4196352LL}, {"block31.layer2.layer", 3145856LL},
	{"block31.layer4.layer", 1050624LL}, {"block32.layer0.layer", 4194320LL},
	{"block32.layer1.layer", 4196352LL}, {"block32.layer2.layer", 3145856LL},
	{"block32.layer4.layer", 1050624LL}, {"block33.layer0.layer", 4194320LL},
	{"block33.layer1.layer", 4196352LL}, {"block33.layer2.layer", 3145856LL},
	{"block33.layer4.layer", 1050624LL}, {"block34.layer0.layer", 4194320LL},
	{"block34.layer1.layer", 4196352LL}, {"block34.layer2.layer", 3145856LL},
	{"block34.layer4.layer", 1050624LL}, {"block35.layer0.layer", 4194320LL},
	{"block35.layer1.layer", 4196352LL}, {"block35.layer2.layer", 3145856LL},
	{"block35.layer4.layer", 1050624LL}, {"block36.layer0.layer", 4194320LL},
	{"block36.layer1.layer", 4196352LL}, {"block36.layer2.layer", 3145856LL},
	{"block36.layer4.layer", 1050624LL}, {"block37.layer0.layer", 4194320LL},
	{"block37.layer1.layer", 4196352LL}, {"block37.layer2.layer", 3145856LL},
	{"block37.layer4.layer", 1050624LL}, {"block38.layer0.layer", 4194320LL},
	{"block38.layer1.layer", 4196352LL}, {"block38.layer2.layer", 3145856LL},
	{"block38.layer4.layer", 1050624LL}, {"block39.layer0.layer", 525312LL},
	{"block40.layer0.layer", 524288LL},	 {"block40.layer1.layer", 263168LL},
	{"block40.layer2.layer", 917568LL},	 {"block40.layer3.layer", 263168LL},
	{"block41.layer0.layer", 524288LL},	 {"block41.layer1.layer", 263168LL},
	{"block41.layer2.layer", 917568LL},	 {"block41.layer3.layer", 263168LL},
	{"block42.layer0.layer", 524288LL},	 {"block42.layer1.layer", 263168LL},
	{"block42.layer2.layer", 917568LL},	 {"block42.layer3.layer", 263168LL},
	{"block43.layer0.layer", 524288LL},	 {"block43.layer1.layer", 263168LL},
	{"block43.layer2.layer", 917568LL},	 {"block43.layer3.layer", 263168LL},
	{"block44.layer0.layer", 524288LL},	 {"block44.layer1.layer", 263168LL},
	{"block44.layer2.layer", 917568LL},	 {"block44.layer3.layer", 263168LL},
	{"block45.layer0.layer", 524288LL},	 {"block45.layer1.layer", 263168LL},
	{"block45.layer2.layer", 917568LL},	 {"block45.layer3.layer", 263168LL},
	{"block46.layer0.layer", 524288LL},	 {"block46.layer1.layer", 263168LL},
	{"block46.layer2.layer", 917568LL},	 {"block46.layer3.layer", 263168LL},
	{"block47.layer0.layer", 524288LL},	 {"block47.layer1.layer", 263168LL},
	{"block47.layer2.layer", 917568LL},	 {"block47.layer3.layer", 263168LL},
	{"block48.layer0.layer", 820784LL},	 {"block49.layer0.layer", 689232LL},
	{"block50.layer0.layer", 689232LL},	 {"block51.layer0.layer", 689232LL},
	{"block52.layer0.layer", 689232LL},	 {"block53.layer0.layer", 689232LL},
	{"block54.layer0.layer", 689232LL},	 {"block55.layer0.layer", 689232LL},
	{"block56.layer0.layer", 230176LL},	 {"block57.layer0.layer", 197184LL},
	{"block58.layer0.layer", 197184LL},	 {"block59.layer0.layer", 197184LL},
	{"block60.layer0.layer", 197184LL},	 {"block61.layer0.layer", 197184LL},
	{"block62.layer0.layer", 70048LL},	 {"block63.layer0.layer", 61760LL},
	{"block64.layer0.layer", 61760LL},	 {"block65.layer0.layer", 61760LL},
	{"block66.layer0.layer", 22784LL},	 {"block67.layer0.layer", 20672LL},
	{"block68.layer0.layer", 20672LL},	 {"block69.layer0.layer", 20672LL},
};

template <> void FDeploymentPlan<false>::BuildCalls()
{
	Calls.reserve(185);
	{ // cc_tinlayout_fused_swin_1h_32_1_inpview_fp8
		using FParameters = FWindowBlockC32InputViewFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c32_input_view_fp8(), Geometry->Grids[0], dim3(32, 1, 1),
							   96, false};
		KernelCall.Name = "window_block_c32_input_view_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 0, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(0));
		KernelCall.Bind(offsetof(FParameters, g_Output), 1, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(1));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 0, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(0));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[0]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[1]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[2]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[3]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[4]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[5]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		using FParameters = FWindowBlockC32Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c32_fp8(), Geometry->Grids[1], dim3(32, 1, 1), 96, false};
		KernelCall.Name = "window_block_c32_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 1, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(1));
		KernelCall.Bind(offsetof(FParameters, g_Output), 2, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(2));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 1, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(1));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[6]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[7]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[8]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[9]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		using FParameters = FWindowBlockC32Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c32_fp8(), Geometry->Grids[2], dim3(32, 1, 1), 96, false};
		KernelCall.Name = "window_block_c32_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 2, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(2));
		KernelCall.Bind(offsetof(FParameters, g_Output), 3, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(3));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 2, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(2));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[10]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[11]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[12]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[13]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_ds_fp8
		using FParameters = FWindowBlockC32DownsampleFp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_downsample_fp8),
							   Geometry->Grids[3], dim3(32, 1, 1), 96, false};
		KernelCall.Name = "window_block_c32_downsample_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 3, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(3));
		KernelCall.Bind(offsetof(FParameters, g_Output), 4, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(4));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 3, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(3));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[14]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[15]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[16]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[17]);
		KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 5, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(5));
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[18]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[19]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_inpview_fp8
		using FParameters = FWindowBlockC64InputViewFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c64_input_view_fp8(), Geometry->Grids[4], dim3(32, 2, 1),
							   88, false};
		KernelCall.Name = "window_block_c64_input_view_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 5, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(5));
		KernelCall.Bind(offsetof(FParameters, g_Output), 6, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(6));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 4, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(4));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[20]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[21]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[22]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[23]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[24]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[25]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_fp8
		using FParameters = FWindowBlockC64Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c64_fp8(), Geometry->Grids[5], dim3(32, 2, 1), 88, false};
		KernelCall.Name = "window_block_c64_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 6, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(6));
		KernelCall.Bind(offsetof(FParameters, g_Output), 7, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(7));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 5, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(5));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[26]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[27]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[28]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[29]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_fp8
		using FParameters = FWindowBlockC64Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c64_fp8(), Geometry->Grids[6], dim3(32, 2, 1), 88, false};
		KernelCall.Name = "window_block_c64_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 7, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(7));
		KernelCall.Bind(offsetof(FParameters, g_Output), 8, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(8));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 6, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(6));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[30]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[31]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[32]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[33]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_ds_fp8
		using FParameters = FWindowBlockC64DownsampleFp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_downsample_fp8),
							   Geometry->Grids[7], dim3(32, 2, 1), 88, false};
		KernelCall.Name = "window_block_c64_downsample_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 8, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(8));
		KernelCall.Bind(offsetof(FParameters, g_Output), 9, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(9));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 7, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(7));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[34]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[35]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[36]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[37]);
		KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 10, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(10));
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[38]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[39]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_inpview_fp8
		using FParameters = FWindowBlockC128InputViewFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_input_view_fp8(), Geometry->Grids[8], dim3(32, 4, 1),
							   88, false};
		KernelCall.Name = "window_block_c128_input_view_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 10, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(10));
		KernelCall.Bind(offsetof(FParameters, g_Output), 11, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(11));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 8, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(8));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[40]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[41]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[42]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[43]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[44]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[45]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		using FParameters = FWindowBlockC128Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_fp8(), Geometry->Grids[9], dim3(32, 4, 1), 88,
							   false};
		KernelCall.Name = "window_block_c128_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 11, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(11));
		KernelCall.Bind(offsetof(FParameters, g_Output), 12, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(12));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 9, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(9));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[46]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[47]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[48]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[49]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		using FParameters = FWindowBlockC128Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_fp8(), Geometry->Grids[10], dim3(32, 4, 1), 88,
							   false};
		KernelCall.Name = "window_block_c128_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 12, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(12));
		KernelCall.Bind(offsetof(FParameters, g_Output), 13, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(13));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 10, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(10));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[50]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[51]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[52]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[53]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		using FParameters = FWindowBlockC128Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_fp8(), Geometry->Grids[11], dim3(32, 4, 1), 88,
							   false};
		KernelCall.Name = "window_block_c128_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 13, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(13));
		KernelCall.Bind(offsetof(FParameters, g_Output), 14, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(14));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 11, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(11));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[54]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[55]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[56]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[57]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		using FParameters = FWindowBlockC128Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_fp8(), Geometry->Grids[12], dim3(32, 4, 1), 88,
							   false};
		KernelCall.Name = "window_block_c128_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 14, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(14));
		KernelCall.Bind(offsetof(FParameters, g_Output), 15, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(15));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 12, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(12));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[58]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[59]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[60]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[61]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_ds_fp8
		using FParameters = FWindowBlockC128DownsampleFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_downsample_fp8(), Geometry->Grids[13],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Name = "window_block_c128_downsample_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 15, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(15));
		KernelCall.Bind(offsetof(FParameters, g_Output), 16, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(16));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 13, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(13));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[62]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[63]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[64]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[65]);
		KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 17, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(17));
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[66]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[67]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_inpview_fp8
		using FParameters = FWindowBlockC256InputViewFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_input_view_fp8(), Geometry->Grids[14],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Name = "window_block_c256_input_view_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 17, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(17));
		KernelCall.Bind(offsetof(FParameters, g_Output), 18, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(18));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 14, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(14));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[68]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[69]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[70]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[71]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[72]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[73]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[15], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 18, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(18));
		KernelCall.Bind(offsetof(FParameters, g_Output), 19, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(19));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 15, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(15));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[74]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[75]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[76]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[77]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[16], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 19, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(19));
		KernelCall.Bind(offsetof(FParameters, g_Output), 20, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(20));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 16, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(16));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[78]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[79]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[80]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[81]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[17], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 20, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(20));
		KernelCall.Bind(offsetof(FParameters, g_Output), 21, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(21));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 17, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(17));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[82]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[83]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[84]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[85]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[18], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 21, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(21));
		KernelCall.Bind(offsetof(FParameters, g_Output), 22, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(22));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 18, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(18));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[86]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[87]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[88]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[89]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[19], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 22, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(22));
		KernelCall.Bind(offsetof(FParameters, g_Output), 23, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(23));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 19, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(19));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[90]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[91]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[92]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[93]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[20], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 23, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(23));
		KernelCall.Bind(offsetof(FParameters, g_Output), 24, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(24));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 20, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(20));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[94]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[95]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[96]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[97]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_ds_fp8
		using FParameters = FWindowBlockC256DownsampleFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_downsample_fp8(), Geometry->Grids[21],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Name = "window_block_c256_downsample_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 24, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(24));
		KernelCall.Bind(offsetof(FParameters, g_Output), 25, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(25));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 21, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(21));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[98]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[99]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[100]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[101]);
		KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 26, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(26));
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[102]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[103]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_inpview_512_fp8
		using FParameters = FWindowFfnInputViewC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_input_view_c512_fp8),
							   Geometry->Grids[22], dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_ffn_input_view_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 27, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(27));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 22, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(22));
		KernelCall.Bind(offsetof(FParameters, g_Input), 26, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(26));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[104]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[105]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[106]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[107]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_inpview_512_fp8
		using FParameters = FWindowFfnProjectionInputViewC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_input_view_c512_fp8),
							   Geometry->Grids[23], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "window_ffn_projection_input_view_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 28, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(28));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 23, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(23));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 26, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(26));
		KernelCall.Bind(offsetof(FParameters, g_Input), 27, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(27));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[108]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[109]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[24],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 29, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(29));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 24, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(24));
		KernelCall.Bind(offsetof(FParameters, g_Input), 28, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(28));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[110]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[111]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[112]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[113]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[25],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 30, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(30));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 25, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(25));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 28, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(28));
		KernelCall.Bind(offsetof(FParameters, g_Input), 29, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(29));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[114]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[115]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[26],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 31, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(31));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 26, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(26));
		KernelCall.Bind(offsetof(FParameters, g_Input), 30, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(30));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[116]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[117]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[118]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[119]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[27], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 32, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(32));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 27, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(27));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 30, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(30));
		KernelCall.Bind(offsetof(FParameters, g_Input), 31, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(31));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[120]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[121]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[28],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 33, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(33));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 28, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(28));
		KernelCall.Bind(offsetof(FParameters, g_Input), 32, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(32));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[122]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[123]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[124]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[125]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[29],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 34, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(34));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 29, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(29));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 32, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(32));
		KernelCall.Bind(offsetof(FParameters, g_Input), 33, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(33));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[126]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[127]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[30],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 35, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(35));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 30, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(30));
		KernelCall.Bind(offsetof(FParameters, g_Input), 34, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(34));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[128]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[129]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[130]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[131]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[31], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 36, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(36));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 31, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(31));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 34, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(34));
		KernelCall.Bind(offsetof(FParameters, g_Input), 35, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(35));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[132]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[133]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[32],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 37, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(37));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 32, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(32));
		KernelCall.Bind(offsetof(FParameters, g_Input), 36, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(36));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[134]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[135]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[136]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[137]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[33],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 38, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(38));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 33, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(33));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 36, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(36));
		KernelCall.Bind(offsetof(FParameters, g_Input), 37, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(37));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[138]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[139]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[34],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 39, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(39));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 34, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(34));
		KernelCall.Bind(offsetof(FParameters, g_Input), 38, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(38));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[140]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[141]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[142]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[143]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[35], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 40, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(40));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 35, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(35));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 38, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(38));
		KernelCall.Bind(offsetof(FParameters, g_Input), 39, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(39));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[144]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[145]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[36],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 41, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(41));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 36, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(36));
		KernelCall.Bind(offsetof(FParameters, g_Input), 40, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(40));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[146]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[147]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[148]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[149]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[37],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 42, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(42));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 37, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(37));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 40, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(40));
		KernelCall.Bind(offsetof(FParameters, g_Input), 41, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(41));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[150]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[151]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[38],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 43, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(43));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 38, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(38));
		KernelCall.Bind(offsetof(FParameters, g_Input), 42, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(42));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[152]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[153]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[154]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[155]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[39], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 44, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(44));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 39, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(39));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 42, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(42));
		KernelCall.Bind(offsetof(FParameters, g_Input), 43, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(43));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[156]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[157]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[40],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 45, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(45));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 40, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(40));
		KernelCall.Bind(offsetof(FParameters, g_Input), 44, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(44));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[158]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[159]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[160]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[161]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[41],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 46, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(46));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 41, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(41));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 44, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(44));
		KernelCall.Bind(offsetof(FParameters, g_Input), 45, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(45));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[162]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[163]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[42],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 47, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(47));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 42, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(42));
		KernelCall.Bind(offsetof(FParameters, g_Input), 46, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(46));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[164]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[165]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[166]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[167]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[43], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 48, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(48));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 43, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(43));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 46, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(46));
		KernelCall.Bind(offsetof(FParameters, g_Input), 47, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(47));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[168]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[169]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[44],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 49, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(49));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 44, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(44));
		KernelCall.Bind(offsetof(FParameters, g_Input), 48, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(48));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[170]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[171]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[172]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[173]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[45],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 50, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(50));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 45, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(45));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 48, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(48));
		KernelCall.Bind(offsetof(FParameters, g_Input), 49, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(49));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[174]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[175]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[46],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 51, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(51));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 46, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(46));
		KernelCall.Bind(offsetof(FParameters, g_Input), 50, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(50));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[176]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[177]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[178]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[179]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[47], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 52, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(52));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 47, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(47));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 50, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(50));
		KernelCall.Bind(offsetof(FParameters, g_Input), 51, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(51));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[180]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[181]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[48],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 53, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(53));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 48, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(48));
		KernelCall.Bind(offsetof(FParameters, g_Input), 52, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(52));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[182]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[183]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[184]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[185]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[49],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 54, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(54));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 49, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(49));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 52, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(52));
		KernelCall.Bind(offsetof(FParameters, g_Input), 53, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(53));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[186]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[187]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[50],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 55, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(55));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 50, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(50));
		KernelCall.Bind(offsetof(FParameters, g_Input), 54, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(54));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[188]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[189]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[190]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[191]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[51], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 56, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(56));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 51, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(51));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 54, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(54));
		KernelCall.Bind(offsetof(FParameters, g_Input), 55, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(55));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[192]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[193]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[52],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 57, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(57));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 52, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(52));
		KernelCall.Bind(offsetof(FParameters, g_Input), 56, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(56));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[194]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[195]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[196]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[197]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_pool_512_fp8
		using FParameters = FWindowAttentionProjectionPoolC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_pool_c512_fp8),
							   Geometry->Grids[53], dim3(32, 4, 1), 80, false};
		KernelCall.Name = "window_attention_projection_pool_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 58, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(58));
		KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 59, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(59));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 53, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(53));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 56, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(56));
		KernelCall.Bind(offsetof(FParameters, g_Input), 57, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(57));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[198]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[199]);
		KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[200]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[201]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_final_head_512_fp8
		using FParameters = FChannelProjectionC512ToC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&channel_projection_c512_to_c1024_fp8),
							   Geometry->Grids[54], dim3(32, 8, 1), 40, false};
		KernelCall.Name = "channel_projection_c512_to_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 60, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(60));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 54, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(54));
		KernelCall.Bind(offsetof(FParameters, g_Input), 59, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(59));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[202]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[203]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_repack_2d_to_1d_fp8
		using FParameters = FGlobalRepackParameters;
		FKernelCall KernelCall{Resolve_repack_2d_to_1d_c1024_fp8(), Geometry->Grids[55], dim3(256, 1, 1), 24,
							   false};
		KernelCall.Name = "repack_2d_to_1d_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 60, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(60));
		KernelCall.Bind(offsetof(FParameters, g_Output), 61, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(61));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[204]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[205]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[56],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 69, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(69));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[206]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[57],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 71, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(71));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[207]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[58],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 73, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(73));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[208]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[59],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 74, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(74));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[209]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8),
							   Geometry->Grids[60], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "global_ffn_expand_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 61, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(61));
		KernelCall.Bind(offsetof(FParameters, g_Output), 62, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(62));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 55, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(55));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[210]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[211]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		using FParameters = FGlobalFfnContractC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[61], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_ffn_contract_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 62, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(62));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 61, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(61));
		KernelCall.Bind(offsetof(FParameters, g_Output), 63, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(63));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 56, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(56));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 69, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(69));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 70, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(70));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[212]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[213]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		using FParameters = FGlobalQkvC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[62],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Name = "global_qkv_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 63, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(63));
		KernelCall.Bind(offsetof(FParameters, g_Query), 64, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(64));
		KernelCall.Bind(offsetof(FParameters, g_Key), 65, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(65));
		KernelCall.Bind(offsetof(FParameters, g_Value), 66, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(66));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 57, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(57));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 71, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(71));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 72, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(72));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[214]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[215]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp8),
							   Geometry->Grids[63], dim3(32, 4, 1), 64, false};
		KernelCall.Name = "global_attention_chained_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Query), 64, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(64));
		KernelCall.Bind(offsetof(FParameters, g_Key), 65, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(65));
		KernelCall.Bind(offsetof(FParameters, g_Value), 66, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(66));
		KernelCall.Bind(offsetof(FParameters, g_Output), 67, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(67));
		KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 71, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(71));
		KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 73, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(73));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[216]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[217]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		using FParameters = FGlobalProjectionC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[64], dim3(32, 4, 1), 72,
							   true};
		KernelCall.Name = "global_projection_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 67, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(67));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 63, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(63));
		KernelCall.Bind(offsetof(FParameters, g_Output), 68, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(68));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 58, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(58));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 74, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(74));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 75, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(75));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[218]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[219]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[65],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 83, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(83));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[220]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[66],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 85, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(85));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[221]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[67],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 87, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(87));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[222]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[68],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 88, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(88));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[223]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8),
							   Geometry->Grids[69], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "global_ffn_expand_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 68, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(68));
		KernelCall.Bind(offsetof(FParameters, g_Output), 76, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(76));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 59, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(59));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[224]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[225]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		using FParameters = FGlobalFfnContractC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[70], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_ffn_contract_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 76, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(76));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 68, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(68));
		KernelCall.Bind(offsetof(FParameters, g_Output), 77, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(77));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 60, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(60));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 83, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(83));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 84, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(84));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[226]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[227]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		using FParameters = FGlobalQkvC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[71],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Name = "global_qkv_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 77, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(77));
		KernelCall.Bind(offsetof(FParameters, g_Query), 78, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(78));
		KernelCall.Bind(offsetof(FParameters, g_Key), 79, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(79));
		KernelCall.Bind(offsetof(FParameters, g_Value), 80, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(80));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 61, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(61));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 85, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(85));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 86, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(86));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[228]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[229]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp8),
							   Geometry->Grids[72], dim3(32, 4, 1), 64, false};
		KernelCall.Name = "global_attention_chained_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Query), 78, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(78));
		KernelCall.Bind(offsetof(FParameters, g_Key), 79, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(79));
		KernelCall.Bind(offsetof(FParameters, g_Value), 80, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(80));
		KernelCall.Bind(offsetof(FParameters, g_Output), 81, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(81));
		KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 85, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(85));
		KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 87, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(87));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[230]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[231]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		using FParameters = FGlobalProjectionC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[73], dim3(32, 4, 1), 72,
							   true};
		KernelCall.Name = "global_projection_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 81, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(81));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 77, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(77));
		KernelCall.Bind(offsetof(FParameters, g_Output), 82, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(82));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 62, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(62));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 88, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(88));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 89, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(89));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[232]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[233]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[74],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 97, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(97));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[234]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[75],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 99, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(99));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[235]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[76],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 101, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(101));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[236]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[77],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 102, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(102));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[237]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8),
							   Geometry->Grids[78], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "global_ffn_expand_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 82, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(82));
		KernelCall.Bind(offsetof(FParameters, g_Output), 90, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(90));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 63, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(63));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[238]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[239]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		using FParameters = FGlobalFfnContractC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[79], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_ffn_contract_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 90, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(90));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 82, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(82));
		KernelCall.Bind(offsetof(FParameters, g_Output), 91, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(91));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 64, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(64));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 97, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(97));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 98, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(98));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[240]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[241]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		using FParameters = FGlobalQkvC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[80],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Name = "global_qkv_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 91, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(91));
		KernelCall.Bind(offsetof(FParameters, g_Query), 92, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(92));
		KernelCall.Bind(offsetof(FParameters, g_Key), 93, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(93));
		KernelCall.Bind(offsetof(FParameters, g_Value), 94, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(94));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 65, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(65));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 99, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(99));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 100, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(100));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[242]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[243]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp8),
							   Geometry->Grids[81], dim3(32, 4, 1), 64, false};
		KernelCall.Name = "global_attention_chained_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Query), 92, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(92));
		KernelCall.Bind(offsetof(FParameters, g_Key), 93, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(93));
		KernelCall.Bind(offsetof(FParameters, g_Value), 94, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(94));
		KernelCall.Bind(offsetof(FParameters, g_Output), 95, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(95));
		KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 99, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(99));
		KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 101, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(101));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[244]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[245]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		using FParameters = FGlobalProjectionC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[82], dim3(32, 4, 1), 72,
							   true};
		KernelCall.Name = "global_projection_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 95, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(95));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 91, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(91));
		KernelCall.Bind(offsetof(FParameters, g_Output), 96, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(96));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 66, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(66));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 102, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(102));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 103, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(103));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[246]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[247]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[83],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 111, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(111));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[248]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[84],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 113, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(113));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[249]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[85],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 115, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(115));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[250]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[86],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 116, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(116));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[251]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8),
							   Geometry->Grids[87], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "global_ffn_expand_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 96, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(96));
		KernelCall.Bind(offsetof(FParameters, g_Output), 104, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(104));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 67, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(67));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[252]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[253]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		using FParameters = FGlobalFfnContractC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[88], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_ffn_contract_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 104, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(104));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 96, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(96));
		KernelCall.Bind(offsetof(FParameters, g_Output), 105, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(105));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 68, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(68));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 111, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(111));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 112, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(112));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[254]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[255]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		using FParameters = FGlobalQkvC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[89],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Name = "global_qkv_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 105, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(105));
		KernelCall.Bind(offsetof(FParameters, g_Query), 106, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(106));
		KernelCall.Bind(offsetof(FParameters, g_Key), 107, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(107));
		KernelCall.Bind(offsetof(FParameters, g_Value), 108, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(108));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 69, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(69));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 113, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(113));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 114, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(114));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[256]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[257]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp8),
							   Geometry->Grids[90], dim3(32, 4, 1), 64, false};
		KernelCall.Name = "global_attention_chained_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Query), 106, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(106));
		KernelCall.Bind(offsetof(FParameters, g_Key), 107, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(107));
		KernelCall.Bind(offsetof(FParameters, g_Value), 108, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(108));
		KernelCall.Bind(offsetof(FParameters, g_Output), 109, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(109));
		KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 113, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(113));
		KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 115, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(115));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[258]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[259]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		using FParameters = FGlobalProjectionC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[91], dim3(32, 4, 1), 72,
							   true};
		KernelCall.Name = "global_projection_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 109, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(109));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 105, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(105));
		KernelCall.Bind(offsetof(FParameters, g_Output), 110, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(110));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 70, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(70));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 116, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(116));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 117, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(117));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[260]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[261]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[92],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 125, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(125));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[262]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[93],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 127, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(127));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[263]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[94],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 129, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(129));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[264]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[95],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 130, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(130));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[265]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8),
							   Geometry->Grids[96], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "global_ffn_expand_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 110, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(110));
		KernelCall.Bind(offsetof(FParameters, g_Output), 118, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(118));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 71, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(71));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[266]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[267]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		using FParameters = FGlobalFfnContractC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[97], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_ffn_contract_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 118, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(118));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 110, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(110));
		KernelCall.Bind(offsetof(FParameters, g_Output), 119, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(119));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 72, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(72));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 125, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(125));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 126, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(126));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[268]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[269]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		using FParameters = FGlobalQkvC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[98],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Name = "global_qkv_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 119, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(119));
		KernelCall.Bind(offsetof(FParameters, g_Query), 120, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(120));
		KernelCall.Bind(offsetof(FParameters, g_Key), 121, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(121));
		KernelCall.Bind(offsetof(FParameters, g_Value), 122, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(122));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 73, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(73));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 127, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(127));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 128, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(128));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[270]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[271]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp8),
							   Geometry->Grids[99], dim3(32, 4, 1), 64, false};
		KernelCall.Name = "global_attention_chained_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Query), 120, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(120));
		KernelCall.Bind(offsetof(FParameters, g_Key), 121, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(121));
		KernelCall.Bind(offsetof(FParameters, g_Value), 122, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(122));
		KernelCall.Bind(offsetof(FParameters, g_Output), 123, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(123));
		KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 127, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(127));
		KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 129, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(129));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[272]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[273]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		using FParameters = FGlobalProjectionC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[100], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_projection_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 123, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(123));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 119, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(119));
		KernelCall.Bind(offsetof(FParameters, g_Output), 124, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(124));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 74, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(74));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 130, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(130));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 131, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(131));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[274]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[275]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[101],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 139, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(139));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[276]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[102],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 141, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(141));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[277]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[103],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 143, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(143));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[278]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[104],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 144, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(144));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[279]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8),
							   Geometry->Grids[105], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "global_ffn_expand_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 124, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(124));
		KernelCall.Bind(offsetof(FParameters, g_Output), 132, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(132));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 75, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(75));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[280]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[281]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		using FParameters = FGlobalFfnContractC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[106], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_ffn_contract_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 132, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(132));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 124, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(124));
		KernelCall.Bind(offsetof(FParameters, g_Output), 133, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(133));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 76, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(76));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 139, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(139));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 140, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(140));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[282]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[283]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		using FParameters = FGlobalQkvC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[107],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Name = "global_qkv_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 133, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(133));
		KernelCall.Bind(offsetof(FParameters, g_Query), 134, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(134));
		KernelCall.Bind(offsetof(FParameters, g_Key), 135, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(135));
		KernelCall.Bind(offsetof(FParameters, g_Value), 136, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(136));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 77, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(77));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 141, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(141));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 142, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(142));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[284]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[285]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp8),
							   Geometry->Grids[108], dim3(32, 4, 1), 64, false};
		KernelCall.Name = "global_attention_chained_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Query), 134, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(134));
		KernelCall.Bind(offsetof(FParameters, g_Key), 135, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(135));
		KernelCall.Bind(offsetof(FParameters, g_Value), 136, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(136));
		KernelCall.Bind(offsetof(FParameters, g_Output), 137, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(137));
		KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 141, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(141));
		KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 143, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(143));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[286]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[287]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		using FParameters = FGlobalProjectionC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[109], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_projection_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 137, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(137));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 133, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(133));
		KernelCall.Bind(offsetof(FParameters, g_Output), 138, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(138));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 78, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(78));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 144, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(144));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 145, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(145));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[288]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[289]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[110],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 153, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(153));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[290]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[111],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 155, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(155));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[291]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[112],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 157, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(157));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[292]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[113],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 158, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(158));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[293]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8),
							   Geometry->Grids[114], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "global_ffn_expand_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 138, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(138));
		KernelCall.Bind(offsetof(FParameters, g_Output), 146, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(146));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 79, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(79));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[294]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[295]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		using FParameters = FGlobalFfnContractC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[115], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_ffn_contract_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 146, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(146));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 138, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(138));
		KernelCall.Bind(offsetof(FParameters, g_Output), 147, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(147));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 80, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(80));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 153, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(153));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 154, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(154));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[296]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[297]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		using FParameters = FGlobalQkvC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[116],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Name = "global_qkv_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 147, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(147));
		KernelCall.Bind(offsetof(FParameters, g_Query), 148, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(148));
		KernelCall.Bind(offsetof(FParameters, g_Key), 149, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(149));
		KernelCall.Bind(offsetof(FParameters, g_Value), 150, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(150));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 81, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(81));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 155, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(155));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 156, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(156));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[298]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[299]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp8),
							   Geometry->Grids[117], dim3(32, 4, 1), 64, false};
		KernelCall.Name = "global_attention_chained_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Query), 148, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(148));
		KernelCall.Bind(offsetof(FParameters, g_Key), 149, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(149));
		KernelCall.Bind(offsetof(FParameters, g_Value), 150, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(150));
		KernelCall.Bind(offsetof(FParameters, g_Output), 151, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(151));
		KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 155, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(155));
		KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 157, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(157));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[300]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[301]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		using FParameters = FGlobalProjectionC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[118], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_projection_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 151, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(151));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 147, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(147));
		KernelCall.Bind(offsetof(FParameters, g_Output), 152, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(152));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 82, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(82));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 158, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(158));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 159, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(159));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[302]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[303]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[119],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 167, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(167));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[304]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[120],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 169, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(169));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[305]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[121],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 171, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(171));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[306]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[122],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 172, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(172));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[307]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8),
							   Geometry->Grids[123], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "global_ffn_expand_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 152, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(152));
		KernelCall.Bind(offsetof(FParameters, g_Output), 160, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(160));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 83, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(83));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[308]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[309]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		using FParameters = FGlobalFfnContractC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[124], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_ffn_contract_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 160, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(160));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 152, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(152));
		KernelCall.Bind(offsetof(FParameters, g_Output), 161, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(161));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 84, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(84));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 167, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(167));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 168, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(168));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[310]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[311]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		using FParameters = FGlobalQkvC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[125],
							   dim3(32, 4, 1), 80, true};
		KernelCall.Name = "global_qkv_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 161, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(161));
		KernelCall.Bind(offsetof(FParameters, g_Query), 162, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(162));
		KernelCall.Bind(offsetof(FParameters, g_Key), 163, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(163));
		KernelCall.Bind(offsetof(FParameters, g_Value), 164, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(164));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 85, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(85));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 169, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(169));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 170, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(170));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[312]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[313]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp8),
							   Geometry->Grids[126], dim3(32, 4, 1), 64, false};
		KernelCall.Name = "global_attention_chained_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Query), 162, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(162));
		KernelCall.Bind(offsetof(FParameters, g_Key), 163, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(163));
		KernelCall.Bind(offsetof(FParameters, g_Value), 164, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(164));
		KernelCall.Bind(offsetof(FParameters, g_Output), 165, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(165));
		KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 169, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(169));
		KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 171, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(171));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[314]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[315]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		using FParameters = FGlobalProjectionC1024Fp8Parameters;
		FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[127], dim3(32, 4, 1),
							   72, true};
		KernelCall.Name = "global_projection_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 165, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(165));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 161, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(161));
		KernelCall.Bind(offsetof(FParameters, g_Output), 166, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(166));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 86, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(86));
		KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 172, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(172));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 173, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(173));
		KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[316]);
		KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[317]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_repack_1d_to_2d_fp8
		using FParameters = FGlobalRepackParameters;
		FKernelCall KernelCall{Resolve_repack_1d_to_2d_c1024_fp8(), Geometry->Grids[128], dim3(256, 1, 1), 24,
							   false};
		KernelCall.Name = "repack_1d_to_2d_c1024_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 166, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(166));
		KernelCall.Bind(offsetof(FParameters, g_Output), 174, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(174));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[318]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[319]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		using FParameters = FCompletionCounterParameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[129],
							   dim3(256, 1, 1), 16, false};
		KernelCall.Name = "completion_counter_clear";
		KernelCall.Bind(offsetof(FParameters, g_Counters), 176, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(176));
		KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[320]);
		Calls.push_back(KernelCall);
	}
	{ // cc_dec_input_upsample_1024_512_fp8
		using FParameters = FDecoderUpsampleC1024ToC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&decoder_upsample_c1024_to_c512_fp8),
							   Geometry->Grids[130], dim3(32, 2, 1), 80, true};
		KernelCall.Name = "decoder_upsample_c1024_to_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 174, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(174));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 58, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(58));
		KernelCall.Bind(offsetof(FParameters, g_Output), 175, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(175));
		KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 176, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(176));
		KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 177, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(177));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 87, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(87));
		KernelCall.Set<int32_t>(offsetof(FParameters, InputHeight), Geometry->GeometryArguments[321]);
		KernelCall.Set<int32_t>(offsetof(FParameters, InputWidth), Geometry->GeometryArguments[322]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OutputHeight), Geometry->GeometryArguments[323]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OutputWidth), Geometry->GeometryArguments[324]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[131],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 178, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(178));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 88, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(88));
		KernelCall.Bind(offsetof(FParameters, g_Input), 175, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(175));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[325]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[326]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[327]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[328]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[132], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 179, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(179));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 89, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(89));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 175, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(175));
		KernelCall.Bind(offsetof(FParameters, g_Input), 178, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(178));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[329]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[330]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[133],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 180, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(180));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 90, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(90));
		KernelCall.Bind(offsetof(FParameters, g_Input), 179, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(179));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[331]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[332]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[333]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[334]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[134],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 181, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(181));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 91, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(91));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 179, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(179));
		KernelCall.Bind(offsetof(FParameters, g_Input), 180, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(180));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[335]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[336]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[135],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 182, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(182));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 92, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(92));
		KernelCall.Bind(offsetof(FParameters, g_Input), 181, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(181));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[337]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[338]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[339]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[340]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[136], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 183, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(183));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 93, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(93));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 181, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(181));
		KernelCall.Bind(offsetof(FParameters, g_Input), 182, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(182));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[341]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[342]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[137],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 184, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(184));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 94, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(94));
		KernelCall.Bind(offsetof(FParameters, g_Input), 183, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(183));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[343]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[344]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[345]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[346]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[138],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 185, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(185));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 95, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(95));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 183, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(183));
		KernelCall.Bind(offsetof(FParameters, g_Input), 184, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(184));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[347]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[348]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[139],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 186, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(186));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 96, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(96));
		KernelCall.Bind(offsetof(FParameters, g_Input), 185, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(185));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[349]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[350]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[351]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[352]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[140], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 187, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(187));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 97, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(97));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 185, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(185));
		KernelCall.Bind(offsetof(FParameters, g_Input), 186, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(186));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[353]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[354]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[141],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 188, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(188));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 98, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(98));
		KernelCall.Bind(offsetof(FParameters, g_Input), 187, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(187));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[355]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[356]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[357]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[358]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[142],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 189, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(189));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 99, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(99));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 187, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(187));
		KernelCall.Bind(offsetof(FParameters, g_Input), 188, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(188));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[359]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[360]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[143],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 190, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(190));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 100, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(100));
		KernelCall.Bind(offsetof(FParameters, g_Input), 189, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(189));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[361]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[362]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[363]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[364]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[144], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 191, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(191));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 101, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(101));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 189, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(189));
		KernelCall.Bind(offsetof(FParameters, g_Input), 190, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(190));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[365]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[366]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[145],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 192, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(192));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 102, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(102));
		KernelCall.Bind(offsetof(FParameters, g_Input), 191, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(191));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[367]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[368]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[369]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[370]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[146],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 193, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(193));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 103, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(103));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 191, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(191));
		KernelCall.Bind(offsetof(FParameters, g_Input), 192, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(192));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[371]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[372]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[147],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 194, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(194));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 104, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(104));
		KernelCall.Bind(offsetof(FParameters, g_Input), 193, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(193));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[373]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[374]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[375]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[376]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[148], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 195, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(195));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 105, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(105));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 193, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(193));
		KernelCall.Bind(offsetof(FParameters, g_Input), 194, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(194));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[377]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[378]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[149],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 196, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(196));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 106, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(106));
		KernelCall.Bind(offsetof(FParameters, g_Input), 195, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(195));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[379]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[380]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[381]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[382]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[150],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 197, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(197));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 107, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(107));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 195, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(195));
		KernelCall.Bind(offsetof(FParameters, g_Input), 196, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(196));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[383]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[384]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[151],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 198, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(198));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 108, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(108));
		KernelCall.Bind(offsetof(FParameters, g_Input), 197, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(197));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[385]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[386]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[387]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[388]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[152], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 199, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(199));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 109, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(109));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 197, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(197));
		KernelCall.Bind(offsetof(FParameters, g_Input), 198, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(198));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[389]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[390]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[153],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 200, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(200));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 110, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(110));
		KernelCall.Bind(offsetof(FParameters, g_Input), 199, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(199));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[391]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[392]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[393]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[394]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[154],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 201, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(201));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 111, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(111));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 199, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(199));
		KernelCall.Bind(offsetof(FParameters, g_Input), 200, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(200));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[395]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[396]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[155],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 202, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(202));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 112, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(112));
		KernelCall.Bind(offsetof(FParameters, g_Input), 201, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(201));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[397]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[398]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[399]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[400]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[156], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 203, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(203));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 113, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(113));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 201, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(201));
		KernelCall.Bind(offsetof(FParameters, g_Input), 202, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(202));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[401]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[402]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[157],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 204, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(204));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 114, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(114));
		KernelCall.Bind(offsetof(FParameters, g_Input), 203, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(203));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[403]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[404]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[405]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[406]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[158],
							   dim3(32, 8, 1), 72, false};
		KernelCall.Name = "window_attention_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 205, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(205));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 115, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(115));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 203, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(203));
		KernelCall.Bind(offsetof(FParameters, g_Input), 204, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(204));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[407]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[408]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		using FParameters = FWindowFfnC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[159],
							   dim3(32, 8, 1), 56, false};
		KernelCall.Name = "window_ffn_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 206, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(206));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 116, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(116));
		KernelCall.Bind(offsetof(FParameters, g_Input), 205, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(205));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[409]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[410]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[411]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[412]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		using FParameters = FWindowFfnProjectionC512Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[160], dim3(32, 4, 1),
							   72, false};
		KernelCall.Name = "window_ffn_projection_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 207, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(207));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 117, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(117));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 205, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(205));
		KernelCall.Bind(offsetof(FParameters, g_Input), 206, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(206));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[413]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[414]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		using FParameters = FWindowQkvC512Fp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[161],
							   dim3(32, 4, 1), 56, false};
		KernelCall.Name = "window_qkv_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 208, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(208));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 118, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(118));
		KernelCall.Bind(offsetof(FParameters, g_Input), 207, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(207));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[415]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[416]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[417]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[418]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_outview_fp8
		using FParameters = FWindowAttentionProjectionOutputViewC512Fp8Parameters;
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&window_attention_projection_output_view_c512_fp8),
			Geometry->Grids[162], dim3(32, 4, 1), 72, false};
		KernelCall.Name = "window_attention_projection_output_view_c512_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Output), 209, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(209));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 119, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(119));
		KernelCall.Bind(offsetof(FParameters, g_Residual), 207, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(207));
		KernelCall.Bind(offsetof(FParameters, g_Input), 208, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(208));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[419]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[420]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_upsample_fp8
		using FParameters = FWindowBlockC256UpsampleFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_upsample_fp8(), Geometry->Grids[163], dim3(32, 8, 1),
							   88, false};
		KernelCall.Name = "window_block_c256_upsample_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 209, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(209));
		KernelCall.Bind(offsetof(FParameters, g_Output), 210, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(210));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 120, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(120));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[421]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[422]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[423]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[424]);
		KernelCall.Bind(offsetof(FParameters, g_Residual), 25, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(25));
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[164], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 210, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(210));
		KernelCall.Bind(offsetof(FParameters, g_Output), 211, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(211));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 121, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(121));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[425]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[426]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[427]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[428]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[165], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 211, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(211));
		KernelCall.Bind(offsetof(FParameters, g_Output), 212, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(212));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 122, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(122));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[429]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[430]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[431]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[432]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[166], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 212, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(212));
		KernelCall.Bind(offsetof(FParameters, g_Output), 213, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(213));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 123, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(123));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[433]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[434]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[435]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[436]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[167], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 213, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(213));
		KernelCall.Bind(offsetof(FParameters, g_Output), 214, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(214));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 124, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(124));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[437]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[438]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[439]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[440]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[168], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 214, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(214));
		KernelCall.Bind(offsetof(FParameters, g_Output), 215, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(215));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 125, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(125));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[441]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[442]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[443]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[444]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		using FParameters = FWindowBlockC256Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_fp8(), Geometry->Grids[169], dim3(32, 8, 1), 88,
							   false};
		KernelCall.Name = "window_block_c256_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 215, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(215));
		KernelCall.Bind(offsetof(FParameters, g_Output), 216, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(216));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 126, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(126));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[445]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[446]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[447]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[448]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_outview_fp8
		using FParameters = FWindowBlockC256OutputViewFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c256_output_view_fp8(), Geometry->Grids[170],
							   dim3(32, 8, 1), 88, false};
		KernelCall.Name = "window_block_c256_output_view_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 216, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(216));
		KernelCall.Bind(offsetof(FParameters, g_Output), 217, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(217));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 127, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(127));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[449]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[450]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[451]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[452]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[453]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[454]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_upsample_fp8
		using FParameters = FWindowBlockC128UpsampleFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_upsample_fp8(), Geometry->Grids[171], dim3(32, 4, 1),
							   88, false};
		KernelCall.Name = "window_block_c128_upsample_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 217, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(217));
		KernelCall.Bind(offsetof(FParameters, g_Output), 218, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(218));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 128, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(128));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[455]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[456]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[457]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[458]);
		KernelCall.Bind(offsetof(FParameters, g_Residual), 16, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(16));
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		using FParameters = FWindowBlockC128Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_fp8(), Geometry->Grids[172], dim3(32, 4, 1), 88,
							   false};
		KernelCall.Name = "window_block_c128_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 218, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(218));
		KernelCall.Bind(offsetof(FParameters, g_Output), 219, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(219));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 129, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(129));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[459]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[460]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[461]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[462]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		using FParameters = FWindowBlockC128Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_fp8(), Geometry->Grids[173], dim3(32, 4, 1), 88,
							   false};
		KernelCall.Name = "window_block_c128_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 219, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(219));
		KernelCall.Bind(offsetof(FParameters, g_Output), 220, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(220));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 130, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(130));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[463]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[464]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[465]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[466]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		using FParameters = FWindowBlockC128Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_fp8(), Geometry->Grids[174], dim3(32, 4, 1), 88,
							   false};
		KernelCall.Name = "window_block_c128_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 220, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(220));
		KernelCall.Bind(offsetof(FParameters, g_Output), 221, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(221));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 131, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(131));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[467]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[468]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[469]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[470]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		using FParameters = FWindowBlockC128Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_fp8(), Geometry->Grids[175], dim3(32, 4, 1), 88,
							   false};
		KernelCall.Name = "window_block_c128_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 221, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(221));
		KernelCall.Bind(offsetof(FParameters, g_Output), 222, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(222));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 132, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(132));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[471]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[472]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[473]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[474]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_outview_fp8
		using FParameters = FWindowBlockC128OutputViewFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c128_output_view_fp8(), Geometry->Grids[176],
							   dim3(32, 4, 1), 88, false};
		KernelCall.Name = "window_block_c128_output_view_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 222, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(222));
		KernelCall.Bind(offsetof(FParameters, g_Output), 223, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(223));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 133, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(133));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[475]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[476]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[477]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[478]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[479]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[480]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_upsample_fp8
		using FParameters = FWindowBlockC64UpsampleFp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_upsample_fp8),
							   Geometry->Grids[177], dim3(32, 2, 1), 88, false};
		KernelCall.Name = "window_block_c64_upsample_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 223, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(223));
		KernelCall.Bind(offsetof(FParameters, g_Output), 224, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(224));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 134, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(134));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[481]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[482]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[483]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[484]);
		KernelCall.Bind(offsetof(FParameters, g_Residual), 9, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(9));
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_fp8
		using FParameters = FWindowBlockC64Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c64_fp8(), Geometry->Grids[178], dim3(32, 2, 1), 88,
							   false};
		KernelCall.Name = "window_block_c64_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 224, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(224));
		KernelCall.Bind(offsetof(FParameters, g_Output), 225, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(225));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 135, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(135));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[485]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[486]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[487]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[488]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_fp8
		using FParameters = FWindowBlockC64Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c64_fp8(), Geometry->Grids[179], dim3(32, 2, 1), 88,
							   false};
		KernelCall.Name = "window_block_c64_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 225, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(225));
		KernelCall.Bind(offsetof(FParameters, g_Output), 226, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(226));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 136, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(136));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[489]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[490]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[491]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[492]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_outview_fp8
		using FParameters = FWindowBlockC64OutputViewFp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c64_output_view_fp8(), Geometry->Grids[180],
							   dim3(32, 2, 1), 88, false};
		KernelCall.Name = "window_block_c64_output_view_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 226, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(226));
		KernelCall.Bind(offsetof(FParameters, g_Output), 227, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(227));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 137, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(137));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[493]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[494]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[495]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[496]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[497]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[498]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_upsample_fp8
		using FParameters = FWindowBlockC32UpsampleFp8Parameters;
		FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_upsample_fp8),
							   Geometry->Grids[181], dim3(32, 1, 1), 96, false};
		KernelCall.Name = "window_block_c32_upsample_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 227, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(227));
		KernelCall.Bind(offsetof(FParameters, g_Output), 228, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(228));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 138, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(138));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[499]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[500]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[501]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[502]);
		KernelCall.Bind(offsetof(FParameters, g_Residual), 4, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(4));
		KernelCall.Set<int32_t>(offsetof(FParameters, ResidualHeight), Geometry->GeometryArguments[503]);
		KernelCall.Set<int32_t>(offsetof(FParameters, ResidualWidth), Geometry->GeometryArguments[504]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		using FParameters = FWindowBlockC32Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c32_fp8(), Geometry->Grids[182], dim3(32, 1, 1), 96,
							   false};
		KernelCall.Name = "window_block_c32_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 228, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(228));
		KernelCall.Bind(offsetof(FParameters, g_Output), 229, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(229));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 139, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(139));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[505]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[506]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[507]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[508]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		using FParameters = FWindowBlockC32Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c32_fp8(), Geometry->Grids[183], dim3(32, 1, 1), 96,
							   false};
		KernelCall.Name = "window_block_c32_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 229, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(229));
		KernelCall.Bind(offsetof(FParameters, g_Output), 230, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(230));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 140, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(140));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[509]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[510]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[511]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[512]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		using FParameters = FWindowBlockC32Fp8Parameters;
		FKernelCall KernelCall{Resolve_window_block_c32_fp8(), Geometry->Grids[184], dim3(32, 1, 1), 96,
							   false};
		KernelCall.Name = "window_block_c32_fp8";
		KernelCall.Bind(offsetof(FParameters, g_Input), 230, false, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(230));
		KernelCall.Bind(offsetof(FParameters, g_Output), 231, false, true);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(231));
		KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 141, true, false);
		KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(141));
		KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[513]);
		KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[514]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[515]);
		KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[516]);
		Calls.push_back(KernelCall);
	}
}
