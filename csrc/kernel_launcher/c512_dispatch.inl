// Included once by the common launcher .cpp. No CUDA body is compiled here.
// Accepted reconstructed CUDA TUs own all 18 registered host stubs below.
#include <ATen/ATen.h>
#include <c10/cuda/CUDAGuard.h>
#include <c10/cuda/CUDAStream.h>
#include <c10/cuda/CUDAException.h>
#include <c10/cuda/CUDACachingAllocator.h>
#include <cuda_runtime_api.h>
#include <array>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <limits>
#include <iterator>
#include <mutex>
#include <type_traits>
#include <vector>

namespace dlssnr::reconstructed::window_ffn_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

void window_ffn_c512_fp8(Parameters);
} // namespace dlssnr::reconstructed::window_ffn_c512_fp8

namespace dlssnr::reconstructed::window_ffn_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

void window_ffn_c512_fp16(Parameters);
} // namespace dlssnr::reconstructed::window_ffn_c512_fp16

namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

void window_ffn_input_view_c512_fp8(Parameters);
} // namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp8

namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

void window_ffn_input_view_c512_fp16(Parameters);
} // namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp16

namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

void window_ffn_projection_c512_fp8(Parameters);
} // namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8

namespace dlssnr::reconstructed::window_ffn_projection_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

void window_ffn_projection_c512_fp16(Parameters);
} // namespace dlssnr::reconstructed::window_ffn_projection_c512_fp16

namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

void window_ffn_projection_input_view_c512_fp8(Parameters);
} // namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8

namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

void window_ffn_projection_input_view_c512_fp16(Parameters);
} // namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16

namespace dlssnr::reconstructed::window_qkv_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

void window_qkv_c512_fp8(Parameters);
} // namespace dlssnr::reconstructed::window_qkv_c512_fp8

namespace dlssnr::reconstructed::window_qkv_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

void window_qkv_c512_fp16(Parameters);
} // namespace dlssnr::reconstructed::window_qkv_c512_fp16

namespace dlssnr::reconstructed::window_attention_projection_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

void window_attention_projection_c512_fp8(Parameters);
} // namespace dlssnr::reconstructed::window_attention_projection_c512_fp8

namespace dlssnr::reconstructed::window_attention_projection_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

void window_attention_projection_c512_fp16(Parameters);
} // namespace dlssnr::reconstructed::window_attention_projection_c512_fp16

namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint64_t g_Pointer24;
	uint32_t Scalar32;
	uint32_t Scalar36;
	uint8_t Reserved40[32];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, g_Pointer24) == 24);
static_assert(offsetof(Parameters, Scalar32) == 32);
static_assert(offsetof(Parameters, Scalar36) == 36);

void window_attention_projection_output_view_c512_fp8(Parameters);
} // namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8

namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint64_t g_Pointer24;
	uint32_t Scalar32;
	uint32_t Scalar36;
	uint8_t Reserved40[32];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, g_Pointer24) == 24);
static_assert(offsetof(Parameters, Scalar32) == 32);
static_assert(offsetof(Parameters, Scalar36) == 36);

void window_attention_projection_output_view_c512_fp16(Parameters);
} // namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint64_t g_Pointer24;
	uint64_t g_Pointer32;
	uint8_t Reserved40[24];
	uint32_t Scalar64;
	uint32_t Scalar68;
	uint32_t Scalar72;
	uint32_t Scalar76;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, g_Pointer24) == 24);
static_assert(offsetof(Parameters, g_Pointer32) == 32);
static_assert(offsetof(Parameters, Scalar64) == 64);
static_assert(offsetof(Parameters, Scalar68) == 68);
static_assert(offsetof(Parameters, Scalar72) == 72);
static_assert(offsetof(Parameters, Scalar76) == 76);

