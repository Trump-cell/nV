#include <nV/String.h>
#ifdef _MSC_VER
#pragma comment(lib,"nVKernel")
#endif

using namespace nV;

CAPI void nvstring_Install(Kernel& k) {
    //wcout << "#String# Install Successfully!" << endl;
}
CAPI void nvstring_Uninstall(nV::Kernel& k) {
    wcout << "#String# Uninstall Successfully!" << endl;
}
