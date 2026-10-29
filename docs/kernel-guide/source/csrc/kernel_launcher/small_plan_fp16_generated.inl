// Generated separate Small31 native FP16 schedule. Every resolution uses the same 109 calls.
// Buffer names are shared; the geometry table supplies their actual byte extents.
static const char* SmallBufferNameTable_fp16[] = {
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
static const FBufferSpec SmallRecordSpecs_fp16[] = {
    {"block1.layer0.layer", 32960LL},
    {"block2.layer0.layer", 37056LL},
    {"block3.layer0.layer", 106816LL},
    {"block4.layer0.layer", 123200LL},
    {"block5.layer0.layer", 361024LL},
    {"block6.layer0.layer", 426560LL},
    {"block7.layer0.layer", 1311808LL},
    {"block8.layer0.layer", 1573952LL},
    {"block9.layer0.layer", 1048576LL},
    {"block9.layer1.layer", 525312LL},
    {"block9.layer2.layer", 1704000LL},
    {"block9.layer3.layer", 525312LL},
    {"block10.layer0.layer", 1048576LL},
    {"block10.layer1.layer", 525312LL},
    {"block10.layer2.layer", 1704000LL},
    {"block10.layer3.layer", 525312LL},
    {"block10.layer4.layer", 1048592LL},
    {"block11.layer0.layer", 8388608LL},
    {"block11.layer1.layer", 8390656LL},
    {"block11.layer2.layer", 6291584LL},
    {"block11.layer4.layer", 2099200LL},
    {"block12.layer0.layer", 8388608LL},
    {"block12.layer1.layer", 8390656LL},
    {"block12.layer2.layer", 6291584LL},
    {"block12.layer4.layer", 2099200LL},
    {"block13.layer0.layer", 8388608LL},
    {"block13.layer1.layer", 8390656LL},
    {"block13.layer2.layer", 6291584LL},
    {"block13.layer4.layer", 2099200LL},
    {"block14.layer0.layer", 8388608LL},
    {"block14.layer1.layer", 8390656LL},
    {"block14.layer2.layer", 6291584LL},
    {"block14.layer4.layer", 2099200LL},
    {"block15.layer0.layer", 8388608LL},
    {"block15.layer1.layer", 8390656LL},
    {"block15.layer2.layer", 6291584LL},
    {"block15.layer4.layer", 2099200LL},
    {"block16.layer0.layer", 8388608LL},
    {"block16.layer1.layer", 8390656LL},
    {"block16.layer2.layer", 6291584LL},
    {"block16.layer4.layer", 2099200LL},
    {"block17.layer0.layer", 8388608LL},
    {"block17.layer1.layer", 8390656LL},
    {"block17.layer2.layer", 6291584LL},
    {"block17.layer4.layer", 2099200LL},
    {"block18.layer0.layer", 8388608LL},
    {"block18.layer1.layer", 8390656LL},
    {"block18.layer2.layer", 6291584LL},
    {"block18.layer4.layer", 2099200LL},
    {"block19.layer0.layer", 1049600LL},
    {"block20.layer0.layer", 1048576LL},
    {"block20.layer1.layer", 525312LL},
    {"block20.layer2.layer", 1704000LL},
    {"block20.layer3.layer", 525312LL},
    {"block21.layer0.layer", 1048576LL},
    {"block21.layer1.layer", 525312LL},
    {"block21.layer2.layer", 1704000LL},
    {"block21.layer3.layer", 525312LL},
    {"block22.layer0.layer", 1574464LL},
    {"block23.layer0.layer", 1311808LL},
    {"block24.layer0.layer", 426816LL},
    {"block25.layer0.layer", 361024LL},
    {"block26.layer0.layer", 123328LL},
    {"block27.layer0.layer", 106816LL},
    {"block28.layer0.layer", 37120LL},
    {"block29.layer0.layer", 32960LL},
};
static const char* SmallBoundaryNames_fp16[] = {
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
template <> void FSmallDeploymentPlan<true>::BuildCalls() {
    Calls.reserve(109);
    { // cc_tinlayout_fused_swin_1h_32_1_inpview
        using FParameters = FWindowBlockC32InputViewFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c32_input_view_fp16(), Geometry->Grids[0], dim3(32, 1, 1), 96, false};
        KernelCall.Name = "window_block_c32_input_view_fp16";
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
    { // cc_tinlayout_fused_swin_1h_32_1_ds
        using FParameters = FWindowBlockC32DownsampleFp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_downsample_fp16), Geometry->Grids[1], dim3(32, 1, 1), 96, false};
        KernelCall.Name = "window_block_c32_downsample_fp16";
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
    { // cc_tinlayout_fused_swin_2h_64_2_inpview
        using FParameters = FWindowBlockC64InputViewFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c64_input_view_fp16(), Geometry->Grids[2], dim3(32, 2, 1), 88, false};
        KernelCall.Name = "window_block_c64_input_view_fp16";
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
    { // cc_tinlayout_fused_swin_2h_64_2_ds
        using FParameters = FWindowBlockC64DownsampleFp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_downsample_fp16), Geometry->Grids[3], dim3(32, 2, 1), 88, false};
        KernelCall.Name = "window_block_c64_downsample_fp16";
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
    { // cc_tinlayout_fused_swin_4h_128_4_inpview
        using FParameters = FWindowBlockC128InputViewFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c128_input_view_fp16(), Geometry->Grids[4], dim3(32, 4, 1), 88, false};
        KernelCall.Name = "window_block_c128_input_view_fp16";
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
    { // cc_tinlayout_fused_swin_4h_128_4_ds
        using FParameters = FWindowBlockC128DownsampleFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c128_downsample_fp16(), Geometry->Grids[5], dim3(32, 4, 1), 88, false};
        KernelCall.Name = "window_block_c128_downsample_fp16";
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
    { // cc_tinlayout_fused_swin_8h_256_8_inpview
        using FParameters = FWindowBlockC256InputViewFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c256_input_view_fp16(), Geometry->Grids[6], dim3(32, 8, 1), 88, false};
        KernelCall.Name = "window_block_c256_input_view_fp16";
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
    { // cc_tinlayout_fused_swin_8h_256_8_ds
        using FParameters = FWindowBlockC256DownsampleFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c256_downsample_fp16(), Geometry->Grids[7], dim3(32, 8, 1), 88, false};
        KernelCall.Name = "window_block_c256_downsample_fp16";
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
    { // cc_split_swin_16h_ffwd_inpview_512
        using FParameters = FWindowFfnInputViewC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_input_view_c512_fp16), Geometry->Grids[8], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_ffn_input_view_c512_fp16";
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
    { // cc_split_swin_16h_ffwd_proj_inpview_512
        using FParameters = FWindowFfnProjectionInputViewC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_projection_input_view_c512_fp16), Geometry->Grids[9], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_ffn_projection_input_view_c512_fp16";
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
    { // cc_split_swin_16h_qkv_512
        using FParameters = FWindowQkvC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[10], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_qkv_c512_fp16";
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
    { // cc_split_swin_16h_proj_512
        using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
        FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp16(), Geometry->Grids[11], dim3(32, 8, 1), 72, false};
        KernelCall.Name = "window_attention_projection_c512_fp16";
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
    { // cc_split_swin_16h_ffwd_512
        using FParameters = FWindowFfnC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[12], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_ffn_c512_fp16";
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
    { // cc_split_swin_16h_ffwd_proj_512
        using FParameters = FWindowFfnProjectionC512Fp16Parameters;
        FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp16(), Geometry->Grids[13], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_ffn_projection_c512_fp16";
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
    { // cc_split_swin_16h_qkv_512
        using FParameters = FWindowQkvC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[14], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_qkv_c512_fp16";
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
    { // cc_split_swin_16h_proj_pool_512
        using FParameters = FWindowAttentionProjectionPoolC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_pool_c512_fp16), Geometry->Grids[15], dim3(32, 4, 1), 80, false};
        KernelCall.Name = "window_attention_projection_pool_c512_fp16";
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
    { // cc_split_swin_16h_final_head_512
        using FParameters = FChannelProjectionC512ToC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&channel_projection_c512_to_c1024_fp16), Geometry->Grids[16], dim3(32, 8, 1), 40, false};
        KernelCall.Name = "channel_projection_c512_to_c1024_fp16";
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
    { // cc_vit_1d_repack_2d_to_1d
        using FParameters = FGlobalRepackParameters;
        FKernelCall KernelCall{Resolve_repack_2d_to_1d_c1024_fp16(), Geometry->Grids[17], dim3(256, 1, 1), 24, false};
        KernelCall.Name = "repack_2d_to_1d_c1024_fp16";
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
        KernelCall.Bind(offsetof(FParameters, g_Counters), 32, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(32));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[79]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[20], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 33, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(33));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[80]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[21], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 34, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(34));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[81]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand
        using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16), Geometry->Grids[22], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp16";
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
    { // cc_vit_1d_ffn_contract
        using FParameters = FGlobalFfnContractC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16), Geometry->Grids[23], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp16";
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
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[84]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[85]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv
        using FParameters = FGlobalQkvC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[24], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp16";
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
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 32, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(32));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[86]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[87]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained
        using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16), Geometry->Grids[25], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "global_attention_chained_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Query), 26, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(26));
        KernelCall.Bind(offsetof(FParameters, g_Key), 27, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(27));
        KernelCall.Bind(offsetof(FParameters, g_Value), 28, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(28));
        KernelCall.Bind(offsetof(FParameters, g_Output), 29, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(29));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 32, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(32));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 33, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(33));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[88]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[89]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection
        using FParameters = FGlobalProjectionC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16), Geometry->Grids[26], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 29, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(29));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 25, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(25));
        KernelCall.Bind(offsetof(FParameters, g_Output), 30, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(30));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 20, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(20));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 34, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(34));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[90]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[91]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[27], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 42, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(42));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[92]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[28], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 43, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(43));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[93]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[29], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 44, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(44));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[94]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[30], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 45, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(45));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[95]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand
        using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16), Geometry->Grids[31], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 30, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(30));
        KernelCall.Bind(offsetof(FParameters, g_Output), 35, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(35));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 21, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(21));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[96]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[97]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract
        using FParameters = FGlobalFfnContractC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16), Geometry->Grids[32], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 35, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(35));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 30, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(30));
        KernelCall.Bind(offsetof(FParameters, g_Output), 36, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(36));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 22, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(22));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 42, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(42));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[98]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[99]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv
        using FParameters = FGlobalQkvC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[33], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 36, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(36));
        KernelCall.Bind(offsetof(FParameters, g_Query), 37, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(37));
        KernelCall.Bind(offsetof(FParameters, g_Key), 38, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(38));
        KernelCall.Bind(offsetof(FParameters, g_Value), 39, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(39));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 23, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(23));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 43, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(43));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[100]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[101]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained
        using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16), Geometry->Grids[34], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "global_attention_chained_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Query), 37, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(37));
        KernelCall.Bind(offsetof(FParameters, g_Key), 38, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(38));
        KernelCall.Bind(offsetof(FParameters, g_Value), 39, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(39));
        KernelCall.Bind(offsetof(FParameters, g_Output), 40, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(40));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 43, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(43));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 44, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(44));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[102]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[103]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection
        using FParameters = FGlobalProjectionC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16), Geometry->Grids[35], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 40, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(40));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 36, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(36));
        KernelCall.Bind(offsetof(FParameters, g_Output), 41, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(41));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 24, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(24));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 45, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(45));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[104]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[105]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[36], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 53, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(53));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[106]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[37], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 54, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(54));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[107]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[38], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 55, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(55));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[108]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[39], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 56, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(56));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[109]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand
        using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16), Geometry->Grids[40], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 41, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(41));
        KernelCall.Bind(offsetof(FParameters, g_Output), 46, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(46));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 25, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(25));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[110]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[111]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract
        using FParameters = FGlobalFfnContractC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16), Geometry->Grids[41], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 46, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(46));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 41, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(41));
        KernelCall.Bind(offsetof(FParameters, g_Output), 47, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(47));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 26, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(26));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 53, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(53));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[112]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[113]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv
        using FParameters = FGlobalQkvC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[42], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 47, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(47));
        KernelCall.Bind(offsetof(FParameters, g_Query), 48, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(48));
        KernelCall.Bind(offsetof(FParameters, g_Key), 49, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(49));
        KernelCall.Bind(offsetof(FParameters, g_Value), 50, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(50));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 27, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(27));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 54, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(54));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[114]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[115]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained
        using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16), Geometry->Grids[43], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "global_attention_chained_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Query), 48, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(48));
        KernelCall.Bind(offsetof(FParameters, g_Key), 49, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(49));
        KernelCall.Bind(offsetof(FParameters, g_Value), 50, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(50));
        KernelCall.Bind(offsetof(FParameters, g_Output), 51, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(51));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 54, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(54));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 55, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(55));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[116]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[117]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection
        using FParameters = FGlobalProjectionC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16), Geometry->Grids[44], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 51, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(51));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 47, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(47));
        KernelCall.Bind(offsetof(FParameters, g_Output), 52, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(52));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 28, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(28));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 56, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(56));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[118]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[119]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[45], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 64, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(64));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[120]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[46], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 65, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(65));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[121]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[47], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 66, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(66));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[122]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[48], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 67, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(67));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[123]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand
        using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16), Geometry->Grids[49], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 52, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(52));
        KernelCall.Bind(offsetof(FParameters, g_Output), 57, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(57));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 29, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(29));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[124]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[125]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract
        using FParameters = FGlobalFfnContractC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16), Geometry->Grids[50], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 57, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(57));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 52, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(52));
        KernelCall.Bind(offsetof(FParameters, g_Output), 58, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(58));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 30, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(30));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 64, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(64));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[126]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[127]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv
        using FParameters = FGlobalQkvC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[51], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 58, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(58));
        KernelCall.Bind(offsetof(FParameters, g_Query), 59, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(59));
        KernelCall.Bind(offsetof(FParameters, g_Key), 60, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(60));
        KernelCall.Bind(offsetof(FParameters, g_Value), 61, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(61));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 31, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(31));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 65, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(65));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[128]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[129]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained
        using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16), Geometry->Grids[52], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "global_attention_chained_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Query), 59, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(59));
        KernelCall.Bind(offsetof(FParameters, g_Key), 60, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(60));
        KernelCall.Bind(offsetof(FParameters, g_Value), 61, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(61));
        KernelCall.Bind(offsetof(FParameters, g_Output), 62, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(62));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 65, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(65));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 66, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(66));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[130]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[131]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection
        using FParameters = FGlobalProjectionC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16), Geometry->Grids[53], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 62, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(62));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 58, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(58));
        KernelCall.Bind(offsetof(FParameters, g_Output), 63, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(63));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 32, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(32));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 67, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(67));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[132]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[133]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[54], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 75, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(75));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[134]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[55], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 76, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(76));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[135]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[56], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 77, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(77));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[136]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[57], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 78, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(78));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[137]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand
        using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16), Geometry->Grids[58], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 63, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(63));
        KernelCall.Bind(offsetof(FParameters, g_Output), 68, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(68));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 33, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(33));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[138]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[139]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract
        using FParameters = FGlobalFfnContractC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16), Geometry->Grids[59], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 68, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(68));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 63, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(63));
        KernelCall.Bind(offsetof(FParameters, g_Output), 69, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(69));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 34, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(34));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 75, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(75));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[140]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[141]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv
        using FParameters = FGlobalQkvC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[60], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 69, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(69));
        KernelCall.Bind(offsetof(FParameters, g_Query), 70, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(70));
        KernelCall.Bind(offsetof(FParameters, g_Key), 71, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(71));
        KernelCall.Bind(offsetof(FParameters, g_Value), 72, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(72));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 35, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(35));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 76, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(76));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[142]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[143]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained
        using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16), Geometry->Grids[61], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "global_attention_chained_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Query), 70, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(70));
        KernelCall.Bind(offsetof(FParameters, g_Key), 71, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(71));
        KernelCall.Bind(offsetof(FParameters, g_Value), 72, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(72));
        KernelCall.Bind(offsetof(FParameters, g_Output), 73, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(73));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 76, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(76));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 77, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(77));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[144]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[145]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection
        using FParameters = FGlobalProjectionC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16), Geometry->Grids[62], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 73, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(73));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 69, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(69));
        KernelCall.Bind(offsetof(FParameters, g_Output), 74, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(74));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 36, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(36));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 78, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(78));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[146]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[147]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[63], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 86, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(86));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[148]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[64], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 87, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(87));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[149]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[65], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 88, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(88));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[150]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[66], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 89, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(89));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[151]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand
        using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16), Geometry->Grids[67], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 74, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(74));
        KernelCall.Bind(offsetof(FParameters, g_Output), 79, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(79));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 37, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(37));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[152]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[153]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract
        using FParameters = FGlobalFfnContractC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16), Geometry->Grids[68], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 79, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(79));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 74, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(74));
        KernelCall.Bind(offsetof(FParameters, g_Output), 80, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(80));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 38, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(38));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 86, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(86));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[154]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[155]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv
        using FParameters = FGlobalQkvC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[69], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 80, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(80));
        KernelCall.Bind(offsetof(FParameters, g_Query), 81, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(81));
        KernelCall.Bind(offsetof(FParameters, g_Key), 82, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(82));
        KernelCall.Bind(offsetof(FParameters, g_Value), 83, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(83));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 39, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(39));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 87, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(87));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[156]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[157]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained
        using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16), Geometry->Grids[70], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "global_attention_chained_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Query), 81, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(81));
        KernelCall.Bind(offsetof(FParameters, g_Key), 82, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(82));
        KernelCall.Bind(offsetof(FParameters, g_Value), 83, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(83));
        KernelCall.Bind(offsetof(FParameters, g_Output), 84, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(84));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 87, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(87));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 88, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(88));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[158]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[159]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection
        using FParameters = FGlobalProjectionC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16), Geometry->Grids[71], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 84, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(84));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 80, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(80));
        KernelCall.Bind(offsetof(FParameters, g_Output), 85, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(85));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 40, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(40));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 89, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(89));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[160]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[161]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[72], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 97, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(97));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[162]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[73], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 98, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(98));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[163]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[74], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 99, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(99));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[164]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[75], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 100, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(100));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[165]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand
        using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16), Geometry->Grids[76], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 85, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(85));
        KernelCall.Bind(offsetof(FParameters, g_Output), 90, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(90));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 41, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(41));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[166]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[167]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract
        using FParameters = FGlobalFfnContractC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16), Geometry->Grids[77], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 90, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(90));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 85, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(85));
        KernelCall.Bind(offsetof(FParameters, g_Output), 91, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(91));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 42, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(42));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 97, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(97));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[168]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[169]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv
        using FParameters = FGlobalQkvC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[78], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 91, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(91));
        KernelCall.Bind(offsetof(FParameters, g_Query), 92, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(92));
        KernelCall.Bind(offsetof(FParameters, g_Key), 93, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(93));
        KernelCall.Bind(offsetof(FParameters, g_Value), 94, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(94));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 43, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(43));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 98, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(98));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[170]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[171]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained
        using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16), Geometry->Grids[79], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "global_attention_chained_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Query), 92, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(92));
        KernelCall.Bind(offsetof(FParameters, g_Key), 93, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(93));
        KernelCall.Bind(offsetof(FParameters, g_Value), 94, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(94));
        KernelCall.Bind(offsetof(FParameters, g_Output), 95, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(95));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 98, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(98));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 99, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(99));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[172]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[173]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection
        using FParameters = FGlobalProjectionC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16), Geometry->Grids[80], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 95, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(95));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 91, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(91));
        KernelCall.Bind(offsetof(FParameters, g_Output), 96, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(96));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 44, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(44));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 100, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(100));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[174]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[175]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[81], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 108, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(108));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[176]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[82], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 109, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(109));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[177]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[83], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 110, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(110));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[178]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[84], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 111, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(111));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[179]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_expand
        using FParameters = FGlobalFfnExpandC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_expand_c1024_fp16), Geometry->Grids[85], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "global_ffn_expand_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 96, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(96));
        KernelCall.Bind(offsetof(FParameters, g_Output), 101, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(101));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 45, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(45));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[180]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[181]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_ffn_contract
        using FParameters = FGlobalFfnContractC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_ffn_contract_c1024_fp16), Geometry->Grids[86], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_ffn_contract_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 101, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(101));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 96, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(96));
        KernelCall.Bind(offsetof(FParameters, g_Output), 102, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(102));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 46, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(46));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 108, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(108));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[182]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[183]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_qkv
        using FParameters = FGlobalQkvC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_qkv_c1024_fp16), Geometry->Grids[87], dim3(32, 4, 1), 80, true};
        KernelCall.Name = "global_qkv_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 102, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(102));
        KernelCall.Bind(offsetof(FParameters, g_Query), 103, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(103));
        KernelCall.Bind(offsetof(FParameters, g_Key), 104, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(104));
        KernelCall.Bind(offsetof(FParameters, g_Value), 105, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(105));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 47, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(47));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 109, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(109));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[184]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[185]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_attention_chained
        using FParameters = FGlobalAttentionChainedC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_attention_chained_c1024_fp16), Geometry->Grids[88], dim3(32, 4, 1), 64, false};
        KernelCall.Name = "global_attention_chained_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Query), 103, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Query), GetBufferAddress(103));
        KernelCall.Bind(offsetof(FParameters, g_Key), 104, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Key), GetBufferAddress(104));
        KernelCall.Bind(offsetof(FParameters, g_Value), 105, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Value), GetBufferAddress(105));
        KernelCall.Bind(offsetof(FParameters, g_Output), 106, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(106));
        KernelCall.Bind(offsetof(FParameters, g_PredecessorCounters), 109, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PredecessorCounters), GetBufferAddress(109));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 110, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(110));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[186]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[187]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_projection
        using FParameters = FGlobalProjectionC1024Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&global_projection_c1024_fp16), Geometry->Grids[89], dim3(32, 4, 1), 72, true};
        KernelCall.Name = "global_projection_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 106, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(106));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 102, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(102));
        KernelCall.Bind(offsetof(FParameters, g_Output), 107, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(107));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 48, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(48));
        KernelCall.Bind(offsetof(FParameters, g_SplitCounters), 111, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitCounters), GetBufferAddress(111));
        KernelCall.Set<int32_t>(offsetof(FParameters, BatchCount), Geometry->GeometryArguments[188]);
        KernelCall.Set<int32_t>(offsetof(FParameters, TokensPerBatch), Geometry->GeometryArguments[189]);
        Calls.push_back(KernelCall);
    }
    { // cc_vit_1d_repack_1d_to_2d
        using FParameters = FGlobalRepackParameters;
        FKernelCall KernelCall{Resolve_repack_1d_to_2d_c1024_fp16(), Geometry->Grids[90], dim3(256, 1, 1), 24, false};
        KernelCall.Name = "repack_1d_to_2d_c1024_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 107, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(107));
        KernelCall.Bind(offsetof(FParameters, g_Output), 112, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(112));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[190]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[191]);
        Calls.push_back(KernelCall);
    }
    { // cc_cb_clear
        using FParameters = FCompletionCounterParameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&completion_counter_clear), Geometry->Grids[91], dim3(256, 1, 1), 16, false};
        KernelCall.Name = "completion_counter_clear";
        KernelCall.Bind(offsetof(FParameters, g_Counters), 114, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Counters), GetBufferAddress(114));
        KernelCall.Set<int32_t>(offsetof(FParameters, CounterCount), Geometry->GeometryArguments[192]);
        Calls.push_back(KernelCall);
    }
    { // cc_dec_input_upsample_1024_512
        using FParameters = FDecoderUpsampleC1024ToC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&decoder_upsample_c1024_to_c512_fp16), Geometry->Grids[92], dim3(32, 2, 1), 80, true};
        KernelCall.Name = "decoder_upsample_c1024_to_c512_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 112, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(112));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 20, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(20));
        KernelCall.Bind(offsetof(FParameters, g_Output), 113, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(113));
        KernelCall.Bind(offsetof(FParameters, g_CompletionCounters), 114, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_CompletionCounters), GetBufferAddress(114));
        KernelCall.Bind(offsetof(FParameters, g_SplitAccumulator), 115, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_SplitAccumulator), GetBufferAddress(115));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 49, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(49));
        KernelCall.Set<int32_t>(offsetof(FParameters, InputHeight), Geometry->GeometryArguments[193]);
        KernelCall.Set<int32_t>(offsetof(FParameters, InputWidth), Geometry->GeometryArguments[194]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OutputHeight), Geometry->GeometryArguments[195]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OutputWidth), Geometry->GeometryArguments[196]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_512
        using FParameters = FWindowFfnC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[93], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_ffn_c512_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Output), 116, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(116));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 50, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(50));
        KernelCall.Bind(offsetof(FParameters, g_Input), 113, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(113));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[197]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[198]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[199]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[200]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_proj_512
        using FParameters = FWindowFfnProjectionC512Fp16Parameters;
        FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp16(), Geometry->Grids[94], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_ffn_projection_c512_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Output), 117, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(117));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 51, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(51));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 113, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(113));
        KernelCall.Bind(offsetof(FParameters, g_Input), 116, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(116));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[201]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[202]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_qkv_512
        using FParameters = FWindowQkvC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[95], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_qkv_c512_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Output), 118, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(118));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 52, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(52));
        KernelCall.Bind(offsetof(FParameters, g_Input), 117, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(117));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[203]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[204]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[205]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[206]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_proj_512
        using FParameters = FWindowAttentionProjectionC512Fp16Parameters;
        FKernelCall KernelCall{Resolve_window_attention_projection_c512_fp16(), Geometry->Grids[96], dim3(32, 8, 1), 72, false};
        KernelCall.Name = "window_attention_projection_c512_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Output), 119, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(119));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 53, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(53));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 117, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(117));
        KernelCall.Bind(offsetof(FParameters, g_Input), 118, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(118));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[207]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[208]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_512
        using FParameters = FWindowFfnC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_ffn_c512_fp16), Geometry->Grids[97], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_ffn_c512_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Output), 120, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(120));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 54, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(54));
        KernelCall.Bind(offsetof(FParameters, g_Input), 119, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(119));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[209]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[210]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[211]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[212]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_ffwd_proj_512
        using FParameters = FWindowFfnProjectionC512Fp16Parameters;
        FKernelCall KernelCall{Resolve_window_ffn_projection_c512_fp16(), Geometry->Grids[98], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_ffn_projection_c512_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Output), 121, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(121));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 55, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(55));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 119, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(119));
        KernelCall.Bind(offsetof(FParameters, g_Input), 120, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(120));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[213]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[214]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_qkv_512
        using FParameters = FWindowQkvC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_qkv_c512_fp16), Geometry->Grids[99], dim3(32, 4, 1), 56, false};
        KernelCall.Name = "window_qkv_c512_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Output), 122, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(122));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 56, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(56));
        KernelCall.Bind(offsetof(FParameters, g_Input), 121, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(121));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[215]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[216]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[217]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[218]);
        Calls.push_back(KernelCall);
    }
    { // cc_split_swin_16h_proj_512_outview
        using FParameters = FWindowAttentionProjectionOutputViewC512Fp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_attention_projection_output_view_c512_fp16), Geometry->Grids[100], dim3(32, 4, 1), 72, false};
        KernelCall.Name = "window_attention_projection_output_view_c512_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Output), 123, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(123));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 57, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(57));
        KernelCall.Bind(offsetof(FParameters, g_Residual), 121, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Residual), GetBufferAddress(121));
        KernelCall.Bind(offsetof(FParameters, g_Input), 122, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(122));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[219]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[220]);
        Calls.push_back(KernelCall);
    }
    { // cc_tinlayout_fused_swin_8h_256_8_upsample
        using FParameters = FWindowBlockC256UpsampleFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c256_upsample_fp16(), Geometry->Grids[101], dim3(32, 8, 1), 88, false};
        KernelCall.Name = "window_block_c256_upsample_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 123, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(123));
        KernelCall.Bind(offsetof(FParameters, g_Output), 124, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(124));
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
    { // cc_tinlayout_fused_swin_8h_256_8_outview
        using FParameters = FWindowBlockC256OutputViewFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c256_output_view_fp16(), Geometry->Grids[102], dim3(32, 8, 1), 88, false};
        KernelCall.Name = "window_block_c256_output_view_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 124, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(124));
        KernelCall.Bind(offsetof(FParameters, g_Output), 125, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(125));
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
    { // cc_tinlayout_fused_swin_4h_128_4_upsample
        using FParameters = FWindowBlockC128UpsampleFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c128_upsample_fp16(), Geometry->Grids[103], dim3(32, 4, 1), 88, false};
        KernelCall.Name = "window_block_c128_upsample_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 125, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(125));
        KernelCall.Bind(offsetof(FParameters, g_Output), 126, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(126));
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
    { // cc_tinlayout_fused_swin_4h_128_4_outview
        using FParameters = FWindowBlockC128OutputViewFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c128_output_view_fp16(), Geometry->Grids[104], dim3(32, 4, 1), 88, false};
        KernelCall.Name = "window_block_c128_output_view_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 126, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(126));
        KernelCall.Bind(offsetof(FParameters, g_Output), 127, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(127));
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
    { // cc_tinlayout_fused_swin_2h_64_2_upsample
        using FParameters = FWindowBlockC64UpsampleFp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c64_upsample_fp16), Geometry->Grids[105], dim3(32, 2, 1), 88, false};
        KernelCall.Name = "window_block_c64_upsample_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 127, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(127));
        KernelCall.Bind(offsetof(FParameters, g_Output), 128, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(128));
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
    { // cc_tinlayout_fused_swin_2h_64_2_outview
        using FParameters = FWindowBlockC64OutputViewFp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c64_output_view_fp16(), Geometry->Grids[106], dim3(32, 2, 1), 88, false};
        KernelCall.Name = "window_block_c64_output_view_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 128, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(128));
        KernelCall.Bind(offsetof(FParameters, g_Output), 129, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(129));
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
    { // cc_tinlayout_fused_swin_1h_32_1_upsample
        using FParameters = FWindowBlockC32UpsampleFp16Parameters;
        FKernelCall KernelCall{reinterpret_cast<const void*>(&window_block_c32_upsample_fp16), Geometry->Grids[107], dim3(32, 1, 1), 96, false};
        KernelCall.Name = "window_block_c32_upsample_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 129, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(129));
        KernelCall.Bind(offsetof(FParameters, g_Output), 130, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(130));
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
    { // cc_tinlayout_fused_swin_1h_32_1
        using FParameters = FWindowBlockC32Fp16Parameters;
        FKernelCall KernelCall{Resolve_window_block_c32_fp16(), Geometry->Grids[108], dim3(32, 1, 1), 96, false};
        KernelCall.Name = "window_block_c32_fp16";
        KernelCall.Bind(offsetof(FParameters, g_Input), 130, false, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Input), GetBufferAddress(130));
        KernelCall.Bind(offsetof(FParameters, g_Output), 131, false, true);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_Output), GetBufferAddress(131));
        KernelCall.Bind(offsetof(FParameters, g_PackedWeights), 65, true, false);
        KernelCall.Set<uint64_t>(offsetof(FParameters, g_PackedWeights), GetRecordAddress(65));
        KernelCall.Set<int32_t>(offsetof(FParameters, Height), Geometry->GeometryArguments[257]);
        KernelCall.Set<int32_t>(offsetof(FParameters, Width), Geometry->GeometryArguments[258]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginX), Geometry->GeometryArguments[259]);
        KernelCall.Set<int32_t>(offsetof(FParameters, OriginY), Geometry->GeometryArguments[260]);
        Calls.push_back(KernelCall);
    }
}
