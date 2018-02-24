!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83149
!! Fixed on 8.0 trunk (r257938)
!!
!! ICE with trunk 8.0 (20171123).  Works fine with 7.2.1 and 6.4.1
!!
!! $ gfortran gfortran-20171124e.f90 gfortran-20171124e-main.f90 
!! gfortran-20171124e-main.f90:3:0:
!! 
!!  select case (get_string())
!!  
!! internal compiler error: Segmentation fault
!! 0xd6b98f crash_signal
!! 	../../gcc/toplev.c:325
!! 0x96852e gfc_sym_type(gfc_symbol*)
!! 	../../gcc/fortran/trans-types.c:2207
!! 0x968ab7 gfc_get_function_type(gfc_symbol*)
!! 	../../gcc/fortran/trans-types.c:2969
!! 0x907aed gfc_get_extern_function_decl(gfc_symbol*)
!! 	../../gcc/fortran/trans-decl.c:2126
!! 0x907ffd gfc_get_extern_function_decl(gfc_symbol*)
!! 	../../gcc/fortran/trans-decl.c:1974
!! 0x91bb24 conv_function_val
!! 	../../gcc/fortran/trans-expr.c:3722
!! 0x91bb24 gfc_conv_procedure_call(gfc_se*, gfc_symbol*, gfc_actual_arglist*, gfc_expr*, vec<tree_node*, va_gc, vl_embed>*)
!! 	../../gcc/fortran/trans-expr.c:6142
!! 0x91c6fa gfc_conv_expr(gfc_se*, gfc_expr*)
!! 	../../gcc/fortran/trans-expr.c:7852
!! 0x923a6a gfc_conv_expr_reference(gfc_se*, gfc_expr*)
!! 	../../gcc/fortran/trans-expr.c:7952
!! 0x957611 gfc_trans_character_select
!! 	../../gcc/fortran/trans-stmt.c:2819
!! 0x95ee1c gfc_trans_select(gfc_code*)
!! 	../../gcc/fortran/trans-stmt.c:3158
!! 0x8e48b7 trans_code
!! 	../../gcc/fortran/trans.c:1940
!! 0x90e7a8 gfc_generate_function_code(gfc_namespace*)
!! 	../../gcc/fortran/trans-decl.c:6437
!! 0x89d036 translate_all_program_units
!! 	../../gcc/fortran/parse.c:6091
!! 0x89d036 gfc_parse_file()
!! 	../../gcc/fortran/parse.c:6294
!! 0x8e0eaf gfc_be_parse_file
!! 	../../gcc/fortran/f95-lang.c:204

module mod
  character(8) string
contains
  function get_string() result(s)
    character(len_trim(string)) s
    s = string
  end function
end module

! Put this main program in a separate file
!use mod
!string = 'fubar'
!select case (get_string())
!case default
!end select
!end
