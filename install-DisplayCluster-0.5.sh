#!/bin/bash

echo "Installing DisplayCluster-0.5"

# Dependencies:
# * poppler >= 0.24 (using poppler-0.37, please see the install script for options)

SOFTWARE=DisplayCluster
MAJOR_VERSION=0
MINOR_VERSION=5
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

cd $LOCAL_SW_BUILD_DIR
git clone $URL $PACKAGE
mkdir -p $BUILD_DIR
mkdir -p $DST_DIR
cd $PACKAGE
# The v0.5.0 tag is from 2015/07/07
#git checkout v0.5.0
# Use the following commit from 2015/10/28. The reason we need this instead
# of the v0.5.0 tag is that two of the files in Deflect tree use QDataStream,
# whose #include the compiler is unable to find. This situation isn't isn't 
# fixed until commit from 2015/10/09, which gets included into the following
# commit as Deflect is an external package
git checkout 027782a
cd ..
cd $BUILD_DIR
module load mpi/mpich-x86_64
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$DST_DIR
make
make install
module unload mpi/mpich-x86_64

