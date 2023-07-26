cmake_minimum_required(VERSION 3.20)
project(boosttemplate LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_VERBOSE_MAKEFILE ON)

set(BUILD_WITH_CONAN ON)
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

add_executable(boosttemplate echo-server.cpp)
copy_after_build(boosttemplate)

if(NOT WIN32)
  target_link_libraries(boosttemplate Boost::system pthread)
else()
  # Windows WIN32 API
  target_link_libraries(boosttemplate Boost::system)
endif()