void window_attention_projection_pool_c512_fp8(Parameters);
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint64_t g_Pointer24;
	uint64_t g_Pointer32;
	uint8_t Reserved40[24];
	uint32_t Scalar64;
	uint32_t Scalar68;
	uint32_t Scalar72;
	uint32_t Scalar76;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, g_Pointer24) == 24);
static_assert(offsetof(Parameters, g_Pointer32) == 32);
static_assert(offsetof(Parameters, Scalar64) == 64);
static_assert(offsetof(Parameters, Scalar68) == 68);
static_assert(offsetof(Parameters, Scalar72) == 72);
static_assert(offsetof(Parameters, Scalar76) == 76);

void window_attention_projection_pool_c512_fp16(Parameters);
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16

namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint8_t Reserved24[8];
	uint32_t Scalar32;
	uint32_t Scalar36;
};

static_assert(sizeof(Parameters) == 40 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, Scalar32) == 32);
static_assert(offsetof(Parameters, Scalar36) == 36);

void channel_projection_c512_to_c1024_fp8(Parameters);
} // namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8

namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint8_t Reserved24[8];
	uint32_t Scalar32;
	uint32_t Scalar36;
};

static_assert(sizeof(Parameters) == 40 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, Scalar32) == 32);
static_assert(offsetof(Parameters, Scalar36) == 36);

void channel_projection_c512_to_c1024_fp16(Parameters);
} // namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16

namespace dlssnr::reconstructed_c512
{
namespace detail
{
constexpr int EntryCount = 18;

struct FKernelEntry
{
	int Role, ElementBytes, AbiBytes, Warps;
	int64_t RecordBytes;
	const void* Function;
};

const std::array<FKernelEntry, EntryCount>& GetEntryTable()
{
	static const std::array<FKernelEntry, EntryCount> Table{{
		{0, 1, 56, 8, 524288,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8)}, // 0: ffn/fp8
		{0, 2, 56, 4, 1048576,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_ffn_c512_fp16::window_ffn_c512_fp16)}, // 1: ffn/half
		{1, 1, 56, 4, 524288,
		 reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_input_view_c512_fp8::
										   window_ffn_input_view_c512_fp8)}, // 2: ffn_input_view/fp8
		{1, 2, 56, 4, 1048576,
		 reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_input_view_c512_fp16::
										   window_ffn_input_view_c512_fp16)}, // 3: ffn_input_view/half
		{2, 1, 72, 4, 263168,
		 reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_projection_c512_fp8::
										   window_ffn_projection_c512_fp8)}, // 4: ffn_projection/fp8
		{2, 2, 72, 4, 525312,
		 reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_projection_c512_fp16::
										   window_ffn_projection_c512_fp16)}, // 5: ffn_projection/half
		{3, 1, 72, 4, 263168,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8::
				 window_ffn_projection_input_view_c512_fp8)}, // 6: ffn_projection_input_view/fp8
		{3, 2, 72, 4, 525312,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16::
				 window_ffn_projection_input_view_c512_fp16)}, // 7: ffn_projection_input_view/half
		{4, 1, 56, 4, 917568,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8)}, // 8: qkv_attention/fp8
		{4, 2, 56, 4, 1704000,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_qkv_c512_fp16::window_qkv_c512_fp16)}, // 9: qkv_attention/half
		{5, 1, 72, 8, 263168,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_c512_fp8::
				 window_attention_projection_c512_fp8)}, // 10: attention_projection/fp8
		{5, 2, 72, 8, 525312,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_c512_fp16::
				 window_attention_projection_c512_fp16)}, // 11: attention_projection/half
		{6, 1, 72, 4, 263168,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8::
				 window_attention_projection_output_view_c512_fp8)}, // 12: attention_projection_output_view/fp8
		{6, 2, 72, 4, 525312,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16::
				 window_attention_projection_output_view_c512_fp16)}, // 13: attention_projection_output_view/half
		{7, 1, 80, 4, 263168,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_pool_c512_fp8::
				 window_attention_projection_pool_c512_fp8)}, // 14: attention_projection_pool/fp8
		{7, 2, 80, 4, 525312,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_pool_c512_fp16::
				 window_attention_projection_pool_c512_fp16)}, // 15: attention_projection_pool/half
		{8, 1, 40, 8, 524304,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8::
				 channel_projection_c512_to_c1024_fp8)}, // 16: adapter_512_to_1024/fp8
		{8, 2, 40, 8, 1048592,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16::
				 channel_projection_c512_to_c1024_fp16)}, // 17: adapter_512_to_1024/half
	}};
	return Table;
}

