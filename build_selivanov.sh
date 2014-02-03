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

echo Building $project [$path]...
echo "                                                          ...... killing cache directory ......"
rm -rf $build

mkdir -p $build
ln -s $build $build2
cd $build

cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/usr -DLINK_DIRECTORIES=$lib -DSYSCONFDIR=  $path
make -j 8
make package
#make doc

echo "                                                          ...... building silent setup package directory ......"
#rm -rf $build
cmake -DSILENTSETUP=ON -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/usr -DLINK_DIRECTORIES=$lib -DSYSCONFDIR=  $path
make package -j 8


#if [ -f DartConfiguration.tcl ]
#then
#echo "Running CTest"
#ctest  -T Start
#ctest  -T Configure
#ctest  -T Build
#ctest  -T Submit
#ctest  -T Test
#ctest  -T Submit
#fi

cd $path

