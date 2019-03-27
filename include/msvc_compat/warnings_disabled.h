#pragma once

#pragma warning(disable: 4201 4100 4013 4127 4189 4244 4267 4456 4457 4459 4204 4702 4715 4706 4701 4703 4565)

#if defined(JEMALLOC_UNIT_TEST)
#pragma warning(disable:4047 4152 4221)
#endif
#if defined(JEMALLOC_INTEGRATION_TEST)
#pragma warning(disable:4152 4310)
#endif
#if defined(JEMALLOC_STRESS_TEST)
#pragma warning(disable:4152)
#endif
