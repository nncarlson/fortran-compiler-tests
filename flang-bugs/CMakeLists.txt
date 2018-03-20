cmake_minimum_required(VERSION 3.9)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(flang-bug Fortran)

add_compiler_test(SOURCES flang-20180319a.f90 COMPILE_ONLY)
add_compiler_test(SOURCES flang-20180319b.f90 COMPILE_ONLY)
add_compiler_test(SOURCES flang-20180120.f90 LINK_ONLY WILL_FAIL LABELS FIXED)
add_compiler_test(SOURCES flang-20171123a.f90 COMPILE_ONLY)
add_compiler_test(SOURCES flang-20171123b.f90 COMPILE_ONLY WILL_FAIL)
add_compiler_test(SOURCES flang-20171122a.f90 LINK_ONLY)
add_compiler_test(SOURCES flang-20171122b.f90 LINK_ONLY)
add_compiler_test(SOURCES flang-20171122c.f90 RUN_ONLY
    PASS_REGULAR_EXPRESSION "copy= 3 2 1 foobar")
add_compiler_test(SOURCES flang-20171122d.f90 COMPILE_ONLY)
add_compiler_test(SOURCES flang-20171122e.f90 RUN_ONLY
    PASS_REGULAR_EXPRESSION "copy=\\[\"foo\",\"bar\"\\]")
add_compiler_test(SOURCES flang-20171122f.f90 RUN_ONLY
    PASS_REGULAR_EXPRESSION "len2=3 ")
add_compiler_test(SOURCES flang-20171122g.f90 RUN_ONLY
    PASS_REGULAR_EXPRESSION "lbound=1 1, ubound=2 2, shape=2 2")
add_compiler_test(SOURCES flang-20171122h.f90 LINK_ONLY)
add_compiler_test(SOURCES flang-20170611a.f90 COMPILE_ONLY LABELS FIXED)
add_compiler_test(SOURCES flang-20170611b.f90 COMPILE_ONLY LABELS FIXED)
add_compiler_test(SOURCES flang-20170611c.f90 COMPILE_ONLY LABELS FIXED)
add_compiler_test(SOURCES flang-20170923a.f90 COMPILE_ONLY LABELS FIXED)
add_compiler_test(SOURCES flang-20170923b.f90 COMPILE_ONLY)
add_compiler_test(SOURCES flang-20170923c.f90 COMPILE_ONLY)
add_compiler_test(SOURCES flang-20170924a.f90 COMPILE_ONLY LABELS FIXED)
add_compiler_test(SOURCES flang-20170924b.f90 COMPILE_ONLY)
add_compiler_test(SOURCES flang-20170924c.f90 RUN_ONLY
    PASS_REGULAR_EXPRESSION "42 \\(expect 42\\)")
add_compiler_test(SOURCES flang-20170930a.f90 RUN_ONLY
    PASS_REGULAR_EXPRESSION "106=01101010")
add_compiler_test(SOURCES flang-20170930b.f90 COMPILE_ONLY)
add_compiler_test(SOURCES flang-20170930c.f90 RUN_ONLY)
