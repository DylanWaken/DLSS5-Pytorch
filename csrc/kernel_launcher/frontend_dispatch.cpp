#include "frontend_dispatch.h"
#include "architecture_support.h"
#include "kernel_impl/shared/common/kernel_abi.h"
#include <c10/cuda/CUDAGuard.h>
#include <c10/cuda/CUDAStream.h>
#include <c10/cuda/CUDAException.h>
#include <c10/cuda/CUDACachingAllocator.h>
#include <algorithm>
#include <cmath>
#include <cstring>
#include <limits>
#include <mutex>

struct FFrontendTensorContract
{
	at::ScalarType Type;
	std::vector<int64_t> Shape;
};

// Construction is split from allocation so partial CUDA resource creation always
// has a live RAII owner. Array destruction never throws during exception unwinding.
struct FFrontendImage
{
	cudaArray_t Array = nullptr;
	cudaTextureObject_t Texture = 0;
	cudaSurfaceObject_t Surface = 0;
	int64_t Height = 0, Width = 0;

	~FFrontendImage()
	{
		if (Texture)
			cudaDestroyTextureObject(Texture);
		if (Surface)
			cudaDestroySurfaceObject(Surface);
		if (Array)
			cudaFreeArray(Array);
	}

	void Allocate(int64_t InputHeight, int64_t InputWidth, bool bTexture, bool bLinear)
	{
		Height = InputHeight;
		Width = InputWidth;
		const cudaChannelFormatDesc Format{32, 32, 32, 32, cudaChannelFormatKindFloat};
		C10_CUDA_CHECK(cudaMallocArray(&Array, &Format, Width, Height, cudaArraySurfaceLoadStore));
		cudaResourceDesc Resource{};
		Resource.resType = cudaResourceTypeArray;
		Resource.res.array.array = Array;
		if (bTexture)
		{
			cudaTextureDesc Sampling{};
			Sampling.addressMode[0] = Sampling.addressMode[1] = Sampling.addressMode[2] =
				cudaAddressModeClamp;
			Sampling.filterMode = bLinear ? cudaFilterModeLinear : cudaFilterModePoint;
			Sampling.readMode = cudaReadModeElementType;
			Sampling.normalizedCoords = 1;
			C10_CUDA_CHECK(cudaCreateTextureObject(&Texture, &Resource, &Sampling, nullptr));
		}
		else
			C10_CUDA_CHECK(cudaCreateSurfaceObject(&Surface, &Resource));
	}

	void CopyFrom(const at::Tensor& Tensor, cudaStream_t Stream) const
	{
		C10_CUDA_CHECK(cudaMemcpy2DToArrayAsync(Array, 0, 0, Tensor.data_ptr(), Width * 16, Width * 16,
												Height, cudaMemcpyDeviceToDevice, Stream));
	}

	void CopyTo(const at::Tensor& Tensor, cudaStream_t Stream) const
	{
		C10_CUDA_CHECK(cudaMemcpy2DFromArrayAsync(Tensor.data_ptr(), Width * 16, Array, 0, 0, Width * 16,
												  Height, cudaMemcpyDeviceToDevice, Stream));
	}
};

struct FFrontendKernelDescriptor final : FPreparedKernelDescriptor
{
	const void* Function = nullptr;
	bool bPostprocess = false, bDownsample = false, bFp8 = false;
	FPreprocessParameters Preprocess{};
	FPostprocessParameters Postprocess{};
	dim3 Grid;
	std::vector<FFrontendTensorContract> InputContracts, OutputContracts;
	std::vector<size_t> TextureIndices;
	std::vector<std::unique_ptr<FFrontendImage>> Textures;
	std::unique_ptr<FFrontendImage> Surface;
	mutable std::mutex EnqueueMutex;

	FFrontendKernelDescriptor(std::string InputName, int InputDeviceIndex)
		: FPreparedKernelDescriptor(std::move(InputName), InputDeviceIndex)
	{
	}

