// lwss: Moved heap sizes into their own file for each platform because the ifdef's were getting annoying
#ifdef __PLAT_WN32__
#include "heap_sizes_win32.h"
#elif __PLAT_XBOX__
#include "heap_sizes_xbox.h"
#else
#error heap sizes missing platform!
#endif