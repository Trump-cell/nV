#!/bin/bash

DIR=$(dirname $(readlink -f $0))
cmake -DUSE_SYS=1 ..
