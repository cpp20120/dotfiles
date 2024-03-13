#!/bin/bash
# Проверка типа дистрибутива
if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update
    sudo apt-get install -y build-essential neofetch lua-nvim git clang clang-tools gcc cmake make ninja-build lld lldb valgrind clang-format qt5-default qtbase5-dev qt6-base-dev glfw glew libglm-dev glew-utils libglew-dev vulkan-tools vulkan-utils vulkan-loader glslang-dev spirv-tools

elif [ -x "$(command -v dnf)" ]; then
    sudo dnf install -y @development-tools neofetch nvim luajit git clang clang-tools-extra gcc cmake make ninja-build lld lldb valgrind qt5-qtbase-devel qt6-devel-multimedia qt6-core qt6-multimedia glfw glm-devel glew vulkan-headers vulkan-loader vulkan-tools vulkan-volk-devel glslang spirv-tools spirv-llvm-translator

elif [ -x "$(command -v pacman)" ]; then
    sudo pacman -Syu base-devel neofetch neovim lua git clang clang compiler-rt gcc cmake ninja make lld lldb valgrind qt5-base qt5-multimedia qt5-quick3d qt6-tools qt6-quick3d qt6-multimedia glfw glew glm vulkan-extra-layers vulkan-extra-tools vulkan-headers vulkan-tools vulkan-validation-layers spirv-llvm-translator

else
    echo "Не удалось определить дистрибутив и установщик пакетов."
    exit 1
fi
