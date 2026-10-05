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
	FSelection Result;
	Result.ActualWidth = Width;
	Result.ActualHeight = Height;
	const int PrecisionIndex = static_cast<int>(PrecisionValue);
	if (Width <= 0 || Height <= 0 || Sm <= 0 || PrecisionIndex < 0 || PrecisionIndex > 1)
	{
		Result.StatusValue = EStatus::InvalidInput;
		return Result;
	}
	Result.QueryWidth = Width < WidthMin ? WidthMin : Width > WidthMax ? WidthMax : Width;
	Result.QueryHeight = Height < HeightMin ? HeightMin : Height > HeightMax ? HeightMax : Height;
	// Measured extrema are family-local and affect metadata only.
	int LoW = WidthMax, HiW = WidthMin, LoH = HeightMax, HiH = HeightMin;
	bool bMeasuredFamily = false;
	for (const auto& EvidenceRow : Anchors)
	{
		if (EvidenceRow.Sm != Sm || EvidenceRow.PrecisionValue != PrecisionIndex)
			continue;
		bMeasuredFamily = true;
		if (EvidenceRow.Width < LoW)
			LoW = EvidenceRow.Width;
		if (EvidenceRow.Width > HiW)
			HiW = EvidenceRow.Width;
		if (EvidenceRow.Height < LoH)
			LoH = EvidenceRow.Height;
		if (EvidenceRow.Height > HiH)
			HiH = EvidenceRow.Height;
	}
	if (bMeasuredFamily)
	{
		Result.QueryWidth = Result.QueryWidth < LoW ? LoW : Result.QueryWidth > HiW ? HiW : Result.QueryWidth;
		Result.QueryHeight = Result.QueryHeight < LoH	? LoH
							 : Result.QueryHeight > HiH ? HiH
														: Result.QueryHeight;
	}
	Result.bClamped = Result.QueryWidth != Width || Result.QueryHeight != Height;
	// Exact actual dimensions only. Clamped coordinates never grant admission.
	for (const auto& EvidenceRow : Admissions)
		if (EvidenceRow.Sm == Sm && EvidenceRow.PrecisionValue == PrecisionIndex &&
			EvidenceRow.Width == Width && EvidenceRow.Height == Height)
		{
			Result.Admission = &EvidenceRow;
			Result.bActualShapeSupported = true;
			Result.bRuntimeQualified = EvidenceRow.bRuntimeQualified;
			break;
		}
	int64_t Best = std::numeric_limits<int64_t>::max();
	for (const auto& EvidenceRow : Anchors)
	{
		if (EvidenceRow.Sm != Sm || EvidenceRow.PrecisionValue != PrecisionIndex)
			continue;
		const int64_t Dx = int64_t(Result.QueryWidth) - EvidenceRow.Width,
					  Dy = int64_t(Result.QueryHeight) - EvidenceRow.Height;
		const int64_t Distance = Dx * Dx * 1440LL * 1440LL + Dy * Dy * 2560LL * 2560LL;
		// Generated rows are sorted by width, height, configuration within family.
		if (Distance < Best)
		{
			Best = Distance;
			Result.AnchorEvidence = &EvidenceRow;
		}
	}
	if (Result.AnchorEvidence)
	{
		Result.ConfigId = Result.AnchorEvidence->ConfigId;
		Result.bActualResolutionMeasured =
			Result.AnchorEvidence->Width == Width && Result.AnchorEvidence->Height == Height;
		Result.StatusValue = Result.bActualResolutionMeasured ? EStatus::ExactMeasured : EStatus::Transferred;
	}
	return Result;
}
} // namespace dlssnr::resolution_policy
