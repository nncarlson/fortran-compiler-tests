cmake_minimum_required(VERSION 3.9)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(gfortran-bug Fortran)

add_compiler_test(SOURCES gfortran-20250605.f90 RUN_ONLY LABELS PR119986)
add_compiler_test(SOURCES gfortran-20250428.f90 RUN_ONLY LABELS PR119986)
add_compiler_test(SOURCES gfortran-20250401.f90 COMPILE_ONLY LABELS PR119994)
add_compiler_test(SOURCES gfortran-20241125.f90 COMPILE_ONLY LABELS PR117774)
add_compiler_test(SOURCES gfortran-20240425.f90 RUN_ONLY
    COMPILE_FLAGS "-g -O0 -fsanitize=address,undefined"
    LINK_FLAGS "-fsanitize=address,undefined" LABELS PR114827)
add_compiler_test(SOURCES gfortran-20231211.f90 COMPILE_ONLY LABELS PR112964)
add_compiler_test(SOURCES gfortran-20230612.f90 COMPILE_ONLY LABELS PR110224)
add_compiler_test(SOURCES gfortran-20230529.f90 COMPILE_ONLY LABELS PR110033)
add_compiler_test(SOURCES gfortran-20230527.f90 COMPILE_ONLY LABELS PR110012)
add_compiler_test(SOURCES gfortran-20230513.f90 LABELS PR109846)
add_compiler_test(SOURCES gfortran-20220221-module.f90
    gfortran-20220221-submodule.f90 gfortran-20220221-main.f90
    LINK_ONLY LABELS PR104630)
add_compiler_test(SOURCES gfortran-20211123.f90 RUN_ONLY LABELS PR103394)
add_compiler_test(SOURCES gfortran-20210527.f90 RUN_ONLY LABELS PR100815)
add_compiler_test(SOURCES gfortran-20201204.f90 LABELS PR93762)
add_compiler_test(SOURCES gfortran-20200501.f90 COMPILE_ONLY LABELS PR94909)
add_compiler_test(SOURCES gfortran-20200402-file1.f90 gfortran-20200402-file2.f90
    LINK_ONLY LABELS PR94463)
add_compiler_test(SOURCES gfortran-20190202.f90 RUN_ONLY LABELS PR89174)
add_compiler_test(SOURCES gfortran-20180610.f90 LABELS PR86100
    COMPILE_FLAGS "-g -fcheck=bounds")
add_compiler_test(SOURCES gfortran-20180224.f90 LABELS PR84546)
add_compiler_test(SOURCES gfortran-20180223a.f90 LABELS PR84539)
add_compiler_test(SOURCES gfortran-20180223b.f90 LABELS PR84539)
add_compiler_test(SOURCES gfortran-20180130e.f90 LABELS PR84143)
add_compiler_test(SOURCES gfortran-20180130d.f90 COMPILE_ONLY LABELS PR84122)
add_compiler_test(SOURCES gfortran-20180130c.f90 LABELS PR84120)
add_compiler_test(SOURCES gfortran-20180130b.f90 COMPILE_ONLY WILL_FAIL LABELS PR84120)
add_compiler_test(SOURCES gfortran-20180130a.f90 LABELS PR84119)
add_compiler_test(SOURCES char-par-inquiry.f90 LABELS PR40196)
add_compiler_test(SOURCES gfortran-20180129.f90 LABELS PR84093)
add_compiler_test(SOURCES gfortran-20180128.f90 COMPILE_ONLY
    WILL_FAIL LABELS PR84093)
add_compiler_test(SOURCES gfortran-20171124a.f90 COMPILE_ONLY LABELS PR83146)
add_compiler_test(SOURCES gfortran-20171124b.f90 COMPILE_ONLY LABELS PR49213)
add_compiler_test(SOURCES gfortran-20171124c.f90 COMPILE_ONLY LABELS PR83148)
add_compiler_test(SOURCES gfortran-20171124d.f90 COMPILE_ONLY LABELS PR79929
    COMPILE_FLAGS "-O1 -Werror")
add_compiler_test(SOURCES gfortran-20171124e.f90 gfortran-20171124e-main.f90
    COMPILE_ONLY LABELS PR83149)
add_compiler_test(SOURCES gfortran-20171124f.f90 gfortran-20171124f-main.f90
    COMPILE_ONLY LABELS PR83149)