struct FPreparedEntries
{
	std::mutex Mutex;
	std::array<bool, 64> Devices{};
};

FPreparedEntries& GetPreparationState()
{
	static FPreparedEntries PreparationState;
	return PreparationState;
}

void ValidatePhysicalTensor(const at::Tensor& g_Tensor, int64_t Bytes, const at::Device& TensorDevice,
							const char* Role)
{
	TORCH_CHECK(g_Tensor.defined() && g_Tensor.is_cuda() && g_Tensor.device() == TensorDevice &&
					g_Tensor.scalar_type() == at::kByte,
				Role, " requires a physical uint8 tensor on the selected CUDA device");
	TORCH_CHECK(g_Tensor.dim() == 1 && g_Tensor.is_contiguous() && g_Tensor.numel() == Bytes, Role,
				" requires exact contiguous physical extent ", Bytes);
	TORCH_CHECK(!g_Tensor.requires_grad(), "reconstructed C512 execution is inference only");
	TORCH_CHECK(reinterpret_cast<uintptr_t>(g_Tensor.data_ptr()) % 16 == 0, Role,
				" requires 16-byte alignment");
}

void ValidateDisjoint(const at::Tensor& g_FirstTensor, const at::Tensor& g_SecondTensor)
{
	const uintptr_t g_FirstAddress = reinterpret_cast<uintptr_t>(g_FirstTensor.data_ptr()),
					g_SecondAddress = reinterpret_cast<uintptr_t>(g_SecondTensor.data_ptr());
	const uintptr_t FirstByteCount = uintptr_t(g_FirstTensor.numel()),
					SecondByteCount = uintptr_t(g_SecondTensor.numel());
	TORCH_CHECK(g_FirstAddress <= std::numeric_limits<uintptr_t>::max() - FirstByteCount &&
					g_SecondAddress <= std::numeric_limits<uintptr_t>::max() - SecondByteCount,
				"C512 physical range overflow");
	TORCH_CHECK(g_FirstAddress + FirstByteCount <= g_SecondAddress ||
					g_SecondAddress + SecondByteCount <= g_FirstAddress,
				"C512 supplied physical buffers must be pairwise disjoint");
}

void ValidateAllDisjoint(const std::vector<const at::Tensor*>& g_Buffers)
{
	for (size_t Index = 0; Index < g_Buffers.size(); ++Index)
		for (size_t OtherIndex = Index + 1; OtherIndex < g_Buffers.size(); ++OtherIndex)
			ValidateDisjoint(*g_Buffers[Index], *g_Buffers[OtherIndex]);
}

int GetDeviceIndex(const at::Tensor& g_Tensor)
{
	const int DeviceIndex = g_Tensor.get_device();
	TORCH_CHECK(DeviceIndex >= 0 && DeviceIndex < 64, "C512 device outside preparation table");
	cudaDeviceProp DeviceProperties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&DeviceProperties, DeviceIndex));
	TORCH_CHECK(DeviceProperties.major == 12 && DeviceProperties.minor == 0,
				"reconstructed C512 requires SM120");
	return DeviceIndex;
}

