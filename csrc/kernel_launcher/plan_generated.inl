// Generated shared native FP8 schedule. Every resolution uses the same 185 calls.
// Buffer names are shared; the geometry table supplies their actual byte extents.
static const char* BufferNameTable[] = {
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
static const FBufferSpec RecordSpecs[] = {
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

void FDeploymentPlan_fp8::BuildCalls()
{
	Calls.reserve(185);
	{ // cc_tinlayout_fused_swin_1h_32_1_inpview_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c32_input_view_fp8::window_block_c32_input_view_fp8),
			Geometry->Grids[0], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(0));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(1));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(0));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[0]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[1]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[2]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[3]);
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[4]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[5]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_block_c32_fp8::window_block_c32_fp8),
			Geometry->Grids[1], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(1));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(2));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(1));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[6]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[7]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[8]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[9]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_block_c32_fp8::window_block_c32_fp8),
			Geometry->Grids[2], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(2));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(3));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(2));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[10]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[11]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[12]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[13]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_ds_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c32_downsample_fp8::window_block_c32_downsample_fp8),
			Geometry->Grids[3], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(3));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(4));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(3));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[14]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[15]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[16]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[17]);
		KernelCall.Set<uint64_t>(64, GetBufferAddress(5));
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[18]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[19]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_inpview_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c64_input_view_fp8::window_block_c64_input_view_fp8),
			Geometry->Grids[4], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(5));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(6));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(4));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[20]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[21]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[22]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[23]);
		KernelCall.Set<int32_t>(80, Geometry->ScalarValues[24]);
		KernelCall.Set<int32_t>(84, Geometry->ScalarValues[25]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_block_c64_fp8::window_block_c64_fp8),
			Geometry->Grids[5], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(6));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(7));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(5));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[26]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[27]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[28]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[29]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_block_c64_fp8::window_block_c64_fp8),
			Geometry->Grids[6], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(7));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(8));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(6));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[30]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[31]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[32]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[33]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_ds_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c64_downsample_fp8::window_block_c64_downsample_fp8),
			Geometry->Grids[7], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(8));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(9));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(7));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[34]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[35]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[36]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[37]);
		KernelCall.Set<uint64_t>(72, GetBufferAddress(10));
		KernelCall.Set<int32_t>(80, Geometry->ScalarValues[38]);
		KernelCall.Set<int32_t>(84, Geometry->ScalarValues[39]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_inpview_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c128_input_view_fp8::window_block_c128_input_view_fp8),
			Geometry->Grids[8], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(10));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(11));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(8));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[40]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[41]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[42]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[43]);
		KernelCall.Set<int32_t>(80, Geometry->ScalarValues[44]);
		KernelCall.Set<int32_t>(84, Geometry->ScalarValues[45]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c128_fp8::window_block_c128_fp8),
							   Geometry->Grids[9], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(11));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(12));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(9));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[46]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[47]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[48]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[49]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c128_fp8::window_block_c128_fp8),
							   Geometry->Grids[10], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(12));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(13));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(10));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[50]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[51]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[52]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[53]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c128_fp8::window_block_c128_fp8),
							   Geometry->Grids[11], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(13));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(14));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(11));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[54]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[55]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[56]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[57]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c128_fp8::window_block_c128_fp8),
							   Geometry->Grids[12], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(14));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(15));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(12));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[58]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[59]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[60]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[61]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_ds_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c128_downsample_fp8::window_block_c128_downsample_fp8),
			Geometry->Grids[13], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(15));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(16));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(13));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[62]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[63]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[64]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[65]);
		KernelCall.Set<uint64_t>(72, GetBufferAddress(17));
		KernelCall.Set<int32_t>(80, Geometry->ScalarValues[66]);
		KernelCall.Set<int32_t>(84, Geometry->ScalarValues[67]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_inpview_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c256_input_view_fp8::window_block_c256_input_view_fp8),
			Geometry->Grids[14], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(17));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(18));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(14));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[68]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[69]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[70]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[71]);
		KernelCall.Set<int32_t>(80, Geometry->ScalarValues[72]);
		KernelCall.Set<int32_t>(84, Geometry->ScalarValues[73]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[15], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(18));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(19));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(15));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[74]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[75]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[76]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[77]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[16], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(19));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(20));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(16));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[78]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[79]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[80]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[81]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[17], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(20));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(21));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(17));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[82]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[83]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[84]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[85]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[18], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(21));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(22));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(18));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[86]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[87]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[88]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[89]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[19], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(22));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(23));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(19));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[90]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[91]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[92]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[93]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[20], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(23));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(24));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(20));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[94]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[95]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[96]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[97]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_ds_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c256_downsample_fp8::window_block_c256_downsample_fp8),
			Geometry->Grids[21], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(24));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(25));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(21));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[98]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[99]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[100]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[101]);
		KernelCall.Set<uint64_t>(72, GetBufferAddress(26));
		KernelCall.Set<int32_t>(80, Geometry->ScalarValues[102]);
		KernelCall.Set<int32_t>(84, Geometry->ScalarValues[103]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_inpview_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_input_view_c512_fp8::window_ffn_input_view_c512_fp8),
			Geometry->Grids[22], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(27));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(22));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(26));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[104]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[105]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[106]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[107]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_inpview_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8::
											  window_ffn_projection_input_view_c512_fp8),
			Geometry->Grids[23], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(28));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(23));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(26));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(27));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[108]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[109]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[24], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(29));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(24));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(28));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[110]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[111]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[112]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[113]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[25], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(30));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(25));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(28));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(29));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[114]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[115]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[26], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(31));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(26));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(30));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[116]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[117]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[118]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[119]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[27], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(32));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(27));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(30));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(31));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[120]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[121]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[28], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(33));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(28));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(32));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[122]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[123]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[124]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[125]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[29], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(34));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(29));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(32));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(33));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[126]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[127]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[30], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(35));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(30));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(34));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[128]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[129]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[130]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[131]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[31], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(36));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(31));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(34));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(35));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[132]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[133]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[32], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(37));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(32));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(36));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[134]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[135]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[136]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[137]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[33], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(38));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(33));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(36));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(37));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[138]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[139]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[34], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(39));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(34));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(38));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[140]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[141]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[142]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[143]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[35], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(40));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(35));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(38));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(39));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[144]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[145]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[36], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(41));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(36));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(40));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[146]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[147]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[148]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[149]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[37], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(42));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(37));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(40));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(41));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[150]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[151]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[38], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(43));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(38));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(42));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[152]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[153]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[154]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[155]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[39], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(44));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(39));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(42));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(43));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[156]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[157]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[40], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(45));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(40));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(44));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[158]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[159]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[160]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[161]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[41], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(46));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(41));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(44));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(45));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[162]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[163]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[42], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(47));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(42));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(46));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[164]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[165]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[166]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[167]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[43], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(48));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(43));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(46));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(47));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[168]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[169]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[44], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(49));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(44));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(48));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[170]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[171]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[172]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[173]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[45], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(50));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(45));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(48));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(49));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[174]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[175]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[46], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(51));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(46));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(50));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[176]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[177]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[178]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[179]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[47], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(52));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(47));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(50));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(51));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[180]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[181]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[48], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(53));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(48));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(52));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[182]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[183]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[184]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[185]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[49], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(54));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(49));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(52));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(53));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[186]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[187]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[50], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(55));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(50));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(54));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[188]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[189]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[190]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[191]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[51], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(56));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(51));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(54));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(55));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[192]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[193]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[52], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(57));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(52));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(56));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[194]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[195]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[196]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[197]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_pool_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_pool_c512_fp8::
											  window_attention_projection_pool_c512_fp8),
			Geometry->Grids[53], dim3(32, 4, 1), 80, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(58));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(59));
		KernelCall.Set<uint64_t>(32, GetRecordAddress(53));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(56));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(57));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[198]);
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[199]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[200]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[201]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_final_head_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8::
											  channel_projection_c512_to_c1024_fp8),
			Geometry->Grids[54], dim3(32, 8, 1), 40, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(60));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(54));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(59));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[202]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[203]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_repack_2d_to_1d_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::repack_2d_to_1d_c1024_fp8::repack_2d_to_1d_c1024_fp8),
			Geometry->Grids[55], dim3(256, 1, 1), 24, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(60));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(61));
		KernelCall.Set<int32_t>(16, Geometry->ScalarValues[204]);
		KernelCall.Set<int32_t>(20, Geometry->ScalarValues[205]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[56], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(69));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[206]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[57], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(71));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[207]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[58], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(73));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[208]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[59], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(74));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[209]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_expand_c1024_fp8::global_ffn_expand_c1024_fp8),
			Geometry->Grids[60], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(61));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(62));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(55));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[210]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[211]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_contract_c1024_fp8::global_ffn_contract_c1024_fp8),
			Geometry->Grids[61], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(62));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(61));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(63));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(56));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(69));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(70));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[212]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[213]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_qkv_c1024_fp8::global_qkv_c1024_fp8),
			Geometry->Grids[62], dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(63));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(64));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(65));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(66));
		KernelCall.Set<uint64_t>(32, GetRecordAddress(57));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(71));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(72));
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[214]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[215]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_attention_chained_c1024_fp8::
											  global_attention_chained_c1024_fp8),
			Geometry->Grids[63], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(64));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(65));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(66));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(67));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(71));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(73));
		KernelCall.Set<int32_t>(56, Geometry->ScalarValues[216]);
		KernelCall.Set<int32_t>(60, Geometry->ScalarValues[217]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_projection_c1024_fp8::global_projection_c1024_fp8),
			Geometry->Grids[64], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(67));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(63));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(68));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(58));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(74));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(75));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[218]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[219]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[65], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(83));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[220]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[66], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(85));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[221]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[67], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(87));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[222]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[68], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(88));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[223]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_expand_c1024_fp8::global_ffn_expand_c1024_fp8),
			Geometry->Grids[69], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(68));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(76));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(59));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[224]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[225]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_contract_c1024_fp8::global_ffn_contract_c1024_fp8),
			Geometry->Grids[70], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(76));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(68));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(77));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(60));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(83));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(84));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[226]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[227]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_qkv_c1024_fp8::global_qkv_c1024_fp8),
			Geometry->Grids[71], dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(77));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(78));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(79));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(80));
		KernelCall.Set<uint64_t>(32, GetRecordAddress(61));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(85));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(86));
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[228]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[229]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_attention_chained_c1024_fp8::
											  global_attention_chained_c1024_fp8),
			Geometry->Grids[72], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(78));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(79));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(80));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(81));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(85));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(87));
		KernelCall.Set<int32_t>(56, Geometry->ScalarValues[230]);
		KernelCall.Set<int32_t>(60, Geometry->ScalarValues[231]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_projection_c1024_fp8::global_projection_c1024_fp8),
			Geometry->Grids[73], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(81));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(77));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(82));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(62));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(88));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(89));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[232]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[233]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[74], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(97));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[234]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[75], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(99));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[235]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[76], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(101));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[236]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[77], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(102));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[237]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_expand_c1024_fp8::global_ffn_expand_c1024_fp8),
			Geometry->Grids[78], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(82));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(90));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(63));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[238]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[239]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_contract_c1024_fp8::global_ffn_contract_c1024_fp8),
			Geometry->Grids[79], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(90));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(82));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(91));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(64));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(97));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(98));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[240]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[241]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_qkv_c1024_fp8::global_qkv_c1024_fp8),
			Geometry->Grids[80], dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(91));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(92));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(93));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(94));
		KernelCall.Set<uint64_t>(32, GetRecordAddress(65));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(99));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(100));
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[242]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[243]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_attention_chained_c1024_fp8::
											  global_attention_chained_c1024_fp8),
			Geometry->Grids[81], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(92));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(93));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(94));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(95));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(99));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(101));
		KernelCall.Set<int32_t>(56, Geometry->ScalarValues[244]);
		KernelCall.Set<int32_t>(60, Geometry->ScalarValues[245]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_projection_c1024_fp8::global_projection_c1024_fp8),
			Geometry->Grids[82], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(95));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(91));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(96));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(66));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(102));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(103));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[246]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[247]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[83], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(111));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[248]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[84], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(113));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[249]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[85], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(115));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[250]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[86], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(116));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[251]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_expand_c1024_fp8::global_ffn_expand_c1024_fp8),
			Geometry->Grids[87], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(96));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(104));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(67));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[252]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[253]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_contract_c1024_fp8::global_ffn_contract_c1024_fp8),
			Geometry->Grids[88], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(104));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(96));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(105));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(68));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(111));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(112));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[254]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[255]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_qkv_c1024_fp8::global_qkv_c1024_fp8),
			Geometry->Grids[89], dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(105));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(106));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(107));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(108));
		KernelCall.Set<uint64_t>(32, GetRecordAddress(69));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(113));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(114));
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[256]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[257]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_attention_chained_c1024_fp8::
											  global_attention_chained_c1024_fp8),
			Geometry->Grids[90], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(106));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(107));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(108));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(109));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(113));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(115));
		KernelCall.Set<int32_t>(56, Geometry->ScalarValues[258]);
		KernelCall.Set<int32_t>(60, Geometry->ScalarValues[259]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_projection_c1024_fp8::global_projection_c1024_fp8),
			Geometry->Grids[91], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(109));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(105));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(110));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(70));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(116));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(117));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[260]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[261]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[92], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(125));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[262]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[93], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(127));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[263]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[94], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(129));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[264]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[95], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(130));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[265]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_expand_c1024_fp8::global_ffn_expand_c1024_fp8),
			Geometry->Grids[96], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(110));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(118));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(71));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[266]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[267]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_contract_c1024_fp8::global_ffn_contract_c1024_fp8),
			Geometry->Grids[97], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(118));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(110));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(119));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(72));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(125));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(126));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[268]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[269]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_qkv_c1024_fp8::global_qkv_c1024_fp8),
			Geometry->Grids[98], dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(119));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(120));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(121));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(122));
		KernelCall.Set<uint64_t>(32, GetRecordAddress(73));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(127));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(128));
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[270]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[271]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_attention_chained_c1024_fp8::
											  global_attention_chained_c1024_fp8),
			Geometry->Grids[99], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(120));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(121));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(122));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(123));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(127));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(129));
		KernelCall.Set<int32_t>(56, Geometry->ScalarValues[272]);
		KernelCall.Set<int32_t>(60, Geometry->ScalarValues[273]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_projection_c1024_fp8::global_projection_c1024_fp8),
			Geometry->Grids[100], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(123));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(119));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(124));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(74));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(130));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(131));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[274]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[275]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[101], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(139));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[276]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[102], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(141));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[277]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[103], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(143));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[278]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[104], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(144));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[279]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_expand_c1024_fp8::global_ffn_expand_c1024_fp8),
			Geometry->Grids[105], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(124));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(132));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(75));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[280]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[281]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_contract_c1024_fp8::global_ffn_contract_c1024_fp8),
			Geometry->Grids[106], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(132));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(124));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(133));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(76));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(139));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(140));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[282]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[283]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_qkv_c1024_fp8::global_qkv_c1024_fp8),
			Geometry->Grids[107], dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(133));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(134));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(135));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(136));
		KernelCall.Set<uint64_t>(32, GetRecordAddress(77));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(141));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(142));
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[284]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[285]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_attention_chained_c1024_fp8::
											  global_attention_chained_c1024_fp8),
			Geometry->Grids[108], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(134));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(135));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(136));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(137));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(141));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(143));
		KernelCall.Set<int32_t>(56, Geometry->ScalarValues[286]);
		KernelCall.Set<int32_t>(60, Geometry->ScalarValues[287]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_projection_c1024_fp8::global_projection_c1024_fp8),
			Geometry->Grids[109], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(137));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(133));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(138));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(78));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(144));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(145));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[288]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[289]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[110], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(153));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[290]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[111], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(155));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[291]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[112], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(157));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[292]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[113], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(158));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[293]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_expand_c1024_fp8::global_ffn_expand_c1024_fp8),
			Geometry->Grids[114], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(138));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(146));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(79));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[294]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[295]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_contract_c1024_fp8::global_ffn_contract_c1024_fp8),
			Geometry->Grids[115], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(146));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(138));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(147));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(80));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(153));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(154));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[296]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[297]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_qkv_c1024_fp8::global_qkv_c1024_fp8),
			Geometry->Grids[116], dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(147));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(148));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(149));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(150));
		KernelCall.Set<uint64_t>(32, GetRecordAddress(81));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(155));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(156));
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[298]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[299]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_attention_chained_c1024_fp8::
											  global_attention_chained_c1024_fp8),
			Geometry->Grids[117], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(148));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(149));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(150));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(151));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(155));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(157));
		KernelCall.Set<int32_t>(56, Geometry->ScalarValues[300]);
		KernelCall.Set<int32_t>(60, Geometry->ScalarValues[301]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_projection_c1024_fp8::global_projection_c1024_fp8),
			Geometry->Grids[118], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(151));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(147));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(152));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(82));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(158));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(159));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[302]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[303]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[119], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(167));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[304]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[120], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(169));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[305]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[121], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(171));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[306]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[122], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(172));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[307]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_expand_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_expand_c1024_fp8::global_ffn_expand_c1024_fp8),
			Geometry->Grids[123], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(152));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(160));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(83));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[308]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[309]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_ffn_contract_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_ffn_contract_c1024_fp8::global_ffn_contract_c1024_fp8),
			Geometry->Grids[124], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(160));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(152));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(161));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(84));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(167));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(168));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[310]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[311]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_qkv_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_qkv_c1024_fp8::global_qkv_c1024_fp8),
			Geometry->Grids[125], dim3(32, 4, 1), 80, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(161));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(162));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(163));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(164));
		KernelCall.Set<uint64_t>(32, GetRecordAddress(85));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(169));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(170));
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[312]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[313]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_attention_chained_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::global_attention_chained_c1024_fp8::
											  global_attention_chained_c1024_fp8),
			Geometry->Grids[126], dim3(32, 4, 1), 64, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(162));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(163));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(164));
		KernelCall.Set<uint64_t>(24, GetBufferAddress(165));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(169));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(171));
		KernelCall.Set<int32_t>(56, Geometry->ScalarValues[314]);
		KernelCall.Set<int32_t>(60, Geometry->ScalarValues[315]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_projection_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::global_projection_c1024_fp8::global_projection_c1024_fp8),
			Geometry->Grids[127], dim3(32, 4, 1), 72, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(165));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(161));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(166));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(86));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(172));
		KernelCall.Set<uint64_t>(40, GetBufferAddress(173));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[316]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[317]);
		Calls.push_back(KernelCall);
	}
	{ // cc_vit_1d_repack_1d_to_2d_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8::repack_1d_to_2d_c1024_fp8),
			Geometry->Grids[128], dim3(256, 1, 1), 24, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(166));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(174));
		KernelCall.Set<int32_t>(16, Geometry->ScalarValues[318]);
		KernelCall.Set<int32_t>(20, Geometry->ScalarValues[319]);
		Calls.push_back(KernelCall);
	}
	{ // cc_cb_clear
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::completion_counter_clear::completion_counter_clear),
			Geometry->Grids[129], dim3(256, 1, 1), 16, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(176));
		KernelCall.Set<int32_t>(8, Geometry->ScalarValues[320]);
		Calls.push_back(KernelCall);
	}
	{ // cc_dec_input_upsample_1024_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp8::
											  decoder_upsample_c1024_to_c512_fp8),
			Geometry->Grids[130], dim3(32, 2, 1), 80, true};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(174));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(58));
		KernelCall.Set<uint64_t>(16, GetBufferAddress(175));
		KernelCall.Set<uint64_t>(32, GetBufferAddress(176));
		KernelCall.Set<uint64_t>(48, GetBufferAddress(177));
		KernelCall.Set<uint64_t>(56, GetRecordAddress(87));
		KernelCall.Set<int32_t>(64, Geometry->ScalarValues[321]);
		KernelCall.Set<int32_t>(68, Geometry->ScalarValues[322]);
		KernelCall.Set<int32_t>(72, Geometry->ScalarValues[323]);
		KernelCall.Set<int32_t>(76, Geometry->ScalarValues[324]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[131], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(178));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(88));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(175));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[325]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[326]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[327]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[328]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[132], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(179));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(89));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(175));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(178));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[329]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[330]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[133], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(180));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(90));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(179));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[331]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[332]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[333]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[334]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[134], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(181));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(91));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(179));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(180));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[335]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[336]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[135], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(182));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(92));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(181));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[337]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[338]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[339]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[340]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[136], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(183));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(93));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(181));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(182));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[341]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[342]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[137], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(184));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(94));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(183));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[343]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[344]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[345]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[346]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[138], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(185));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(95));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(183));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(184));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[347]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[348]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[139], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(186));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(96));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(185));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[349]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[350]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[351]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[352]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[140], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(187));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(97));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(185));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(186));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[353]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[354]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[141], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(188));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(98));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(187));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[355]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[356]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[357]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[358]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[142], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(189));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(99));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(187));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(188));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[359]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[360]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[143], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(190));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(100));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(189));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[361]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[362]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[363]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[364]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[144], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(191));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(101));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(189));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(190));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[365]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[366]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[145], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(192));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(102));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(191));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[367]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[368]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[369]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[370]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[146], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(193));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(103));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(191));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(192));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[371]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[372]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[147], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(194));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(104));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(193));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[373]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[374]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[375]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[376]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[148], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(195));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(105));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(193));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(194));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[377]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[378]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[149], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(196));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(106));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(195));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[379]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[380]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[381]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[382]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[150], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(197));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(107));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(195));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(196));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[383]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[384]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[151], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(198));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(108));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(197));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[385]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[386]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[387]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[388]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[152], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(199));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(109));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(197));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(198));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[389]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[390]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[153], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(200));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(110));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(199));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[391]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[392]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[393]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[394]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[154], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(201));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(111));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(199));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(200));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[395]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[396]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[155], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(202));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(112));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(201));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[397]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[398]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[399]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[400]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[156], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(203));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(113));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(201));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(202));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[401]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[402]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[157], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(204));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(114));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(203));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[403]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[404]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[405]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[406]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_attention_projection_c512_fp8::
											  window_attention_projection_c512_fp8),
			Geometry->Grids[158], dim3(32, 8, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(205));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(115));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(203));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(204));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[407]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[408]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8),
			Geometry->Grids[159], dim3(32, 8, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(206));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(116));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(205));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[409]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[410]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[411]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[412]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_ffwd_proj_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_ffn_projection_c512_fp8::window_ffn_projection_c512_fp8),
			Geometry->Grids[160], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(207));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(117));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(205));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(206));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[413]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[414]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_qkv_512_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8),
			Geometry->Grids[161], dim3(32, 4, 1), 56, false};
		KernelCall.Set<uint64_t>(8, GetBufferAddress(208));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(118));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(207));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[415]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[416]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[417]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[418]);
		Calls.push_back(KernelCall);
	}
	{ // cc_split_swin_16h_proj_512_outview_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8::
									   window_attention_projection_output_view_c512_fp8),
							   Geometry->Grids[162], dim3(32, 4, 1), 72, false};
		KernelCall.Set<uint64_t>(16, GetBufferAddress(209));
		KernelCall.Set<uint64_t>(24, GetRecordAddress(119));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(207));
		KernelCall.Set<uint64_t>(0, GetBufferAddress(208));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[419]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[420]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_upsample_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c256_upsample_fp8::window_block_c256_upsample_fp8),
			Geometry->Grids[163], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(209));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(210));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(120));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[421]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[422]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[423]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[424]);
		KernelCall.Set<uint64_t>(24, GetBufferAddress(25));
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[164], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(210));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(211));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(121));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[425]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[426]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[427]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[428]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[165], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(211));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(212));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(122));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[429]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[430]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[431]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[432]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[166], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(212));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(213));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(123));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[433]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[434]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[435]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[436]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[167], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(213));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(214));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(124));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[437]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[438]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[439]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[440]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[168], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(214));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(215));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(125));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[441]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[442]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[443]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[444]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c256_fp8::window_block_c256_fp8),
							   Geometry->Grids[169], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(215));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(216));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(126));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[445]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[446]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[447]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[448]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_8h_256_8_outview_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c256_output_view_fp8::window_block_c256_output_view_fp8),
			Geometry->Grids[170], dim3(32, 8, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(216));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(217));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(127));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[449]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[450]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[451]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[452]);
		KernelCall.Set<int32_t>(80, Geometry->ScalarValues[453]);
		KernelCall.Set<int32_t>(84, Geometry->ScalarValues[454]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_upsample_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c128_upsample_fp8::window_block_c128_upsample_fp8),
			Geometry->Grids[171], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(217));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(218));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(128));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[455]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[456]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[457]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[458]);
		KernelCall.Set<uint64_t>(24, GetBufferAddress(16));
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c128_fp8::window_block_c128_fp8),
							   Geometry->Grids[172], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(218));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(219));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(129));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[459]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[460]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[461]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[462]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c128_fp8::window_block_c128_fp8),
							   Geometry->Grids[173], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(219));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(220));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(130));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[463]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[464]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[465]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[466]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c128_fp8::window_block_c128_fp8),
							   Geometry->Grids[174], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(220));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(221));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(131));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[467]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[468]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[469]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[470]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_fp8
		FKernelCall KernelCall{reinterpret_cast<const void*>(
								   &dlssnr::reconstructed::window_block_c128_fp8::window_block_c128_fp8),
							   Geometry->Grids[175], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(221));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(222));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(132));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[471]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[472]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[473]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[474]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_4h_128_4_outview_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c128_output_view_fp8::window_block_c128_output_view_fp8),
			Geometry->Grids[176], dim3(32, 4, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(222));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(223));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(133));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[475]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[476]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[477]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[478]);
		KernelCall.Set<int32_t>(80, Geometry->ScalarValues[479]);
		KernelCall.Set<int32_t>(84, Geometry->ScalarValues[480]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_upsample_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c64_upsample_fp8::window_block_c64_upsample_fp8),
			Geometry->Grids[177], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(223));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(224));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(134));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[481]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[482]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[483]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[484]);
		KernelCall.Set<uint64_t>(24, GetBufferAddress(9));
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_block_c64_fp8::window_block_c64_fp8),
			Geometry->Grids[178], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(224));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(225));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(135));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[485]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[486]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[487]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[488]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_block_c64_fp8::window_block_c64_fp8),
			Geometry->Grids[179], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(225));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(226));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(136));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[489]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[490]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[491]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[492]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_2h_64_2_outview_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c64_output_view_fp8::window_block_c64_output_view_fp8),
			Geometry->Grids[180], dim3(32, 2, 1), 88, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(226));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(227));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(137));
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[493]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[494]);
		KernelCall.Set<int32_t>(40, Geometry->ScalarValues[495]);
		KernelCall.Set<int32_t>(44, Geometry->ScalarValues[496]);
		KernelCall.Set<int32_t>(80, Geometry->ScalarValues[497]);
		KernelCall.Set<int32_t>(84, Geometry->ScalarValues[498]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_upsample_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(
				&dlssnr::reconstructed::window_block_c32_upsample_fp8::window_block_c32_upsample_fp8),
			Geometry->Grids[181], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(227));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(228));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(138));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[499]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[500]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[501]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[502]);
		KernelCall.Set<uint64_t>(80, GetBufferAddress(4));
		KernelCall.Set<int32_t>(88, Geometry->ScalarValues[503]);
		KernelCall.Set<int32_t>(92, Geometry->ScalarValues[504]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_block_c32_fp8::window_block_c32_fp8),
			Geometry->Grids[182], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(228));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(229));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(139));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[505]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[506]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[507]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[508]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_block_c32_fp8::window_block_c32_fp8),
			Geometry->Grids[183], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(229));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(230));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(140));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[509]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[510]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[511]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[512]);
		Calls.push_back(KernelCall);
	}
	{ // cc_tinlayout_fused_swin_1h_32_1_fp8
		FKernelCall KernelCall{
			reinterpret_cast<const void*>(&dlssnr::reconstructed::window_block_c32_fp8::window_block_c32_fp8),
			Geometry->Grids[184], dim3(32, 1, 1), 96, false};
		KernelCall.Set<uint64_t>(0, GetBufferAddress(230));
		KernelCall.Set<uint64_t>(8, GetBufferAddress(231));
		KernelCall.Set<uint64_t>(16, GetRecordAddress(141));
		KernelCall.Set<int32_t>(24, Geometry->ScalarValues[513]);
		KernelCall.Set<int32_t>(28, Geometry->ScalarValues[514]);
		KernelCall.Set<int32_t>(32, Geometry->ScalarValues[515]);
		KernelCall.Set<int32_t>(36, Geometry->ScalarValues[516]);
		Calls.push_back(KernelCall);
	}
}
