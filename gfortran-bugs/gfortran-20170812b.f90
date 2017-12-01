!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=79072
!! fixed in 255064 (8.0.0 20171122)
!!
!! Same results with 20171028 version of 8.0.0 and 6.4.1
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 7.2.1 20171028
!! 
!! $ gfortran gfortran-bug-20170812b.f90 
!! gfortran-bug-20170812b.f90:1:0:
!! 
!!  character(3), target :: a = 'foo'
!!  
!! internal compiler error: in gfc_advance_chain, at fortran/trans.c:58
!! 0x65d137 gfc_advance_chain(tree_node*, int)
!! 	../../gcc/fortran/trans.c:58
!! 0x685eba gfc_class_len_get(tree_node*)
!! 	../../gcc/fortran/trans-expr.c:226
!! 0x6c6364 trans_associate_var
!! 	../../gcc/fortran/trans-stmt.c:1778
!! 0x6c6364 gfc_trans_block_construct(gfc_code*)
!! 	../../gcc/fortran/trans-stmt.c:1831
!! 0x65d6b7 trans_code
!! 	../../gcc/fortran/trans.c:1913
!! 0x6c77d9 gfc_trans_select_type_cases
!! 	../../gcc/fortran/trans-stmt.c:2422
!! 0x6c77d9 gfc_trans_select_type(gfc_code*)
!! 	../../gcc/fortran/trans-stmt.c:3133
!! 0x65d747 trans_code
!! 	../../gcc/fortran/trans.c:1933
!! 0x6c5e38 gfc_trans_block_construct(gfc_code*)
!! 	../../gcc/fortran/trans-stmt.c:1824
!! 0x65d6b7 trans_code
!! 	../../gcc/fortran/trans.c:1913
!! 0x682847 gfc_generate_function_code(gfc_namespace*)
!! 	../../gcc/fortran/trans-decl.c:6332
!! 0x682634 gfc_generate_contained_functions
!! 	../../gcc/fortran/trans-decl.c:5327
!! 0x682634 gfc_generate_function_code(gfc_namespace*)
!! 	../../gcc/fortran/trans-decl.c:6261
!! 0x616eb6 translate_all_program_units
!! 	../../gcc/fortran/parse.c:6074
!! 0x616eb6 gfc_parse_file()
!! 	../../gcc/fortran/parse.c:6274
!! 0x65a02f gfc_be_parse_file
!! 	../../gcc/fortran/f95-lang.c:204

character(3), target :: a = 'foo'
class(*), pointer :: b
b => ptr()
select type (b)
type is (character(*))
  print '(3a)', 'b="', b, '" (expect "foo")'
end select
contains
  function ptr()
    class(*), pointer :: ptr
    ptr => a
    select type (ptr)
    type is (character(*))
    end select
  end function
end
