#!/bin/bash
#Created by Sam Gleske
#Sun Sep  4 12:21:06 PDT 2016
#Ubuntu 16.04.1 LTS
#Linux 4.4.0-36-generic x86_64
#GNU bash, version 4.3.46(1)-release (x86_64-pc-linux-gnu)

#See also:
#  https://wiki.winehq.org/Building_Biarch_Wine_On_Ubuntu

#install prereqs
#sudo dpkg --add-architecture i386
#sudo apt-get update
#sudo apt-get install build-essential git
#sudo apt-get build-dep wine-devel wine-devel:i386
##additional packages for 32-bit
#sudo apt-get install xorg-dev libx11-dev flex bison gcc-multilib g++-multilib nvidia-opencl-dev libx11-dev:i386 libfreetype6-dev libfreetype6-dev:i386

export PREFIX="${PREFIX:-${HOME}/usr}"
export WINE_VERSION="${WINE_VERSION:-master}"
[[ -z "${THREADS}" ]] && export THREADS="$(awk '{ threads+=($0 ~ "^processor") }END{ print threads+1 }' /proc/cpuinfo)"

if [ ! -d "${PREFIX}/src" ]; then
  mkdir -p "${PREFIX}"/src
fi

cd "${PREFIX}"/src
if [ ! -d "./wine" ]; then
  git clone git://source.winehq.org/git/wine.git && (
    cd ./wine
    git checkout ${WINE_VERSION}
  )
fi

mkdir -p wine64 wine32-tools wine32

#build wine64
pushd ./wine64/
../wine/configure --enable-win64 --prefix="${PREFIX}"
make -j${THREADS}
popd

#build wine32-tools
pushd ./wine32-tools/
../wine/configure --prefix="${PREFIX}"
make -j${THREADS}
popd

#build wine32 biarch
pushd ./wine32/
../wine/configure --with-wine64=../wine64 --with-wine-tools=../wine32-tools --prefix="${PREFIX}"
make -j${THREADS}
popd

#install biarch wine
(
  cd ./wine32/
  make install
)
(
  cd ./wine64/
  make install
)

#First time setup
#wineboot
#winecfg
#winetricks -q msxml3
#winetricks -q vcrun2010
#winetricks -q vcrun2013
#winetricks videomemorysize=2048
#wine setup_no_mans_sky_2.3.0.5.exe
