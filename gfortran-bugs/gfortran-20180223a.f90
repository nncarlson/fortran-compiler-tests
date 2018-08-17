!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84539
!!
!! ICE ON ASSIGNMENT TO CLASS(*) ALLOCATABLE ARRAY
!!
!! The assignment statement (not the declaration of X) seems to be
!! what triggers the ICE (comment out all lines but first and second).
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 8.0.1 20180224 (experimental)
!!  
!! $ gfortran -g -fbacktrace gfortran-20180223a.f90 
!! gfortran-20180223a.f90:7:0:
!! 
!!  class(*), allocatable :: x(:)
!!  
!! Error: conversion of register to a different size
!! VIEW_CONVERT_EXPR<void *>(_1);
!! 
!! _12 = VIEW_CONVERT_EXPR<void *>(_1);
!! gfortran-20180223a.f90:7:0: internal compiler error: verify_gimple failed
!! 0xd2b9bd verify_gimple_in_seq(gimple*)
!! 	../../gcc/tree-cfg.c:5247
!! 0xaa7495 gimplify_body(tree_node*, bool)
!! 	../../gcc/gimplify.c:12710
!! 0xaa7684 gimplify_function_tree(tree_node*)
!! 	../../gcc/gimplify.c:12800
!! 0x925d17 cgraph_node::analyze()
!! 	../../gcc/cgraphunit.c:670
!! 0x9286b3 analyze_functions
!! 	../../gcc/cgraphunit.c:1131
!! 0x9294a2 symbol_table::finalize_compilation_unit()
!! 	../../gcc/cgraphunit.c:2691
!!
!! Update with 8.2.0. The ICE is gone, but a run time segfault remains
!! at the assignment statement.
!!
!! $ gfortran -g -fbacktrace gfortran-20180223a.f90
!! $ ./a.out
!! 
!! Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
!! 
!! Backtrace for this error:
!! #0  0x7fe9463696df in ???
!! #1  0x400754 in MAIN__
!! 	at /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20180223a.f90:51
!! #2  0x400979 in main
!! 	at /home/nnc/Fortran/fortran-compiler-tests/gfortran-bugs/gfortran-20180223a.f90:56
!! Segmentation fault (core dumped)

class(*), allocatable :: x(:)
x = [4,2]
select type (x)
type is (integer)
  if (any(x /= [4,2])) stop 1
end select
end
