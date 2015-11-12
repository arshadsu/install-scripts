#!/bin/bash

echo "Installing poppler-0.37.0"

SOFTWARE=poppler
MAJOR_VERSION=0
MINOR_VERSION=37
RELEASE_VERSION=0
VERSION=$MAJOR_VERSION.$MINOR_VERSION.$RELEASE_VERSION
PACKAGE=$SOFTWARE-$VERSION
PACKAGE_TAR_FILE=$PACKAGE.tar
PACKAGE_ZIP_FILE=$PACKAGE_TAR_FILE.xz
ROOT_DIR=$PACKAGE
BUILD_DIR=$ROOT_DIR/build
DST_DIR=$LOCAL_SW_INSTALL_DIR/$SOFTWARE/$VERSION
PROTOCOL=http
SERVER=poppler.freedesktop.org
SERVER_DIR=
URL=$PROTOCOL://$SERVER/$PACKAGE_ZIP_FILE

cd $LOCAL_SW_BUILD_DIR;
wget $URL;
tar xvfJ $PACKAGE_ZIP_FILE;
rm -f $PACKAGE_ZIP_FILE;
mkdir -p $BUILD_DIR;
mkdir -p $DST_DIR;
cd $BUILD_DIR;
../configure \
  --prefix=$DST_DIR \
  --enable-shared \
  --enable-static \
  --enable-build-type=release \
  --enable-libopenjpeg=auto \
  --enable-zlib \
  --enable-libcurl \
  --enable-introspection=auto \
  --enable-poppler-qt4 \
  --enable-poppler-qt5 \
  --enable-poppler-cpp \
  --enable-compile-warnings=yes
make;
make install;