template <class TParameters>
void LaunchWithParameters(const void* Function, dim3 Grid, dim3 Block, cudaStream_t Stream,
						  const std::array<uint64_t, 5>& g_Pointers, const std::array<int32_t, 4>& Scalars,
						  int Abi)
{
	static_assert(std::is_standard_layout<TParameters>::value &&
				  std::is_trivially_copyable<TParameters>::value);
	TORCH_CHECK(sizeof(TParameters) == size_t(Abi) && alignof(TParameters) == 8,
				"exact compiled Parameters ABI");
	TParameters ParameterBlock{};
	auto* ParameterStorage = reinterpret_cast<unsigned char*>(&ParameterBlock);
	const int PointerCount = Abi == 80 ? 5 : Abi == 72 ? 4 : 3;
	for (int Index = 0; Index < PointerCount; ++Index)
		std::memcpy(ParameterStorage + 8 * Index, &g_Pointers[Index], 8);
	const int ScalarOffset = Abi == 56 ? 24 : Abi == 80 ? 64 : 32;
	const int ScalarCount = (Abi == 56 || Abi == 80) ? 4 : 2;
	for (int Index = 0; Index < ScalarCount; ++Index)
		std::memcpy(ParameterStorage + ScalarOffset + 4 * Index, &Scalars[Index], 4);
	void* Argv[] = {&ParameterBlock};
	C10_CUDA_CHECK(cudaLaunchKernel(Function, Grid, Block, Argv, 0, Stream));
}
} // namespace detail

// Returns 18 rows of [entry,device,SM,registers,shared,local,maxThreads].
// Explicit loading/admission is outside capture even when already prepared.
std::vector<int64_t> PrepareEntries(const at::Tensor& g_Anchor)
{
	TORCH_CHECK(g_Anchor.is_cuda(), "C512 preparation requires CUDA");
	c10::cuda::CUDAGuard DeviceGuard(g_Anchor.device());
	const int DeviceIndex = detail::GetDeviceIndex(g_Anchor);
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	cudaStreamCaptureStatus Capture = cudaStreamCaptureStatusNone;
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream.stream(), &Capture));
	TORCH_CHECK(Capture == cudaStreamCaptureStatusNone,
				"C512 preparation forbidden during capture, including cache hits");
	std::vector<int64_t> Result;
	Result.reserve(18 * 7);
	for (int EntryIndex = 0; EntryIndex < 18; ++EntryIndex)
	{
		const auto& EntrySpec = detail::GetEntryTable()[EntryIndex];
		cudaFuncAttributes FunctionAttributes{};
		C10_CUDA_CHECK(cudaFuncGetAttributes(&FunctionAttributes, EntrySpec.Function));
		TORCH_CHECK(FunctionAttributes.binaryVersion == 120,
					"C512 stub must resolve to the accepted SM120 device body");
		TORCH_CHECK(FunctionAttributes.maxThreadsPerBlock >= 32 * EntrySpec.Warps,
					"compiled C512 block admission");
		const int64_t Row[] = {EntryIndex,
							   DeviceIndex,
							   120,
							   FunctionAttributes.numRegs,
							   int64_t(FunctionAttributes.sharedSizeBytes),
							   int64_t(FunctionAttributes.localSizeBytes),
							   FunctionAttributes.maxThreadsPerBlock};
		Result.insert(Result.end(), std::begin(Row), std::end(Row));
	}
	auto& Preparation = detail::GetPreparationState();
	std::lock_guard<std::mutex> Lock(Preparation.Mutex);
	Preparation.Devices[DeviceIndex] = true;
	return Result;
}

