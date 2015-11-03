#!/bin/bash

echo "Installing libjpeg-turbo-1.4.2"

SOFTWARE=libjpeg-turbo
MAJOR_VERSION=1
MINOR_VERSION=4
RELEASE_VERSION=2
VERSION=$MAJOR_VERSION.$MINOR_VERSION.$RELEASE_VERSION
PACKAGE=$SOFTWARE-$VERSION
PACKAGE_TAR_FILE=$PACKAGE.tar
PACKAGE_ZIP_FILE=$PACKAGE.tar.gz
ROOT_DIR=$PACKAGE
BUILD_DIR=$ROOT_DIR/build
DST_DIR=$LOCAL_SW_INSTALL_DIR/$SOFTWARE/$VERSION
PROTOCOL=http
SERVER=downloads.sourceforge.net
SERVER_DIR=project/$SOFTWARE/$VERSION
URL=$PROTOCOL://$SERVER/$SERVER_DIR/$PACKAGE_ZIP_FILE

cd $LOCAL_SW_BUILD_DIR;
wget $URL;
gunzip $PACKAGE_ZIP_FILE;
tar xvf $PACKAGE_TAR_FILE;
rm -f $PACKAGE_TAR_FILE;
mkdir -p $BUILD_DIR;
mkdir -p $DST_DIR;
cd $BUILD_DIR;
../configure \
  --enable-shared \
  --enable-static \
  --enable-fast-install \
  --prefix=$DST_DIR
make;
make install;

