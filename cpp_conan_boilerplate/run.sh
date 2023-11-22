#!/bin/bash
if [[ "$(uname -s)" == "Linux" && "$(cat /etc/*-release | grep -oP '(?<=^ID=) +')" == "Debian" ]];
then
  if [ $(dpkg-query -W -f='${Status}' conan 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
    sudo apt-get -y install conan cmake ninja clang;
  fi
fi

if [[ "$(uname -s)" == "Linux" && "$(cat /etc/*-release | grep -oP '(?<=^ID=).+')" == "Fedora" ]];
then
  if [ $( rpm -qa --quiet | grep conan 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
    sudo dnf -y install conan cmake ninja clang;
  fi
fi

if [[ "$(uname -s)" == "Linux" && "$(cat /etc/*-release | grep -oP '(?<=^ID=).+')" == "Arch" ]];
then
  if
  then
    yay -S -y conan cmake ninja clang;
  fi
fi

set -e
set -x

BASEDIR=$(dirname "$0")
pushd "$BASEDIR"

rm -rf build

conan install . --output-folder=build --build=missing
cd build
cmake .. -G Ninja -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build .
./test