	~FFrontendKernelDescriptor() override
	{
		// The owner must outlive graph replay. Synchronization here additionally
		// protects eager launches still pending when the final owner is released.
		if (Textures.empty() && !Surface)
			return;
		int PreviousDevice = DeviceIndex;
		cudaGetDevice(&PreviousDevice);
		if (cudaSetDevice(DeviceIndex) == cudaSuccess)
		{
			cudaDeviceSynchronize();
			Surface.reset();
			Textures.clear();
			cudaSetDevice(PreviousDevice);
		}
	}

	void Validate(const std::vector<at::Tensor>& Inputs, const std::vector<at::Tensor>& Outputs,
				  bool bMeta) const override
	{
		TORCH_CHECK(Inputs.size() == InputContracts.size() && Outputs.size() == OutputContracts.size(), Name,
					": input/output tensor roles differ from the prepared frontend");
		std::vector<std::pair<uintptr_t, uintptr_t>> Ranges;
		const auto CheckList = [&](const auto& Tensors, const auto& Contracts)
		{
			for (size_t Index = 0; Index < Tensors.size(); ++Index)
			{
				const auto& Tensor = Tensors[Index];
				const auto& Contract = Contracts[Index];
				TORCH_CHECK(Tensor.defined() && Tensor.scalar_type() == Contract.Type &&
								Tensor.dim() == int64_t(Contract.Shape.size()) && Tensor.is_contiguous(),
							Name,
							": tensor dtype/shape differs from prepared physical or HWC4 layout at role ",
							Index);
				// Prepared geometry is fixed, but Dynamo may initially present symbolic
				// sizes. Guard each equality instead of requesting concrete sizes().
				for (int64_t Dimension = 0; Dimension < Tensor.dim(); ++Dimension)
					TORCH_CHECK(Tensor.sym_size(Dimension)
									.sym_eq(c10::SymInt(Contract.Shape[Dimension]))
									.guard_bool(__FILE__, __LINE__),
								Name,
								": tensor dtype/shape differs from prepared physical or HWC4 layout at role ",
								Index);
				TORCH_CHECK(!Tensor.requires_grad(), Name, ": deployment frontend is inference only");
				if (bMeta)
					continue;
				TORCH_CHECK(Tensor.is_cuda() && Tensor.get_device() == DeviceIndex, Name,
							": every input/output must be on the prepared CUDA device");
				if (!Tensor.numel())
					continue;
				const auto g_Address = reinterpret_cast<uintptr_t>(Tensor.data_ptr());
				const auto Bytes = Tensor.nbytes();
				TORCH_CHECK(g_Address % 16 == 0 && g_Address <= std::numeric_limits<uintptr_t>::max() - Bytes,
							Name, ": tensor physical storage must be 16-byte aligned with a valid extent");
				Ranges.emplace_back(g_Address, g_Address + Bytes);
			}
		};
		CheckList(Inputs, InputContracts);
		CheckList(Outputs, OutputContracts);
		std::sort(Ranges.begin(), Ranges.end());
		for (size_t Index = 1; Index < Ranges.size(); ++Index)
			TORCH_CHECK(Ranges[Index - 1].second <= Ranges[Index].first, Name,
						": tensor arguments must be pairwise disjoint");
	}

