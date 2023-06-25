cmake_minimum_required(VERSION 3.20)

project(${CMAKE_PROJECT_NAME} CXX)

set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (DOCS)
    add_subdirectory(docs)
endif()

find_package(package_name CONFIG REQUIRED)

# include headers and source files
include_directories("${PROJECT_SOURCE_DIR}/include")
FILE(GLOB CPP_SOURCES "src/*.cpp")

#for single file
add_executable(${CMAKE_PROJECT_NAME} src/FILENAME.cpp)

# add code files
add_executable(${CMAKE_PROJECT_NAME} ${H_HEADERS} ${CPP_SOURCES})
