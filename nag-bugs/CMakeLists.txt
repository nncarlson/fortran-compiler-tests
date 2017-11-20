cmake_minimum_required(VERSION 3.9)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(nag-bug Fortran)

add_compile_test(SOURCES nag-20171110.f90)
add_compile_test(SOURCES nag-20171027.f90)
add_compile_test(SOURCES nag-20170805a.f90)
add_compile_test(SOURCES nag-20170805b.f90)
add_compile_test(SOURCES nag-20160321.f90)
add_compile_test(SOURCES nag-20160129.f90 nag-20160129-main.f90)

add_run_test(SOURCES nag-20150528.f90 nag-20150528-main.f90 COMPILE_FLAGS "-C -PIC")

add_compile_test(SOURCES nag-20150520.f90 COMPILE_FLAGS "-O2")
add_compile_test(SOURCES nag-20150321.f90)

add_run_test(SOURCES nag-20140617.f90 PASS_REGULAR_EXPRESSION "len=3")

add_compile_test(SOURCES nag-20140616.f90)
add_compile_test(SOURCES nag-20140417.f90)
add_compile_test(SOURCES nag-20140108.f90 COMPILE_FLAGS "-nan")
add_compile_test(SOURCES nag-20131204.f90 COMPILE_FLAGS "-C=all")

add_run_test(SOURCES nag-20130818.f90 COMPILE_FLAGS "-C -gline")

add_compile_test(SOURCES nag-20121111.f90 COMPILE_FLAGS "-C=all")
add_compile_test(SOURCES nag-20121007.f90 WILL_FAIL)
