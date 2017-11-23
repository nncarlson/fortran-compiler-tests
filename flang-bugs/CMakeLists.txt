cmake_minimum_required(VERSION 3.9)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(flang-bug Fortran)

add_executable(flang-20171122a EXCLUDE_FROM_ALL flang-20171122a.f90)
add_test(NAME flang-20171122a
    COMMAND ${CMAKE_COMMAND} --build . --target flang-20171122a --config $<CONFIGURATION>
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_executable(flang-20171122b EXCLUDE_FROM_ALL flang-20171122b.f90)
add_test(NAME flang-20171122b
    COMMAND ${CMAKE_COMMAND} --build . --target flang-20171122b --config $<CONFIGURATION>
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_run_test(SOURCES flang-20171122c.f90 PASS_REGULAR_EXPRESSION "copy= 3 2 1 foobar")
add_compile_test(SOURCES flang-20171122d.f90)
add_run_test(SOURCES flang-20171122e.f90 PASS_REGULAR_EXPRESSION "copy=\\[\"foo\",\"bar\"\\]")
add_run_test(SOURCES flang-20171122f.f90 PASS_REGULAR_EXPRESSION "len2=3 ")
add_run_test(SOURCES flang-20171122g.f90 PASS_REGULAR_EXPRESSION "lbound=1 1, ubound=2 2, shape=2 2")

add_executable(flang-20171122h EXCLUDE_FROM_ALL flang-20171122h.f90)
add_test(NAME flang-20171122h
    COMMAND ${CMAKE_COMMAND} --build . --target flang-20171122h --config $<CONFIGURATION>
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

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
