#!/bin/bash

echo "Installing DisplayCluster-0.6"

# Dependencies:
# * poppler >= 0.24 (using poppler-0.37, please see the install script for options)

SOFTWARE=DisplayCluster
MAJOR_VERSION=0
MINOR_VERSION=6
RELEASE_VERSION=
VERSION=$MAJOR_VERSION.$MINOR_VERSION
PACKAGE=$SOFTWARE-$VERSION
PACKAGE_TAR_FILE=$PACKAGE.tar
PACKAGE_ZIP_FILE=$PACKAGE.tar.gz
ROOT_DIR=$PACKAGE
BUILD_DIR=$ROOT_DIR/build
DST_DIR=$LOCAL_SW_INSTALL_DIR/$SOFTWARE/$VERSION
PROTOCOL=https
SERVER=github.com
SERVER_DIR=BlueBrain
URL=$PROTOCOL://$SERVER/$SERVER_DIR/$SOFTWARE.git
SCRIPT_DIR=`pwd`

cd $LOCAL_SW_BUILD_DIR
git clone $URL $PACKAGE
mkdir -p $BUILD_DIR
mkdir -p $DST_DIR
cd $PACKAGE
# The v0.6.0 tag is from 2015/11/04
#git checkout v0.6.0
# Apply a patch to a file to remove error that compiler is unable to find defintion
# for std::min
patch $LOCAL_SW_BUILD_DIR/$PACKAGE/dc/core/MPINospin.cpp $SCRIPT_DIR/patch_MPINospin_cpp_3ff3ca7.txt
cd ..
cd $BUILD_DIR
module load mpi/mpich-x86_64
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$DST_DIR
make
make install
module unload mpi/mpich-x86_64