// Inputs use public order state,record[,skip]; outputs high[,pool].
// All memory is caller-owned. No preparation, allocation, conversion, native
// module lookup, legacy computation, or fallback is performed by this route.
std::vector<at::Tensor> LaunchEntry(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
									std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
									int64_t Phase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry 0..17");
	const auto& EntrySpec = detail::GetEntryTable()[EntryIndex];
	const bool bHead = EntrySpec.Role == 8, bPool = EntrySpec.Role == 7,
			   bResidual = EntrySpec.Role == 2 || EntrySpec.Role == 3 || EntrySpec.Role == 5 ||
						   EntrySpec.Role == 6 || bPool;
	TORCH_CHECK(g_Inputs.size() == size_t(bResidual ? 3 : 2) && g_Outputs.size() == size_t(bPool ? 2 : 1),
				"C512 exact input/output roles");
	const auto& g_State = g_Inputs[0];
	TORCH_CHECK(g_State.is_cuda(), "C512 requires CUDA state");
	const bool bFull = Height == (bHead ? 36 : 68) && Width == (bHead ? 60 : 120);
	const bool bBoundedFp16 = EntrySpec.ElementBytes == 2 && Height == 16 && Width == 24;
	TORCH_CHECK(bFull || bBoundedFp16, "C512 fixed 4K field or separate bounded Half field required");
	TORCH_CHECK(Phase >= 0 && Phase <= 3 && (EntrySpec.Role == 4 || Phase == 0),
				"phase belongs only to fused QKV/attention");
	const int64_t ImageBytes = Height * Width * 512 * EntrySpec.ElementBytes,
				  PoolHeight = ((Height + 7) / 8) * 4, PoolWidth = ((Width + 7) / 8) * 4;
	detail::ValidatePhysicalTensor(g_State, ImageBytes, g_State.device(), "state");
	detail::ValidatePhysicalTensor(g_Inputs[1], EntrySpec.RecordBytes, g_State.device(), "record");
	if (bResidual)
		detail::ValidatePhysicalTensor(g_Inputs[2], ImageBytes, g_State.device(), "skip");
	detail::ValidatePhysicalTensor(g_Outputs[0], bHead ? 2 * ImageBytes : ImageBytes, g_State.device(),
								   "high");
	if (bPool)
		detail::ValidatePhysicalTensor(g_Outputs[1], PoolHeight * PoolWidth * 512 * EntrySpec.ElementBytes,
									   g_State.device(), "pool");
	std::vector<const at::Tensor*> g_Buffers;
	for (const auto& g_Tensor : g_Inputs)
		g_Buffers.push_back(&g_Tensor);
	for (const auto& g_Tensor : g_Outputs)
		g_Buffers.push_back(&g_Tensor);
	detail::ValidateAllDisjoint(g_Buffers);
	c10::cuda::CUDAGuard DeviceGuard(g_State.device());
	const int DeviceIndex = g_State.get_device();
	TORCH_CHECK(DeviceIndex >= 0 && DeviceIndex < 64, "C512 device outside preparation table");
	{
		auto& Preparation = detail::GetPreparationState();
		std::lock_guard<std::mutex> Lock(Preparation.Mutex);
		TORCH_CHECK(Preparation.Devices[DeviceIndex],
					"prepare all reconstructed C512 entries outside capture first");
	}
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (const auto* g_Tensor : g_Buffers)
		c10::cuda::CUDACachingAllocator::recordStream(g_Tensor->storage().data_ptr(), Stream);
	const auto GetTensorAddress = [](const at::Tensor& g_Tensor)
	{ return uint64_t(reinterpret_cast<uintptr_t>(g_Tensor.data_ptr())); };
	std::array<uint64_t, 5> g_Pointers{};
	if (bPool)
		g_Pointers = {GetTensorAddress(g_State), GetTensorAddress(g_Inputs[2]),
					  GetTensorAddress(g_Outputs[0]), GetTensorAddress(g_Outputs[1]),
					  GetTensorAddress(g_Inputs[1])};
	else if (bResidual)
		g_Pointers = {GetTensorAddress(g_State), GetTensorAddress(g_Inputs[2]),
					  GetTensorAddress(g_Outputs[0]), GetTensorAddress(g_Inputs[1]), 0};
	else
		g_Pointers = {GetTensorAddress(g_State), GetTensorAddress(g_Outputs[0]),
					  GetTensorAddress(g_Inputs[1]), 0, 0};
	const int ShiftX = (Phase == 1 || Phase == 2) ? 4 : 0, ShiftY = (Phase == 1 || Phase == 3) ? 4 : 0;
	std::array<int32_t, 4> Scalars{{int32_t(Height), int32_t(Width), 0, 0}};
	if (EntrySpec.Role == 4)
	{
		Scalars[2] = -ShiftX;
		Scalars[3] = -ShiftY;
	}
	if (bPool)
	{
		Scalars[2] = int32_t(PoolHeight);
		Scalars[3] = int32_t(PoolWidth);
	}
	const unsigned TilesX = unsigned((Width + 7) / 8), TilesY = unsigned((Height + 7) / 8);
	dim3 Grid(EntrySpec.Role == 4 ? unsigned((Width + ShiftX + 7) / 8)
								  : (bHead				   ? 4 * TilesX
									 : EntrySpec.Role <= 1 ? TilesX
														   : 2 * TilesX),
			  EntrySpec.Role == 4 ? unsigned((Height + ShiftY + 7) / 8) : TilesY,
			  EntrySpec.Role == 4	? 4
			  : EntrySpec.Role <= 1 ? 2
									: 1);
	const dim3 Block(32, EntrySpec.Warps, 1);
	switch (EntryIndex)
	{
	case 0:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_c512_fp8::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 1:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_c512_fp16::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 2:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_input_view_c512_fp8::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 3:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_input_view_c512_fp16::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 4:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_projection_c512_fp8::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 5:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_projection_c512_fp16::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 6:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 7:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 8:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_qkv_c512_fp8::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 9:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_qkv_c512_fp16::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 10:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_attention_projection_c512_fp8::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 11:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_attention_projection_c512_fp16::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 12:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 13:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 14:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_attention_projection_pool_c512_fp8::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 15:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_attention_projection_pool_c512_fp16::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 16:
		detail::LaunchWithParameters<dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	case 17:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16::Parameters>(
			EntrySpec.Function, Grid, Block, Stream.stream(), g_Pointers, Scalars, EntrySpec.AbiBytes);
		break;
	default:
		TORCH_CHECK(false, "unreachable C512 entry");
	}
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	return g_Outputs;
}

