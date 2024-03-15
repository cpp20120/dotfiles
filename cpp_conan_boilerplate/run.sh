#!/bin/bash
# Проверка типа дистрибутива
if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update
    sudo apt-get install -y build-essential neofetch git clang clang-tools clang-format gcc cmake ninja-build lld lldb valgrind gtest python3-pip doxygen neovim

elif [ -x "$(command -v dnf)" ]; then
    sudo dnf install -y @development-tools neofetch git clang clang-tools-extra gcc cmake ninja-build lld lldb valgrind gtest python3-pip doxygen neovim


else
    echo "Не удалось определить дистрибутив и установщик пакетов."
    exit 1
fi

pip3 install conan

set -e
set -x

BASEDIR=$(dirname "$0")
pushd "$BASEDIR"

rm -rf build

conan install . --output-folder=build --build=missing
cd build
cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build .
./test


