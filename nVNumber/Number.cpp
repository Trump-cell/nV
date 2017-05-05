#include "common.h"
#include <nV/Number.h>
#ifdef _MSC_VER
#pragma comment(lib,"nVKernel")
#endif

using namespace nV;

CAPI void nvnumber_Install(Kernel& k) {
    //wcout << "#Number# Install Successfully!" << endl;
    Number::Randomize();
}
CAPI void nvnumber_Uninstall(nV::Kernel& k) {
    wcout << "#Number# Uninstall Successfully!" << endl;
}
