#pragma once
// Generated offline. Configuration transfer is not measured coverage or admission.
#include <array>
#include <cstdint>
#include <limits>

namespace dlssnr::resolution_policy
{
inline constexpr char Version[] = "212c80bfd9243b45f4798b01a27754afb51933745f827946694a2feb38086612";
inline constexpr char ResolverVersion[] = "domain_then_same_family_measured_extrema_v1";
inline constexpr int WidthMin = 1280, WidthMax = 3840, HeightMin = 720, HeightMax = 2160;
enum class EPrecision : int
{
	Fp8 = 0,
	Fp16 = 1
};
enum class EStatus : int
{
	Unmeasured = 0,
	ExactMeasured = 1,
	Transferred = 2,
	InvalidInput = 3
};

struct FAnchor
{
	int Sm, PrecisionValue, Width, Height, ConfigId;
	int64_t MedianNs;
	int Samples;
	const char *ConfigurationSha256, *Interval, *BinarySha256, *SourceSha256, *ReceiptSha256;
};

struct FAdmission
{
	int Sm, PrecisionValue, Width, Height;
	bool bRuntimeQualified;
	const char* ReceiptSha256;
};

inline constexpr std::array<FAnchor, 0> Anchors{{

}};
inline constexpr std::array<FAdmission, 0> Admissions{{

}};

struct FSelection
{
	int ConfigId = -1;
	EStatus StatusValue = EStatus::Unmeasured;
	int ActualWidth = 0, ActualHeight = 0, QueryWidth = 0, QueryHeight = 0;
	bool bClamped = false, bActualResolutionMeasured = false, bActualShapeSupported = false,
		 bRuntimeQualified = false;
	const FAnchor* AnchorEvidence = nullptr;
	const FAdmission* Admission = nullptr;
};

inline FSelection Select(int Width, int Height, int Sm, EPrecision PrecisionValue)
{
	FSelection Selection;
	Selection.ActualWidth = Width;
	Selection.ActualHeight = Height;
	const int PrecisionIndex = static_cast<int>(PrecisionValue);
	if (Width <= 0 || Height <= 0 || Sm <= 0 || PrecisionIndex < 0 || PrecisionIndex > 1)
	{
		Selection.StatusValue = EStatus::InvalidInput;
		return Selection;
	}
	Selection.QueryWidth = Width < WidthMin ? WidthMin : Width > WidthMax ? WidthMax : Width;
	Selection.QueryHeight = Height < HeightMin ? HeightMin : Height > HeightMax ? HeightMax : Height;
	// Measured extrema are family-local and affect metadata only.
	int MeasuredWidthMin = WidthMax, MeasuredWidthMax = WidthMin, MeasuredHeightMin = HeightMax,
		MeasuredHeightMax = HeightMin;
	bool bMeasuredFamily = false;
	for (const auto& EvidenceRow : Anchors)
	{
		if (EvidenceRow.Sm != Sm || EvidenceRow.PrecisionValue != PrecisionIndex)
			continue;
		bMeasuredFamily = true;
		if (EvidenceRow.Width < MeasuredWidthMin)
			MeasuredWidthMin = EvidenceRow.Width;
		if (EvidenceRow.Width > MeasuredWidthMax)
			MeasuredWidthMax = EvidenceRow.Width;
		if (EvidenceRow.Height < MeasuredHeightMin)
			MeasuredHeightMin = EvidenceRow.Height;
		if (EvidenceRow.Height > MeasuredHeightMax)
			MeasuredHeightMax = EvidenceRow.Height;
	}
	if (bMeasuredFamily)
	{
		Selection.QueryWidth = Selection.QueryWidth < MeasuredWidthMin	 ? MeasuredWidthMin
							   : Selection.QueryWidth > MeasuredWidthMax ? MeasuredWidthMax
																		 : Selection.QueryWidth;
		Selection.QueryHeight = Selection.QueryHeight < MeasuredHeightMin	? MeasuredHeightMin
								: Selection.QueryHeight > MeasuredHeightMax ? MeasuredHeightMax
																			: Selection.QueryHeight;
	}
	Selection.bClamped = Selection.QueryWidth != Width || Selection.QueryHeight != Height;
	// Exact actual dimensions only. Clamped coordinates never grant admission.
	for (const auto& EvidenceRow : Admissions)
		if (EvidenceRow.Sm == Sm && EvidenceRow.PrecisionValue == PrecisionIndex &&
			EvidenceRow.Width == Width && EvidenceRow.Height == Height)
		{
			Selection.Admission = &EvidenceRow;
			Selection.bActualShapeSupported = true;
			Selection.bRuntimeQualified = EvidenceRow.bRuntimeQualified;
			break;
		}
	int64_t NearestDistanceSquared = std::numeric_limits<int64_t>::max();
	for (const auto& EvidenceRow : Anchors)
	{
		if (EvidenceRow.Sm != Sm || EvidenceRow.PrecisionValue != PrecisionIndex)
			continue;
		const int64_t WidthDelta = int64_t(Selection.QueryWidth) - EvidenceRow.Width,
					  HeightDelta = int64_t(Selection.QueryHeight) - EvidenceRow.Height;
		const int64_t DistanceSquared =
			WidthDelta * WidthDelta * 1440LL * 1440LL + HeightDelta * HeightDelta * 2560LL * 2560LL;
		// Generated rows are sorted by width, height, configuration within family.
		if (DistanceSquared < NearestDistanceSquared)
		{
			NearestDistanceSquared = DistanceSquared;
			Selection.AnchorEvidence = &EvidenceRow;
		}
	}
	if (Selection.AnchorEvidence)
	{
		Selection.ConfigId = Selection.AnchorEvidence->ConfigId;
		Selection.bActualResolutionMeasured =
			Selection.AnchorEvidence->Width == Width && Selection.AnchorEvidence->Height == Height;
		Selection.StatusValue =
			Selection.bActualResolutionMeasured ? EStatus::ExactMeasured : EStatus::Transferred;
	}
	return Selection;
}
} // namespace dlssnr::resolution_policy
