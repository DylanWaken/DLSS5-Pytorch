#pragma once
#include <cuda_runtime_api.h>
#include <array>
#include <cstdint>
#include <limits>
#include <stdexcept>
#include <vector>

// Geometry belongs to a prepared plan, rather than a table of measured image
// sizes. All execution paths retain these exact extents for their lifetime.
struct FGeometryPlanSpec
{
	int64_t ValidWidth, ValidHeight;
	std::vector<int64_t> BufferBytes;
	std::vector<dim3> Grids;
	std::vector<int32_t> GeometryArguments;
};

inline int64_t GeometryDivideUp(int64_t Value, int64_t Divisor)
{
	return Value / Divisor + (Value % Divisor != 0);
}

inline int64_t GeometryAlignUp(int64_t Value, int64_t Alignment)
{
	return GeometryDivideUp(Value, Alignment) * Alignment;
}

inline int32_t GeometryScalar(int64_t Value)
{
	if (Value < std::numeric_limits<int32_t>::min() || Value > std::numeric_limits<int32_t>::max())
		throw std::invalid_argument("network geometry exceeds the signed 32-bit operand index range");
	return int32_t(Value);
}

inline int64_t GeometryElementCount(int64_t Rows, int64_t Columns, int64_t Channels)
{
	// Several recovered layouts multiply logical indices as signed 32-bit
	// integers before widening a byte address. Reject overflow before allocation.
	constexpr int64_t Maximum = std::numeric_limits<int32_t>::max();
	if (Rows <= 0 || Columns <= 0 || Channels <= 0 || Rows > Maximum / Columns ||
		Rows * Columns > Maximum / Channels)
		throw std::invalid_argument("network tensor exceeds the signed 32-bit operand index range");
	return Rows * Columns * Channels;
}

inline dim3 GeometryGrid(int64_t X, int64_t Y, int64_t Z)
{
	// The runtime also checks the selected device's limits. These CUDA limits
	// prevent narrowing while building a plan without touching the GPU.
	if (X <= 0 || X > std::numeric_limits<int32_t>::max() || Y <= 0 || Y > 65535 || Z <= 0 || Z > 65535)
		throw std::invalid_argument("network geometry exceeds CUDA grid dimensions");
	return dim3(unsigned(X), unsigned(Y), unsigned(Z));
}

struct FNetworkGeometry
{
	int64_t FullWidth, FullHeight;
	std::array<std::array<int64_t, 2>, 6> Levels;

	int64_t Width(int Level) const
	{
		return Levels.at(Level)[0];
	}

	int64_t Height(int Level) const
	{
		return Levels.at(Level)[1];
	}

	int64_t Tokens() const
	{
		return GeometryElementCount(Height(5), Width(5), 1);
	}

	int64_t PaddedTokens() const
	{
		return GeometryAlignUp(Tokens(), 32);
	}

	int64_t SpatialBytes(int Level, int Channels, int ElementBytes) const
	{
		return GeometryElementCount(Height(Level), Width(Level), Channels) * ElementBytes;
	}

	int64_t TokenBytes(int Channels, int ElementBytes, int Components = 1) const
	{
		return GeometryElementCount(PaddedTokens(), Channels, Components) * ElementBytes;
	}

	int64_t DownsampleBytes(int Level, int Channels, int ElementBytes) const
	{
		const bool bPadded = Width(Level) != 2 * Width(Level + 1) || Height(Level) != 2 * Height(Level + 1);
		// The fused downsample uses the second physical span to clear padding.
		return SpatialBytes(Level + 1, Channels * 2, ElementBytes) * (bPadded ? 2 : 1);
	}

	int64_t CounterBytes(int CountersPerTile) const
	{
		return GeometryElementCount(GeometryDivideUp(Tokens(), 128), CountersPerTile, 1) * 4;
	}

	int64_t DecoderCounterBytes() const
	{
		return GeometryElementCount(GeometryDivideUp(Height(5), 4), GeometryDivideUp(Width(5), 4), 2) * 4;
	}
};

inline int64_t NetworkFieldAlignment(int64_t ValidSize)
{
	int Reductions = 0;
	for (int Level = 0; Level < 6; ++Level)
	{
		const int64_t Half = GeometryAlignUp(GeometryDivideUp(ValidSize, 2), 4);
		Reductions += Half < ValidSize;
		Reductions += Level == 0 && Half % 8 != 0;
		ValidSize = Half;
	}
	return int64_t(1) << Reductions;
}

inline FNetworkGeometry CreateNetworkGeometry(int64_t ValidWidth, int64_t ValidHeight)
{
	if (ValidWidth <= 0 || ValidHeight <= 0)
		throw std::invalid_argument("input image resolution must be positive");
	GeometryScalar(ValidWidth);
	GeometryScalar(ValidHeight);
	const int64_t WidthAlignment = NetworkFieldAlignment(ValidWidth);
	const int64_t HeightAlignment = NetworkFieldAlignment(ValidHeight);
	int64_t Width = GeometryAlignUp(ValidWidth, WidthAlignment);
	int64_t Height = GeometryAlignUp(ValidHeight, HeightAlignment);
	Width = Width < 320 ? 320 : Width;
	Height = Height < 320 ? 320 : Height;
	// This native field-layout adjustment is part of the network's padding,
	// including when the requested dimensions happen to be exact multiples.
	if (Width % (4 * WidthAlignment) == 0 && Height % (4 * HeightAlignment) == 0)
		Width += WidthAlignment;
	GeometryScalar(Width);
	GeometryScalar(Height);
	FNetworkGeometry Shape{Width, Height, {}};
	for (int Level = 0; Level < 6; ++Level)
	{
		Width = GeometryAlignUp(GeometryDivideUp(Width, 2), 4);
		Height = GeometryAlignUp(GeometryDivideUp(Height, 2), 4);
		Shape.Levels[Level] = {Width, Height};
	}
	if (Shape.Width(0) % 8 || Shape.Height(0) % 8)
		throw std::invalid_argument("padded input requires complete eight-pixel windows");
	return Shape;
}
