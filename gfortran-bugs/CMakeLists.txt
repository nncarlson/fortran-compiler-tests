cmake_minimum_required(VERSION 3.9)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(gfortran-bug Fortran)

add_compile_test(SOURCES gfortran-bug-20171115.f90)
add_run_test(SOURCES gfortran-bug-20171114a.f90)
add_compile_test(NAME compile-20171114b SOURCES gfortran-bug-20171114b.f90)  # ICE with some versions
add_run_test(SOURCES gfortran-bug-20171114b.f90)  # compiles but segfaults with others
add_compile_test(NAME compile-20171114c SOURCES gfortran-bug-20171114c.f90)  # ICE with some versions
add_run_test(SOURCES gfortran-bug-20171114c.f90)  # compiles but segfaults with others
add_run_test(SOURCES gfortran-bug-20170812a.f90 PASS_REGULAR_EXPRESSION "b=\"foo\"")
add_compile_test(SOURCES gfortran-bug-20170812b.f90)
add_compile_test(SOURCES gfortran-bug-20170112a.f90)
add_run_test(SOURCES gfortran-bug-20170112b.f90 PASS_REGULAR_EXPRESSION "5 fubar")
add_compile_test(SOURCES gfortran-bug-20160821.f90)
add_run_test(SOURCES gfortran-bug-20160321.f90 PASS_REGULAR_EXPRESSION "copy= 3 2 1 foobar")
add_run_test(SOURCES gfortran-bug-20160320.f90 PASS_REGULAR_EXPRESSION "3 2 foobar")
add_compile_test(SOURCES gfortran-bug-20160319a.f90 COMPILE_FLAGS "-Wsurprising -Werror")
add_compile_test(SOURCES gfortran-bug-20160319b.f90 COMPILE_FLAGS "-Wsurprising -Werror")
add_compile_test(SOURCES gfortran-bug-20160129.f90)
add_compile_test(SOURCES gfortran-bug-20151108.f90)
add_run_test(SOURCES gfortran-bug-20151102a.f90) # success is not segfaulting
add_run_test(SOURCES gfortran-bug-20151102b.f90 PASS_REGULAR_EXPRESSION "foobar")
add_compile_test(SOURCES gfortran-bug-20151101.f90)
add_run_test(SOURCES gfortran-bug-20150913.f90) # success is not segfaulting
add_run_test(SOURCES gfortran-bug-20150912a.f90 COMPILE_FLAGS "-fcheck=recursion")
add_compile_test(SOURCES gfortran-bug-20120411.f90)
add_compile_test(SOURCES gfortran-bug-20110616.f90)
add_compile_test(SOURCES gfortran-bug-20110528.f90)
add_compile_test(SOURCES gfortran-bug-20100925.f90)
add_compile_test(SOURCES gfortran-bug-20100924.f90)
