#include "common.h"
#include <mU/Interface.h>
#ifdef _WIN32
#include <ShellAPI.h>
#else
#include <dlfcn.h>
#endif

namespace mU {
string cstr(wcs x) {
    return string(x, x + wcslen(x)).c_str();
}
string cstr(Var x) {
    return cstr(CStr(x).c_str());
}
string cpath(const char* x) {
#ifdef _WIN32
#ifdef _MSC_VER
    return string(x) + string(".dll");
#else
    return "lib" + string(x) + string(".dll");
#endif
#elif __APPLE__
	return "lib" + string(x) + ".dylib";
#else
    return "lib" + string(x) + string(".so");
#endif
}
void* cload(const char* x) {
	string s = cpath(x);
#if __EMSCRIPTEN__
	return dlopen(NULL, 0);
#else
#ifdef _WIN32
	void *r = LoadLibraryA((mU_Home() + "/bin/" + s).c_str());
	return r ? r : LoadLibraryA(s.c_str());
#else
	void * r = dlopen((mU_Home() + "/lib/" + s).c_str(), RTLD_LAZY);
	return r ? r : dlopen(s.c_str(), RTLD_LAZY);
#endif
#endif
}
void* cnoload(const char* x) {
	string s = cpath(x);
#if __EMSCRIPTEN__
	return dlopen(NULL, 0);
#else
#ifdef _WIN32
	void *r = GetModuleHandleA((mU_Home() + "/bin/" + s).c_str());
	return r ? r : GetModuleHandleA(s.c_str());
#else
	void *r = dlopen((mU_Home() + "/lib/" + s).c_str(), RTLD_LAZY | RTLD_NOLOAD);
	return r ? r : dlopen(s.c_str(), RTLD_LAZY | RTLD_NOLOAD);
#endif
#endif
}
void cunload(void* x) {
#ifdef _WIN32
    FreeLibrary(reinterpret_cast<HMODULE>(x));
#else
    dlclose(x);
#endif
}
void* csym(void* m, const char* x) {
    return
#ifdef _WIN32
        (void*)GetProcAddress(reinterpret_cast<HMODULE>(m), x)
#else
        dlsym(m, x)
#endif
        ;
}
bool cinstall(const char* x) {
    typedef void(*Ptr)();
    void* m = cload(x);
    if (!m)
        return false;
    void* ptr = csym(m, (string(x) + "_mUInstall").c_str());
    if (ptr)
        reinterpret_cast<Ptr>(ptr)();
    return true;
}
bool cuninstall(const char* x) {
    typedef void(*Ptr)();
    void* m = cnoload(x);
    if (!m)
        return false;
    void* ptr = csym(m, (string(x) + "_mUUninstall").c_str());
    if (ptr)
        reinterpret_cast<Ptr>(ptr)();
    cunload(m);
    return true;
}
string cname(Var x) {
    wstring s = ContextName[Context(x)];
    s += Name(x);
    std::replace(s.begin(), s.end(), _W('`'),_W('_'));
#if __EMSCRIPTEN__
    std::replace(s.begin(), s.end(), _W('$'),_W('_'));
#endif
    return cstr(s.c_str());
}
void* cfunc(void* m, Var x) {
    string s = cname(x);
    return csym(m, s.c_str());
}
}
