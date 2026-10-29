// Generated separate Small31 native FP8 schedule. Every resolution uses the same 109 calls.
// Buffer names are shared; the geometry table supplies their actual byte extents.
static const char* SmallBufferNameTable_fp8[] = {
    "input",
    "b1.output",
    "b4.output",
    "b4.down",
    "b5.output",
    "b8.output",
    "b8.down",
    "b9.output",
    "b14.output",
    "b14.down",
    "b15.output",
    "b22.output",
    "b22.down",
    "b23.branches",
    "b23.ffn",
    "b23.attended",
    "b23.output",
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
    "b47.branches",
    "b47.ffn",
    "b47.attended",
    "b47.output",
    "b48.output",
    "b55.output",
    "b56.output",
    "b61.output",
    "b62.output",
    "b65.output",
    "b66.output",
    "b69.output",
};
static const FBufferSpec SmallRecordSpecs_fp8[] = {
    {"block1.layer0.layer", 20672LL},
    {"block2.layer0.layer", 22720LL},
    {"block3.layer0.layer", 61760LL},
    {"block4.layer0.layer", 69936LL},
    {"block5.layer0.layer", 197184LL},
    {"block6.layer0.layer", 229936LL},
    {"block7.layer0.layer", 689232LL},
    {"block8.layer0.layer", 820288LL},
    {"block9.layer0.layer", 524288LL},
    {"block9.layer1.layer", 263168LL},
    {"block9.layer2.layer", 917568LL},
    {"block9.layer3.layer", 263168LL},
    {"block10.layer0.layer", 524288LL},
    {"block10.layer1.layer", 263168LL},
    {"block10.layer2.layer", 917568LL},
    {"block10.layer3.layer", 263168LL},
    {"block10.layer4.layer", 524304LL},
    {"block11.layer0.layer", 4194320LL},
    {"block11.layer1.layer", 4196352LL},
    {"block11.layer2.layer", 3145856LL},
    {"block11.layer4.layer", 1050624LL},
    {"block12.layer0.layer", 4194320LL},
    {"block12.layer1.layer", 4196352LL},
    {"block12.layer2.layer", 3145856LL},
    {"block12.layer4.layer", 1050624LL},
    {"block13.layer0.layer", 4194320LL},
    {"block13.layer1.layer", 4196352LL},
    {"block13.layer2.layer", 3145856LL},
    {"block13.layer4.layer", 1050624LL},
    {"block14.layer0.layer", 4194320LL},
    {"block14.layer1.layer", 4196352LL},
    {"block14.layer2.layer", 3145856LL},
    {"block14.layer4.layer", 1050624LL},
    {"block15.layer0.layer", 4194320LL},
    {"block15.layer1.layer", 4196352LL},
    {"block15.layer2.layer", 3145856LL},
    {"block15.layer4.layer", 1050624LL},
    {"block16.layer0.layer", 4194320LL},
    {"block16.layer1.layer", 4196352LL},
    {"block16.layer2.layer", 3145856LL},
    {"block16.layer4.layer", 1050624LL},
    {"block17.layer0.layer", 4194320LL},
    {"block17.layer1.layer", 4196352LL},
    {"block17.layer2.layer", 3145856LL},
    {"block17.layer4.layer", 1050624LL},
    {"block18.layer0.layer", 4194320LL},
    {"block18.layer1.layer", 4196352LL},
    {"block18.layer2.layer", 3145856LL},
    {"block18.layer4.layer", 1050624LL},
    {"block19.layer0.layer", 525312LL},
    {"block20.layer0.layer", 524288LL},
    {"block20.layer1.layer", 263168LL},
    {"block20.layer2.layer", 917568LL},
    {"block20.layer3.layer", 263168LL},
    {"block21.layer0.layer", 524288LL},
    {"block21.layer1.layer", 263168LL},
    {"block21.layer2.layer", 917568LL},
    {"block21.layer3.layer", 263168LL},
    {"block22.layer0.layer", 820784LL},
    {"block23.layer0.layer", 689232LL},
    {"block24.layer0.layer", 230176LL},
    {"block25.layer0.layer", 197184LL},
    {"block26.layer0.layer", 70048LL},
    {"block27.layer0.layer", 61760LL},
    {"block28.layer0.layer", 22784LL},
    {"block29.layer0.layer", 20672LL},
};
static const char* SmallBoundaryNames_fp8[] = {
    "b1.output",
    "b4.output",
    "b4.down",
    "b5.output",
    "b8.output",
    "b8.down",
    "b9.output",
    "b14.output",
    "b14.down",
    "b15.output",
    "b22.output",
    "b22.down",
    "b23.output",
    "b30.output",
    "b30.down",
    "b31.output",
    "b32.output",
    "b33.output",
    "b34.output",
    "b35.output",
    "b36.output",
    "b37.output",
    "b38.output",
    "b39.output",
    "b40.output",
    "b47.output",
    "b48.output",
    "b55.output",
    "b56.output",
    "b61.output",
    "b62.output",
    "b65.output",
    "b66.output",
    "b69.output",
};
template <> void FSmallDeploymentPlan<false>::BuildCalls() {
    Calls.reserve(109);
    { // cc_tinlayout_fused_swin_1h_32_1_inpview_fp8
        using FParameters = FWindowBlockC32InputViewFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c32_input_view_fp8(), Geometry->Grids[0], dim3(32, 1, 1), 96, false};
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
    { // cc_tinlayout_fused_swin_1h_32_1_ds_fp8
        using FParameters = FWindowBlockC32DownsampleFp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_downsample_fp8), Geometry->Grids[1], dim3(32, 1, 1), 96, false};
        KernelCall.Name = "window_block_c32_downsample_fp8";
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
        KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 3, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(3));
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[10]);
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[11]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_2h_64_2_inpview_fp8
        using FParameters = FWindowBlockC64InputViewFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c64_input_view_fp8(), Geometry->Grids[2], dim3(32, 2, 1), 88, false};
        KernelCall.Name = "window_block_c64_input_view_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 3, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(3));
        KernelCall.Bind(offsetof(FParameters, g_Output), 4, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(4));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 2, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(2));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[12]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[13]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[14]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[15]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[16]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[17]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_2h_64_2_ds_fp8
        using FParameters = FWindowBlockC64DownsampleFp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_downsample_fp8), Geometry->Grids[3], dim3(32, 2, 1), 88, false};
        KernelCall.Name = "window_block_c64_downsample_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 4, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(4));
        KernelCall.Bind(offsetof(FParameters, g_Output), 5, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(5));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 3, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(3));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[18]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[19]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[20]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[21]);
        KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 6, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(6));
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[22]);
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[23]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_4h_128_4_inpview_fp8
        using FParameters = FWindowBlockC128InputViewFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c128_input_view_fp8(), Geometry->Grids[4], dim3(32, 4, 1), 88, false};
        KernelCall.Name = "window_block_c128_input_view_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 6, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(6));
        KernelCall.Bind(offsetof(FParameters, g_Output), 7, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(7));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 4, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(4));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[24]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[25]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[26]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[27]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[28]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[29]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_4h_128_4_ds_fp8
        using FParameters = FWindowBlockC128DownsampleFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c128_downsample_fp8(), Geometry->Grids[5], dim3(32, 4, 1), 88, false};
        KernelCall.Name = "window_block_c128_downsample_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 7, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(7));
        KernelCall.Bind(offsetof(FParameters, g_Output), 8, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(8));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 5, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(5));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[30]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[31]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[32]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[33]);
        KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 9, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(9));
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[34]);
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[35]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_8h_256_8_inpview_fp8
        using FParameters = FWindowBlockC256InputViewFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c256_input_view_fp8(), Geometry->Grids[6], dim3(32, 8, 1), 88, false};
        KernelCall.Name = "window_block_c256_input_view_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 9, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(9));
        KernelCall.Bind(offsetof(FParameters, g_Output), 10, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(10));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 6, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(6));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[36]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[37]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[38]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[39]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[40]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[41]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_8h_256_8_ds_fp8
        using FParameters = FWindowBlockC256DownsampleFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c256_downsample_fp8(), Geometry->Grids[7], dim3(32, 8, 1), 88, false};
        KernelCall.Name = "window_block_c256_downsample_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 10, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(10));
        KernelCall.Bind(offsetof(FParameters, g_Output), 11, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(11));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 7, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(7));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[42]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[43]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[44]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[45]);
        KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 12, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(12));
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[46]);
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[47]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_inpview_512_fp8
        using FParameters = FWindowFfnInputViewC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_input_view_c512_fp8), Geometry->Grids[8], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_ffn_input_view_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 13, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(13));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 8, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(8));
        KernelCall.Bind(offsetof(FParameters, g_Input), 12, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(12));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[48]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[49]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[50]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[51]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_proj_inpview_512_fp8
        using FParameters = FWindowFfnProjectionInputViewC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_input_view_c512_fp8), Geometry->Grids[9], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_ffn_projection_input_view_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 14, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(14));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 9, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(9));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 12, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(12));
        KernelCall.Bind(offsetof(FParameters, g_Input), 13, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(13));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[52]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[53]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_qkv_512_fp8
        using FParameters = FWindowQkvC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[10], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_qkv_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 15, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(15));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 10, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(10));
        KernelCall.Bind(offsetof(FParameters, g_Input), 14, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(14));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[54]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[55]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[56]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[57]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_proj_512_fp8
        using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
        FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[11], dim3(32, 8, 1), 72, false};
        KernelCall.Name = "window_attention_projection_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 16, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(16));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 11, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(11));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 14, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(14));
        KernelCall.Bind(offsetof(FParameters, g_Input), 15, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(15));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[58]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[59]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_512_fp8
        using FParameters = FWindowFfnC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[12], dim3(32, 8, 1), 56, false};
        KernelCall.Name = "window_ffn_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 17, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(17));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 12, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(12));
        KernelCall.Bind(offsetof(FParameters, g_Input), 16, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(16));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[60]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[61]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[62]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[63]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_proj_512_fp8
        using FParameters = FWindowFfnProjectionC512Fp8Parameters;
        FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[13], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_ffn_projection_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 18, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(18));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 13, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(13));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 16, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(16));
        KernelCall.Bind(offsetof(FParameters, g_Input), 17, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(17));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[64]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[65]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_qkv_512_fp8
        using FParameters = FWindowQkvC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[14], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_qkv_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 19, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(19));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 14, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(14));
        KernelCall.Bind(offsetof(FParameters, g_Input), 18, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(18));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[66]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[67]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[68]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[69]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_proj_pool_512_fp8
        using FParameters = FWindowAttentionProjectionPoolC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_pool_c512_fp8), Geometry->Grids[15], dim3(32, 4, 1), 80, false};
        KernelCall.Name = "window_attention_projection_pool_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 20, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(20));
        KernelCall.Bind(offsetof(FParameters, g_DownsampledOutput), 21, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_DownsampledOutput), GetBufferAddress(21));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 15, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(15));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 18, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(18));
        KernelCall.Bind(offsetof(FParameters, g_Input), 19, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(19));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[70]);
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledHeight), Geometry->GeometryArguments[71]);
        KernelCall.Set<int32_t>(offsetof(FParameters, DownsampledWidth), Geometry->GeometryArguments[72]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[73]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_final_head_512_fp8
        using FParameters = FChannelProjectionC512ToC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&channel_projection_c512_to_c1024_fp8), Geometry->Grids[16], dim3(32, 8, 1), 40, false};
        KernelCall.Name = "channel_projection_c512_to_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 22, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(22));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 16, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(16));
        KernelCall.Bind(offsetof(FParameters, g_Input), 21, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(21));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[74]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[75]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_repack_2d_to_1d_fp8
        using FParameters = FGlobalRepackParameters;
        FKernelCall KernelCall{Resolve_repack_2d_to_1d_c1024_fp8(), Geometry->Grids[17], dim3(256, 1, 1), 24, false};
        KernelCall.Name = "repack_2d_to_1d_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 22, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(22));
        KernelCall.Bind(offsetof(FParameters, g_Output), 23, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(23));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[76]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[77]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[18], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 31, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(31));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[78]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[19], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 33, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(33));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[79]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[20], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 35, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(35));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[80]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[21], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 36, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(36));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[81]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand_fp8
        using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8), Geometry->Grids[22], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 23, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(23));
        KernelCall.Bind(offsetof(FParameters, g_Output), 24, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(24));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 17, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(17));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[82]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[83]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract_fp8
        using FParameters = FGlobalFfnContractC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[23], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 24, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(24));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 23, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(23));
        KernelCall.Bind(offsetof(FParameters, g_Output), 25, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(25));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 18, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(18));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 31, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(31));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 32, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(32));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[84]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[85]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv_fp8
        using FParameters = FGlobalQkvC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[24], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 25, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(25));
        KernelCall.Bind(offsetof(FParameters, g_Query), 26, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(26));
        KernelCall.Bind(offsetof(FParameters, g_Key), 27, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(27));
        KernelCall.Bind(offsetof(FParameters, g_Value), 28, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(28));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 19, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(19));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 33, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(33));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 34, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(34));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[86]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[87]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained_fp8
        using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&small_global_attention_chained_c1024_fp8), Geometry->Grids[25], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "small_global_attention_chained_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Query), 26, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(26));
        KernelCall.Bind(offsetof(FParameters, g_Key), 27, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(27));
        KernelCall.Bind(offsetof(FParameters, g_Value), 28, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(28));
        KernelCall.Bind(offsetof(FParameters, g_Output), 29, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(29));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 33, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(33));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 35, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(35));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[88]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[89]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection_fp8
        using FParameters = FGlobalProjectionC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[26], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 29, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(29));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 25, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(25));
        KernelCall.Bind(offsetof(FParameters, g_Output), 30, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(30));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 20, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(20));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 36, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(36));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 37, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(37));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[90]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[91]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[27], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 45, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(45));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[92]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[28], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 47, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(47));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[93]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[29], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 49, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(49));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[94]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[30], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 50, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(50));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[95]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand_fp8
        using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8), Geometry->Grids[31], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 30, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(30));
        KernelCall.Bind(offsetof(FParameters, g_Output), 38, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(38));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 21, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(21));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[96]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[97]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract_fp8
        using FParameters = FGlobalFfnContractC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[32], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 38, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(38));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 30, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(30));
        KernelCall.Bind(offsetof(FParameters, g_Output), 39, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(39));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 22, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(22));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 45, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(45));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 46, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(46));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[98]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[99]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv_fp8
        using FParameters = FGlobalQkvC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[33], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 39, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(39));
        KernelCall.Bind(offsetof(FParameters, g_Query), 40, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(40));
        KernelCall.Bind(offsetof(FParameters, g_Key), 41, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(41));
        KernelCall.Bind(offsetof(FParameters, g_Value), 42, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(42));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 23, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(23));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 47, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(47));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 48, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(48));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[100]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[101]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained_fp8
        using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&small_global_attention_chained_c1024_fp8), Geometry->Grids[34], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "small_global_attention_chained_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Query), 40, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(40));
        KernelCall.Bind(offsetof(FParameters, g_Key), 41, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(41));
        KernelCall.Bind(offsetof(FParameters, g_Value), 42, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(42));
        KernelCall.Bind(offsetof(FParameters, g_Output), 43, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(43));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 47, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(47));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 49, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(49));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[102]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[103]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection_fp8
        using FParameters = FGlobalProjectionC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[35], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 43, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(43));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 39, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(39));
        KernelCall.Bind(offsetof(FParameters, g_Output), 44, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(44));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 24, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(24));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 50, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(50));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 51, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(51));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[104]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[105]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[36], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 59, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(59));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[106]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[37], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 61, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(61));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[107]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[38], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 63, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(63));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[108]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[39], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 64, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(64));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[109]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand_fp8
        using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8), Geometry->Grids[40], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 44, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(44));
        KernelCall.Bind(offsetof(FParameters, g_Output), 52, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(52));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 25, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(25));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[110]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[111]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract_fp8
        using FParameters = FGlobalFfnContractC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[41], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 52, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(52));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 44, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(44));
        KernelCall.Bind(offsetof(FParameters, g_Output), 53, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(53));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 26, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(26));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 59, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(59));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 60, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(60));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[112]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[113]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv_fp8
        using FParameters = FGlobalQkvC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[42], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 53, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(53));
        KernelCall.Bind(offsetof(FParameters, g_Query), 54, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(54));
        KernelCall.Bind(offsetof(FParameters, g_Key), 55, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(55));
        KernelCall.Bind(offsetof(FParameters, g_Value), 56, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(56));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 27, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(27));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 61, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(61));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 62, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(62));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[114]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[115]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained_fp8
        using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&small_global_attention_chained_c1024_fp8), Geometry->Grids[43], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "small_global_attention_chained_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Query), 54, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(54));
        KernelCall.Bind(offsetof(FParameters, g_Key), 55, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(55));
        KernelCall.Bind(offsetof(FParameters, g_Value), 56, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(56));
        KernelCall.Bind(offsetof(FParameters, g_Output), 57, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(57));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 61, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(61));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 63, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(63));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[116]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[117]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection_fp8
        using FParameters = FGlobalProjectionC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[44], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 57, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(57));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 53, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(53));
        KernelCall.Bind(offsetof(FParameters, g_Output), 58, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(58));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 28, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(28));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 64, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(64));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 65, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(65));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[118]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[119]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[45], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 73, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(73));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[120]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[46], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 75, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(75));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[121]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[47], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 77, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(77));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[122]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[48], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 78, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(78));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[123]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand_fp8
        using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8), Geometry->Grids[49], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 58, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(58));
        KernelCall.Bind(offsetof(FParameters, g_Output), 66, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(66));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 29, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(29));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[124]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[125]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract_fp8
        using FParameters = FGlobalFfnContractC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[50], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 66, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(66));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 58, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(58));
        KernelCall.Bind(offsetof(FParameters, g_Output), 67, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(67));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 30, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(30));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 73, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(73));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 74, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(74));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[126]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[127]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv_fp8
        using FParameters = FGlobalQkvC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[51], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 67, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(67));
        KernelCall.Bind(offsetof(FParameters, g_Query), 68, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(68));
        KernelCall.Bind(offsetof(FParameters, g_Key), 69, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(69));
        KernelCall.Bind(offsetof(FParameters, g_Value), 70, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(70));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 31, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(31));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 75, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(75));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 76, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(76));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[128]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[129]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained_fp8
        using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&small_global_attention_chained_c1024_fp8), Geometry->Grids[52], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "small_global_attention_chained_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Query), 68, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(68));
        KernelCall.Bind(offsetof(FParameters, g_Key), 69, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(69));
        KernelCall.Bind(offsetof(FParameters, g_Value), 70, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(70));
        KernelCall.Bind(offsetof(FParameters, g_Output), 71, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(71));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 75, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(75));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 77, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(77));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[130]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[131]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection_fp8
        using FParameters = FGlobalProjectionC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[53], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 71, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(71));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 67, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(67));
        KernelCall.Bind(offsetof(FParameters, g_Output), 72, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(72));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 32, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(32));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 78, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(78));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 79, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(79));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[132]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[133]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[54], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 87, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(87));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[134]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[55], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 89, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(89));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[135]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[56], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 91, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(91));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[136]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[57], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 92, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(92));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[137]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand_fp8
        using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8), Geometry->Grids[58], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 72, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(72));
        KernelCall.Bind(offsetof(FParameters, g_Output), 80, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(80));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 33, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(33));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[138]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[139]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract_fp8
        using FParameters = FGlobalFfnContractC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[59], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 80, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(80));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 72, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(72));
        KernelCall.Bind(offsetof(FParameters, g_Output), 81, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(81));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 34, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(34));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 87, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(87));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 88, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(88));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[140]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[141]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv_fp8
        using FParameters = FGlobalQkvC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[60], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 81, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(81));
        KernelCall.Bind(offsetof(FParameters, g_Query), 82, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(82));
        KernelCall.Bind(offsetof(FParameters, g_Key), 83, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(83));
        KernelCall.Bind(offsetof(FParameters, g_Value), 84, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(84));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 35, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(35));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 89, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(89));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 90, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(90));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[142]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[143]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained_fp8
        using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&small_global_attention_chained_c1024_fp8), Geometry->Grids[61], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "small_global_attention_chained_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Query), 82, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(82));
        KernelCall.Bind(offsetof(FParameters, g_Key), 83, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(83));
        KernelCall.Bind(offsetof(FParameters, g_Value), 84, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(84));
        KernelCall.Bind(offsetof(FParameters, g_Output), 85, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(85));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 89, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(89));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 91, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(91));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[144]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[145]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection_fp8
        using FParameters = FGlobalProjectionC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[62], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 85, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(85));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 81, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(81));
        KernelCall.Bind(offsetof(FParameters, g_Output), 86, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(86));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 36, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(36));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 92, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(92));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 93, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(93));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[146]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[147]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[63], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 101, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(101));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[148]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[64], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 103, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(103));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[149]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[65], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 105, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(105));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[150]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[66], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 106, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(106));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[151]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand_fp8
        using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8), Geometry->Grids[67], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 86, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(86));
        KernelCall.Bind(offsetof(FParameters, g_Output), 94, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(94));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 37, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(37));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[152]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[153]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract_fp8
        using FParameters = FGlobalFfnContractC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[68], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 94, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(94));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 86, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(86));
        KernelCall.Bind(offsetof(FParameters, g_Output), 95, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(95));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 38, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(38));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 101, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(101));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 102, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(102));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[154]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[155]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv_fp8
        using FParameters = FGlobalQkvC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[69], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 95, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(95));
        KernelCall.Bind(offsetof(FParameters, g_Query), 96, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(96));
        KernelCall.Bind(offsetof(FParameters, g_Key), 97, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(97));
        KernelCall.Bind(offsetof(FParameters, g_Value), 98, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(98));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 39, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(39));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 103, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(103));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 104, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(104));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[156]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[157]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained_fp8
        using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&small_global_attention_chained_c1024_fp8), Geometry->Grids[70], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "small_global_attention_chained_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Query), 96, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(96));
        KernelCall.Bind(offsetof(FParameters, g_Key), 97, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(97));
        KernelCall.Bind(offsetof(FParameters, g_Value), 98, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(98));
        KernelCall.Bind(offsetof(FParameters, g_Output), 99, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(99));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 103, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(103));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 105, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(105));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[158]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[159]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection_fp8
        using FParameters = FGlobalProjectionC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[71], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 99, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(99));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 95, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(95));
        KernelCall.Bind(offsetof(FParameters, g_Output), 100, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(100));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 40, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(40));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 106, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(106));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 107, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(107));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[160]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[161]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[72], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 115, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(115));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[162]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[73], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 117, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(117));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[163]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[74], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 119, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(119));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[164]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[75], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 120, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(120));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[165]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand_fp8
        using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8), Geometry->Grids[76], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 100, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(100));
        KernelCall.Bind(offsetof(FParameters, g_Output), 108, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(108));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 41, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(41));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[166]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[167]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract_fp8
        using FParameters = FGlobalFfnContractC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[77], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 108, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(108));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 100, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(100));
        KernelCall.Bind(offsetof(FParameters, g_Output), 109, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(109));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 42, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(42));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 115, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(115));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 116, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(116));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[168]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[169]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv_fp8
        using FParameters = FGlobalQkvC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[78], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 109, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(109));
        KernelCall.Bind(offsetof(FParameters, g_Query), 110, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(110));
        KernelCall.Bind(offsetof(FParameters, g_Key), 111, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(111));
        KernelCall.Bind(offsetof(FParameters, g_Value), 112, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(112));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 43, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(43));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 117, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(117));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 118, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(118));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[170]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[171]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained_fp8
        using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&small_global_attention_chained_c1024_fp8), Geometry->Grids[79], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "small_global_attention_chained_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Query), 110, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(110));
        KernelCall.Bind(offsetof(FParameters, g_Key), 111, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(111));
        KernelCall.Bind(offsetof(FParameters, g_Value), 112, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(112));
        KernelCall.Bind(offsetof(FParameters, g_Output), 113, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(113));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 117, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(117));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 119, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(119));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[172]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[173]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection_fp8
        using FParameters = FGlobalProjectionC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[80], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 113, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(113));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 109, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(109));
        KernelCall.Bind(offsetof(FParameters, g_Output), 114, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(114));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 44, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(44));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 120, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(120));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 121, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(121));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[174]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[175]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[81], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 129, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(129));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[176]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[82], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 131, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(131));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[177]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[83], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 133, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(133));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[178]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[84], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 134, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(134));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[179]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand_fp8
        using FParameters = FGlobalFfnExpandC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp8), Geometry->Grids[85], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 114, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(114));
        KernelCall.Bind(offsetof(FParameters, g_Output), 122, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(122));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 45, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(45));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[180]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[181]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract_fp8
        using FParameters = FGlobalFfnContractC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_ffn_contract_c1024_fp8(), Geometry->Grids[86], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 122, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(122));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 114, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(114));
        KernelCall.Bind(offsetof(FParameters, g_Output), 123, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(123));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 46, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(46));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 129, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(129));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 130, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(130));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[182]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[183]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv_fp8
        using FParameters = FGlobalQkvC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp8), Geometry->Grids[87], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 123, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(123));
        KernelCall.Bind(offsetof(FParameters, g_Query), 124, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(124));
        KernelCall.Bind(offsetof(FParameters, g_Key), 125, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(125));
        KernelCall.Bind(offsetof(FParameters, g_Value), 126, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(126));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 47, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(47));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 131, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(131));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 132, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(132));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[184]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[185]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained_fp8
        using FParameters = FGlobalAttentionChainedC1024Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&small_global_attention_chained_c1024_fp8), Geometry->Grids[88], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "small_global_attention_chained_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Query), 124, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(124));
        KernelCall.Bind(offsetof(FParameters, g_Key), 125, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(125));
        KernelCall.Bind(offsetof(FParameters, g_Value), 126, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(126));
        KernelCall.Bind(offsetof(FParameters, g_Output), 127, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(127));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 131, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(131));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 133, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(133));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[186]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[187]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection_fp8
        using FParameters = FGlobalProjectionC1024Fp8Parameters;
        FKernelCall KernelCall{Resolve_global_projection_c1024_fp8(), Geometry->Grids[89], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 127, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(127));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 123, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(123));
        KernelCall.Bind(offsetof(FParameters, g_Output), 128, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(128));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 48, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(48));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 134, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(134));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 135, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(135));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[188]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[189]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_repack_1d_to_2d_fp8
        using FParameters = FGlobalRepackParameters;
        FKernelCall KernelCall{Resolve_repack_1d_to_2d_c1024_fp8(), Geometry->Grids[90], dim3(256, 1, 1), 24, false};
        KernelCall.Name = "repack_1d_to_2d_c1024_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 128, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(128));
        KernelCall.Bind(offsetof(FParameters, g_Output), 136, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(136));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[190]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[191]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[91], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 138, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(138));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[192]);
        Calls.push_back(KernelCall);
    }
    { // cc_dec_input_upsample_1024_512_fp8
        using FParameters = FDecoderUpsampleC1024ToC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&decoder_upsample_c1024_to_c512_fp8), Geometry->Grids[92], dim3(32, 2, 1), 80, true};
        KernelCall.Name = "decoder_upsample_c1024_to_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 136, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(136));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 20, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(20));
        KernelCall.Bind(offsetof(FParameters, g_Output), 137, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(137));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 138, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(138));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 139, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(139));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 49, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(49));
        KernelCall.Set<int32_t>(offsetof(FParameters, InputHeight), Geometry->GeometryArguments[193]);
        KernelCall.Set<int32_t>(offsetof(FParameters, InputWidth), Geometry->GeometryArguments[194]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OutputHeight), Geometry->GeometryArguments[195]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OutputWidth), Geometry->GeometryArguments[196]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_512_fp8
        using FParameters = FWindowFfnC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[93], dim3(32, 8, 1), 56, false};
        KernelCall.Name = "window_ffn_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 140, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(140));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 50, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(50));
        KernelCall.Bind(offsetof(FParameters, g_Input), 137, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(137));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[197]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[198]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[199]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[200]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_proj_512_fp8
        using FParameters = FWindowFfnProjectionC512Fp8Parameters;
        FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[94], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_ffn_projection_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 141, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(141));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 51, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(51));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 137, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(137));
        KernelCall.Bind(offsetof(FParameters, g_Input), 140, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(140));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[201]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[202]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_qkv_512_fp8
        using FParameters = FWindowQkvC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[95], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_qkv_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 142, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(142));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 52, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(52));
        KernelCall.Bind(offsetof(FParameters, g_Input), 141, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(141));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[203]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[204]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[205]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[206]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_proj_512_fp8
        using FParameters = FWindowAttentionProjectionC512Fp8Parameters;
        FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp8(), Geometry->Grids[96], dim3(32, 8, 1), 72, false};
        KernelCall.Name = "window_attention_projection_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 143, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(143));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 53, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(53));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 141, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(141));
        KernelCall.Bind(offsetof(FParameters, g_Input), 142, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(142));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[207]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[208]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_512_fp8
        using FParameters = FWindowFfnC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp8), Geometry->Grids[97], dim3(32, 8, 1), 56, false};
        KernelCall.Name = "window_ffn_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 144, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(144));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 54, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(54));
        KernelCall.Bind(offsetof(FParameters, g_Input), 143, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(143));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[209]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[210]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[211]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[212]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_proj_512_fp8
        using FParameters = FWindowFfnProjectionC512Fp8Parameters;
        FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp8(), Geometry->Grids[98], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_ffn_projection_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 145, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(145));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 55, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(55));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 143, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(143));
        KernelCall.Bind(offsetof(FParameters, g_Input), 144, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(144));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[213]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[214]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_qkv_512_fp8
        using FParameters = FWindowQkvC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp8), Geometry->Grids[99], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_qkv_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 146, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(146));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 56, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(56));
        KernelCall.Bind(offsetof(FParameters, g_Input), 145, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(145));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[215]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[216]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[217]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[218]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_proj_512_outview_fp8
        using FParameters = FWindowAttentionProjectionOutputViewC512Fp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_output_view_c512_fp8), Geometry->Grids[100], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_attention_projection_output_view_c512_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Output), 147, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(147));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 57, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(57));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 145, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(145));
        KernelCall.Bind(offsetof(FParameters, g_Input), 146, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(146));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[219]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[220]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_8h_256_8_upsample_fp8
        using FParameters = FWindowBlockC256UpsampleFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c256_upsample_fp8(), Geometry->Grids[101], dim3(32, 8, 1), 88, false};
        KernelCall.Name = "window_block_c256_upsample_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 147, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(147));
        KernelCall.Bind(offsetof(FParameters, g_Output), 148, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(148));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 58, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(58));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[221]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[222]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[223]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[224]);
        KernelCall.Bind(offsetof(FParameters, g_Residual), 11, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(11));
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_8h_256_8_outview_fp8
        using FParameters = FWindowBlockC256OutputViewFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c256_output_view_fp8(), Geometry->Grids[102], dim3(32, 8, 1), 88, false};
        KernelCall.Name = "window_block_c256_output_view_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 148, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(148));
        KernelCall.Bind(offsetof(FParameters, g_Output), 149, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(149));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 59, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(59));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[225]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[226]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[227]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[228]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[229]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[230]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_4h_128_4_upsample_fp8
        using FParameters = FWindowBlockC128UpsampleFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c128_upsample_fp8(), Geometry->Grids[103], dim3(32, 4, 1), 88, false};
        KernelCall.Name = "window_block_c128_upsample_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 149, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(149));
        KernelCall.Bind(offsetof(FParameters, g_Output), 150, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(150));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 60, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(60));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[231]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[232]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[233]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[234]);
        KernelCall.Bind(offsetof(FParameters, g_Residual), 8, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(8));
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_4h_128_4_outview_fp8
        using FParameters = FWindowBlockC128OutputViewFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c128_output_view_fp8(), Geometry->Grids[104], dim3(32, 4, 1), 88, false};
        KernelCall.Name = "window_block_c128_output_view_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 150, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(150));
        KernelCall.Bind(offsetof(FParameters, g_Output), 151, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(151));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 61, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(61));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[235]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[236]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[237]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[238]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[239]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[240]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_2h_64_2_upsample_fp8
        using FParameters = FWindowBlockC64UpsampleFp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_upsample_fp8), Geometry->Grids[105], dim3(32, 2, 1), 88, false};
        KernelCall.Name = "window_block_c64_upsample_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 151, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(151));
        KernelCall.Bind(offsetof(FParameters, g_Output), 152, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(152));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 62, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(62));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[241]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[242]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[243]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[244]);
        KernelCall.Bind(offsetof(FParameters, g_Residual), 5, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(5));
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_2h_64_2_outview_fp8
        using FParameters = FWindowBlockC64OutputViewFp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c64_output_view_fp8(), Geometry->Grids[106], dim3(32, 2, 1), 88, false};
        KernelCall.Name = "window_block_c64_output_view_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 152, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(152));
        KernelCall.Bind(offsetof(FParameters, g_Output), 153, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(153));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 63, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(63));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[245]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[246]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[247]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[248]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewHeight), Geometry->GeometryArguments[249]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ViewWidth), Geometry->GeometryArguments[250]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_1h_32_1_upsample_fp8
        using FParameters = FWindowBlockC32UpsampleFp8Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_upsample_fp8), Geometry->Grids[107], dim3(32, 1, 1), 96, false};
        KernelCall.Name = "window_block_c32_upsample_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 153, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(153));
        KernelCall.Bind(offsetof(FParameters, g_Output), 154, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(154));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 64, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(64));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[251]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[252]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[253]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[254]);
        KernelCall.Bind(offsetof(FParameters, g_Residual), 2, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(2));
        KernelCall.Set<int32_t>(offsetof(FParameters, ResidualHeight), Geometry->GeometryArguments[255]);
        KernelCall.Set<int32_t>(offsetof(FParameters, ResidualWidth), Geometry->GeometryArguments[256]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_1h_32_1_fp8
        using FParameters = FWindowBlockC32Fp8Parameters;
        FKernelCall KernelCall{Resolve_window_block_c32_fp8(), Geometry->Grids[108], dim3(32, 1, 1), 96, false};
        KernelCall.Name = "window_block_c32_fp8";
        KernelCall.Bind(offsetof(FParameters, g_Input), 154, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(154));
        KernelCall.Bind(offsetof(FParameters, g_Output), 155, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(155));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 65, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(65));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[257]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[258]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[259]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[260]);
        Calls.push_back(KernelCall);
    }
}
