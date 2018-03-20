cmake_minimum_required(VERSION 3.9)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(pgi-bugs Fortran)

add_compiler_test(SOURCES pgi-20180320.f90 RUN_ONLY)
