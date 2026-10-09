#pragma once
#include <cstdint>

// A test/tuning capacity limit can only make scheduling more conservative.
// Zero means use every SM reported by the current device.
constexpr int EffectiveSplitSmCount(int DeviceSmCount, int SmCountLimit)
{
	return SmCountLimit > 0 && SmCountLimit < DeviceSmCount ? SmCountLimit : DeviceSmCount;
}

// Independent-Z kernels need no ordering. Dependent splits use separate stream
// launches whenever the complete logical grid cannot be resident together.
// Compare by division so even a large logical grid cannot overflow a product.
constexpr unsigned SelectSplitLaunchCount(bool bDependentSplits, uint64_t PlaneBlocks, unsigned SplitCount,
										  int ActiveBlocksPerSm, int SmCount)
{
	if (!bDependentSplits || SplitCount <= 1)
		return 1;
	const uint64_t Capacity =
		ActiveBlocksPerSm > 0 && SmCount > 0 ? uint64_t(ActiveBlocksPerSm) * uint64_t(SmCount) : 0;
	return PlaneBlocks <= Capacity / SplitCount ? 1 : SplitCount;
}
