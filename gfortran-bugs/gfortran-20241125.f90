!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117774
!! Fixed in gfortran 15.1.0
!!
!! INTERNAL COMPILER ERROR
!!
!! Passing imaginary part of complex array to an assumed-rank dummy.
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 14.1.0
!! 
!! $ gfortran gfortran-20241125.f90 
!! gfortran-20241125.f90:17:40:
!! 
!!    43 | call foo(x%im) ! INTERNAL COMPILER ERROR
!!       |                                        1
!! internal compiler error: Segmentation fault
!! 0xdff61f crash_signal
!! 	../../gcc/toplev.cc:319
!! 0x8ae07b gfc_conv_procedure_call(gfc_se*, gfc_symbol*, gfc_actual_arglist*, gfc_expr*, vec<tree_node*, va_gc, vl_embed>*)
!! 	../../gcc/fortran/trans-expr.cc:7149
!! 0x8f8362 gfc_trans_call(gfc_code*, bool, tree_node*, tree_node*, bool)
!! 	../../gcc/fortran/trans-stmt.cc:425
!! 0x870edb trans_code
!! 	../../gcc/fortran/trans.cc:2431
!! 0x8a0ea4 gfc_generate_function_code(gfc_namespace*)
!! 	../../gcc/fortran/trans-decl.cc:7880
!! 0x812d46 translate_all_program_units
!! 	../../gcc/fortran/parse.cc:7099
!! 0x812d46 gfc_parse_file()
!! 	../../gcc/fortran/parse.cc:7413
!! 0x86dc6f gfc_be_parse_file
!! 	../../gcc/fortran/f95-lang.cc:241
!! Please submit a full bug report, with preprocessed source (by using -freport-bug).
!!

module mod
contains
  subroutine foo(r)
    real, intent(in) :: r(..) ! ASSUMED-RANK DUMMY
  end subroutine
end module

use mod
complex :: x(3,10)
call foo(x%re) ! COMPILES WITHOUT ERROR
call foo(x%im) ! INTERNAL COMPILER ERROR
end
