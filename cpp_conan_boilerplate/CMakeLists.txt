cmake_minimum_required(VERSION 3.20)
project(boosttemplate LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(BUILD_WITH_CONAN ON)

add_compile_options(-Wall -Wextra -Wpedantic -Werror -std=c++20)
#sanitizers
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address -fsanitize=undefined -fsanitize=thread -fPIE -pie -fno-omit-frame-pointer -g")
set(CMAKE_EXE_LINKER_FLAGS -fuse-ld=lld)

find_program(IWYU_PROGRAM NAMES include-what-you-use) # https://github.com/include-what-you-use/include-what-you-use

#doxygen
if (DOCS)
    add_subdirectory(docs)
endif()

#  Functions
function(copy_after_build TARGET_NAME)
  set(DESTDIR ${CMAKE_CURRENT_LIST_DIR}/bin/)
  file(MAKE_DIRECTORY ${DESTDIR})
  # Copy binary file to <CMakeLists.txt didctory>./bin after target is compiled.
  add_custom_command(
    TARGET ${TARGET_NAME}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${TARGET_NAME}> ${DESTDIR})
endfunction()

#Conan Bootstrap 

if(BUILD_WITH_CONAN)
  message([INFO] " =>> Building with CONAN OK.")

  if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
    message(
      STATUS
      "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
    file(DOWNLOAD
      "https://github.com/conan-io/cmake-conan/raw/v0.13/conan.cmake"
      "${CMAKE_BINARY_DIR}/conan.cmake")
  endif()

  include(${CMAKE_BINARY_DIR}/conan.cmake)

  # Add all dependencies here
  conan_cmake_run(REQUIRES boost/1.70.0@conan/stable BASIC_SETUP BUILD missing)
endif()

# Find Packages 

#  using static 
set(Boost_USE_STATIC_LIBS ON)

find_package(
  Boost
  COMPONENTS system coroutine
  REQUIRED)

#Target Configurations

file(GLOB SOURCE_FILE src/*.cpp)
add_executable(boosttemplate ${SOURCE_FILE})
copy_after_build(boosttemplate)

if(NOT WIN32)
  target_link_libraries(boosttemplate Boost::system pthread)
else()
  # Windows WIN32 API
  target_link_libraries(boosttemplate Boost::system)
endif()


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