	void Launch(const std::vector<at::Tensor>& Inputs, const std::vector<at::Tensor>& Outputs) const override
	{
		// Host enqueue is serialized; the caller still orders work across streams
		// because each invocation shares this context's CUDA texture/surface arrays.
		std::lock_guard<std::mutex> Lock(EnqueueMutex);
		c10::cuda::CUDAGuard DeviceGuard(c10::Device(c10::kCUDA, DeviceIndex));
		const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
		for (const auto* Tensors : {&Inputs, &Outputs})
			for (const auto& Tensor : *Tensors)
				if (Tensor.numel())
					c10::cuda::CUDACachingAllocator::recordStream(Tensor.storage().data_ptr(), Stream);
		for (size_t Index = 0; Index < Textures.size(); ++Index)
			if (Textures[Index])
				Textures[Index]->CopyFrom(Inputs[TextureIndices[Index]], Stream.stream());
		const auto Texture = [&](size_t Index) -> uint64_t
		{ return Textures[Index] ? Textures[Index]->Texture : 0; };
		if (bPostprocess)
		{
			auto Parameters = Postprocess;
			Parameters.g_Input = reinterpret_cast<uint64_t>(Inputs[0].data_ptr());
			Parameters.g_Adapter = reinterpret_cast<uint64_t>(Inputs[1].data_ptr());
			Parameters.g_PackedWeights = reinterpret_cast<uint64_t>(Inputs[2].data_ptr());
			Parameters.ColorTexture = Texture(0);
			Parameters.HistoryTexture = Texture(1);
			Parameters.MotionTexture = Texture(2);
			Parameters.g_BlendScale =
				Inputs[6].numel() ? reinterpret_cast<uint64_t>(Inputs[6].data_ptr()) : 0;
			Parameters.OutputSurface = Surface->Surface;
			// Preserve any untouched pixels: outputs are explicitly mutable inputs
			// to functionalization, including their initial surface contents.
			Surface->CopyFrom(Outputs[0], Stream.stream());
			void* Arguments[] = {&Parameters};
			C10_CUDA_CHECK(cudaLaunchKernel(Function, Grid, dim3(32), Arguments, 0, Stream.stream()));
			Surface->CopyTo(Outputs[0], Stream.stream());
		}
		else
		{
			auto Parameters = Preprocess;
			Parameters.CurrentTexture = Texture(0);
			Parameters.HistoryTexture = Texture(1);
			Parameters.MotionTexture = Texture(2);
			Parameters.DepthTexture = Texture(3);
			Parameters.ConditioningTexture = Texture(4);
			Parameters.g_PackedWeights = reinterpret_cast<uint64_t>(Inputs[0].data_ptr());
			Parameters.g_Output = reinterpret_cast<uint64_t>(Outputs[0].data_ptr());
			Parameters.g_PooledOutput = bDownsample ? reinterpret_cast<uint64_t>(Outputs[1].data_ptr()) : 0;
			void* Arguments[] = {&Parameters};
			C10_CUDA_CHECK(cudaLaunchKernel(Function, Grid, dim3(32), Arguments, 0, Stream.stream()));
		}
		C10_CUDA_KERNEL_LAUNCH_CHECK();
	}
};

static void CheckFrontendTransform(const FTextureTransform& Transform, bool bUsed, bool bReciprocal = false)
{
	for (float Value : {Transform.BiasX, Transform.BiasY, Transform.ScaleX, Transform.ScaleY,
						Transform.NormalizeX, Transform.NormalizeY})
		TORCH_CHECK(std::isfinite(Value), "frontend texture transform must contain finite values");
	if (bUsed)
		TORCH_CHECK(Transform.NormalizeX != 0 && Transform.NormalizeY != 0 &&
						(!bReciprocal || (Transform.ScaleX != 0 && Transform.ScaleY != 0)),
					"active frontend texture transform has a zero normalization or reciprocal scale");
}

static void CheckFrontendGeometry(int Height, int Width, int ValidHeight, int ValidWidth)
{
	TORCH_CHECK(Height >= 8 && Width >= 8 && Height <= 16384 && Width <= 16384 && Height % 8 == 0 &&
					Width % 8 == 0,
				"frontend dimensions must be 8..16384 multiples of 8");
	TORCH_CHECK(ValidHeight > 0 && ValidWidth > 0 && ValidHeight <= Height && ValidWidth <= Width,
				"frontend valid dimensions must lie within its physical dimensions");
}

