!! Bug 77310
!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=77310
!!
!! Marked as a duplicate of bug 49636
!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49636
!!
!! $ gfortran --version
!! GNU Fortran (GCC) 6.1.0
!! 
!! $ gfortran -c gfortran-bug-20160821.f90 
!! gfortran-bug-20160821.f90:38:0:
!! 
!!      select case (n_array(1))
!!  
!! internal compiler error: in gfc_get_element_type, at fortran/trans-types.c:1181
!! 0x6f1daa gfc_get_element_type(tree_node*)
!! 	../../gcc/fortran/trans-types.c:1181
!! 0x6ea705 trans_associate_var
!! 	../../gcc/fortran/trans-stmt.c:1581
!! 0x6ea705 gfc_trans_block_construct(gfc_code*)
!! 	../../gcc/fortran/trans-stmt.c:1806
!! 0x688977 trans_code
!! 	../../gcc/fortran/trans.c:1785
!! 0x6abe8c gfc_generate_function_code(gfc_namespace*)
!! 	../../gcc/fortran/trans-decl.c:6154
!! 0x644c50 translate_all_program_units
!! 	../../gcc/fortran/parse.c:5613
!! 0x644c50 gfc_parse_file()
!! 	../../gcc/fortran/parse.c:5819
!! 0x685cc5 gfc_be_parse_file
!! 	../../gcc/fortran/f95-lang.c:201
!! Please submit a full bug report,
!! with preprocessed source if appropriate.

subroutine ice_example
  type :: inner
    integer :: n
  end type
  type :: outer
    type(inner), allocatable :: array(:)
  end type
  type(outer) :: var
  associate (n_array => var%array%n)
    select case (n_array(1))
    case default
    end select
  end associate
end subroutine
