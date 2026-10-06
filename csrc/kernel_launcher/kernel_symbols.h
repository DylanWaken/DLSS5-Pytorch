#pragma once
#include <string>

// Query explicitly for diagnostics; ordinary preparation and launch do not need
// device symbol names. Public Torch names are stable across template refactors.
std::string KernelSymbol(const std::string& Name);
