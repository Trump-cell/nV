#!/bin/bash

DIR=$(dirname $(readlink -f $0))
emconfigure cmake -Dgmp_LIBRARIES=${DIR}/Lib/libgmp.so -Dmpfr_LIBRARIES=${DIR}/Lib/libmpfr.so -Dmpfi_LIBRARIES=${DIR}/Lib/libmpfi.a -DEMCC=1 ..