// All 16 real C512 blocks, including the input/pooled/output boundaries.
// Records are layer0..3 (plus4 at block30). Workspaces are branches,FFN,
// attended,high (plus pool,down at block30); all are retained and returned.
std::vector<at::Tensor> BlockOutEntry(int64_t Block, bool bFp16, const at::Tensor& g_State,
									  std::vector<at::Tensor> g_Records, std::vector<at::Tensor> g_Workspaces)
{
	TORCH_CHECK((Block >= 23 && Block <= 30) || (Block >= 40 && Block <= 47),
				"C512 actual blocks23..30/40..47 only");
	const bool bInputView = Block == 23, bDownsample = Block == 30, bOutputView = Block == 47;
	const int PrecisionOffset = bFp16 ? 1 : 0;
	TORCH_CHECK(g_Records.size() == size_t(bDownsample ? 5 : 4) &&
					g_Workspaces.size() == size_t(bDownsample ? 6 : 4),
				"C512 block complete retained roles");
	TORCH_CHECK(g_State.is_cuda(), "C512 block state CUDA");
	const int64_t ImageBytes = 68 * 120 * 512 * (bFp16 ? 2 : 1);
	detail::ValidatePhysicalTensor(g_State, ImageBytes, g_State.device(), "block state");
	const std::array<int64_t, 5> RecordByteExtents{{bFp16 ? 1048576 : 524288, bFp16 ? 525312 : 263168,
													bFp16 ? 1704000 : 917568, bFp16 ? 525312 : 263168,
													bFp16 ? 1048592 : 524304}};
	std::vector<const at::Tensor*> g_Buffers{&g_State};
	for (size_t Index = 0; Index < g_Records.size(); ++Index)
	{
		detail::ValidatePhysicalTensor(g_Records[Index], RecordByteExtents[Index], g_State.device(),
									   "block record");
		g_Buffers.push_back(&g_Records[Index]);
	}
	for (size_t Index = 0; Index < g_Workspaces.size(); ++Index)
	{
		const int64_t Bytes = Index < 4 ? ImageBytes : 36 * 60 * 512 * (bFp16 ? 2 : 1) * (Index == 5 ? 2 : 1);
		detail::ValidatePhysicalTensor(g_Workspaces[Index], Bytes, g_State.device(), "block workspace");
		g_Buffers.push_back(&g_Workspaces[Index]);
	}
	detail::ValidateAllDisjoint(g_Buffers);
	LaunchEntry((bInputView ? 2 : 0) + PrecisionOffset, {g_State, g_Records[0]}, {g_Workspaces[0]}, 68, 120,
				0);
	LaunchEntry((bInputView ? 6 : 4) + PrecisionOffset, {g_Workspaces[0], g_Records[1], g_State},
				{g_Workspaces[1]}, 68, 120, 0);
	const int Phase = int(Block < 31 ? (Block - 23) % 4 : (Block - 40) % 4);
	LaunchEntry(8 + PrecisionOffset, {g_Workspaces[1], g_Records[2]}, {g_Workspaces[2]}, 68, 120, Phase);
	if (bDownsample)
	{
		LaunchEntry(14 + PrecisionOffset, {g_Workspaces[2], g_Records[3], g_Workspaces[1]},
					{g_Workspaces[3], g_Workspaces[4]}, 68, 120, 0);
		LaunchEntry(16 + PrecisionOffset, {g_Workspaces[4], g_Records[4]}, {g_Workspaces[5]}, 36, 60, 0);
	}
	else
		LaunchEntry((bOutputView ? 12 : 10) + PrecisionOffset,
					{g_Workspaces[2], g_Records[3], g_Workspaces[1]}, {g_Workspaces[3]}, 68, 120, 0);
	return g_Workspaces;
}

