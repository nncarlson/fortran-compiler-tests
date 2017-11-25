!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83148
!!
!! ICE with the 8.0 trunk (20171123)
!! Versions 7.2.1 and 6.4.1 are okay.
!!
!! $ gfortran -c gfortran-20171124c.f90 
!! f951: internal compiler error: Segmentation fault
!! 0xd6b98f crash_signal
!! 	../../gcc/toplev.c:325
!! 0xfb33fd tree_class_check(tree_node const*, tree_code_class, char const*, int, char const*)
!! 	../../gcc/tree.h:3480
!! 0xfb33fd wi::from_mpz(tree_node const*, __mpz_struct*, bool)
!! 	../../gcc/wide-int.cc:244
!! 0x900284 gfc_conv_mpz_to_tree(__mpz_struct*, int)
!! 	../../gcc/fortran/trans-const.c:205
!! 0x9008bf gfc_conv_constant(gfc_se*, gfc_expr*)
!! 	../../gcc/fortran/trans-const.c:413
!! 0x922b91 gfc_conv_initializer(gfc_expr*, gfc_typespec*, tree_node*, bool, bool, bool)
!! 	../../gcc/fortran/trans-expr.c:6833
!! 0x9231ad gfc_conv_structure(gfc_se*, gfc_expr*, int)
!! 	../../gcc/fortran/trans-expr.c:7748
!! 0x922cdf gfc_conv_initializer(gfc_expr*, gfc_typespec*, tree_node*, bool, bool, bool)
!! 	../../gcc/fortran/trans-expr.c:6883
!! 0x90a78b gfc_get_symbol_decl(gfc_symbol*)
!! 	../../gcc/fortran/trans-decl.c:1819
!! 0x90d340 gfc_create_module_variable
!! 	../../gcc/fortran/trans-decl.c:4943
!! 0x8cf472 do_traverse_symtree
!! 	../../gcc/fortran/symbol.c:4157
!! 0x910193 gfc_generate_module_vars(gfc_namespace*)
!! 	../../gcc/fortran/trans-decl.c:5415
!! 0x8e88fc gfc_generate_module_code(gfc_namespace*)
!! 	../../gcc/fortran/trans.c:2180
!! 0x89cf7b translate_all_program_units
!! 	../../gcc/fortran/parse.c:6078
!! 0x89cf7b gfc_parse_file()
!! 	../../gcc/fortran/parse.c:6294
!! 0x8e0eaf gfc_be_parse_file
!! 	../../gcc/fortran/f95-lang.c:204

module fhypre
  use iso_c_binding, only: c_ptr, c_null_ptr
  use iso_c_binding, only: hypre_obj => c_ptr, hypre_null_obj => c_null_ptr
  private
  public :: hypre_obj, hypre_null_obj
end module

module hypre_hybrid_type
  use fhypre
  type hypre_hybrid
    type(hypre_obj) :: solver = hypre_null_obj
  end type hypre_hybrid
end module
