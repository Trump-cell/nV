@set PATH="d:\Program Files\CMake\bin";%PATH%
@set BOOST_ROOT=D:\Lib\boost_1_63_0
cmake -G "Visual Studio 9 2008" -Dgmp_LIBRARIES=%~dp0Lib\gmp.lib -Dmpfr_LIBRARIES=%~dp0Lib\mpfr.lib -Dmpfi_LIBRARIES=%~dp0Lib\mpfi.lib -DUSE_BOOST_LIB=1 ..
