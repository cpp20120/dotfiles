#!/bin/bash
if [ $(dpkg-query -W -f='${Status}' conan 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install conan;
fi

if [[ "$(uname -s)" == "Linux" && "$(cat /etc/*-release | grep -oP '(?<=^ID=).+')" == "fedora" ]];
then
  if [ $( rpm -qa --quiet | grep conan 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
    sudo dnf install conan;
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
