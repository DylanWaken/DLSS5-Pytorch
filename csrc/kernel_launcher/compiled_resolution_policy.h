#pragma once
// Generated offline. Configuration transfer is not measured coverage or admission.
#include <array>
#include <cstdint>
#include <limits>

inline constexpr char CONST_RESOLUTION_POLICY_VERSION[] =
	"212c80bfd9243b45f4798b01a27754afb51933745f827946694a2feb38086612";
inline constexpr char CONST_RESOLUTION_RESOLVER_VERSION[] = "domain_then_same_family_measured_extrema_v1";
inline constexpr int CONST_RESOLUTION_WIDTH_MIN = 1280, CONST_RESOLUTION_WIDTH_MAX = 3840,
					 CONST_RESOLUTION_HEIGHT_MIN = 720, CONST_RESOLUTION_HEIGHT_MAX = 2160;
enum class EResolutionPrecision : int
{
	Fp8 = 0,
	Fp16 = 1
};
enum class EResolutionStatus : int
{
	Unmeasured = 0,
	ExactMeasured = 1,
	Transferred = 2,
	InvalidInput = 3
};

struct FResolutionAnchor
{
	int Sm, PrecisionValue, Width, Height, ConfigId;
	int64_t MedianNs;
	int Samples;
	const char *ConfigurationSha256, *Interval, *BinarySha256, *SourceSha256, *ReceiptSha256;
};

struct FResolutionAdmission
{
	int Sm, PrecisionValue, Width, Height;
	bool bRuntimeQualified;
	const char* ReceiptSha256;
};

inline constexpr std::array<FResolutionAnchor, 0> ResolutionAnchors{{

}};
inline constexpr std::array<FResolutionAdmission, 0> ResolutionAdmissions{{

}};

struct FResolutionSelection
{
	int ConfigId = -1;
	EResolutionStatus StatusValue = EResolutionStatus::Unmeasured;
	int ActualWidth = 0, ActualHeight = 0, QueryWidth = 0, QueryHeight = 0;
	bool bClamped = false, bActualResolutionMeasured = false, bActualShapeSupported = false,
		 bRuntimeQualified = false;
	const FResolutionAnchor* AnchorEvidence = nullptr;
	const FResolutionAdmission* Admission = nullptr;
};

inline FResolutionSelection SelectResolutionPolicy(int Width, int Height, int Sm,
												   EResolutionPrecision PrecisionValue)
{
	FResolutionSelection Selection;
	Selection.ActualWidth = Width;
	Selection.ActualHeight = Height;
	const int PrecisionIndex = static_cast<int>(PrecisionValue);
	if (Width <= 0 || Height <= 0 || Sm <= 0 || PrecisionIndex < 0 || PrecisionIndex > 1)
	{
		Selection.StatusValue = EResolutionStatus::InvalidInput;
		return Selection;
	}
	Selection.QueryWidth = Width < CONST_RESOLUTION_WIDTH_MIN	? CONST_RESOLUTION_WIDTH_MIN
						   : Width > CONST_RESOLUTION_WIDTH_MAX ? CONST_RESOLUTION_WIDTH_MAX
																: Width;
	Selection.QueryHeight = Height < CONST_RESOLUTION_HEIGHT_MIN   ? CONST_RESOLUTION_HEIGHT_MIN
							: Height > CONST_RESOLUTION_HEIGHT_MAX ? CONST_RESOLUTION_HEIGHT_MAX
																   : Height;
	// Measured extrema are family-local and affect metadata only.
	int MeasuredWidthMin = CONST_RESOLUTION_WIDTH_MAX, MeasuredWidthMax = CONST_RESOLUTION_WIDTH_MIN,
		MeasuredHeightMin = CONST_RESOLUTION_HEIGHT_MAX, MeasuredHeightMax = CONST_RESOLUTION_HEIGHT_MIN;
	bool bMeasuredFamily = false;
	for (const auto& EvidenceRow : ResolutionAnchors)
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
	for (const auto& EvidenceRow : ResolutionAdmissions)
		if (EvidenceRow.Sm == Sm && EvidenceRow.PrecisionValue == PrecisionIndex &&
			EvidenceRow.Width == Width && EvidenceRow.Height == Height)
		{
			Selection.Admission = &EvidenceRow;
			Selection.bActualShapeSupported = true;
			Selection.bRuntimeQualified = EvidenceRow.bRuntimeQualified;
			break;
		}
	int64_t NearestDistanceSquared = std::numeric_limits<int64_t>::max();
	for (const auto& EvidenceRow : ResolutionAnchors)
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
		Selection.StatusValue = Selection.bActualResolutionMeasured ? EResolutionStatus::ExactMeasured
																	: EResolutionStatus::Transferred;
	}
	return Selection;
}
