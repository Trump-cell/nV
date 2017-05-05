@set PATH="d:\Program Files\CMake\bin";%PATH%
@set BOOST_ROOT=D:\Lib\boost_1_63_0
cmake -G "Visual Studio 14 2015" -Dgmp_LIBRARIES=%~dp0Lib\gmp.lib -Dmpfr_LIBRARIES=%~dp0Lib\mpfr.lib -Dmpfi_LIBRARIES=%~dp0Lib\mpfi.lib ..
