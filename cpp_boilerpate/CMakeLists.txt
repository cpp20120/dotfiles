cmake_minimum_required(VERSION 3.20)

project(${CMAKE_PROJECT_NAME} CXX)

set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set (VCPKG_HOME "$ENV{HOME}/vcpkg")
set (CMAKE_TOOLCHAIN_FILE "${VCPKG_HOME}/scripts/buildsystems/vcpkg.cmake")

add_compile_options(-Wall -Wextra -Wpedantic -Werror -std=c++20)
set(CMAKE_EXE_LINKER_FLAGS -fuse-ld=lld)
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
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE imgui)

find_package(glfw3 CONFIG REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE glfw)

find_package(glm CONFIG REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE glm)

find_package(glad CONFIG REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE glad::glad)

find_package(Vulkan REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE Vulkan::Vulkan)

find_package(fmt CONFIG REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE fmt::fmt)

find_package(GTest CONFIG REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)

############## Build SHADERS #######################
find_program(GLSL_VALIDATOR glslangValidator HINTS 
  ${Vulkan_GLSLANG_VALIDATOR_EXECUTABLE} 
  /usr/bin 
  /usr/local/bin 
  ${VULKAN_SDK_PATH}/Bin
  ${VULKAN_SDK_PATH}/Bin32
  $ENV{VULKAN_SDK}/Bin/ 
  $ENV{VULKAN_SDK}/Bin32/
)

# get all .vert and .frag files in shaders directory
file(GLOB_RECURSE GLSL_SOURCE_FILES
  "${PROJECT_SOURCE_DIR}/shaders/*.frag"
  "${PROJECT_SOURCE_DIR}/shaders/*.vert"
)

foreach(GLSL ${GLSL_SOURCE_FILES})
  get_filename_component(FILE_NAME ${GLSL} NAME)
  set(SPIRV "${PROJECT_SOURCE_DIR}/shaders/${FILE_NAME}.spv")
  add_custom_command(
    OUTPUT ${SPIRV}
    COMMAND ${GLSL_VALIDATOR} -V ${GLSL} -o ${SPIRV}
    DEPENDS ${GLSL})
  list(APPEND SPIRV_BINARY_FILES ${SPIRV})
endforeach(GLSL)

add_custom_target(
    Shaders
    DEPENDS ${SPIRV_BINARY_FILES}
)
