// Generated exact physical-layout formulas; dimensions are runtime values.
// Measured resolutions select tuning policy only; they are not an execution whitelist.
static FGeometryPlanSpec SelectSmallGeometryPlan_fp16(int64_t Width, int64_t Height)
{
    const auto Shape = CreateNetworkGeometry(Width, Height);
    constexpr int ElementBytes = 2;
    FGeometryPlanSpec Geometry{Width, Height, {}, {}, {}};
    Geometry.BufferBytes = {
        Shape.SpatialBytes(0, 32, ElementBytes), // input
        Shape.SpatialBytes(0, 32, ElementBytes), // b1.output
        Shape.SpatialBytes(0, 32, ElementBytes), // b4.output
        Shape.DownsampleBytes(0, 32, ElementBytes), // b4.down
        Shape.SpatialBytes(1, 64, ElementBytes), // b5.output
        Shape.SpatialBytes(1, 64, ElementBytes), // b8.output
        Shape.DownsampleBytes(1, 64, ElementBytes), // b8.down
        Shape.SpatialBytes(2, 128, ElementBytes), // b9.output
        Shape.SpatialBytes(2, 128, ElementBytes), // b14.output
        Shape.DownsampleBytes(2, 128, ElementBytes), // b14.down
        Shape.SpatialBytes(3, 256, ElementBytes), // b15.output
        Shape.SpatialBytes(3, 256, ElementBytes), // b22.output
        Shape.DownsampleBytes(3, 256, ElementBytes), // b22.down
        Shape.SpatialBytes(4, 512, ElementBytes), // b23.branches
        Shape.SpatialBytes(4, 512, ElementBytes), // b23.ffn
        Shape.SpatialBytes(4, 512, ElementBytes), // b23.attended
        Shape.SpatialBytes(4, 512, ElementBytes), // b23.output
        Shape.SpatialBytes(4, 512, ElementBytes), // b30.branches
        Shape.SpatialBytes(4, 512, ElementBytes), // b30.ffn
        Shape.SpatialBytes(4, 512, ElementBytes), // b30.attended
        Shape.SpatialBytes(4, 512, ElementBytes), // b30.output
        Shape.SpatialBytes(5, 512, ElementBytes), // b30.pool
        Shape.SpatialBytes(5, 1024, ElementBytes), // b30.down
        Shape.TokenBytes(1024, ElementBytes), // repack-30-31
        Shape.TokenBytes(4096, ElementBytes), // b31.expanded
        Shape.TokenBytes(1024, ElementBytes), // b31.contracted
        Shape.TokenBytes(1024, ElementBytes), // b31.Q
        Shape.TokenBytes(1024, ElementBytes), // b31.K
        Shape.TokenBytes(1024, ElementBytes), // b31.V
        Shape.TokenBytes(1024, ElementBytes), // b31.attended
        Shape.TokenBytes(1024, ElementBytes), // b31.output
        Shape.CounterBytes(8), // b31.contract_counter
        Shape.CounterBytes(16), // b31.qkv_counter
        Shape.CounterBytes(32), // b31.attention_counter
        Shape.CounterBytes(8), // b31.projection_counter
        Shape.TokenBytes(4096, ElementBytes), // b32.expanded
        Shape.TokenBytes(1024, ElementBytes), // b32.contracted
        Shape.TokenBytes(1024, ElementBytes), // b32.Q
        Shape.TokenBytes(1024, ElementBytes), // b32.K
        Shape.TokenBytes(1024, ElementBytes), // b32.V
        Shape.TokenBytes(1024, ElementBytes), // b32.attended
        Shape.TokenBytes(1024, ElementBytes), // b32.output
        Shape.CounterBytes(8), // b32.contract_counter
        Shape.CounterBytes(16), // b32.qkv_counter
        Shape.CounterBytes(32), // b32.attention_counter
        Shape.CounterBytes(8), // b32.projection_counter
        Shape.TokenBytes(4096, ElementBytes), // b33.expanded
        Shape.TokenBytes(1024, ElementBytes), // b33.contracted
        Shape.TokenBytes(1024, ElementBytes), // b33.Q
        Shape.TokenBytes(1024, ElementBytes), // b33.K
        Shape.TokenBytes(1024, ElementBytes), // b33.V
        Shape.TokenBytes(1024, ElementBytes), // b33.attended
        Shape.TokenBytes(1024, ElementBytes), // b33.output
        Shape.CounterBytes(8), // b33.contract_counter
        Shape.CounterBytes(16), // b33.qkv_counter
        Shape.CounterBytes(32), // b33.attention_counter
        Shape.CounterBytes(8), // b33.projection_counter
        Shape.TokenBytes(4096, ElementBytes), // b34.expanded
        Shape.TokenBytes(1024, ElementBytes), // b34.contracted
        Shape.TokenBytes(1024, ElementBytes), // b34.Q
        Shape.TokenBytes(1024, ElementBytes), // b34.K
        Shape.TokenBytes(1024, ElementBytes), // b34.V
        Shape.TokenBytes(1024, ElementBytes), // b34.attended
        Shape.TokenBytes(1024, ElementBytes), // b34.output
        Shape.CounterBytes(8), // b34.contract_counter
        Shape.CounterBytes(16), // b34.qkv_counter
        Shape.CounterBytes(32), // b34.attention_counter
        Shape.CounterBytes(8), // b34.projection_counter
        Shape.TokenBytes(4096, ElementBytes), // b35.expanded
        Shape.TokenBytes(1024, ElementBytes), // b35.contracted
        Shape.TokenBytes(1024, ElementBytes), // b35.Q
        Shape.TokenBytes(1024, ElementBytes), // b35.K
        Shape.TokenBytes(1024, ElementBytes), // b35.V
        Shape.TokenBytes(1024, ElementBytes), // b35.attended
        Shape.TokenBytes(1024, ElementBytes), // b35.output
        Shape.CounterBytes(8), // b35.contract_counter
        Shape.CounterBytes(16), // b35.qkv_counter
        Shape.CounterBytes(32), // b35.attention_counter
        Shape.CounterBytes(8), // b35.projection_counter
        Shape.TokenBytes(4096, ElementBytes), // b36.expanded
        Shape.TokenBytes(1024, ElementBytes), // b36.contracted
        Shape.TokenBytes(1024, ElementBytes), // b36.Q
        Shape.TokenBytes(1024, ElementBytes), // b36.K
        Shape.TokenBytes(1024, ElementBytes), // b36.V
        Shape.TokenBytes(1024, ElementBytes), // b36.attended
        Shape.TokenBytes(1024, ElementBytes), // b36.output
        Shape.CounterBytes(8), // b36.contract_counter
        Shape.CounterBytes(16), // b36.qkv_counter
        Shape.CounterBytes(32), // b36.attention_counter
        Shape.CounterBytes(8), // b36.projection_counter
        Shape.TokenBytes(4096, ElementBytes), // b37.expanded
        Shape.TokenBytes(1024, ElementBytes), // b37.contracted
        Shape.TokenBytes(1024, ElementBytes), // b37.Q
        Shape.TokenBytes(1024, ElementBytes), // b37.K
        Shape.TokenBytes(1024, ElementBytes), // b37.V
        Shape.TokenBytes(1024, ElementBytes), // b37.attended
        Shape.TokenBytes(1024, ElementBytes), // b37.output
        Shape.CounterBytes(8), // b37.contract_counter
        Shape.CounterBytes(16), // b37.qkv_counter
        Shape.CounterBytes(32), // b37.attention_counter
        Shape.CounterBytes(8), // b37.projection_counter
        Shape.TokenBytes(4096, ElementBytes), // b38.expanded
        Shape.TokenBytes(1024, ElementBytes), // b38.contracted
        Shape.TokenBytes(1024, ElementBytes), // b38.Q
        Shape.TokenBytes(1024, ElementBytes), // b38.K
        Shape.TokenBytes(1024, ElementBytes), // b38.V
        Shape.TokenBytes(1024, ElementBytes), // b38.attended
        Shape.TokenBytes(1024, ElementBytes), // b38.output
        Shape.CounterBytes(8), // b38.contract_counter
        Shape.CounterBytes(16), // b38.qkv_counter
        Shape.CounterBytes(32), // b38.attention_counter
        Shape.CounterBytes(8), // b38.projection_counter
        Shape.SpatialBytes(5, 1024, ElementBytes), // repack-38-39
        Shape.SpatialBytes(4, 512, ElementBytes), // b39.output
        Shape.DecoderCounterBytes(), // b39.up_counter
        Shape.SpatialBytes(5, 512, 2), // b39.scratch
        Shape.SpatialBytes(4, 512, ElementBytes), // b40.branches
        Shape.SpatialBytes(4, 512, ElementBytes), // b40.ffn
        Shape.SpatialBytes(4, 512, ElementBytes), // b40.attended
        Shape.SpatialBytes(4, 512, ElementBytes), // b40.output
        Shape.SpatialBytes(4, 512, ElementBytes), // b47.branches
        Shape.SpatialBytes(4, 512, ElementBytes), // b47.ffn
        Shape.SpatialBytes(4, 512, ElementBytes), // b47.attended
        Shape.SpatialBytes(4, 512, ElementBytes), // b47.output
        Shape.SpatialBytes(3, 256, ElementBytes), // b48.output
        Shape.SpatialBytes(3, 256, ElementBytes), // b55.output
        Shape.SpatialBytes(2, 128, ElementBytes), // b56.output
        Shape.SpatialBytes(2, 128, ElementBytes), // b61.output
        Shape.SpatialBytes(1, 64, ElementBytes), // b62.output
        Shape.SpatialBytes(1, 64, ElementBytes), // b65.output
        Shape.SpatialBytes(0, 32, ElementBytes), // b66.output
        Shape.SpatialBytes(0, 32, ElementBytes), // b69.output
    };
    Geometry.Grids = {
        GeometryGrid(GeometryDivideUp(Shape.Width(0) + 0, 8), GeometryDivideUp(Shape.Height(0) + 0, 8), 1), // window_block_c32_input_view_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(0) + 4, 8), GeometryDivideUp(Shape.Height(0) + 4, 8), 1), // window_block_c32_downsample_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(1) + 0, 8), GeometryDivideUp(Shape.Height(1) + 0, 8), 1), // window_block_c64_input_view_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(1) + 4, 8), GeometryDivideUp(Shape.Height(1) + 4, 8), 1), // window_block_c64_downsample_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(2) + 0, 8), GeometryDivideUp(Shape.Height(2) + 0, 8), 1), // window_block_c128_input_view_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(2) + 4, 8), GeometryDivideUp(Shape.Height(2) + 4, 8), 1), // window_block_c128_downsample_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(3) + 0, 8), GeometryDivideUp(Shape.Height(3) + 0, 8), 1), // window_block_c256_input_view_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(3) + 4, 8), GeometryDivideUp(Shape.Height(3) + 4, 8), 1), // window_block_c256_downsample_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 2), // window_ffn_input_view_c512_fp16
        GeometryGrid(2 * GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 1), // window_ffn_projection_input_view_c512_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(4) + 0, 8), GeometryDivideUp(Shape.Height(4) + 0, 8), 4), // window_qkv_c512_fp16
        GeometryGrid(2 * GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 1), // window_attention_projection_c512_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 2), // window_ffn_c512_fp16
        GeometryGrid(2 * GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 1), // window_ffn_projection_c512_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(4) + 4, 8), GeometryDivideUp(Shape.Height(4) + 4, 8), 4), // window_qkv_c512_fp16
        GeometryGrid(2 * GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 1), // window_attention_projection_pool_c512_fp16
        GeometryGrid(4 * GeometryDivideUp(Shape.Width(5), 8), GeometryDivideUp(Shape.Height(5), 8), 1), // channel_projection_c512_to_c1024_fp16
        GeometryGrid(Shape.PaddedTokens() * ElementBytes, 1, 1), // repack_2d_to_1d_c1024_fp16
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[31] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[32] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[33] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[34] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(32 * GeometryDivideUp(Shape.Tokens(), 128), 1, 1), // global_ffn_expand_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_ffn_contract_c1024_fp16
        GeometryGrid(16 * GeometryDivideUp(Shape.Tokens(), 128), 1, 2), // global_qkv_c1024_fp16
        GeometryGrid(32, GeometryDivideUp(Shape.Tokens(), 256), 1), // small_global_attention_chained_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_projection_c1024_fp16
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[42] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[43] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[44] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[45] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(32 * GeometryDivideUp(Shape.Tokens(), 128), 1, 1), // global_ffn_expand_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_ffn_contract_c1024_fp16
        GeometryGrid(16 * GeometryDivideUp(Shape.Tokens(), 128), 1, 2), // global_qkv_c1024_fp16
        GeometryGrid(32, GeometryDivideUp(Shape.Tokens(), 256), 1), // small_global_attention_chained_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_projection_c1024_fp16
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[53] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[54] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[55] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[56] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(32 * GeometryDivideUp(Shape.Tokens(), 128), 1, 1), // global_ffn_expand_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_ffn_contract_c1024_fp16
        GeometryGrid(16 * GeometryDivideUp(Shape.Tokens(), 128), 1, 2), // global_qkv_c1024_fp16
        GeometryGrid(32, GeometryDivideUp(Shape.Tokens(), 256), 1), // small_global_attention_chained_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_projection_c1024_fp16
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[64] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[65] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[66] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[67] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(32 * GeometryDivideUp(Shape.Tokens(), 128), 1, 1), // global_ffn_expand_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_ffn_contract_c1024_fp16
        GeometryGrid(16 * GeometryDivideUp(Shape.Tokens(), 128), 1, 2), // global_qkv_c1024_fp16
        GeometryGrid(32, GeometryDivideUp(Shape.Tokens(), 256), 1), // small_global_attention_chained_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_projection_c1024_fp16
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[75] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[76] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[77] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[78] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(32 * GeometryDivideUp(Shape.Tokens(), 128), 1, 1), // global_ffn_expand_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_ffn_contract_c1024_fp16
        GeometryGrid(16 * GeometryDivideUp(Shape.Tokens(), 128), 1, 2), // global_qkv_c1024_fp16
        GeometryGrid(32, GeometryDivideUp(Shape.Tokens(), 256), 1), // small_global_attention_chained_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_projection_c1024_fp16
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[86] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[87] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[88] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[89] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(32 * GeometryDivideUp(Shape.Tokens(), 128), 1, 1), // global_ffn_expand_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_ffn_contract_c1024_fp16
        GeometryGrid(16 * GeometryDivideUp(Shape.Tokens(), 128), 1, 2), // global_qkv_c1024_fp16
        GeometryGrid(32, GeometryDivideUp(Shape.Tokens(), 256), 1), // small_global_attention_chained_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_projection_c1024_fp16
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[97] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[98] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[99] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[100] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(32 * GeometryDivideUp(Shape.Tokens(), 128), 1, 1), // global_ffn_expand_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_ffn_contract_c1024_fp16
        GeometryGrid(16 * GeometryDivideUp(Shape.Tokens(), 128), 1, 2), // global_qkv_c1024_fp16
        GeometryGrid(32, GeometryDivideUp(Shape.Tokens(), 256), 1), // small_global_attention_chained_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_projection_c1024_fp16
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[108] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[109] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[110] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[111] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(32 * GeometryDivideUp(Shape.Tokens(), 128), 1, 1), // global_ffn_expand_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_ffn_contract_c1024_fp16
        GeometryGrid(16 * GeometryDivideUp(Shape.Tokens(), 128), 1, 2), // global_qkv_c1024_fp16
        GeometryGrid(32, GeometryDivideUp(Shape.Tokens(), 256), 1), // small_global_attention_chained_c1024_fp16
        GeometryGrid(8 * GeometryDivideUp(Shape.Tokens(), 128), 1, 4), // global_projection_c1024_fp16
        GeometryGrid(Shape.PaddedTokens() * ElementBytes, 1, 1), // repack_1d_to_2d_c1024_fp16
        GeometryGrid(GeometryDivideUp((Geometry.BufferBytes[114] / 4), 256), 1, 1), // completion_counter_clear
        GeometryGrid(2 * GeometryDivideUp(Shape.Width(5), 4), GeometryDivideUp(Shape.Height(5), 4), 4), // decoder_upsample_c1024_to_c512_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 2), // window_ffn_c512_fp16
        GeometryGrid(2 * GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 1), // window_ffn_projection_c512_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(4) + 4, 8), GeometryDivideUp(Shape.Height(4) + 0, 8), 4), // window_qkv_c512_fp16
        GeometryGrid(2 * GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 1), // window_attention_projection_c512_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 2), // window_ffn_c512_fp16
        GeometryGrid(2 * GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 1), // window_ffn_projection_c512_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(4) + 0, 8), GeometryDivideUp(Shape.Height(4) + 4, 8), 4), // window_qkv_c512_fp16
        GeometryGrid(2 * GeometryDivideUp(Shape.Width(4), 8), GeometryDivideUp(Shape.Height(4), 8), 1), // window_attention_projection_output_view_c512_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(3) + 4, 8), GeometryDivideUp(Shape.Height(3) + 0, 8), 1), // window_block_c256_upsample_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(3) + 0, 8), GeometryDivideUp(Shape.Height(3) + 4, 8), 1), // window_block_c256_output_view_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(2) + 4, 8), GeometryDivideUp(Shape.Height(2) + 0, 8), 1), // window_block_c128_upsample_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(2) + 0, 8), GeometryDivideUp(Shape.Height(2) + 4, 8), 1), // window_block_c128_output_view_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(1) + 4, 8), GeometryDivideUp(Shape.Height(1) + 0, 8), 1), // window_block_c64_upsample_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(1) + 0, 8), GeometryDivideUp(Shape.Height(1) + 4, 8), 1), // window_block_c64_output_view_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(0) + 4, 8), GeometryDivideUp(Shape.Height(0) + 0, 8), 1), // window_block_c32_upsample_fp16
        GeometryGrid(GeometryDivideUp(Shape.Width(0) + 0, 8), GeometryDivideUp(Shape.Height(0) + 4, 8), 1), // window_block_c32_fp16
    };
    Geometry.GeometryArguments = {
        GeometryScalar(Shape.Height(0)), GeometryScalar(Shape.Width(0)), GeometryScalar(0), GeometryScalar(0), GeometryScalar(Shape.Height(0)), GeometryScalar(Shape.Width(0)), // window_block_c32_input_view_fp16
        GeometryScalar(Shape.Height(0)), GeometryScalar(Shape.Width(0)), GeometryScalar(-4), GeometryScalar(-4), GeometryScalar(Shape.Height(1)), GeometryScalar(Shape.Width(1)), // window_block_c32_downsample_fp16
        GeometryScalar(Shape.Height(1)), GeometryScalar(Shape.Width(1)), GeometryScalar(0), GeometryScalar(0), GeometryScalar(Shape.Height(1)), GeometryScalar(Shape.Width(1)), // window_block_c64_input_view_fp16
        GeometryScalar(Shape.Height(1)), GeometryScalar(Shape.Width(1)), GeometryScalar(-4), GeometryScalar(-4), GeometryScalar(Shape.Height(2)), GeometryScalar(Shape.Width(2)), // window_block_c64_downsample_fp16
        GeometryScalar(Shape.Height(2)), GeometryScalar(Shape.Width(2)), GeometryScalar(0), GeometryScalar(0), GeometryScalar(Shape.Height(2)), GeometryScalar(Shape.Width(2)), // window_block_c128_input_view_fp16
        GeometryScalar(Shape.Height(2)), GeometryScalar(Shape.Width(2)), GeometryScalar(-4), GeometryScalar(-4), GeometryScalar(Shape.Height(3)), GeometryScalar(Shape.Width(3)), // window_block_c128_downsample_fp16
        GeometryScalar(Shape.Height(3)), GeometryScalar(Shape.Width(3)), GeometryScalar(0), GeometryScalar(0), GeometryScalar(Shape.Height(3)), GeometryScalar(Shape.Width(3)), // window_block_c256_input_view_fp16
        GeometryScalar(Shape.Height(3)), GeometryScalar(Shape.Width(3)), GeometryScalar(-4), GeometryScalar(-4), GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Width(4)), // window_block_c256_downsample_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(0), GeometryScalar(0), GeometryScalar(Shape.Width(4)), // window_ffn_input_view_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Width(4)), // window_ffn_projection_input_view_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(0), GeometryScalar(0), GeometryScalar(Shape.Width(4)), // window_qkv_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Width(4)), // window_attention_projection_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(0), GeometryScalar(0), GeometryScalar(Shape.Width(4)), // window_ffn_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Width(4)), // window_ffn_projection_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(-4), GeometryScalar(-4), GeometryScalar(Shape.Width(4)), // window_qkv_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Height(5)), GeometryScalar(Shape.Width(5)), GeometryScalar(Shape.Width(4)), // window_attention_projection_pool_c512_fp16
        GeometryScalar(Shape.Height(5)), GeometryScalar(Shape.Width(5)), // channel_projection_c512_to_c1024_fp16
        GeometryScalar(Shape.Height(5)), GeometryScalar(Shape.Width(5)), // repack_2d_to_1d_c1024_fp16
        GeometryScalar((Geometry.BufferBytes[31] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[32] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[33] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[34] / 4)), // completion_counter_clear
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_expand_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_contract_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_qkv_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // small_global_attention_chained_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_projection_c1024_fp16
        GeometryScalar((Geometry.BufferBytes[42] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[43] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[44] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[45] / 4)), // completion_counter_clear
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_expand_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_contract_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_qkv_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // small_global_attention_chained_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_projection_c1024_fp16
        GeometryScalar((Geometry.BufferBytes[53] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[54] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[55] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[56] / 4)), // completion_counter_clear
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_expand_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_contract_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_qkv_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // small_global_attention_chained_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_projection_c1024_fp16
        GeometryScalar((Geometry.BufferBytes[64] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[65] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[66] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[67] / 4)), // completion_counter_clear
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_expand_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_contract_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_qkv_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // small_global_attention_chained_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_projection_c1024_fp16
        GeometryScalar((Geometry.BufferBytes[75] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[76] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[77] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[78] / 4)), // completion_counter_clear
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_expand_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_contract_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_qkv_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // small_global_attention_chained_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_projection_c1024_fp16
        GeometryScalar((Geometry.BufferBytes[86] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[87] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[88] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[89] / 4)), // completion_counter_clear
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_expand_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_contract_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_qkv_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // small_global_attention_chained_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_projection_c1024_fp16
        GeometryScalar((Geometry.BufferBytes[97] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[98] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[99] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[100] / 4)), // completion_counter_clear
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_expand_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_contract_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_qkv_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // small_global_attention_chained_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_projection_c1024_fp16
        GeometryScalar((Geometry.BufferBytes[108] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[109] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[110] / 4)), // completion_counter_clear
        GeometryScalar((Geometry.BufferBytes[111] / 4)), // completion_counter_clear
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_expand_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_ffn_contract_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_qkv_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // small_global_attention_chained_c1024_fp16
        GeometryScalar(1), GeometryScalar(Shape.Tokens()), // global_projection_c1024_fp16
        GeometryScalar(Shape.Height(5)), GeometryScalar(Shape.Width(5)), // repack_1d_to_2d_c1024_fp16
        GeometryScalar((Geometry.BufferBytes[114] / 4)), // completion_counter_clear
        GeometryScalar(Shape.Height(5)), GeometryScalar(Shape.Width(5)), GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Width(4)), // decoder_upsample_c1024_to_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(0), GeometryScalar(0), GeometryScalar(Shape.Width(4)), // window_ffn_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Width(4)), // window_ffn_projection_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(-4), GeometryScalar(0), GeometryScalar(Shape.Width(4)), // window_qkv_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Width(4)), // window_attention_projection_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(0), GeometryScalar(0), GeometryScalar(Shape.Width(4)), // window_ffn_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Width(4)), // window_ffn_projection_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(0), GeometryScalar(-4), GeometryScalar(Shape.Width(4)), // window_qkv_c512_fp16
        GeometryScalar(Shape.Height(4)), GeometryScalar(Shape.Width(4)), // window_attention_projection_output_view_c512_fp16
        GeometryScalar(Shape.Height(3)), GeometryScalar(Shape.Width(3)), GeometryScalar(-4), GeometryScalar(0), // window_block_c256_upsample_fp16
        GeometryScalar(Shape.Height(3)), GeometryScalar(Shape.Width(3)), GeometryScalar(0), GeometryScalar(-4), GeometryScalar(Shape.Height(3)), GeometryScalar(Shape.Width(3)), // window_block_c256_output_view_fp16
        GeometryScalar(Shape.Height(2)), GeometryScalar(Shape.Width(2)), GeometryScalar(-4), GeometryScalar(0), // window_block_c128_upsample_fp16
        GeometryScalar(Shape.Height(2)), GeometryScalar(Shape.Width(2)), GeometryScalar(0), GeometryScalar(-4), GeometryScalar(Shape.Height(2)), GeometryScalar(Shape.Width(2)), // window_block_c128_output_view_fp16
        GeometryScalar(Shape.Height(1)), GeometryScalar(Shape.Width(1)), GeometryScalar(-4), GeometryScalar(0), // window_block_c64_upsample_fp16
        GeometryScalar(Shape.Height(1)), GeometryScalar(Shape.Width(1)), GeometryScalar(0), GeometryScalar(-4), GeometryScalar(Shape.Height(1)), GeometryScalar(Shape.Width(1)), // window_block_c64_output_view_fp16
        GeometryScalar(Shape.Height(0)), GeometryScalar(Shape.Width(0)), GeometryScalar(-4), GeometryScalar(0), GeometryScalar(Shape.Height(0)), GeometryScalar(Shape.Width(0)), // window_block_c32_upsample_fp16
        GeometryScalar(Shape.Height(0)), GeometryScalar(Shape.Width(0)), GeometryScalar(0), GeometryScalar(-4), // window_block_c32_fp16
    };
    return Geometry;
}
