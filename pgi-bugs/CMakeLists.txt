cmake_minimum_required(VERSION 3.9)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(testing)

project(pgi-bugs Fortran)

add_compiler_test(SOURCES pgi-20180320.f90 RUN_ONLY)

add_compiler_test(SOURCES pgi-20180505a.f90 RUN_ONLY)
add_compiler_test(SOURCES pgi-20180505b.f90 COMPILE_ONLY)
add_compiler_test(SOURCES pgi-20180505c.f90 COMPILE_ONLY)

add_compiler_test(SOURCES pgi-bitfun-kind.f90 COMPILE_ONLY)

add_compiler_test(SOURCES pgi-constructor-1.f90 COMPILE_ONLY)

add_compiler_test(SOURCES pgi-dflt-init-1.f90 COMPILE_ONLY)
add_compiler_test(SOURCES pgi-dflt-init-2.f90 COMPILE_ONLY)

add_compiler_test(SOURCES pgi-dt-asn-1.f90 RUN_ONLY)

add_compiler_test(SOURCES pgi-src-alloc-2.f90 RUN_ONLY)

add_compiler_test(SOURCES pgi-ptr-rank-remap-1.f90 RUN_ONLY)
add_compiler_test(SOURCES pgi-ptr-rank-remap-2.f90 RUN_ONLY)
