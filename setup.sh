#!/bin/bash

install_fedora () {
 sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
 echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
 sudo dnf install -y  gcc  clang  cmake  ninja-build  make  clang-tools-extra qt6-qtbase-devel SFML SFML-devel SDL2-devel SDL2_image-devel dotnet-sdk-8.0 dotnet-runtime-8.0 sqlite sqlite-devel code doxygen gtest-devel python3 python3-pip 
}

install_debian() {
 sudo add-apt-repository contrib
 sudo add-apt-repository non-free
 sudo apt-get update

 curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg -dearmor > microsoft.gpg
 sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg

 sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
 sudo apt update
 sudo apt install -y  gcc  clang  cmake  ninja-build  make  clang-format clang-tools lld doxygen qt6-base-dev  libsfml-dev libsdl2-dev libsdl2-image-dev dotnet-sdk  sqlite3  code libgtest-dev python3 python3-pip 
}

install_arch () {
 sudo pacman -Syu  gcc  clang  cmake  ninja  make  clang-format  qt6-base  sfml sdl2 sdl2_image dotnet-sdk  sqlite  code doxygen gtest python python-pip 
}

install_macos () {
 if ! command -v brew > /dev/null; then
  echo "Homebrew не найден. Устанавливаю Homebrew..."
  /bin/bash -c "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
 fi

 xcode-select -install
 brew install  gcc  llvm cmake  ninja  qt  sfml sdl2_image sdl2 sqlite googletest doxygen  dotnet-sdk python python-pip –cask visual-studio-code 

 echo "Установка завершена!"
}

install_other_fedora () {
 sudo dnf -y install dnf-plugins-core
 sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
 sudo dnf5 install -y zsh eza fzf screenfetch lcov qt5-qtbase-devel qt5-qtbase  qt6-qtbase qt6-qtbase-devel qt6-qtmultimedia compiler-rt mold lld lldb valgrind glslc vulkan-headers vulkan-loader vulkan-tools vulkan-volk-devel glslang spirv-tools spirv-llvm-translator vulkan-validation-layers glew-devel glfw-devel glm-devel postgresql pgadmin4 redis docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin podman tokei poco-devel boost boost-devel
}

install_other_debian () {
 sudo apt-get update
 sudo apt install -y  qt5-default  qtbase5-dev  qt6-base-dev  qt6-base  qt6-quick3d-dev  libqt6quick3d6  glfw  glm-dev  glew-utils  libglew-dev  vulkan-tools  vulkan-utils  vulkan-loader  glslang-dev  spirv-tools  spirv-llvm-translator zsh  screenfetch  lcov  mold  lld  lldb  valgrind  glslc  shaderc  postgresql  pgadmin4  redis  docker  docker-compose  podman  podman-docker  docker-compose-plugin  docker-buildx-plugin tokei libboost-all-dev libpoco-dev
}

instalL_other_archlinux () {
 sudo pacman -Syyu --noconfirm
 sudo pacman -S  paru
 sudo pacman -S zsh screenfetch lcov qt5-base qt6-base qt6-multimedia compiler-rt mold lld lldb valgrind glslc shaderc vulkan-headers vulkan-loader vulkan-tools vulkan-volk-devel glslang spirv-tools spirv-llvm-translator vulkan-validation-layers glew glfw glm postgresql pgadmin4 docker docker-compose containerd tokei boost poco
 paru -S --noconfirm --needed zsh-completions docker-compose-plugin podman podman-docker
}

if [ -x "$(command -v dnf)" ]; then
 read -p "Do you want to install additional development tools (zsh, docker, etc.)? (y/n) " -n 1 -r
 echo
 if [[ $REPLY =~ ^[Yy]$ ]]; then
  install_other_fedora
 else
  install_fedora
 fi
elif [ -x "$(command -v apt-get)" ]; then
 read -p "Do you want to install additional development tools (zsh, docker, etc.)? (y/n) " -n 1 -r
 echo
 if [[ $REPLY =~ ^[Yy]$ ]]; then
  install_other_debian
 else
  install_debian
 fi
elif [ -x "$(command -v pacman)" ]; then
 read -p "Do you want to install additional development tools (zsh, docker, etc.)? (y/n) " -n 1 -r
 echo
 if [[ $REPLY =~ ^[Yy]$ ]]; then
  instalL_other_archlinux
 else
  install_arch
 fi
elif [ -x "$(command -v brew)" ]; then
 install_macos
else
 echo "Не удалось определить операционную систему. Используйте: fedora|debian|arch|macos"
 exit 1
fi

echo "Установка завершена!"