c10::intrusive_ptr<FPreparedKernelHandle> PrepareFrontend(std::string Name, at::Tensor Configuration,
														  std::vector<at::Tensor> Inputs,
														  std::vector<at::Tensor> Outputs, bool bLinearFilter)
{
	TORCH_CHECK(!Inputs.empty() && Inputs[0].defined() && Inputs[0].is_cuda(),
				"prepare_frontend requires CUDA tensor inputs");
	const int DeviceIndex = Inputs[0].get_device();
	c10::cuda::CUDAGuard DeviceGuard(c10::Device(c10::kCUDA, DeviceIndex));
	cudaStreamCaptureStatus CaptureStatus{};
	C10_CUDA_CHECK(
		cudaStreamIsCapturing(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream(), &CaptureStatus));
	TORCH_CHECK(CaptureStatus == cudaStreamCaptureStatusNone,
				"prepare_frontend must run outside CUDA graph capture");
	cudaDeviceProp Properties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&Properties, DeviceIndex));
	auto Descriptor = std::make_shared<FFrontendKernelDescriptor>(Name, DeviceIndex);
	if (Name == "input_preprocess_window_c32_fp8")
		Descriptor->Function = reinterpret_cast<const void*>(&input_preprocess_window_c32_fp8);
	else if (Name == "input_preprocess_window_c32_fp16")
		Descriptor->Function = reinterpret_cast<const void*>(&input_preprocess_window_c32_fp16);
	else if (Name == "input_preprocess_window_downsample_c32_fp8")
		Descriptor->Function = reinterpret_cast<const void*>(&input_preprocess_window_downsample_c32_fp8);
	else if (Name == "input_preprocess_window_downsample_c32_fp16")
		Descriptor->Function = reinterpret_cast<const void*>(&input_preprocess_window_downsample_c32_fp16);
	else if (Name == "output_window_postprocess_c32_fp8")
		Descriptor->Function = reinterpret_cast<const void*>(&output_window_postprocess_c32_fp8);
	else if (Name == "output_window_postprocess_c32_fp16")
		Descriptor->Function = reinterpret_cast<const void*>(&output_window_postprocess_c32_fp16);
	else
		TORCH_CHECK(false, "unknown frontend kernel: ", Name);
	Descriptor->bPostprocess = Name.find("output_") == 0;
	Descriptor->bDownsample = Name.find("_downsample_") != std::string::npos;
	Descriptor->bFp8 = Name.size() >= 4 && Name.substr(Name.size() - 4) == "_fp8";
	ValidateKernelDevice(Descriptor->Function, Properties, !Descriptor->bFp8, dim3(32), Name.c_str());
	const bool bPostprocess = Descriptor->bPostprocess;
	const bool bDownsample = Descriptor->bDownsample;
	const int64_t ElementBytes = Descriptor->bFp8 ? 1 : 2;
	TORCH_CHECK(Configuration.defined() && Configuration.device().is_cpu() &&
					Configuration.scalar_type() == at::kByte && Configuration.dim() == 1 &&
					Configuration.is_contiguous() &&
					Configuration.numel() ==
						(bPostprocess ? sizeof(FPostprocessParameters) : sizeof(FPreprocessParameters)),
				"frontend configuration must be an exact CPU uint8 ABI template");
	TORCH_CHECK(Inputs.size() == (bPostprocess ? 7 : 6) && Outputs.size() == (bDownsample ? 2 : 1),
				"frontend input/output role counts are incorrect");
	for (const auto& Tensor : Inputs)
		TORCH_CHECK(Tensor.defined(), "frontend input tensors must be defined");
	const auto Bytes = [](int64_t Extent) { return FFrontendTensorContract{at::kByte, {Extent}}; };
	const auto TextureContract = [&](size_t Index, bool bRequired)
	{
		const auto& Tensor = Inputs[Index];
		TORCH_CHECK(Tensor.defined(), "frontend texture tensor must be defined");
		if (Tensor.numel() == 0)
		{
			TORCH_CHECK(!bRequired, "frontend current texture is required");
			return FFrontendTensorContract{at::kFloat, {0}};
		}
		TORCH_CHECK(Tensor.dim() == 3 && Tensor.size(2) == 4 && Tensor.size(0) > 0 &&
						Tensor.size(0) <= 16384 && Tensor.size(1) > 0 && Tensor.size(1) <= 16384,
					"frontend texture must be bounded float32 HWC4");
		return FFrontendTensorContract{at::kFloat, Tensor.sizes().vec()};
	};
	if (bPostprocess)
	{
		auto& Parameters = Descriptor->Postprocess;
		std::memcpy(&Parameters, Configuration.data_ptr(), sizeof(Parameters));
		TORCH_CHECK(!(Parameters.g_Input | Parameters.g_Adapter | Parameters.OutputSurface |
					  Parameters.g_PackedWeights | Parameters.ColorTexture | Parameters.HistoryTexture |
					  Parameters.MotionTexture | Parameters.g_BlendScale | Parameters.ReservedPadding),
					"postprocess configuration must contain zero pointers, handles and reserved fields");
		CheckFrontendGeometry(Parameters.Height, Parameters.Width, Parameters.ValidHeight,
							  Parameters.ValidWidth);
		TORCH_CHECK((Parameters.OriginX == 0 || Parameters.OriginX == -4) &&
						(Parameters.OriginY == 0 || Parameters.OriginY == -4),
					"postprocess origins must be 0 or -4");
		TORCH_CHECK(Parameters.bDisplayOutput <= 1 && Parameters.bApplyMotion <= 1 &&
						std::isfinite(Parameters.OutputScale) && std::isfinite(Parameters.MotionScaleX) &&
						std::isfinite(Parameters.MotionScaleY),
					"invalid postprocess scalar configuration");
		CheckFrontendTransform(Parameters.ColorTransform, Inputs[3].numel() != 0);
		CheckFrontendTransform(Parameters.HistoryTransform, Inputs[4].numel() != 0);
		CheckFrontendTransform(Parameters.MotionTransform, Inputs[5].numel() != 0);
		const int64_t Pixels = int64_t(Parameters.Height) * Parameters.Width;
		Descriptor->InputContracts = {Bytes(Pixels * 8 * ElementBytes),
									  Bytes(Pixels * 32 * ElementBytes),
									  Bytes(Descriptor->bFp8 ? 21808 : 34096),
									  TextureContract(3, false),
									  TextureContract(4, false),
									  TextureContract(5, false),
									  Bytes(Inputs[6].numel() ? 2 : 0)};
		Descriptor->OutputContracts = {{at::kFloat, {Parameters.Height, Parameters.Width, 4}}};
		Descriptor->TextureIndices = {3, 4, 5};
		Descriptor->Grid = dim3((Parameters.Width - Parameters.OriginX + 7) / 8,
								(Parameters.Height - Parameters.OriginY + 7) / 8);
	}
	else
	{
		auto& Parameters = Descriptor->Preprocess;
		std::memcpy(&Parameters, Configuration.data_ptr(), sizeof(Parameters));
		TORCH_CHECK(!(Parameters.CurrentTexture | Parameters.HistoryTexture | Parameters.MotionTexture |
					  Parameters.DepthTexture | Parameters.ConditioningTexture | Parameters.g_Output |
					  Parameters.g_PackedWeights | Parameters.ReservedOutputPointer |
					  Parameters.g_PooledOutput | Parameters.ReservedAlignment),
					"preprocess configuration must contain zero pointers, handles and reserved fields");
		CheckFrontendGeometry(Parameters.FullHeight, Parameters.FullWidth, Parameters.ValidHeight,
							  Parameters.ValidWidth);
		TORCH_CHECK(Parameters.FullHeight <= 2 * Parameters.ValidHeight - 1 &&
						Parameters.FullWidth <= 2 * Parameters.ValidWidth - 1,
					"preprocess supports one reflected padding extension");
		TORCH_CHECK(Parameters.PooledHeight == (bDownsample ? Parameters.FullHeight / 2 : 0) &&
						Parameters.PooledWidth == (bDownsample ? Parameters.FullWidth / 2 : 0),
					"preprocess pooled dimensions must match the selected entry");
		TORCH_CHECK(Parameters.bPreferGreaterDepth <= 1 && Parameters.bConditioningOverride <= 1,
					"preprocess flags must be zero or one");
		for (float Value : {Parameters.MotionScaleX, Parameters.MotionScaleY, Parameters.ConditioningGreen,
							Parameters.ConditioningBlue, Parameters.ConstantConditioning,
							Parameters.ConditioningOverrideGreen, Parameters.ConditioningOverrideBlue,
							Parameters.ColorScale})
			TORCH_CHECK(std::isfinite(Value), "preprocess scalar configuration must contain finite values");
		CheckFrontendTransform(Parameters.CurrentTransform, true);
		CheckFrontendTransform(Parameters.HistoryTransform, Inputs[2].numel() != 0);
		CheckFrontendTransform(Parameters.MotionTransform, Inputs[3].numel() != 0, true);
		CheckFrontendTransform(Parameters.DepthTransform, Inputs[4].numel() != 0, true);
		CheckFrontendTransform(Parameters.ConditioningTransform, Inputs[5].numel() != 0);
		// FP8's learned fields end at 21680 bytes; its native checkpoint record
		// retains 16 bytes of trailing alignment, which is part of the public byte ABI.
		Descriptor->InputContracts = {Bytes(Descriptor->bFp8 ? 21696 : 33984)};
		for (size_t Index = 1; Index < 6; ++Index)
			Descriptor->InputContracts.push_back(TextureContract(Index, Index == 1));
		const int64_t Pixels = int64_t(Parameters.FullHeight) * Parameters.FullWidth;
		Descriptor->OutputContracts = {Bytes(Pixels * 32 * ElementBytes)};
		if (bDownsample)
			Descriptor->OutputContracts.push_back(Bytes(Pixels * 8 * ElementBytes));
		Descriptor->TextureIndices = {1, 2, 3, 4, 5};
		Descriptor->Grid = dim3(Parameters.FullWidth / 8, Parameters.FullHeight / 8);
	}
	ValidateKernelGrid(Descriptor->Grid, Properties, Name.c_str());
	Descriptor->Validate(Inputs, Outputs, false);
	for (const auto Index : Descriptor->TextureIndices)
	{
		Descriptor->Textures.push_back(nullptr);
		if (!Inputs[Index].numel())
			continue;
		auto& Image = Descriptor->Textures.back();
		Image = std::make_unique<FFrontendImage>();
		Image->Allocate(Inputs[Index].size(0), Inputs[Index].size(1), true, bLinearFilter);
	}
	if (bPostprocess)
	{
		Descriptor->Surface = std::make_unique<FFrontendImage>();
		Descriptor->Surface->Allocate(Descriptor->Postprocess.Height, Descriptor->Postprocess.Width, false,
									  false);
	}
	return RegisterPreparedKernel(std::move(Descriptor), std::move(Inputs), std::move(Outputs));
}

