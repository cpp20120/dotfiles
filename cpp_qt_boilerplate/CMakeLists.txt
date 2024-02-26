cmake_minimum_required(VERSION 3.20)
project(qt_boilerplae CXX)

# Qt
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# C++ Standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_PREFIX_PATH "")

# FindThreads.cmake fix
set(CMAKE_THREAD_LIBS_INIT "-lpthread")

find_package(Qt6 COMPONENTS Core Gui Widgets REQUIRED)

include_directories(include)


add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} Qt::Core Qt::Gui Qt::Widgets)

if (DEBUG)
    add_compile_options(-g3 -ggdb)
    add_compile_definitions(DEBUG)
endif()

if (DOCS)
    add_subdirectory(docs)
endif()

add_subdirectory(src)
