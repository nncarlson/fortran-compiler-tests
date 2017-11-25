!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83149
!!
!! ICE with trunk 8.0 (20171123), 7.2.1, and 6.4.1
!!
!! $ gfortran gfortran-20171124f.f90 gfortran-20171124f-main.f90 
!! gfortran-20171124f-main.f90:2:0:
!! 
!!  s = sum(get())
!!  
!! internal compiler error: Segmentation fault
!! 0xd6b98f crash_signal
!! 	../../gcc/toplev.c:325
!! 0x90aeeb gfc_finish_var_decl
!! 	../../gcc/fortran/trans-decl.c:606
!! 0x90a274 gfc_get_symbol_decl(gfc_symbol*)
!! 	../../gcc/fortran/trans-decl.c:1777
!! 0x920387 gfc_conv_variable
!! 	../../gcc/fortran/trans-expr.c:2505
!! 0x91c71a gfc_conv_expr(gfc_se*, gfc_expr*)
!! 	../../gcc/fortran/trans-expr.c:7860
!! 0x91ea0a gfc_apply_interface_mapping(gfc_interface_mapping*, gfc_se*, gfc_expr*)
!! 	../../gcc/fortran/trans-expr.c:4355
!! 0x8ebd04 gfc_set_loop_bounds_from_array_spec(gfc_interface_mapping*, gfc_se*, gfc_array_spec*)
!! 	../../gcc/fortran/trans-array.c:920
!! 0x91a5b1 gfc_conv_procedure_call(gfc_se*, gfc_symbol*, gfc_actual_arglist*, gfc_expr*, vec<tree_node*, va_gc, vl_embed>*)
!! 	../../gcc/fortran/trans-expr.c:6024
!! 0x91c6fa gfc_conv_expr(gfc_se*, gfc_expr*)
!! 	../../gcc/fortran/trans-expr.c:7852
!! 0x8fa083 gfc_add_loop_ss_code
!! 	../../gcc/fortran/trans-array.c:2796
!! 0x8faab5 gfc_conv_loop_setup(gfc_loopinfo*, locus*)
!! 	../../gcc/fortran/trans-array.c:5097
!! 0x93ad87 gfc_conv_intrinsic_arith
!! 	../../gcc/fortran/trans-intrinsic.c:4197
!! 0x93fd3f gfc_conv_intrinsic_function(gfc_se*, gfc_expr*)
!! 	../../gcc/fortran/trans-intrinsic.c:9146
!! 0x91c6fa gfc_conv_expr(gfc_se*, gfc_expr*)
!! 	../../gcc/fortran/trans-expr.c:7852
!! 0x925065 gfc_trans_assignment_1
!! 	../../gcc/fortran/trans-expr.c:10018
!! 0x8e45cf trans_code
!! 	../../gcc/fortran/trans.c:1828
!! 0x90e7a8 gfc_generate_function_code(gfc_namespace*)
!! 	../../gcc/fortran/trans-decl.c:6437
!! 0x89d036 translate_all_program_units
!! 	../../gcc/fortran/parse.c:6091
!! 0x89d036 gfc_parse_file()
!! 	../../gcc/fortran/parse.c:6294
!! 0x8e0eaf gfc_be_parse_file
!! 	../../gcc/fortran/f95-lang.c:204

module mod1
  integer :: ncells
end module

module mod2
contains
  function get() result(array)
    use mod1
    real array(ncells)
  end function
end module

!use mod2
!s = sum(get())
!end
