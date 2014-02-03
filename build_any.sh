#!/bin/bash
if [ $# -ne 1 ]
then
    echo "Usage: build.sh <project_path>"
    exit 1
fi

path=$1
project=`basename $path`
path_hash=`echo $path | /usr/bin/md5sum | cut -f1 -d" "`
build=/tmp/${path_hash:0:6}
build2=/tmp/`whoami`/$project
lib=/tmp/`whoami`/lib

mkdir -p $build
ln -s $build $build2
cd $build

cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/usr -DLINK_DIRECTORIES=$lib -DSYSCONFDIR=  $path
make
make package

if [ -f DartConfiguration.tcl ]
then
echo "Running CTest"
ctest  -T Start
ctest  -T Configure
ctest  -T Build
ctest  -T Submit
ctest  -T Test
ctest  -T Submit
fi

cd $path

