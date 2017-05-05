#!/bin/bash

DIR=$(dirname $(readlink -f $0))
export MU_HOME=${DIR}/gcc/MinSizeRel
export NV_HOME=${DIR}/gcc/MinSizeRel
export PATH=${DIR}/gcc/MinSizeRel/bin:$PATH

nv
