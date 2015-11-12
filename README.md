# install-scripts

This repo contains the scripts I have written so far for adding custom packages to the CentOS 7 installation. I started this to add DisplayCluster-0.4 to the KVL CentOS 7 installation. Most of the required packages were installed by default, however, the following were needed:
* FFmpeg-0.10.2

There were some optional packages also needed, as they were either not installed or the system version was older than the one required:
* poppler-0.37.0
* TUIO-1.4

Building TUIO required a more recent version of CMake than the one installed (2.8.11 at the persent time) so I added CMake-3.3.2, but this version somehow conflicts with DisplayCluster build (configuration phase), so I have used CMake-3.3.2 just to build TUIO-1.4, but otherwise used the system CMake for building DislayCluster-0.4.

In order to use these scripts the following environment variables need to be set:
* LOCAL_SW_BUILD_DIR
* LOCAL_SW_INSTALL_DIR

As clear from the name, these are the root directories for build and installation of these packages.

[Update: 2015/11/12]
Added scirpt for DisplayCluster-0.5, which requires:
* poppler-0.37.0 (built with qt5 wrappers enabled)

TUIO-1.4 is fetched as external dependency by the build CMake.
