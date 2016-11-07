#!/bin/bash

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get -y install build-essential git
sudo apt-get build-dep wine-devel wine-devel:i386
#additional packages for 32-bit
packages=(
  xorg-dev
  libx11-dev
  flex
  bison
  gcc-multilib
  g++-multilib
  #nvidia-opencl-dev
  libx11-dev:i386
  libfreetype6-dev
  libfreetype6-dev:i386
  libxml2-dev:i386
  libxshmfence-dev
  libxshmfence-dev:i386
  libxrandr-dev
  libxrandr-dev:i386
  libxinerama-dev
  libxinerama-dev:i386
  libglu1-mesa-dev
  libglu1-mesa-dev:i386
  libosmesa6-dev
  libosmesa6-dev:i386
  ocl-icd-opencl-dev
  libncurses5-dev
  libncurses5-dev:i386
  libv4l-dev
  libv4l-dev:i386
  liblcms2-dev
  liblcms2-dev:i386
  libudev-dev
  libudev-dev:i386
  libcapi20-dev
  libcapi20-dev:i386
  libcups2-dev
  libcups2-dev:i386
  libfontconfig1-dev
  libfontconfig1-dev:i386
  libgsm1-dev
  libgsm1-dev:i386
  libtiff5-dev
  libtiff5-dev:i386
  libmpg123-dev
  libmpg123-dev:i386
  libopenal-dev
  libopenal-dev:i386
  libldap2-dev
  libldap2-dev:i386
  libxrender-dev
  libxrender-dev:i386
  libxslt1-dev
  libxslt1-dev:i386
  libjpeg-dev
  libjpeg-dev:i386
  libxcursor-dev
  libxcursor-dev:i386
)
sudo apt-get -y install ${packages[*]}
#the following causes an odd conflict
sudo rm -f /usr/share/doc/ocl-icd-opencl-dev/changelog.Debian.gz
sudo apt-get install ocl-icd-opencl-dev:i386
