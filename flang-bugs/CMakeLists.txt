cmake_minimum_required(VERSION 3.9)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(flang-bugs Fortran)

add_compiler_test(NAME flang-20250902 SOURCES flang-20250902.f90  RUN_ONLY
    PASS_REGULAR_EXPRESSION "42")
add_compiler_test(NAME flang-20250504 SOURCES mpi_bcast.f90 flang-20250504.F90  RUN_ONLY
    PASS_REGULAR_EXPRESSION "in mpi_bcast: buffer= 1.[0-9]* 3.[0-9]* 5.[0-9]*")