at::Tensor FrontendConfiguration(std::string Name, int64_t Height, int64_t Width, int64_t ValidHeight,
								 int64_t ValidWidth, int64_t Phase, int64_t Seed)
{
	const bool bPostprocess =
		Name == "output_window_postprocess_c32_fp8" || Name == "output_window_postprocess_c32_fp16";
	const bool bDownsample = Name == "input_preprocess_window_downsample_c32_fp8" ||
							 Name == "input_preprocess_window_downsample_c32_fp16";
	const bool bPreprocess = bDownsample || Name == "input_preprocess_window_c32_fp8" ||
							 Name == "input_preprocess_window_c32_fp16";
	TORCH_CHECK(bPreprocess || bPostprocess, "unknown frontend kernel: ", Name);
	TORCH_CHECK(Height >= 8 && Height <= 16384 && Width >= 8 && Width <= 16384,
				"frontend configuration dimensions must be 8..16384");
	if (!ValidHeight)
		ValidHeight = Height;
	if (!ValidWidth)
		ValidWidth = Width;
	TORCH_CHECK(ValidHeight > 0 && ValidHeight <= Height && ValidWidth > 0 && ValidWidth <= Width,
				"frontend valid dimensions must lie within its physical dimensions");
	CheckFrontendGeometry(int(Height), int(Width), int(ValidHeight), int(ValidWidth));
	TORCH_CHECK(Phase >= 0 && Phase < 4 && (bPostprocess || Phase == 0),
				"frontend phase must be 0..3 for postprocess and zero for preprocess");
	TORCH_CHECK(Seed >= 0 && uint64_t(Seed) <= std::numeric_limits<uint32_t>::max(),
				"frontend noise seed must fit uint32");
	auto Configuration =
		at::zeros({int64_t(bPostprocess ? sizeof(FPostprocessParameters) : sizeof(FPreprocessParameters))},
				  at::TensorOptions().device(at::kCPU).dtype(at::kByte));
	if (bPostprocess)
	{
		FPostprocessParameters Parameters{};
		Parameters.Height = int(Height);
		Parameters.Width = int(Width);
		Parameters.ValidHeight = int(ValidHeight);
		Parameters.ValidWidth = int(ValidWidth);
		constexpr int OriginX[] = {0, -4, -4, 0}, OriginY[] = {0, -4, 0, -4};
		Parameters.OriginX = OriginX[Phase];
		Parameters.OriginY = OriginY[Phase];
		Parameters.OutputScale = 1.0f;
		Parameters.ColorTransform = Parameters.HistoryTransform = Parameters.MotionTransform =
			FTextureTransform{0, 0, 1, 1, 1, 1};
		std::memcpy(Configuration.data_ptr(), &Parameters, sizeof(Parameters));
	}
	else
	{
		TORCH_CHECK(Height <= 2 * ValidHeight - 1 && Width <= 2 * ValidWidth - 1,
					"preprocess supports one reflected padding extension");
		FPreprocessParameters Parameters{};
		Parameters.FullHeight = int(Height);
		Parameters.FullWidth = int(Width);
		Parameters.ValidHeight = int(ValidHeight);
		Parameters.ValidWidth = int(ValidWidth);
		Parameters.CurrentTransform = Parameters.HistoryTransform = Parameters.MotionTransform =
			Parameters.DepthTransform = Parameters.ConditioningTransform = FTextureTransform{
				0, 0, float(Width), float(Height), 1.0f / float(Width), 1.0f / float(Height)};
		Parameters.MotionScaleX = 1.0f / float(Width);
		Parameters.MotionScaleY = 1.0f / float(Height);
		Parameters.ConditioningGreen = 0.25f;
		Parameters.ConditioningBlue = 0.5f;
		Parameters.ConstantConditioning = 0.25f;
		Parameters.ConditioningOverrideGreen = Parameters.ConditioningOverrideBlue = -1.0f;
		Parameters.bConditioningOverride = 1;
		Parameters.ColorScale = 0.0625f;
		Parameters.NoiseSeed = uint32_t(Seed);
		Parameters.PooledHeight = bDownsample ? int(Height / 2) : 0;
		Parameters.PooledWidth = bDownsample ? int(Width / 2) : 0;
		std::memcpy(Configuration.data_ptr(), &Parameters, sizeof(Parameters));
	}
	return Configuration;
}

void RegisterFrontendKernels(torch::Library& Library)
{
	Library.def("prepare_frontend", &PrepareFrontend);
	Library.def(
		"frontend_configuration(str name, int height, int width, int valid_height=0, int valid_width=0, int phase=0, int seed=0) -> Tensor",
		&FrontendConfiguration);
}
