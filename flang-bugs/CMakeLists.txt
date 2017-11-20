cmake_minimum_required(VERSION 3.9)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(flang-bug Fortran)

add_compile_test(SOURCES flang-bug-20170611a.f90)
add_compile_test(SOURCES flang-bug-20170611b.f90)
add_compile_test(SOURCES flang-bug-20170611c.f90)
add_compile_test(SOURCES flang-bug-20170923a.f90)
add_compile_test(SOURCES flang-bug-20170923b.f90)
add_compile_test(SOURCES flang-bug-20170923c.f90)
add_compile_test(SOURCES flang-bug-20170924a.f90)
add_compile_test(SOURCES flang-bug-20170924b.f90)
add_run_test(SOURCES flang-bug-20170924c.f90 PASS_REGULAR_EXPRESSION "42 \\(expect 42\\)")
add_run_test(SOURCES flang-bug-20170930a.f90 PASS_REGULAR_EXPRESSION "106=01101010")
add_compile_test(SOURCES flang-bug-20170930b.f90)
add_run_test(SOURCES flang-bug-20170930c.f90)
