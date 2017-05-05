# set build type below, possible values are: Debug, Release, RelWithDebInfo
# (meaning "release version with debug information retained") and MinSizeRel
# (meaning "minimum size release version")
set(CMAKE_BUILD_TYPE "MinSizeRel")

set(CMAKE_PREFIX_PATH ""
    CACHE STRING "We will try to find all external libraries here")
set(EXTRA_INCLUDE ""
    CACHE STRING "extra directories to find *.h files")

set(USE_JAVA      "NO" CACHE STRING "nVLink - Java")
set(USE_NTL_FLINT "NO" CACHE STRING "nVLink - ntl & flint")
set(USE_YAFU      "NO"  CACHE STRING "nVLink - yafu")
set(USE_PYTHON    "NO"  CACHE STRING "nVLink - Python")
set(USE_LUA       "NO" CACHE STRING "nVLink - Lua")
set(USE_ECL       "NO"  CACHE STRING "nVLink - Ecl")
set(USE_MU0       "NO"  CACHE STRING "nVLink - mU0")
