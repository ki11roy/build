#!/bin/bash
if [ $# -ne 1 ]
then
    echo "Usage: build.sh <project_path>"
    exit 1
fi

path=$1
if [ `whoami` == 'fast' ]
then
    source ./build_fast.sh $path
elif [ `whoami` == 'selivanov' ]
then
    source ./build_selivanov.sh $path
elif [ -n "$build_silent" ] && [ $build_silent == 1 ]
then
    source ./build_silent.sh $path
else
    source ./build_any.sh $path
fi
