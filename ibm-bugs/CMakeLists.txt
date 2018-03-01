cmake_minimum_required(VERSION 3.7)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(ibm-bugs Fortran)

set(CMAKE_Fortran_COMPILER xlf2008) # I don't know of a better way ...
message(STATUS "CMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAG}")

add_compiler_test(SOURCES ibm-20180301a.f90 COMPILE_ONLY)
add_compiler_test(SOURCES ibm-20180301b.f90 COMPILE_ONLY)