add_compiler_test(SOURCES gfortran-20171122.f90 RUN_ONLY LABELS PR83118
    PASS_REGULAR_EXPRESSION "copy=\\[\"foo\",\"bar\"\\]")
add_compiler_test(SOURCES gfortran-20171122b.f90 RUN_ONLY LABELS PR83118
    PASS_REGULAR_EXPRESSION "copy=\\[\"foo\",\"bar\"\\]")
add_compiler_test(SOURCES gfortran-20171115.f90 COMPILE_ONLY LABELS PR83012)
add_compiler_test(SOURCES gfortran-20171114a.f90 RUN_ONLY LABELS PR82996
    COMPILE_FLAGS "-g -fsanitize=address,undefined"
    LINK_FLAGS "-fsanitize=address,undefined")
add_compiler_test(SOURCES gfortran-20171114b.f90 LABELS PR82996
    COMPILE_FLAGS "-g -fsanitize=address,undefined"
    LINK_FLAGS "-fsanitize=address,undefined")
add_compiler_test(SOURCES gfortran-20171114c.f90 LABELS PR82996
    COMPILE_FLAGS "-g -fsanitize=address,undefined"
    LINK_FLAGS "-fsanitize=address,undefined")
add_compiler_test(SOURCES gfortran-20170812a.f90 RUN_ONLY LABELS PR79072
    PASS_REGULAR_EXPRESSION "b=\"foo\"")
add_compiler_test(SOURCES gfortran-20170812b.f90 LABELS PR79072
    PASS_REGULAR_EXPRESSION "b=\"foo\"")
add_compiler_test(SOURCES gfortran-20170112a.f90 COMPILE_ONLY LABELS PR79072)
add_compiler_test(SOURCES gfortran-20170112b.f90 RUN_ONLY LABELS PR79072
    PASS_REGULAR_EXPRESSION "5 fubar")
add_compiler_test(SOURCES gfortran-20160821.f90 COMPILE_ONLY LABELS PR77310)
add_compiler_test(SOURCES gfortran-20160321.f90 RUN_ONLY
    PASS_REGULAR_EXPRESSION "copy= 3 2 1 foobar")
add_compiler_test(SOURCES gfortran-20160320.f90 RUN_ONLY LABELS PR67564
    PASS_REGULAR_EXPRESSION "3 2 foobar")
add_compiler_test(SOURCES gfortran-20160319a.f90 COMPILE_ONLY LABELS PR70312
    COMPILE_FLAGS "-Wsurprising -Werror")
add_compiler_test(SOURCES gfortran-20160319b.f90 COMPILE_ONLY LABELS PR70312
    COMPILE_FLAGS "-Wsurprising -Werror")
add_compiler_test(SOURCES gfortran-20160129.f90 COMPILE_ONLY LABELS PR69563)
add_compiler_test(SOURCES gfortran-20151108.f90 COMPILE_ONLY LABELS PR66577)
add_compiler_test(SOURCES gfortran-20151102a.f90 RUN_ONLY LABELS PR54070)
add_compiler_test(SOURCES gfortran-20151102b.f90 RUN_ONLY LABELS PR54070
    PASS_REGULAR_EXPRESSION "foobar")
add_compiler_test(SOURCES gfortran-20151101.f90 COMPILE_ONLY LABELS PR68174)
add_compiler_test(SOURCES gfortran-20150913.f90 RUN_ONLY LABELS PR67564)
add_compiler_test(SOURCES gfortran-20150912a.f90 RUN_ONLY LABELS PR67560
    COMPILE_FLAGS "-fcheck=recursion")
add_compiler_test(SOURCES gfortran-20120411.f90 COMPILE_ONLY LABELS PR52864)
add_compiler_test(SOURCES gfortran-20110616.f90 COMPILE_ONLY LABELS PR49213)
add_compiler_test(SOURCES gfortran-20110528.f90 COMPILE_ONLY LABELS PR49213)
add_compiler_test(SOURCES gfortran-20100925.f90 COMPILE_ONLY LABELS PR45794)
add_compiler_test(SOURCES gfortran-20100924.f90 COMPILE_ONLY LABELS PR45786)
add_compiler_test(SOURCES gfortran-20181114.f90 gfortran-20181114-main.f90
  RUN_ONLY COMPILE_FLAGS "-g -fcheck=all" LABELS PR88043)
