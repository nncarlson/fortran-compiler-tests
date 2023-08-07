!! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66577
!! marked a duplicate of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61767
!! Fixed in 12.2.0 and probably much earlier.
!!
!! Using gfortran 5.2:
!!
!! $ gfortran -c json.F90 
!! f951: internal compiler error: in generate_finalization_wrapper, at fortran/class.c:1567
!! 0x5fbccb generate_finalization_wrapper
!! 	../../gcc-5.2.0/gcc/fortran/class.c:1566
!! 0x5fbccb gfc_find_derived_vtab(gfc_symbol*)
!! 	../../gcc-5.2.0/gcc/fortran/class.c:2401
!! 0x67ce35 resolve_fl_derived
!! 	../../gcc-5.2.0/gcc/fortran/resolve.c:12946
!! 0x6778c7 resolve_symbol
!! 	../../gcc-5.2.0/gcc/fortran/resolve.c:13226
!! 0x69014b do_traverse_symtree
!! 	../../gcc-5.2.0/gcc/fortran/symbol.c:3646
!! 0x67aa02 resolve_types
!! 	../../gcc-5.2.0/gcc/fortran/resolve.c:14973
!! 0x67664f gfc_resolve(gfc_namespace*)
!! 	../../gcc-5.2.0/gcc/fortran/resolve.c:15083
!! 0x661f56 gfc_parse_file()
!! 	../../gcc-5.2.0/gcc/fortran/parse.c:5476
!! 0x6a15f5 gfc_be_parse_file
!! 	../../gcc-5.2.0/gcc/fortran/f95-lang.c:229
!! Please submit a full bug report,
!! with preprocessed source if appropriate.
!! Please include the complete backtrace with any bug report.

module json

  type :: array_element
  contains
    final :: array_element_delete
  end type

  type, public :: json_array_iterator
    type(array_element), pointer :: element
  end type

contains

  subroutine array_element_delete (this)
    type(array_element) :: this
  end subroutine

  subroutine array_iter_next (this)
    class(json_array_iterator) :: this
  end subroutine

end module
