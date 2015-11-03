#!/bin/bash

echo "Installing mpich-3.1.4"

SOFTWARE=mpich
MAJOR_VERSION=3
MINOR_VERSION=1
RELEASE_VERSION=4
VERSION=$MAJOR_VERSION.$MINOR_VERSION.$RELEASE_VERSION
PACKAGE=$SOFTWARE-$VERSION
PACKAGE_TAR_FILE=$PACKAGE.tar
PACKAGE_ZIP_FILE=$PACKAGE_TAR_FILE.gz
ROOT_DIR=$PACKAGE
BUILD_DIR=$ROOT_DIR/build
DST_DIR=$LOCAL_SW_INSTALL_DIR/$SOFTWARE/$VERSION
PROTOCOL=http
SERVER=www.mpich.org
SERVER_DIR=static/downloads
URL=$PROTOCOL://$SERVER/$SERVER_DIR/$VERSION/$PACKAGE_ZIP_FILE

cd $LOCAL_SW_BUILD_DIR;
#wget $URL;
#gunzip $PACKAGE_ZIP_FILE;
#tar xvf $PACKAGE_TAR_FILE;
#rm -f $PACKAGE_TAR_FILE;
mkdir -p $BUILD_DIR;
mkdir -p $DST_DIR;
cd $BUILD_DIR;
../configure \
    --enable-fortran=all \
    --enable-cxx \
    --enable-debuginfo \
    --enable-threads=multiple \
    --enable-shared=yes \
    --enable-static=yes \
    --enable-fast-install=yes \
    --enable-cache \
    --enable-coverage \
    --prefix=$DST_DIR;
make;
make install;

