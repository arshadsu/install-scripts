# install-scripts

This repo contains the scripts I have written so far for adding custom packages to the CentOS 7 installation. I started this to add DisplayCluster 0.4 to the KVL CentOS 7 installation. Most of the required packages were installed by default, however, some were needed including:
* FFMPEG-0.10.2

There were some optional packages needed including:
* poppler-0.37.0
* TUIO-1.4

Building TUIO required a more recent version of CMake than the one installed (2.8.11 at the persent time) so I added CMake-3.3.2, but this conflicts with DisplayCluster installation, so I used CMake-3.3.2 to build TUIO-1.4, but use the system CMake for building DislayCluster-0.4.

In order to use these scripts the following environment variables need to be set:
* LOCAL_SW_BUILD_DIR
* LOCAL_SW_INSTALL_DIR

As clear from the name, these are the root directories for build and installation of these packages.