std::vector<int64_t> PrepareC512_fp8(const at::Tensor& g_Anchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(detail::GetEntryTable()[EntryIndex].ElementBytes == 1,
				"C512 precision does not match _fp8 binding");
	return PrepareEntries(g_Anchor);
}

std::vector<at::Tensor> LaunchC512_fp8(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
									   std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
									   int64_t Phase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(detail::GetEntryTable()[EntryIndex].ElementBytes == 1,
				"C512 precision does not match _fp8 binding");
	return LaunchEntry(EntryIndex, std::move(g_Inputs), std::move(g_Outputs), Height, Width, Phase);
}

std::vector<at::Tensor> C512BlockOut_fp8(int64_t Block, const at::Tensor& g_State,
										 std::vector<at::Tensor> g_Records,
										 std::vector<at::Tensor> g_Workspaces)
{
	return BlockOutEntry(Block, false, g_State, std::move(g_Records), std::move(g_Workspaces));
}

std::vector<int64_t> PrepareC512_fp16(const at::Tensor& g_Anchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(detail::GetEntryTable()[EntryIndex].ElementBytes == 2,
				"C512 precision does not match _fp16 binding");
	return PrepareEntries(g_Anchor);
}

std::vector<at::Tensor> LaunchC512_fp16(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
										std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
										int64_t Phase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(detail::GetEntryTable()[EntryIndex].ElementBytes == 2,
				"C512 precision does not match _fp16 binding");
	return LaunchEntry(EntryIndex, std::move(g_Inputs), std::move(g_Outputs), Height, Width, Phase);
}

std::vector<at::Tensor> C512BlockOut_fp16(int64_t Block, const at::Tensor& g_State,
										  std::vector<at::Tensor> g_Records,
										  std::vector<at::Tensor> g_Workspaces)
{
	return BlockOutEntry(Block, true, g_State, std::move(g_Records), std::move(g_Workspaces));
}
} // namespace dlssnr::reconstructed_c512
