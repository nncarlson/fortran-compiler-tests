cmake_minimum_required(VERSION 3.9)

project(FlangBugReports Fortran)
enable_testing()

add_library(flang-bug-20170611a OBJECT EXCLUDE_FROM_ALL flang-bug-20170611a.f90)
add_test(NAME flang-bug-20170611a
    COMMAND ${CMAKE_COMMAND} --build . --target flang-bug-20170611a
        --config $<CONFIGURATION> WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_library(flang-bug-20170611b OBJECT EXCLUDE_FROM_ALL flang-bug-20170611b.f90)
add_test(NAME flang-bug-20170611b
    COMMAND ${CMAKE_COMMAND} --build . --target flang-bug-20170611b
        --config $<CONFIGURATION> WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_library(flang-bug-20170611c OBJECT EXCLUDE_FROM_ALL flang-bug-20170611c.f90)
add_test(NAME flang-bug-20170611c
    COMMAND ${CMAKE_COMMAND} --build . --target flang-bug-20170611c
        --config $<CONFIGURATION> WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_library(flang-bug-20170923a OBJECT EXCLUDE_FROM_ALL flang-bug-20170923a.f90)
add_test(NAME flang-bug-20170923a
    COMMAND ${CMAKE_COMMAND} --build . --target flang-bug-20170923a
        --config $<CONFIGURATION> WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_library(flang-bug-20170923b OBJECT EXCLUDE_FROM_ALL flang-bug-20170923b.f90)
add_test(NAME flang-bug-20170923b
    COMMAND ${CMAKE_COMMAND} --build . --target flang-bug-20170923b
        --config $<CONFIGURATION> WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_library(flang-bug-20170923c OBJECT EXCLUDE_FROM_ALL flang-bug-20170923c.f90)
add_test(NAME flang-bug-20170923c
    COMMAND ${CMAKE_COMMAND} --build . --target flang-bug-20170923c
        --config $<CONFIGURATION> WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_library(flang-bug-20170924a OBJECT EXCLUDE_FROM_ALL flang-bug-20170924a.f90)
add_test(NAME flang-bug-20170924a
    COMMAND ${CMAKE_COMMAND} --build . --target flang-bug-20170924a
        --config $<CONFIGURATION> WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_library(flang-bug-20170924b OBJECT EXCLUDE_FROM_ALL flang-bug-20170924b.f90)
add_test(NAME flang-bug-20170924b
    COMMAND ${CMAKE_COMMAND} --build . --target flang-bug-20170924b
        --config $<CONFIGURATION> WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_executable(flang-bug-20170924c flang-bug-20170924c.f90)
add_test(flang-bug-20170924c flang-bug-20170924c)
set_tests_properties(flang-bug-20170924c PROPERTIES
    PASS_REGULAR_EXPRESSION "42 \\(expect 42\\)")

add_executable(flang-bug-20170930a flang-bug-20170930a.f90)
add_test(flang-bug-20170930a flang-bug-20170930a)
set_tests_properties(flang-bug-20170930a PROPERTIES
    PASS_REGULAR_EXPRESSION "106=01101010")

add_library(flang-bug-20170930b OBJECT EXCLUDE_FROM_ALL flang-bug-20170930b.f90)
add_test(NAME flang-bug-20170930b
    COMMAND ${CMAKE_COMMAND} --build . --target flang-bug-20170930b
        --config $<CONFIGURATION> WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_executable(flang-bug-20170930c flang-bug-20170930c.f90)
add_test(flang-bug-20170930c flang-bug-20170930c)
