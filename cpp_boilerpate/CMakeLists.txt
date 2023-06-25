cmake_minimum_required(VERSION 3.20)

project(${CMAKE_PROJECT_NAME} CXX)

set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(package_name CONFIG REQUIRED)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
file(GLOB src "src/*.cpp")

#for single file
add_executable(${CMAKE_PROJECT_NAME} src/FILENAME.cpp)
