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
SCRIPT_DIR=`pwd`

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
patch $LOCAL_SW_BUILD_DIR/$PACKAGE/dc/core/Options.cpp $SCRIPT_DIR/patch_DC_05_Options_cpp_027782a.txt
patch $LOCAL_SW_BUILD_DIR/$PACKAGE/dc/core/DisplayGroup.cpp $SCRIPT_DIR/patch_DC_05_DisplayGroup_cpp_027782a.txt
cd ..
cd $BUILD_DIR
if [ -n "`grep 'Scientific Linux release 6' /etc/system-release`" ]; then
    module load kvl-remote
    module load gcc/4.8.4
    module load icu/54.1
    module load qt/5.4.1
    module load openjpeg/2.1
    module load poppler/0.34.0
    module load TUIO/1.4
    module load fcgi/2.4.1
    module load python/2.7.3
    module load mpich-x86_64
    module load turbojpeg/1.2.1
    module load ffmpeg/0.10.2
    module load boost/1.55.0-mpich-3.1
    else if [ -n "`grep 'CentOS Linux release 7' /etc/system-release`" ]; then
        module load mpi/mpich-x86_64
    fi
fi
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$DST_DIR
make
make install
module unload mpi/mpich-x86_64

