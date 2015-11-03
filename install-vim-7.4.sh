#!/bin/bash

echo "Installing vim-7.4"

SOFTWARE=vim
MAJOR_VERSION=7
MINOR_VERSION=4
VERSION=$MAJOR_VERSION.$MINOR_VERSION
PACKAGE=$SOFTWARE-$VERSION
PACKAGE_TAR_FILE=$PACKAGE.tar
PACKAGE_ZIP_FILE=$PACKAGE.tar.bz2
ROOT_DIR=$SOFTWARE$MAJOR_VERSION$MINOR_VERSION
BUILD_DIR=$ROOT_DIR
DST_DIR=$LOCAL_SW_INSTALL_DIR/$SOFTWARE/$VERSION
PROTOCOL=ftp
SERVER=ftp.vim.org
SERVER_DIR=pub/$SOFTWARE/unix
URL=$PROTOCOL://$SERVER/$SERVER_DIR/$PACKAGE_ZIP_FILE

cd $LOCAL_SW_BUILD_DIR;
wget $URL;
bunzip2 $PACKAGE_ZIP_FILE;
tar xvf $PACKAGE_TAR_FILE;
rm -f $PACKAGE_TAR_FILE;
mkdir -p $DST_DIR;
cd $BUILD_DIR;
./configure
    --with-features=huge \
    --enable-luainterp \
    --enable-pythoninterp \
    --enable-python3interp \
    --enable-tclinterp \
    --enable-rubyinterp \
    --enable-cscope \
    --enable-multibyte \
    --enable-gui=auto \
    --enable-fontset \
    --prefix=$DST_DIR;
make;
make install;

