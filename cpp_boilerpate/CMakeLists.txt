cmake_minimum_required(VERSION 3.20)

project(${CMAKE_PROJECT_NAME} CXX)

set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON) #for vscode and nvim
set (VCPKG_HOME "$ENV{HOME}/vcpkg")
set (CMAKE_TOOLCHAIN_FILE "${VCPKG_HOME}/scripts/buildsystems/vcpkg.cmake")
#doxygen
if (DOCS)
    add_subdirectory(docs)
endif()

# include headers and source files
include_directories("${PROJECT_SOURCE_DIR}/include")
FILE(GLOB CPP_SOURCES "src/*.cpp")

#for single file
add_executable(${CMAKE_PROJECT_NAME} src/FILENAME.cpp)

# add code files
add_executable(${CMAKE_PROJECT_NAME} ${H_HEADERS} ${CPP_SOURCES})

# add libs
#1)find_package(package_name CONFIG REQUIRED)
#2)target_link_libraries($PROJECT_NAME PRIVATE package_name)

#examples for graphics project

find_package(imgui CONFIG REQUIRED)
target_link_libraries(Engine PRIVATE imgui)

find_package(glfw3 CONFIG REQUIRED)
target_link_libraries(Engine PRIVATE glfw)

find_package(glm CONFIG REQUIRED)
target_link_libraries(Engine PRIVATE glm)

find_package(Vulkan REQUIRED)
target_link_libraries(Engine PRIVATE Vulkan::Vulkan)

find_package(fmt CONFIG REQUIRED)
target_link_libraries(Engine PRIVATE fmt::fmt)

find_package(GTest CONFIG REQUIRED)
target_link_libraries(Engine PRIVATE GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)
